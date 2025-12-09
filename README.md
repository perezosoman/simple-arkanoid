# Documentación del Proyecto Arkanoid

Esta documentación detalla la estructura del proyecto, el flujo de carga de niveles y la interacción entre las escenas mediante señales.

## Diagrama de Clases

Este diagrama muestra las clases principales del proyecto, sus variables clave y métodos, así como las relaciones de herencia y composición.

```mermaid
classDiagram
    class Node {
        <<Built-in>>
    }
    class Node2D {
        <<Built-in>>
    }
    class Control {
        <<Built-in>>
    }
    class CharacterBody2D {
        <<Built-in>>
    }
    class StaticBody2D {
        <<Built-in>>
    }

    class Main {
        +Array[PackedScene] levels
        +LevelBase current_level
        +int current_level_index
        +bool is_game_over
        +start_game()
        +load_level()
        +show_game_over()
        -_on_level_completed()
        -_on_level_lost_life()
        -_on_level_increase_points()
    }

    class LevelBase {
        <<Signal>> next_level
        <<Signal>> lost_life
        <<Signal>> increase_point
        +start_new_game()
        -_on_block_block_was_hit()
        -_on_background_ball_lost()
    }

    class Block {
        <<Signal>> block_was_hit
        +hit()
        +destroy_me()
    }

    class Ball {
        +Vector2 direction
        +float speed
        +_physics_process()
    }

    class Player {
        +Vector2 target_position
        +update_target_position()
        +stop_player()
    }

    class Background {
        <<Signal>> ball_lost
    }

    class Welcome {
        <<Signal>> start_game
    }

    class GameOver {
        <<Signal>> exit_game
        <<Signal>> repeat_level
    }

    class Global {
        +int score
        +int lives
    }

    Main --|> Node
    LevelBase --|> Node
    Block --|> StaticBody2D
    Ball --|> CharacterBody2D
    Player --|> CharacterBody2D
    Background --|> Node2D
    Welcome --|> Control
    GameOver --|> Control
    Global --|> Node

    Main o-- LevelBase : Manages
    Main o-- Welcome : UI
    Main o-- GameOver : UI
    LevelBase o-- Block : Contains
    LevelBase o-- Ball : Spawns
    LevelBase o-- Player : Contains
    LevelBase o-- Background : Contains
```

## Diagrama de Secuencia: Flujo de Carga de Niveles

Este diagrama ilustra cómo se inicia el juego y cómo se gestiona la transición entre niveles desde el script `Main`.

```mermaid
sequenceDiagram
    actor User
    participant Welcome
    participant Main
    participant Level as LevelBase
    participant Global

    User->>Welcome: Click "Jugar"
    Welcome->>Main: signal start_game
    Main->>Main: start_game()
    Main->>Global: Reset lives & score
    Main->>Main: load_level()
    
    create participant NewLevel as Level Instance
    Main->>NewLevel: instantiate()
    Main->>NewLevel: connect signals (next_level, lost_life, increase_point)
    Main->>Main: add_child(NewLevel)
    
    loop Game Loop
        User->>NewLevel: Play Level
    end

    NewLevel->>Main: signal next_level (All blocks destroyed)
    Main->>Main: _on_level_completed()
    Main->>Main: current_level_index++
    Main->>Main: load_level()
    Main->>NewLevel: queue_free()
    
    alt More Levels Exist
        Main->>Main: Instantiate Next Level...
    else No More Levels
        Main->>Welcome: visible = true
        Main->>Main: Reset UI
    end
```

## Diagrama de Interacción y Señales

Este diagrama muestra las principales señales emitidas por los distintos nodos y quién las escucha, definiendo la arquitectura de eventos del juego.

```mermaid
graph TD
    subgraph UI
        Welcome[Welcome Scene]
        GameOver[GameOver Scene]
    end

    subgraph Core
        Main[Main Script]
        Level[LevelBase Script]
    end

    subgraph GameObjects
        Block[Block Node]
        Background[Background Node]
    end

    %% Connections
    Welcome -- "signal start_game" --> Main
    GameOver -- "signal exit_game" --> Main
    GameOver -- "signal repeat_level" --> Main

    Level -- "signal next_level" --> Main
    Level -- "signal lost_life" --> Main
    Level -- "signal increase_point" --> Main

    Block -- "signal block_was_hit" --> Level
    Background -- "signal ball_lost" --> Level

    %% Descriptions
    Main -.->|Instantiates| Level
    Level -.->|Contains| Block
    Level -.->|Contains| Background
```
