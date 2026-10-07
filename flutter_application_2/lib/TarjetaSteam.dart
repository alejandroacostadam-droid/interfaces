import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117),
      ),
      home: const Scaffold(
        body: Center(
          child: Padding(padding: EdgeInsets.all(16.0), child: GameCard()),
        ),
      ),
    );
  }
}

class GameCard extends StatefulWidget {
  const GameCard({super.key});

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  // Estado para la interacción del botón de favoritos
  bool isFavorite = false;

  // Datos del producto
  double precioBase = 19.99;
  double descuentoPorcentaje = 20.0; // 20% de descuento para prueba

  // 1. Función utilizada directamente como callback (sin parámetros)
  void _toggleFavorito() {
    setState(() {
      isFavorite = !isFavorite;
    });
    print('Callback ejecutado: Estado de favorito cambiado a $isFavorite');
  }

  // 2. Función que recibe algún parámetro
  void _mostrarInfoPlataforma(String plataforma) {
    print('Información solicitada para la plataforma: $plataforma');
  }

  // 3. Acción que realiza una operación sencilla (Cálculo de precio con descuento)
  void _calcularPrecioConDescuento() {
    double precioFinal =
        precioBase - (precioBase * (descuentoPorcentaje / 100));
    print('--- CÁLCULO DE OFERTA ---');
    print('Precio base: \$${precioBase.toStringAsFixed(2)} €');
    print('Descuento aplicado: $descuentoPorcentaje%');
    print('Precio final: \$${precioFinal.toStringAsFixed(2)} €');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF131B26), // Fondo oscuro de la tarjeta
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================== ZONA DE LA IMAGEN Y TÍTULO ====================
          Stack(
            children: [
              // Imagen de cabecera en assets
              SizedBox(
                height: 220,
                width: double.infinity,
                child: Image.asset(
                  'assets/img/portada.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Placeholder si la imagen aún no está cargada
                    return Container(
                      color: const Color(0xFF2E3B4E),
                      child: const Center(
                        child: Icon(
                          Icons.landscape,
                          size: 50,
                          color: Colors.white54,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Degradado oscuro inferior sobre la imagen para legibilidad
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFF131B26).withOpacity(0.9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // Botón de Favorito (IconButton con acción propia)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.redAccent : Colors.white,
                    ),
                    onPressed: _toggleFavorito, // Función usada directamente como callback
                  ),
                ),
              ),

              // Título "MINECRAFT" sobre la imagen
              const Positioned(
                bottom: 12,
                left: 16,
                child: Text(
                  'MINECRAFT',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),

          // ==================== DETALLES Y VALORACIÓN ====================
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Valoración de estrellas
                Row(
                  children: const [
                    Icon(
                      Icons.star_border_rounded,
                      color: Colors.amber,
                      size: 22,
                    ),
                    SizedBox(width: 6),
                    Text(
                      '4,9',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // Etiqueta de Categora / Tag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber.withOpacity(0.3)),
                  ),
                  child: const Text(
                    'SUPERVIVENCIA',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            color: Colors.white10,
            height: 1,
            indent: 16,
            endIndent: 16,
          ),

          // ==================== INFORMACIÓN EXTRA (PLATAFORMA Y LANZAMIENTO) ====================
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // 5. GestureDetector aplicado sobre elemento no botón (Bloque Plataforma)
                Expanded(
                  child: GestureDetector(
                    onTap: () => _mostrarInfoPlataforma(
                      'PC, Xbox, PlayStation y Switch',
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.tv,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'PLATAFORMA',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'PC · Xbox · PlayStation · Switch',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bloque Lanzamiento
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.calendar_month,
                        color: Colors.amber,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'LANZAMIENTO',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '18 NOV 2011',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ==================== FOOTER: PRECIO Y BOTÓN PRINCIPAL ====================
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Precio (GestureDetector para simular cálculo de descuento)
                GestureDetector(
                  onTap: _calcularPrecioConDescuento, // 6. Operación sencilla (Calcular descuento)
                  child: Text(
                    '${precioBase.toStringAsFixed(2).replaceAll('.', ',')} €',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Botón principal "Ver detalles —>"
                ElevatedButton(
                  onPressed: () {
                    print(
                      'ElevatedButton presionado: Navegando a la vista detallada de Minecraft',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC843), // Amarillo exacto
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Ver detalles',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
