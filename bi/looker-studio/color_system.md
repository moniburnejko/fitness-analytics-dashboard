# color system
this file defines the **official color palette** for the looker studio dashboard used in the *fitness analytics etl + bi* project.  
it ensures a consistent visual language across all pages, metrics, and intensity scales.

the palette follows a **dark ui** approach with high-contrast highlight tones  
and color-coded semantics for workout types, intensity, and health indicators.

## palette overview
### main colors
| variable | hex | usage |
|-----------|-----|--------|
| 💎 `primary-blue` | `#4CC9F0` | main chart color, accents, primary buttons |
| 🌺 `energy-pink` | `#F15BB5` | alerts, high intensity, attention-grabbing values |
| 🍀 `success-green` | `#00C896` | success metrics, completed goals |
| 💟 `calm-violet` | `#B388EB` | recovery and relaxation metrics |
| ⬜ `neutral-gray` | `#9D9D9D` | secondary elements, borders, muted data |

### intensity scale
| variable | hex | meaning | usage |
|-----------|-----|----------|--------|
| 🌺 `intensity-high` | `#F15BB5` | strong activity / stress | high hr, high effort sessions |
| 💛 `intensity-medium` | `#F7B801` | medium intensity | average load or medium effort |
| 💎 `intensity-low` | `#4CC9F0` | low effort / calm state | light activity, recovery days |

### background colors
| variable | hex | usage |
|-----------|-----|--------|
| ⚫ `background-primary` | `#121212` | main dashboard background |
| ⚫ `background-secondary` | `#1E1E1E` | widgets, cards, and panels |
| ⚫ `background-accent` | `#252525` | hover zones, emphasis highlights |

### text colors
| variable | hex | usage |
|-----------|-----|--------|
| ⚪ `text-primary` | `#EAEAEA` | primary text and labels |
| ⚪ `text-secondary` | `#B0B0B0` | secondary text and legends |
| ⚪ `text-muted` | `#7A7A7A` | disabled text or low importance info |

### semantic colors by workout type
| type | color | meaning |
|------|--------|---------|
| 🌺 `HIIT` | `#F15BB5` | vibrant pink – high intensity |
| 💛 `Running` | `#F7B801` | warm yellow – endurance |
| 💙­ `Cycling` | `#4A90E2` | bright blue – cardio |
| 🍀 `Walking` | `#00C896` | fresh green – light movement |
| 💟 `Yoga` | `#B388EB` | soft violet – relaxation |
| 💎 `Swimming` | `#4CC9F0` | aqua blue – balance & flow |
| 💢 `Strength` | `#EF476F` | magenta-red – power workouts |
| 🔶 `Tennis` | `#F79901` | light amber – agility & coordination |

## usage examples in dashboards
### performance panel
- **primary blue (`#4CC9F0`)** → line in *monthly activity trend* and key chart elements  
- **energy pink (`#F15BB5`)** → highlights on *workout intensity breakdown*
- **neutral gray (`#9D9D9D`)** → reference line in *daily steps vs day of week*  
- **semantic palette** → used in *workout breakdown by type* donut chart  
- **intensity scale** → used in *workout breakdown by intensity* donut chart
  
### workout analytics
- **semantic palette** → for workout-type charts (*comparison*, *duration vs calories burned*)  
- **intensity scale** → in *heart rate zones* chart  
- **neutral gray (`#9D9D9D`)** → for axis lines and text labels to maintain visual balance
- **primary blue (`#4CC9F0`)** → header buttons, check boxes

### health & recovery
- **gauge charts** (*sleep quality*, *move quality*) use gradient scale:  
  - alert pink (`#F15BB5`) → poor (<50%)      
  - medium yellow (`#F7B801`) → moderate (50–74%)   
  - success green (`#00C896`) → optimal (≥75%)  
- **resting hr trend** → calm violet (`#B388EB`) line with neutal gray (`#9D9D9D`) moving average  
- **sleep pattern heatmap** →  
  - short sleep (<6h) → alert pink (`#F15BB5`)   
  - optimal (6–8h) → success green (`#00C896`)    
  - long (>8h) → medium yellow (`#F7B801`)    
- **recovery timeline (gantt)** → energy pink (`#F15BB5`)= workout, recovery blue (`#4CC9F0`) = recovery, calm violet (`#B388EB`) = rest  

## notes
- all colors use **rgb hex codes** and are optimized for dark backgrounds.  
- no opacity or gradient overlays are applied in charts (solid fills for clarity).  
- palette supports accessibility with high luminance contrast for core metrics.

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
