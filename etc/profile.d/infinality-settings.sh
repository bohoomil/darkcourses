##################################################################
# INFINALITY ENVIRONMENT VARIABLES FOR EXTRA RUN-TIME OPTIONS
##################################################################
#
# These environment variables require that their respective patches
# from http://www.infinality.net have been applied to the Freetype
# installation you are using.  They will do abolutely
# nothing otherwise!
#

# This file should be copied to /etc/profile.d/ for system-wide
# effects and/or included in ~/.bashrc or ~/.bash_profile for per-user
# effects:
# 
#   . ~/path/to/this/file/infinality-settings.sh
#
# Of course, the per-user settings will override the system-wide
# settings.  Default values indicated below will be used when the
# environment variables below are not defined.



##################################################################
# INFINALITY_FT_FILTER_PARAMS
#
# This is a modified version of the patch here:
# http://levelsofdetail.kendeeter.com/2008/12/dynamic_fir_filter_patch.html
#
# Allows you to adjust the FIR filter at runtime instead of at
# compile time.  The idea is to have values add up to 100, and be
# symmetrical around the middle value.  If the values add up to 
# more than 100, the glyphs will appear darker.  If less than 100,
# lighter.  I recommend using this method to make glyphs darker
# or lighter as opposed to using the pseudo-gamma option (see note in 
# pseudo-gamma option).
#
# Here are some samples of various filter parameters:
#
# (this has been changed to use integers between 0 and 100 to
#  avoid problems with regional differences like comma for decimal point)
#
# Strong Extra Smooth  "15 20 30 20 15"  (extra smooth, natural weight)
# Extra Smooth      "20 20 30 20 20"  (extra smooth, extra weight)
# Smooth            "15 20 32 20 15"  (smooth, natural weight)
# Stronger Gibson   "11 22 38 22 11"  (smooth, extra weight)          
# Gibson            "11 22 33 22 11"  (smooth, natural weight)
# Freetype Light    "00 33 34 33 00"  (sharp, natural weight)
# Freetype Default  "06 25 44 25 06"  (sharp, extra weight)           # freetype's default
# Extra Sharp       "00 35 35 35 00"  (extra sharp, extra weight)     # freetype's "light" LCD filter
#
# Default:     [Freetype's default]
# Recommended: "11 22 38 22 11"
#
# Example 1:  export INFINALITY_FT_FILTER_PARAMS="11 22 38 22 11"
#

# Infinality recommendation (too dark / smooth for some)
export INFINALITY_FT_FILTER_PARAMS="11 22 38 22 11"
#export INFINALITY_FT_FILTER_PARAMS="06 25 44 25 06"



##################################################################
# INFINALITY_FT_STEM_ALIGNMENT_STRENGTH
#
# This performs analysis on each glyph and determines an amount
# to shift the glyph, left or right, so that it aligns better to
# pixel boundaries.
# This results in subtley cleaner looking fonts, at the expense of
# proper distances between glyphs.  This is only active for sizes
# 10 px or greater and does not apply to bold or italic fonts.
# 
# Possible values:
# 0 through 100 - think of as percentage of strength
# 
# 0 corresponds to no shifting whatsoever.  In other words, OFF.
# 
# 100 corresponds to a full half pixel move, be left or right.  This
#   is the full amount any glyph could be moved in order to make it
#   align to a pixel boundary.
#
# Values inbetween act as caps.  If the algorithm determines that it
# wants to move the glyph .33 of a pixel to the left, but the value
# is set to 50 (i.e. 50%), then the maximum move that would be allowed
# is 50% of half a pixel, in other words .25.  So instead of .33 the 
# glyph is moved .25 of a pixel.
#
#
# Default:     0
# Recommended: 25

export INFINALITY_FT_STEM_ALIGNMENT_STRENGTH=25


