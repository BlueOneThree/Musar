//
//  Constants.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI

// MARK: - Themes (by mood)

let themes: [String: [String]] = [

    "Euphoric": [
        "Golden hour, windows down, volume up...",
        "The moment right before the drop...",
        "First day of summer, no plans...",
        "You just got the call — you made it...",
        "Rooftop at sunrise, the city waking up below...",
        "Dancing alone in your room like nobody's watching...",
        "The night is young and so are we...",
        "Everything is falling into place for once...",
        "Confetti falling, the crowd screaming your name...",
        "That first breath of freedom after the last exam...",
    ],

    "Melancholic": [
        "3am, driving alone, no destination...",
        "The last voicemail you never deleted...",
        "Rain on a window you used to share...",
        "An empty chair at the table, still set for two...",
        "Scrolling through old photos you should've deleted...",
        "The song that played the night everything changed...",
        "Watching the sunset from the place you first met...",
        "A hoodie that still smells like them...",
        "The city looks different since you left...",
        "Writing a letter you'll never send...",
    ],

    "Nostalgic": [
        "The smell of your childhood home...",
        "A song comes on and suddenly you're 16 again...",
        "Summer nights that felt like they'd never end...",
        "The corner store that isn't there anymore...",
        "Polaroids fading in a shoebox under your bed...",
        "Your grandma's kitchen, Saturday morning cartoons...",
        "The sound of a dial-up connecting, waiting for magic...",
        "Riding bikes with no destination until the streetlights came on...",
        "That one summer everyone was still together...",
        "Looking at the stars from the same backyard, years later...",
    ],

    "Angry": [
        "They smiled in your face and talked behind your back...",
        "Burned every bridge and don't regret a single match...",
        "The system failed you and expects you to be grateful...",
        "Bit your tongue one too many times...",
        "They took credit for everything you built...",
        "Punching walls won't fix it but silence is worse...",
        "Trust is a word that lost all meaning...",
        "You played fair in a rigged game...",
        "The betrayal wasn't the knife — it was who held it...",
        "Done being the bigger person...",
    ],

    "Dreamy": [
        "Floating between sleep and awake, thoughts dissolving...",
        "Clouds moving in slow motion above an open field...",
        "A whisper you can almost hear but never quite catch...",
        "Underwater light filtering through in slow beams...",
        "The space between two heartbeats, infinite and still...",
        "A garden growing inside an abandoned building...",
        "Walking through fog, the world softened at every edge...",
        "The hum of a city heard from very far away...",
        "A paper boat drifting down a quiet stream...",
        "Stars reflected in a lake so still it looks like glass...",
    ],

    "Dark": [
        "The hallway light flickers and nobody moves...",
        "Midnight, headlights off, engine still running...",
        "You hear your name but the room is empty...",
        "Shadows have weight here...",
        "The door is open but something tells you not to enter...",
        "A phone ringing in an empty house, over and over...",
        "The last train, the wrong station, no way back...",
        "Fog rolling in, swallowing the road ahead...",
        "A clock ticking in a room where time doesn't matter...",
        "The mirror shows someone you don't recognize...",
    ],

    "Romantic": [
        "Your hand in mine, the world disappearing...",
        "Slow dancing in the kitchen at 2am...",
        "The way you said my name like it meant something...",
        "Two coffee cups on a Sunday morning windowsill...",
        "A love letter folded into a paper plane...",
        "Your laugh echoing in an empty cathedral...",
        "Tracing constellations on each other's skin...",
        "The first time you stayed and didn't leave by morning...",
        "A single rose left on the passenger seat...",
        "Falling asleep mid-sentence because you felt that safe...",
    ],

    "Rebellious": [
        "They said you couldn't, so you did it twice...",
        "Skipping school to chase something that actually matters...",
        "Spray paint on a wall that used to be silent...",
        "The rules were written by people who never played the game...",
        "Burning the playbook and writing your own...",
        "They want you quiet — give them volume...",
        "Walking out the door they told you to stay behind...",
        "No permission needed, no apology given...",
        "The dropout who outworked everyone with a degree...",
        "Your voice shaking but you say it anyway...",
    ],

    "Chaotic": [
        "Everything happening at once and you're laughing...",
        "Seventeen tabs open, none of them make sense...",
        "Running through the rain in clothes you'll regret wearing...",
        "The moment the plan falls apart and something better starts...",
        "Strangers becoming best friends at 4am in a parking lot...",
        "A playlist on shuffle that somehow tells your life story...",
        "Screaming the wrong lyrics and meaning every word...",
        "Lost in a city you've never been to and loving it...",
        "The fire alarm goes off and nobody moves...",
        "The night went left, then right, then somewhere unnamed...",
    ],
]

// MARK: - Colors

enum AppColors {
    static let primary = Color("prim0")
    static let secondary = Color("seco0")
    static let background = Color("bck")
}
