# frozen_string_literal: true

module Thredded
  module MarkdownKatex
    module MathMLWhitelist
      # All the presentation MathML elements and attributes, as per the
      # MathML Version 3.0 3rd Edition schema:
      # https://www.w3.org/Math/draft-spec/appendixa.html

      # Attributes common to all MathML elements
      COMMON_ATT = %w(id xref class style href).freeze
      # Attributes common to presentational elements
      COMMON_PRES_ATT = %w(mathcolor mathbackground).freeze
      # Attributes common to token elements
      TOKEN_ATT = %w(mathvariant mathsize dir).freeze
      # Attributes common to elements that can be indented
      INDENT_ATT = %w(
        indentalign indentshift indenttarget indentalignfirst indentshiftfirst
        indentalignlast indentshiftlast
      ).freeze
      # Attributes common to definition elements
      DEF_ENC_ATT = %w(definitionURL encoding).freeze

      # All of these elements have MATHML_COMMON_PRES_ATT.
      PRESENTATION_WHITELIST = {
        'maction' => %w(actiontype selection),
        'menclose' => %w(notation),
        'merror' => %w(),
        'mfenced' => %w(open close separators),
        'mfrac' =>
              %w(bevelled denomalign linethickness numalign),
        'mglyph' => %w(src width height valign alt),
        'mpadded' =>
              %w(height depth width lspace voffset),
        'mphantom' => %w(),
        'mroot' => %w(),
        'mrow' => %w(dir),
        'msqrt' => %w(),
        'mstyle' => INDENT_ATT + %w(
          scriptlevel displaystyle scriptsizemultiplier scriptminsize
          infixlinebreakstyle decimalpoint accent accentunder align
          alignmentscope bevelled charalign charspacing close columnalign
          columnlines columnspacing columnspan columnwidth crossout
          denomalign depth dir edge equalcolumns equalrows fence form frame
          framespacing groupalign height largeop leftoverhang length
          linebreak linebreakmultchar linebreakstyle lineleading
          linethickness location longdivstyle lquote lspace mathsize
          mathvariant maxsize minlabelspacing minsize movablelimits
          mslinethickness notation numalign open position rightoverhang
          rowalign rowlines rowspacing rowspan rquote rspace selection
          separator separators shift side stackalign stretchy
          subscriptshift superscriptshift symmetric valign width
        ),
        'mi' => TOKEN_ATT,
        'mn' => TOKEN_ATT,
        'mo' => TOKEN_ATT + INDENT_ATT +
                %w(form fence separator lspace rspace stretchy symmetric minsize
                   maxsize largeop movablelimits accent linebreak lineleading
                   linebreakstyle linebreakmultchar),
        'ms' => TOKEN_ATT + %w(lquote rquote),
        'mspace' => TOKEN_ATT + INDENT_ATT +
                    %w(width height depth linebreak),
        'mtext' => TOKEN_ATT,
        'maligngroup' => %w(groupalign),
        'malignmark' => %w(edge),
        'mlabeledtr' => %w(rowalign columnalign groupalign),
        'mtable' => %w(
          align rowalign columnalign groupalign alignmentscope columnwidth
          width rowspacing columnspacing rowlines columnlines frame
          framespacing equalrows equalcolumns displaystyle side
          minlabelspacing
        ),
        'mtd' => %w(rowspan columnspan rowalign columnalign groupalign),
        'mtr' => %w(rowalign columnalign groupalign),
        'mmultiscripts' => %w(superscriptshift subscriptshift),
        'msub' => %w(subscriptshift),
        'msup' => %w(superscriptshift),
        'msubsup' => %w(superscriptshift subscriptshift),
        'munder' => %w(accentunder align),
        'mover' => %w(accent align),
        'munderover' => %w(accent accentunder align),
        'mlongdiv' => %w(position shift longdivstyle),
        'mscarries' => %w(position location crossout scriptsizemultiplier),
        'mscarry' => %w(location crossout),
        'msgroup' => %w(position shift),
        'msline' =>
              %w(position length leftoverhang rightoverhang mslinethickness),
        'none' => %w(),
        'mprescripts' => %w(),
        'msrow' => %w(position),
        'mstack' => %w(align stackalign charalign charspacing)
      }.freeze

      OTHER_WHITELIST = {
        'math' => %w(xmlns display maxwidth overflow altimg altimg-width
                     altimg-height altimg-valign alttext cdgroup),
        'semantics' => DEF_ENC_ATT,
        'annotation' => %w(cd name src) + DEF_ENC_ATT,
        'annotation-xml' => %w(cd name src) + DEF_ENC_ATT
      }.freeze
    end
  end
end
