// Importe le package material de Flutter, qui contient les widgets et les outils pour créer une interface utilisateur selon les principes du Material Design.
import 'package:flutter/material.dart';
// Importe le package url_launcher pour ouvrir des URLs externes.
import 'package:url_launcher/url_launcher.dart';

// Le point d'entrée de toute application Flutter. La fonction `runApp` prend le widget racine et le monte à l'écran.
void main() {
  runApp(const MonAppEntrainement());
}

// MonAppEntrainement est un widget "Stateless". Son état ne change pas au cours du temps.
// Il configure le thème global de l'application et définit le widget de la page d'accueil.
class MonAppEntrainement extends StatelessWidget {
  const MonAppEntrainement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Désactive la bannière de débogage en haut à droite
      debugShowCheckedModeBanner: false,
      title: 'Carte de Visite Flutter',
      theme: ThemeData(
        // Définit la palette de couleurs de l'application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Le widget de la page d'accueil de notre application.
      home: const CarteDeVisitePage(),
    );
  }
}

// CarteDeVisitePage est un widget "Stateful". Cela signifie qu'il peut contenir un état qui change
// et que l'interface peut être redessinée lorsque cet état change (par exemple, notre niveau de compétence).
class CarteDeVisitePage extends StatefulWidget {
  const CarteDeVisitePage({super.key});

  @override
  State<CarteDeVisitePage> createState() => _CarteDeVisitePageState();
}

// C'est la classe qui contient l'état (les données) et la logique de notre widget Stateful.
class _CarteDeVisitePageState extends State<CarteDeVisitePage> {
  // La variable d'état. C'est le niveau que nous allons afficher et modifier.
  int _niveauDeCompetence = 0;

  // La méthode qui sera appelée lorsque l'utilisateur appuie sur le bouton pour augmenter le niveau.
  void _augmenterNiveau() {
    // setState est crucial : il notifie Flutter que l'état a changé,
    // ce qui déclenche une reconstruction du widget pour afficher la nouvelle valeur.
    setState(() {
      _niveauDeCompetence++;
    });
  }

  // La méthode qui sera appelée lorsque l'utilisateur appuie sur le bouton pour diminuer le niveau.
  void _diminuerNiveau() {
    setState(() {
      // S'assurer que le niveau ne descend pas en dessous de zéro
      if (_niveauDeCompetence > 0) {
        _niveauDeCompetence--;
      }
    });
  }

  // Méthode pour lancer une URL dans un navigateur.
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      // Gérer l'erreur si l'URL ne peut pas être lancée.
      // Dans une vraie application, vous afficheriez un message à l'utilisateur.
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold est un widget de base qui fournit la structure visuelle standard d'une page (barre d'app, corps, etc.).
    return Scaffold(
      // Nous définissons la couleur de fond du Scaffold à transparent
      // car le dégradé sera géré par le Container enfant.
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Ma Carte de Visite'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 33, 2, 145),
        foregroundColor: Colors.white,
      ),
      // Le corps du Scaffold est un Container qui contient le dégradé.
      body: Container(
        // Définir la décoration du Container avec un LinearGradient pour le dégradé.
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, // Début du dégradé en haut à gauche
            end: Alignment.bottomRight, // Fin du dégradé en bas à droite
            colors: [
              Color.fromARGB(255, 60, 100, 170), // Un bleu plus clair
              Color.fromARGB(255, 20, 50, 120),  // Un bleu plus foncé
            ],
          ),
        ),
        // Le contenu du Container est centré.
        child: Center(
          // Padding ajoute de l'espace autour de son enfant.
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            // Column arrange ses enfants en une colonne verticale.
            child: Column(
              // Aligne les enfants au centre de la colonne horizontalement.
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Un avatar circulaire pour la photo de profil.
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage('https://portfolio-frederic-toppan.vercel.app/static/media/20180912_110504.b5862247acb948c84f0c.webp'), // Image de profil aléatoire
                ),
                // Un séparateur visuel.
                const Divider(
                  height: 60.0, // Espace vertical total du séparateur
                  color: Color.fromARGB(255, 5, 5, 5),
                ),
                const Text(
                  'NOM',
                  style: TextStyle(color: Colors.white70, letterSpacing: 2.0), // Couleur du texte ajustée pour le dégradé
                ),
                // SizedBox est utilisé pour créer un espacement vertical.
                const SizedBox(height: 10.0),
                Text(
                  'Frédéric TOPPAN',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255), // Couleur du texte ajustée pour le dégradé
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
                const Text(
                  ' FLUTTER LEVEL',
                  style: TextStyle(color: Colors.white70, letterSpacing: 2.0), // Couleur du texte ajustée pour le dégradé
                ),
                const SizedBox(height: 10.0),
                Text(
                  '$_niveauDeCompetence', // Affiche la valeur de notre variable d'état.
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255), // Couleur du texte ajustée pour le dégradé
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
                // Un bouton surélevé pour augmenter le niveau.
                ElevatedButton.icon(
                  onPressed: _augmenterNiveau, // Appelle notre méthode au clic.
                  icon: const Icon(Icons.arrow_upward),
                  label: const Text('Augmenter le niveau'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 87, 194, 87),
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0), // Ajout d'un espacement entre les boutons
                // Un bouton surélevé pour diminuer le niveau.
                ElevatedButton.icon(
                  onPressed: _diminuerNiveau, // Appelle notre méthode au clic.
                  icon: const Icon(Icons.arrow_downward),
                  label: const Text('Diminuer le niveau'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 53, 53),
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 30.0),
                // Ligne pour l'e-mail, maintenant cliquable
                InkWell( // Rends la Row cliquable et donne un effet visuel au tap
                  onTap: () {
                    // Lance le lien vers la page de contact de votre portfolio
                    _launchURL('https://portfolio-frederic-toppan.vercel.app/contact');
                  },
                  child: const Row(
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        color: Color.fromARGB(179, 174, 243, 15), // Nouvelle couleur de l'icône
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        'frederic.toppan@gmail.com',
                        style: TextStyle(
                          color: Color.fromARGB(181, 238, 215, 5), // Nouvelle couleur du texte
                          fontSize: 18.0,
                          letterSpacing: 1.0,
                          decoration: TextDecoration.underline, // Souligne le texte pour indiquer que c'est un lien
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0), // Espacement entre l'e-mail et le site web

                // Nouvelle ligne pour l'icône et le lien du site web (inchangée)
                InkWell( // Rends la Row cliquable et donne un effet visuel au tap
                  onTap: () {
                    _launchURL('https://portfolio-frederic-toppan.vercel.app/'); // Remplacez par votre URL de portfolio
                  },
                  child: const Row(
                    children: <Widget>[
                      Icon(
                        Icons.public, // Une icône de globe ou de lien est appropriée
                        color: Colors.white70, // Couleur de l'icône ajustée
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        'Mon Portfolio', // Texte du lien
                        style: TextStyle(
                          color: Colors.white70, // Couleur du texte ajustée
                          fontSize: 18.0,
                          letterSpacing: 1.0,
                          decoration: TextDecoration.underline, // Souligne le texte pour indiquer que c'est un lien
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                  _launchURL('https://portfolio-frederic-toppan.vercel.app/');
                  },
                  child: Image.network(
                  'https://portfolio-frederic-toppan.vercel.app/static/media/Shenzor.665b7cdd5c7bb9ab5b85.webp',
                    height: 180.0, // Ajuste la taille selon tes besoins
                 ),
              ),
                  const SizedBox(height: 20.0), // Espacement avant le logo
              ],
            ),
          ),
        ),
      ),
    );
  }
}
