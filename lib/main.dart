// Importe le package material de Flutter, qui contient les widgets et les outils pour créer une interface utilisateur selon les principes du Material Design.
import 'package:flutter/material.dart';

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

  // La méthode qui sera appelée lorsque l'utilisateur appuie sur le bouton.
  void _augmenterNiveau() {
    // setState est crucial : il notifie Flutter que l'état a changé,
    // ce qui déclenche une reconstruction du widget pour afficher la nouvelle valeur.
    setState(() {
      _niveauDeCompetence++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold est un widget de base qui fournit la structure visuelle standard d'une page (barre d'app, corps, etc.).
    return Scaffold(
      backgroundColor: Colors.grey[200], // Couleur de fond de la page
      appBar: AppBar(
        title: const Text('Ma Carte de Visite'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[400],
        foregroundColor: Colors.white,
      ),
      // Center permet de centrer son widget enfant.
      body: Center(
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
                color: Colors.deepPurple,
              ),
              const Text(
                'NOM',
                style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
              ),
              // SizedBox est utilisé pour créer un espacement vertical.
              const SizedBox(height: 10.0),
              Text(
                'Frédéric TOPPAN',
                style: TextStyle(
                  color: Colors.deepPurple,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0),
              const Text(
                'NIVEAU DE COMPÉTENCE FLUTTER',
                style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                '$_niveauDeCompetence', // Affiche la valeur de notre variable d'état.
                style: TextStyle(
                  color: Colors.deepPurple,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0),
              // Un bouton surélevé.
              ElevatedButton.icon(
                onPressed: _augmenterNiveau, // Appelle notre méthode au clic.
                icon: const Icon(Icons.add),
                label: const Text('Augmenter le niveau'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[400],
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}