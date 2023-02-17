# frozen_string_literal: true

module Thredded
  module MarkdownKatex
    module SVGAllowlist
      # All the non-script SVG elements and attributes.

      SVG_ELEMENTS = %w[
        a animate animateColor animateMotion animateTransform
        circle clipPath defs desc ellipse feGaussianBlur filter font-face
        font-face-name font-face-src foreignObject
        g glyph hkern linearGradient line marker mask metadata missing-glyph
        mpath path polygon polyline radialGradient rect set stop svg switch
        text textPath title tspan use
      ].freeze

      SVG_ATTRIBUTES = %w[
        accent-height accumulate additive alphabetic
        arabic-form ascent attributeName attributeType baseProfile bbox begin
        by calcMode cap-height class clip-path clip-rule color
        color-interpolation-filters color-rendering content cx cy d dx
        dy descent display dur end fill fill-opacity fill-rule
        filterRes filterUnits font-family
        font-size font-stretch font-style font-variant font-weight from fx fy g1
        g2 glyph-name gradientUnits hanging height horiz-adv-x horiz-origin-x id
        ideographic k keyPoints keySplines keyTimes lang marker-end
        marker-mid marker-start markerHeight markerUnits markerWidth
        maskContentUnits maskUnits mathematical max method min name offset
        opacity orient origin overline-position overline-thickness panose-1 path
        pathLength patternContentUnits patternTransform patternUnits points
        preserveAspectRatio primitiveUnits r refX refY repeatCount repeatDur
        requiredExtensions requiredFeatures restart rotate rx ry slope spacing
        startOffset stdDeviation stemh
        stemv stop-color stop-opacity strikethrough-position
        strikethrough-thickness stroke stroke-dasharray stroke-dashoffset
        stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity
        stroke-width systemLanguage target text-anchor to transform type u1
        u2 underline-position underline-thickness unicode unicode-range
        units-per-em values version viewBox visibility width widths x
        x-height x1 x2 xlink:actuate xlink:arcrole xlink:href xlink:role
        xlink:show xlink:title xlink:type xml:base xml:lang xml:space xmlns
        xmlns:xlink y y1 y2 zoomAndPan
      ].freeze

      SVG_ALLOWED_STYLE_PROPERTIES = %w[
        fill fill-opacity fill-rule stroke
        stroke-width stroke-linecap stroke-linejoin stroke-opacity
      ].freeze

      # TODO: The allowlists below are not applied yet.

      SVG_ATTR_VAL_ALLOWS_REF = %w[
        clip-path color-profile cursor fill
        filter marker marker-start marker-mid marker-end mask stroke
      ].freeze

      SVG_ALLOW_LOCAL_HREF = %w[
        altGlyph animate animateColor animateMotion
        animateTransform cursor feImage filter linearGradient pattern
        radialGradient textpath tref set use
      ].freeze
    end
  end
end