##################################################################
# INFINALITY_FT_STEM_FITTING_STRENGTH
#
# This performs analysis on each glyph and determines an amount
# to horizontally stretch the glyph, so that stems align better to
# pixel boundaries.  An emboldening (or anti-emboldening) is
# performed afterward to account for stem width exaggeration.
# This results in subtley cleaner looking fonts, at the expense of
# proper distances between glyphs and slightly misshapen glyphs.  
# This is only active for sizes 10 px or greater and does not 
# apply to bold or italic fonts.
# 
# Possible values:
# 0 through 100 - think of as percentage of strength
# 
# 0 corresponds to no stretching whatsoever.  In other words, OFF.
# 
# 100 corresponds to a full pixel stretch, be outward or inward.  This
#   is the full amount any glyph could be stretched in order to make it
#   align to a pixel boundary.  Which direction is chosen is part
#   of the art of what I'm trying to do in the code.  ;)
#
# Values inbetween act as caps.  If the algorithm determines that it
# wants to stretch the glyph .75 of a pixel outward, but the value
# is set to 50 (i.e. 50%), then the maximum move that would be allowed
# is 50% of a pixel, in other words .50.  So instead of .75 the 
# glyph is stretched .50 of a pixel.
#
#
# Default:     0
# Recommended: 25

export INFINALITY_FT_STEM_FITTING_STRENGTH=25



##################################################################
# INFINALITY_FT_CHROMEOS_STYLE_SHARPENING_STRENGTH
#
# This enables an algorithm found in ChromeOS for sharpening the
# appearance of glyphs.  It is based off this patch:
#
# http://codereview.chromium.org/3298011/diff/9001/media-libs/freetype/files/freetype-2.3.11-lcd-sharpen.patches
#
# It gives glyphs a more "grainy" look, more similar to Windows.
# This effect will apply to any glyph being rendered using the LCD filter.
#
# Possible values:
# 0 through 100 - think of as percentage of strength
# 
# 0 corresponds to no sharpening whatsoever.  In other words, OFF.
#
# 25 is good for a subtle effect.
#
# 50 corresponds to the default ChromeOS value.
#
# 100 corresponds to maximum sharpening.  This usually results in 
#  something undesirable looking.
#
# As you increase this amount, it is good to decrease the gamma (2nd value)
# of INFINALITY_FT_PSEUDO_GAMMA, and possibly increase 
# INFINALITY_FT_STEM_FITTING_STRENGTH and 
# INFINALITY_FT_STEM_ALIGNMENT_STRENGTH, as it seems like the algorithm
# lightens stems that aren't fully on-pixel.
#
# Default:     0
# Recommended: 50

export INFINALITY_FT_CHROMEOS_STYLE_SHARPENING_STRENGTH=50
#export INFINALITY_FT_CHROMEOS_STYLE_SHARPENING_STRENGTH=0



##################################################################
# INFINALITY_FT_AUTOFIT_STEM_SNAP_LIGHT
#
# Cause the height of horizontal stems to snap to integer pixels
# when using light auto-hinting.  (This happens automatically
# when using full auto-hinting)
#
# This produces an effect similar to the way Windows renders fonts
# without requiring the font to contain bytecode instructions.
#
# Possible values:
# true             - enable stem snapping
# false            - do not enable stem snapping
#
# Default:     false
# Recommended: true

export INFINALITY_FT_AUTOFIT_STEM_SNAP_LIGHT=true



##################################################################
# INFINALITY_FT_AUTOFIT_EMBOLDEN_LIGHT
#
# Embolden particularly light or thin fonts, like DejaVu Sans Light,
# Inconsolata, Freemono, Courier New, etc. up until stem width is
# 1 pixel wide.  This makes these fonts easier to read at lower
# ppems.  Only applies when the autohinter is being used.
#
# Possible values:
# true             - enable emboldening of light fonts
# false            - do not enable emboldening of light fonts
#
# Default:     false
# Recommended: true

export INFINALITY_FT_AUTOFIT_EMBOLDEN_LIGHT=true



