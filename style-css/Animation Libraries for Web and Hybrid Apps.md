#  Animation Libraries for Web/Hybrid Apps

> **Reviews**
>
> - last reviewed : 
>
> **Related Versions**
>
> - 
>
> **References**
>
> * 

##  What Are The Options?

> Know your use case.

### CSS Animation And Houdini

- It doesn't run on javascript runtime. It just extends existing CSS. So it calculates before javascript code manipulates existing styles.
- It still has a browser compatibility issues.
- It's only for web.

### Framer Motion

- You use premade React subcomponents. And every control is set for you.
#### Pros
- Very Easy To Use with interactive editor on web.
- It comes With Preset Interpolations like spring, intertial and Interaction Handling Like Dragging, Gestures.
- Very production friendly for UI. You can find every possible exampels for UI animation you need. (https://framerbook.com/animation/example-animations/ )
#### Cons
- It's very opinionated, and it feels like writing CSS. You can't go further than it provides.
- No support for native platforms.

### React Spring

- It's more like a simple animation library like tween.js. It lerps values between keyframes.
#### Pros
- It has a React Native support. So you'll be able to describe your animation once, and use them both on React and React Native component.
- Smaller Bundle Size Than Framer.
- Interpolations Are more Customizable. But you still don't have more control over it like b-splines.
#### Cons
- No Built-in Handling for Interactions. You should use external libraries for each.
- You can't efficiently animate more complex shapes and vertices.

### Bodymovin + Lottie

- Bodymovin exports Adobe Aftereffect Project as a lightweight single JSON file.
- Lottie is a Frontend Player for Bodymovin Export File

  #### Pros
- AfterEffect Is Powerful Tool. Detailed Keyframe interpolation with curves and animating complex vertices are possible. If your animation has more than certain complexity, you just can't achieve it without tools like AfterEffects.
- Every popular platform is supported. Even QT and Xamarin.

  #### Cons
- But if you want to do more than a simply playing a premade animation, like dragging around multiple components, you can't.
- It has more overhead than others, as it has to parse and populate DOMs / Views with json file, before manipulating them. So if you care about time-to-interactive of the animated component, you should go with the other two.
- Compotibility Issues.

  1.  Not every features in AfterEffects are ported to bodymovin. (https://airbnb.io/lottie/#/supported-features )
  2.  AfterEffect and Bodymovin itself can have compatibility issues.

- It can make production process more complex and unmaintainable without a lottie-dedicated designer. Designer should be familiar with the library and it's limitations. And be able to make an optimized AfterEffects project for your target platforms.

## Some Tips

### So What Should I Use?

  1.  Framer Motion is for DOM based UI animation, for Web
  2.  React-Spring is for Component based more complex UI animation, for React and ReactNative
  3.  Lottie is for complex scenes that are achievable with AfterEffects, for many native platforms.

### SVG or Canvas?

  1.  SVG is better when your component
  2.  is large
  3.  have less objects
  4.  needs to scale
  5.  needs to be modified with CSS
  6.  Canvas is better when your component is
  7.  small
  8.  have many objects
  9.  no need to scale
  10. no needs to be modified with CSS
  11. Size matters because canvas has to recalculate every pixels again in the separate context, while SVG's rendering context is inside default rendering pipeline.
  12. Number of objects matters as SVG is another node for DOM to consider. So if your DOM

### How to optimize your AfterEffect project and SVG

  1.  https://codepen.io/tigt/post/improving-svg-rendering-performance

## Examples of Lottie Implementation

### Kakao Talk Background Animations for Event Purposes

#### what is this

1.  This animation renders as a background of a chat app, when some specific keywords like "birthday" are sent.
2.  This animation updates often for special events like Halloween.

#### how it works

1.  They use lottie for every platform.
2.  They serve bodymovin json file from cache (in mac, it's in here : /Users/jangwonsuh/library/Containers/com.kakao.kakaotalkmac/Data/Library/Caches)

#### why they use this

1.  Data should be loaded right after user opens the application, because it's played without any user's action.
2.  Data should be updated by network without the whole application update, because it will be updated irregularly.
3.  You'll need many different sized GIF as this app has plenty of platforms supported.
4.  So data should be a small as possible.
5.  Lottie library and embedmend inside the view can be done in first installation and reused.