# Arquitectura y Diagramas Adicionales

## Máquina de Estados del Juego

Este diagrama representa los estados de alto nivel del juego y las transiciones entre ellos.

```mermaid
stateDiagram-v2
    [*] --> Welcome: Inicio de la Aplicación

    state "Pantalla de Bienvenida" as Welcome {
        [*] --> EsperandoInput
        EsperandoInput --> [*]: Botón "Jugar" presionado
    }

    state "Jugando (Main Loop)" as Playing {
        [*] --> CargarNivel
        CargarNivel --> EnJuego: Nivel Instanciado
        
        state EnJuego {
            [*] --> PelotaEnMovimiento
            PelotaEnMovimiento --> PelotaPerdida: Cae al vacío
            PelotaPerdida --> RestarVida
            RestarVida --> ReiniciarPelota: Vidas > 0
            RestarVida --> GameOverState: Vidas == 0
            
            PelotaEnMovimiento --> BloqueDestruido: Colisión
            BloqueDestruido --> VerificarVictoria
            VerificarVictoria --> NivelCompletado: Bloques <= 0
            VerificarVictoria --> PelotaEnMovimiento: Bloques > 0
        }
    }

    state "Game Over" as GameOverState {
        [*] --> MostrarMenu
        MostrarMenu --> Reiniciar: Botón "Repetir"
        MostrarMenu --> Salir: Botón "Salir"
    }

    Welcome --> Playing: signal start_game
    Playing --> GameOverState: Vidas agotadas
    Playing --> Playing: Siguiente Nivel
    Playing --> Welcome: Todos los niveles completados
    Reiniciar --> Playing: signal repeat_level
    Salir --> [*]: Quit Application
```

## Árbol de Escenas (Scene Tree)

Estructura jerárquica de los nodos en tiempo de ejecución.

```mermaid
graph TD
    Root[root (Window)]
    Main[Main (Node)]
    
    subgraph UI_Layer
        Welcome[Welcome (Control)]
        UI[UI_Points (Control)]
        GameOver[GameOver (Control)]
    end
    
    subgraph Dynamic_Level
        Level[Current Level (Node2D)]
        Background[Background (Node2D)]
        Player[Player (CharacterBody2D)]
        Ball[Ball (CharacterBody2D)]
        BlockList[block-list (Node)]
        Block1[Block (StaticBody2D)]
        Block2[Block (StaticBody2D)]
        BlockN[Block... (StaticBody2D)]
    end

    Root --> Main
    Main --> Welcome
    Main --> UI
    Main --> GameOver
    Main --> Level
    
    Level --> Background
    Level --> Player
    Level --> Ball
    Level --> BlockList
    BlockList --> Block1
    BlockList --> Block2
    BlockList --> BlockN
```

## Flujo de Navegación de Pantallas

```mermaid
graph LR
    Start((Inicio)) --> WelcomeScreen[Pantalla Bienvenida]
    
    WelcomeScreen -- "Jugar" --> GameScreen[Pantalla de Juego]
    
    GameScreen -- "Perder todas las vidas" --> GameOverScreen[Pantalla Game Over]
    GameScreen -- "Completar todos los niveles" --> WelcomeScreen
    
    GameOverScreen -- "Repetir" --> GameScreen
    GameOverScreen -- "Salir" --> End((Fin))
```