##################################################################
# INFINALITY_FT_PSEUDO_GAMMA
#
# This does a weighted gamma correction at the LCD filter phase
# prior to the LCD filter.  It's called "pseudo" because it doesn't
# take into account the color on which the glyph is being rendered
# (or for that matter the color of the glyph),
# which would need to happen in X rendering.  It is actually
# using the gamma function in calculations though.
#
# The first value indicates a px value, the second indicates a
# "gamma" value.  All sizes less than the px value will be corrected
# on a weighted scale based on the second value.
#
# The gamma value is commonly between 0.0 and 3.0.  Due to localization
# issues, the gamma value should be specified as it's actual value
# multiplied by 100.  So a gamma of 1.3 would be 130.  In practice,
# I'd stay between 40 and 250.
#
# Although you could use this to modify gamma for all sizes of
# glyphs, you may want to reserve this for just beefing up smaller
# glyphs.  (You can achieve a darkening or lightening effect for all
# sizes by adjusting INFINALITY_FT_FILTER_PARAMS values to add up
# to more or less than 100.)
#
# Values 1 through 100 will darken the glyph
# Values greater than 100 will lighten the glyph
#
# Example 1:  Darken glyphs that are less than 10 px. With some fonts
#             even 5 or 6px is readable!
# export INFINALITY_FT_PSEUDO_GAMMA="10 60"
#
# Example 2:  Lighten all glyphs (below 100px)
# export INFINALITY_FT_PSEUDO_GAMMA="100 150"
#
# Default:     [No gamma correction]
# Recommended: "9 70"

export INFINALITY_FT_PSEUDO_GAMMA="9 70"




##################################################################
# INFINALITY_FT_AUTOFIT_ADJUST_HEIGHTS
#
# This will slightly stretch some glyphs vertically between 9px
# and 14px (inclusive).  Some people may find this more
# aesthetically pleasing.  This only applies to fonts that are
# using autohint.  
#
# The goal here is to increase the height of some fonts by 1 px
# but leave the x-height where it is.  Arial is a good example
# of this working properly.
#
# Possible values:
# true             - enable height adjustment
# false            - do not enable height adjustment
#
# Default:     false

export INFINALITY_FT_AUTOFIT_ADJUST_HEIGHTS=true




##################################################################
# INFINALITY_FT_ENHANCED_EMBOLDEN
#
# When doing artificial emboldening, only embolden in the X
# direction, skipping the Y direction. Most people will find this
# more aesthetically pleasing than the default behavior.
# I *strongly* recommend enabling this.  There is almost no value
# in the way freetype does it by default.
#
# Possible values:
# true             - enable enhanced emboldening
# false            - no not enable enhanced emboldening
#
# Default:     false
# Recommended: true

export INFINALITY_FT_ENHANCED_EMBOLDEN=true




##################################################################
# INFINALITY_FT_EMBOLDEN_MAINTAIN_WIDTH
#
# When doing artificial emboldening, don't change the glyph width.
#
# Possible values:
# true             - maintain width
# false            - do not maintain width
#
# Default:     false
# Recommended: true

export INFINALITY_FT_EMBOLDEN_MAINTAIN_WIDTH=true



##################################################################
# INFINALITY_FT_AUTO_AUTOHINT
#
# Automatically use autohint when rendering a font that contains
# no truetype instructions, regardless of what the calling
# program asks for.  The truetype hinter will not do a good job
# on these.
#
# Possible values:
# true             - automatically use autohint
# false            - do not automatically use autohint
#
# Default:     false
# Recommended: true

export INFINALITY_FT_AUTO_AUTOHINT=true



##################################################################
# INFINALITY_FT_AUTOFIT_FORCE_SLIGHT_HINTING
#
# Some programs refuse to listen to fontconfig (e.g. chrome), or intentionally
# ignore it.  I personally find the full hinting of autohint to not
# look nice.  This flag will force slight hinting of autohint
# within freetype, so you *KNOW* it will always work!  This is
# currently very much a dirty hack, and could crash your system,
# delete your files, or come alive and go on a murderous rampage.
#
# Possible values:
# true             - force slight hinting with autohint
# false            - do not force slight hinting with autohint
#
# Default:     false
# Recommended: true

export INFINALITY_FT_AUTOFIT_FORCE_SLIGHT_HINTING=true

