# Game Design Document (GDD) - Simple Arkanoid 

## 1. Resumen del Juego
**Título:** Arkanoid Clone (Nombre provisional)
**Género:** Arcade / Breakout
**Plataforma:** PC (Windows/Linux/Mac) - Godot Engine
**Público Objetivo:** Jugadores casuales, fans de juegos retro.

## 2. Descripción General
El juego es una recreación del clásico Arkanoid/Breakout donde el jugador controla una paleta en la parte inferior de la pantalla para hacer rebotar una pelota y destruir una formación de bloques en la parte superior. El objetivo es limpiar la pantalla de bloques para avanzar al siguiente nivel sin perder todas las vidas.

## 3. Mecánicas de Juego
### 3.1. Reglas Principales
- **Vidas:** El jugador comienza con 5 vidas (`Global.lives`).
- **Puntuación:** Cada bloque destruido otorga 1 punto (`Global.score`).
- **Victoria:** Se gana el nivel al destruir todos los bloques (o cuando queda 1 o menos, según la lógica actual). Al completar todos los niveles, se regresa a la pantalla de bienvenida.
- **Derrota:** Si la pelota cae por debajo de la paleta, se pierde una vida. Si las vidas llegan a 0, aparece la pantalla de "Game Over".

### 3.2. Controles
- **Movimiento:** El jugador mueve la paleta horizontalmente usando el ratón (`InputEventMouse`).
- **Lanzamiento:** (Automático al inicio del nivel o tras perder una vida).
- **Interacción UI:** Clic izquierdo para botones en menús (Jugar, Salir, Repetir).

### 3.3. Física y Colisiones
- **Pelota:** Rebota contra las paredes, el techo, la paleta y los bloques.
- **Bloques:** Se destruyen al ser golpeados por la pelota.
- **Zona de Muerte:** Un área invisible debajo de la paleta detecta si la pelota cae.

## 4. Elementos del Juego
### 4.1. Jugador (Paddle)
- **Script:** `player.gd`
- **Comportamiento:** Sigue la posición X del ratón dentro de unos límites definidos (`min_x`, `max_x`). Mantiene su posición Y fija.

### 4.2. Pelota (Ball)
- **Script:** `ball.gd`
- **Comportamiento:** Se mueve a velocidad constante y rebota según las normales de colisión.

### 4.3. Bloques (Blocks)
- **Script:** `block.gd`
- **Comportamiento:** Al ser golpeados, emiten una señal, reproducen una animación de desaparición (tween de escala y opacidad) y se eliminan.
- **Tipos de Bloques:**
    - **Normal:** Se destruye con 1 golpe.
    - **Resistente (HardBlock):** Requiere 2 golpes. Al primer golpe cambia de color.
    - **Indestructible (UnbreakableBlock):** No se destruye. Actúa como obstáculo.

### 4.4. Niveles
- **Gestión:** `main.gd` y `level.gd`
- **Estructura:** Los niveles son escenas instanciadas (`level_1.tscn`, `level_2.tscn`) que utilizan `TileMapLayer` para posicionar los bloques mediante "scene tiles".

## 5. Interfaz de Usuario (UI)
- **Pantalla de Bienvenida:** Muestra el título y botón "Jugar".
- **HUD (In-Game):** Muestra Vidas y Puntuación.
- **Game Over:** Muestra mensaje de derrota y opciones para "Repetir" o "Salir".

## 6. Estilo Visual y Audio
- **Gráficos:** Estilo 2D simple con sprites para bloques, paleta y pelota.
- **Audio:** (Pendiente de implementación) Efectos de sonido para rebotes, destrucción de bloques y game over.
