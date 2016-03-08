Lists
=====


<div class="hidden">

<pre><span class=hs-linenum> 7: </span><span class='hs-keyword'>{-@</span> <span class='hs-conid'>LIQUID</span> <span class='hs-str'>"--short-names"</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum> 8: </span><span class='hs-keyword'>{-@</span> <span class='hs-conid'>LIQUID</span> <span class='hs-str'>"--no-termination"</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum> 9: </span>
<span class=hs-linenum>10: </span><span class='hs-comment'>-- CHECKBINDER prop_size</span>
<span class=hs-linenum>11: </span><span class='hs-comment'>-- CHECKBINDER empty</span>
<span class=hs-linenum>12: </span><span class='hs-comment'>-- CHECKBINDER add</span>
<span class=hs-linenum>13: </span><span class='hs-comment'>-- CHECKBINDER singleton</span>
<span class=hs-linenum>14: </span><span class='hs-comment'>-- CHECKBINDER prop_replicate</span>
<span class=hs-linenum>15: </span><span class='hs-comment'>-- CHECKBINDER prop_map</span>
<span class=hs-linenum>16: </span><span class='hs-comment'>-- CHECKBINDER foldr1</span>
<span class=hs-linenum>17: </span><span class='hs-comment'>-- CHECKBINDER prop_zipWith</span>
<span class=hs-linenum>18: </span><span class='hs-comment'>-- CHECKBINDER prop_concat</span>
<span class=hs-linenum>19: </span> 
<span class=hs-linenum>20: </span>
<span class=hs-linenum>21: </span><span class='hs-keyword'>module</span> <span class='hs-conid'>List</span> <span class='hs-layout'>(</span> <span class='hs-conid'>List</span>
<span class=hs-linenum>22: </span>            <span class='hs-layout'>,</span> <span class='hs-varid'>empty</span>
<span class=hs-linenum>23: </span>            <span class='hs-layout'>,</span> <span class='hs-varid'>add</span>
<span class=hs-linenum>24: </span>            <span class='hs-layout'>,</span> <span class='hs-varid'>singleton</span>
<span class=hs-linenum>25: </span>            <span class='hs-layout'>,</span> <span class='hs-varid'>map</span>
<span class=hs-linenum>26: </span>            <span class='hs-layout'>,</span> <span class='hs-varid'>replicate</span>
<span class=hs-linenum>27: </span>            <span class='hs-layout'>,</span> <span class='hs-varid'>foldr</span>
<span class=hs-linenum>28: </span>            <span class='hs-layout'>,</span> <span class='hs-varid'>foldr1</span>
<span class=hs-linenum>29: </span>            <span class='hs-layout'>,</span> <span class='hs-varid'>zipWith</span>
<span class=hs-linenum>30: </span>            <span class='hs-layout'>,</span> <span class='hs-varid'>concat</span>
<span class=hs-linenum>31: </span>            <span class='hs-layout'>)</span> <span class='hs-keyword'>where</span>
<span class=hs-linenum>32: </span>
<span class=hs-linenum>33: </span><span class='hs-keyword'>import</span> <span class='hs-conid'>Assert</span>
<span class=hs-linenum>34: </span><span class='hs-keyword'>import</span> <span class='hs-conid'>Prelude</span> <span class='hs-varid'>hiding</span> <span class='hs-layout'>(</span><span class='hs-varid'>length</span><span class='hs-layout'>,</span> <span class='hs-varid'>replicate</span><span class='hs-layout'>,</span> <span class='hs-varid'>foldr</span><span class='hs-layout'>,</span> <span class='hs-varid'>foldr1</span><span class='hs-layout'>,</span> <span class='hs-varid'>map</span><span class='hs-layout'>,</span> <span class='hs-varid'>concat</span><span class='hs-layout'>,</span> <span class='hs-varid'>zipWith</span><span class='hs-layout'>)</span>
<span class=hs-linenum>35: </span>
<span class=hs-linenum>36: </span><span class='hs-keyword'>infixr</span> <span class='hs-num'>9</span> <span class='hs-conop'>:+:</span>
<span class=hs-linenum>37: </span>
<span class=hs-linenum>38: </span><span class='hs-definition'>empty</span>     <span class='hs-keyglyph'>::</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span>
<span class=hs-linenum>39: </span><span class='hs-definition'>add</span>       <span class='hs-keyglyph'>::</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span>
<span class=hs-linenum>40: </span><span class='hs-definition'>singleton</span> <span class='hs-keyglyph'>::</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span>
<span class=hs-linenum>41: </span><span class='hs-definition'>replicate</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>Int</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span>
<span class=hs-linenum>42: </span><span class='hs-definition'>map</span>       <span class='hs-keyglyph'>::</span> <span class='hs-layout'>(</span><span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>b</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>b</span>
<span class=hs-linenum>43: </span><span class='hs-definition'>zipWith</span>   <span class='hs-keyglyph'>::</span> <span class='hs-layout'>(</span><span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>b</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>c</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>b</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>c</span>
<span class=hs-linenum>44: </span><span class='hs-definition'>concat</span>    <span class='hs-keyglyph'>::</span> <span class='hs-conid'>List</span> <span class='hs-layout'>(</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span>
</pre>

A Sized List Datatype
---------------------

Lets cook up our own `List` data type from scratch:


<pre><span class=hs-linenum>53: </span><span class='hs-keyword'>data</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>=</span> <span class='hs-conid'>Emp</span>
<span class=hs-linenum>54: </span>            <span class='hs-keyglyph'>|</span> <span class='hs-layout'>(</span><span class='hs-conop'>:+:</span><span class='hs-layout'>)</span> <span class='hs-varid'>a</span> <span class='hs-layout'>(</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span><span class='hs-layout'>)</span>
<span class=hs-linenum>55: </span>              <span class='hs-keyword'>deriving</span> <span class='hs-layout'>(</span><a class=annot href="#"><span class=annottext>(Eq a) =&gt; (Eq (List a))</span><span class='hs-conid'>Eq</span></a><span class='hs-layout'>,</span> <a class=annot href="#"><span class=annottext>(Eq (List a), Ord a) =&gt; (Ord (List a))</span><span class='hs-conid'>Ord</span></a><span class='hs-layout'>,</span> <a class=annot href="#"><span class=annottext>(Show a) =&gt; (Show (List a))</span><span class='hs-conid'>Show</span></a><span class='hs-layout'>)</span>
</pre>

We can write a **measure** that logically represents
the *size*, i.e. number of elements of a `List`:


<pre><span class=hs-linenum>62: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>measure</span> <span class='hs-varid'>size</span>      <span class='hs-keyglyph'>::</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>Int</span>
<span class=hs-linenum>63: </span>    <span class='hs-varid'>size</span> <span class='hs-layout'>(</span><span class='hs-conid'>Emp</span><span class='hs-layout'>)</span>        <span class='hs-keyglyph'>=</span> <span class='hs-num'>0</span>
<span class=hs-linenum>64: </span>    <span class='hs-varid'>size</span> <span class='hs-layout'>(</span><span class='hs-layout'>(</span><span class='hs-conop'>:+:</span><span class='hs-layout'>)</span> <span class='hs-varid'>x</span> <span class='hs-varid'>xs</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>=</span> <span class='hs-num'>1</span> <span class='hs-varop'>+</span> <span class='hs-varid'>size</span> <span class='hs-varid'>xs</span>
<span class=hs-linenum>65: </span>  <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>66: </span>
<span class=hs-linenum>67: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>invariant</span> <span class='hs-keyword'>{v:</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyword'>| 0 &lt;= size v}</span> <span class='hs-keyword'>@-}</span>
</pre>

It will be helpful to have a few abbreviations. First,
lists whose size is equal to `N`


<pre><span class=hs-linenum>74: </span><span class='hs-keyword'>{-@</span> <span class='hs-keyword'>type</span> <span class='hs-conid'>ListN</span> <span class='hs-varid'>a</span> <span class='hs-conid'>N</span>  <span class='hs-keyglyph'>=</span> <span class='hs-layout'>{</span><span class='hs-varid'>v</span><span class='hs-conop'>:</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>|</span> <span class='hs-varid'>size</span> <span class='hs-varid'>v</span> <span class='hs-keyglyph'>=</span> <span class='hs-conid'>N</span><span class='hs-layout'>}</span> <span class='hs-keyword'>@-}</span>
</pre>
and then, lists whose size equals that of *another* list `Xs`:


<pre><span class=hs-linenum>79: </span><span class='hs-keyword'>{-@</span> <span class='hs-keyword'>type</span> <span class='hs-conid'>ListX</span> <span class='hs-varid'>a</span> <span class='hs-conid'>Xs</span> <span class='hs-keyglyph'>=</span> <span class='hs-layout'>{</span><span class='hs-varid'>v</span><span class='hs-conop'>:</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>|</span> <span class='hs-varid'>size</span> <span class='hs-varid'>v</span> <span class='hs-keyglyph'>=</span> <span class='hs-varid'>size</span> <span class='hs-conid'>Xs</span><span class='hs-layout'>}</span> <span class='hs-keyword'>@-}</span>
</pre>

(a) Computing the Length of a List
----------------------------------

Write down a *refined* type for `length`:


<pre><span class=hs-linenum>88: </span><span class='hs-comment'>-- size is only defined for List, not ListN or ListX, so that is why you get unbound symbol error</span>
<span class=hs-linenum>89: </span><span class='hs-comment'>-- at first</span>
<span class=hs-linenum>90: </span>
<span class=hs-linenum>91: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>length</span> <span class='hs-keyglyph'>::</span> <span class='hs-varid'>lst</span><span class='hs-conop'>:</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-keyword'>{v:</span><span class='hs-conid'>Int</span> <span class='hs-keyword'>| v == size(lst)}</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>92: </span><span class='hs-definition'>length</span>            <span class='hs-keyglyph'>::</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>Int</span>
<span class=hs-linenum>93: </span><a class=annot href="#"><span class=annottext>x1:(List a) -&gt; {v : Int | v == size x1}</span><span class='hs-definition'>length</span></a> <span class='hs-conid'>Emp</span>        <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>x1:Int# -&gt; {v : Int | v == (x1 : int)}</span><span class='hs-num'>0</span></a>
<span class=hs-linenum>94: </span><span class='hs-definition'>length</span> <span class='hs-layout'>(</span><span class='hs-varid'>x</span> <span class='hs-conop'>:+:</span> <span class='hs-varid'>xs</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>Int</span><span class='hs-num'>1</span></a> <a class=annot href="#"><span class=annottext>x1:Int -&gt; x2:Int -&gt; {v : Int | v == x1 + x2}</span><span class='hs-varop'>+</span></a> <a class=annot href="#"><span class=annottext>Int</span><span class='hs-varid'>length</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == xs}</span><span class='hs-varid'>xs</span></a>
</pre>

such that the following type checks:


<pre><span class=hs-linenum>100: </span>
<span class=hs-linenum>101: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>prop_size</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>TRUE</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>102: </span><a class=annot href="#"><span class=annottext>{v : Bool | Prop v}</span><span class='hs-definition'>prop_size</span></a>  <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : Bool | Prop v} -&gt; {v : Bool | Prop v}</span><span class='hs-varid'>lAssert</span></a> <a class=annot href="#"><span class=annottext>Bool</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>Int</span><span class='hs-varid'>length</span></a> <a class=annot href="#"><span class=annottext>{v : (List Int) | v == List.l3}</span><span class='hs-varid'>l3</span></a> <a class=annot href="#"><span class=annottext>x1:Int -&gt; x2:Int -&gt; {v : Bool | Prop v &lt;=&gt; x1 == x2}</span><span class='hs-varop'>==</span></a> <a class=annot href="#"><span class=annottext>Int</span><span class='hs-num'>3</span></a><span class='hs-layout'>)</span>
<span class=hs-linenum>103: </span>
<span class=hs-linenum>104: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>l3</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>ListN</span> <span class='hs-conid'>Int</span> <span class='hs-num'>3</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>105: </span><a class=annot href="#"><span class=annottext>{v : (List Int) | size v == 3}</span><span class='hs-definition'>l3</span></a>     <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>Int</span><span class='hs-num'>3</span></a> <span class='hs-conop'>:+:</span> <a class=annot href="#"><span class=annottext>{v : (List Int) | v == List.l2}</span><span class='hs-varid'>l2</span></a>
<span class=hs-linenum>106: </span>
<span class=hs-linenum>107: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>l2</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>ListN</span> <span class='hs-conid'>Int</span> <span class='hs-num'>2</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>108: </span><a class=annot href="#"><span class=annottext>{v : (List Int) | size v == 2}</span><span class='hs-definition'>l2</span></a>     <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>Int</span><span class='hs-num'>2</span></a> <span class='hs-conop'>:+:</span> <a class=annot href="#"><span class=annottext>{v : (List Int) | v == List.l1}</span><span class='hs-varid'>l1</span></a>
<span class=hs-linenum>109: </span>
<span class=hs-linenum>110: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>l1</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>ListN</span> <span class='hs-conid'>Int</span> <span class='hs-num'>1</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>111: </span><a class=annot href="#"><span class=annottext>{v : (List Int) | size v == 1}</span><span class='hs-definition'>l1</span></a>     <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>Int</span><span class='hs-num'>1</span></a> <span class='hs-conop'>:+:</span> <a class=annot href="#"><span class=annottext>{v : (List Int) | v == List.l0}</span><span class='hs-varid'>l0</span></a>
<span class=hs-linenum>112: </span>
<span class=hs-linenum>113: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>l0</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>ListN</span> <span class='hs-conid'>Int</span> <span class='hs-num'>0</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>114: </span><a class=annot href="#"><span class=annottext>{v : (List Int) | size v == 0}</span><span class='hs-definition'>l0</span></a>     <span class='hs-keyglyph'>=</span> <span class='hs-conid'>Emp</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>List</span> <span class='hs-conid'>Int</span>
</pre>


(b) Constructing Lists
----------------------

Fill in the implementations of the following functions so that
LiquidHaskell verifies respect the given type signatures:


<pre><span class=hs-linenum>125: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>empty</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>ListN</span> <span class='hs-varid'>a</span> <span class='hs-num'>0</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>126: </span><a class=annot href="#"><span class=annottext>{v : (List a) | size v == 0}</span><span class='hs-definition'>empty</span></a> <span class='hs-keyglyph'>=</span> <span class='hs-conid'>Emp</span>
<span class=hs-linenum>127: </span>
<span class=hs-linenum>128: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>add</span> <span class='hs-keyglyph'>::</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>xs</span><span class='hs-conop'>:</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>ListN</span> <span class='hs-varid'>a</span> <span class='hs-keyword'>{1 + size xs}</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>129: </span><a class=annot href="#"><span class=annottext>a -&gt; x2:(List a) -&gt; {v : (List a) | size v == 1 + size x2}</span><span class='hs-definition'>add</span></a> <a class=annot href="#"><span class=annottext>a</span><span class='hs-varid'>x</span></a> <a class=annot href="#"><span class=annottext>(List a)</span><span class='hs-varid'>xs</span></a> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{VV : a | VV == x}</span><span class='hs-varid'>x</span></a> <span class='hs-conop'>:+:</span> <a class=annot href="#"><span class=annottext>{v : (List a) | v == xs}</span><span class='hs-varid'>xs</span></a>
<span class=hs-linenum>130: </span>
<span class=hs-linenum>131: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>singleton</span> <span class='hs-keyglyph'>::</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>ListN</span> <span class='hs-varid'>a</span> <span class='hs-num'>1</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>132: </span><a class=annot href="#"><span class=annottext>a -&gt; {v : (List a) | size v == 1}</span><span class='hs-definition'>singleton</span></a> <a class=annot href="#"><span class=annottext>a</span><span class='hs-varid'>x</span></a> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>x1:(List a) -&gt; {v : (List a) | size v == 1 + size x1}</span><span class='hs-varid'>add</span></a> <a class=annot href="#"><span class=annottext>{VV : a | VV == x}</span><span class='hs-varid'>x</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | allSize v == 0 &amp;&amp; size v == 0}</span><span class='hs-conid'>Emp</span></a>
</pre>

(c) Replicating Values
----------------------

Fill in the code, and update the refinement type specification
for `replicate n x` which should return a `List` `n` copies of
the value `x`:


<pre><span class=hs-linenum>143: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>replicate</span> <span class='hs-keyglyph'>::</span> <span class='hs-varid'>n</span><span class='hs-conop'>:</span><span class='hs-conid'>Int</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>ListN</span> <span class='hs-varid'>a</span> <span class='hs-varid'>n</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>144: </span><a class=annot href="#"><span class=annottext>x1:Int -&gt; a -&gt; {v : (List a) | size v == x1}</span><span class='hs-definition'>replicate</span></a>  <a class=annot href="#"><span class=annottext>Int</span><span class='hs-varid'>n</span></a> <a class=annot href="#"><span class=annottext>a</span><span class='hs-varid'>a</span></a> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>x1:(List a) -&gt; {v : (List a) | size v == 1 + size x1}</span><span class='hs-varid'>add</span></a> <a class=annot href="#"><span class=annottext>{VV : a | VV == a}</span><span class='hs-varid'>a</span></a> <a class=annot href="#"><span class=annottext>(List a)</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>x1:Int -&gt; a -&gt; {v : (List a) | size v == x1}</span><span class='hs-varid'>replicate</span></a> <a class=annot href="#"><span class=annottext>Int</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>{v : Int | v == n}</span><span class='hs-varid'>n</span></a><a class=annot href="#"><span class=annottext>x1:Int -&gt; x2:Int -&gt; {v : Int | v == x1 - x2}</span><span class='hs-comment'>-</span></a><a class=annot href="#"><span class=annottext>Int</span><span class='hs-num'>1</span></a><span class='hs-layout'>)</span> <a class=annot href="#"><span class=annottext>{VV : a | VV == a}</span><span class='hs-varid'>a</span></a><span class='hs-layout'>)</span>
</pre>

When you are done, the following assertion should be verified by LH.


<pre><span class=hs-linenum>150: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>prop_replicate</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>Nat</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>TRUE</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>151: </span><a class=annot href="#"><span class=annottext>{v : Int | v &gt;= 0} -&gt; a -&gt; {v : Bool | Prop v}</span><span class='hs-definition'>prop_replicate</span></a> <a class=annot href="#"><span class=annottext>{v : Int | v &gt;= 0}</span><span class='hs-varid'>n</span></a> <a class=annot href="#"><span class=annottext>a</span><span class='hs-varid'>x</span></a> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : Bool | Prop v} -&gt; {v : Bool | Prop v}</span><span class='hs-varid'>lAssert</span></a> <a class=annot href="#"><span class=annottext>Bool</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>{v : Int | v == n}</span><span class='hs-varid'>n</span></a> <a class=annot href="#"><span class=annottext>x1:Int -&gt; x2:Int -&gt; {v : Bool | Prop v &lt;=&gt; x1 == x2}</span><span class='hs-varop'>==</span></a> <a class=annot href="#"><span class=annottext>Int</span><span class='hs-varid'>length</span></a> <a class=annot href="#"><span class=annottext>(List a)</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>x1:Int -&gt; a -&gt; {v : (List a) | size v == x1}</span><span class='hs-varid'>replicate</span></a> <a class=annot href="#"><span class=annottext>{v : Int | v == n}</span><span class='hs-varid'>n</span></a> <a class=annot href="#"><span class=annottext>{VV : a | VV == x}</span><span class='hs-varid'>x</span></a><span class='hs-layout'>)</span><span class='hs-layout'>)</span>
</pre>

(d) Map
-------

Fix the specification for `map` such that the assertion in `prop_map`
is verified by LH. (This will require you to first complete part (a) above.)


<pre><span class=hs-linenum>161: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>map</span> <span class='hs-keyglyph'>::</span> <span class='hs-layout'>(</span><span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>b</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>lst</span><span class='hs-conop'>:</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>ListN</span> <span class='hs-varid'>b</span> <span class='hs-keyword'>{size lst}</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>162: </span><a class=annot href="#"><span class=annottext>(a -&gt; b) -&gt; x3:(List a) -&gt; {v : (List b) | size v == size x3}</span><span class='hs-definition'>map</span></a> <a class=annot href="#"><span class=annottext>a -&gt; b</span><span class='hs-varid'>f</span></a> <span class='hs-conid'>Emp</span>        <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : (List a) | allSize v == 0 &amp;&amp; size v == 0}</span><span class='hs-conid'>Emp</span></a>
<span class=hs-linenum>163: </span><span class='hs-definition'>map</span> <span class='hs-varid'>f</span> <span class='hs-layout'>(</span><span class='hs-varid'>x</span> <span class='hs-conop'>:+:</span> <span class='hs-varid'>xs</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>a -&gt; b</span><span class='hs-varid'>f</span></a> <a class=annot href="#"><span class=annottext>{VV : a | VV == x}</span><span class='hs-varid'>x</span></a> <span class='hs-conop'>:+:</span> <a class=annot href="#"><span class=annottext>(a -&gt; b) -&gt; x3:(List a) -&gt; {v : (List b) | size v == size x3}</span><span class='hs-varid'>map</span></a> <a class=annot href="#"><span class=annottext>a -&gt; b</span><span class='hs-varid'>f</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == xs}</span><span class='hs-varid'>xs</span></a>
<span class=hs-linenum>164: </span>
<span class=hs-linenum>165: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>prop_map</span> <span class='hs-keyglyph'>::</span> <span class='hs-layout'>(</span><span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>b</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>TRUE</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>166: </span><a class=annot href="#"><span class=annottext>(b -&gt; a) -&gt; (List b) -&gt; {v : Bool | Prop v}</span><span class='hs-definition'>prop_map</span></a> <a class=annot href="#"><span class=annottext>a -&gt; b</span><span class='hs-varid'>f</span></a> <a class=annot href="#"><span class=annottext>(List a)</span><span class='hs-varid'>xs</span></a> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : Bool | Prop v} -&gt; {v : Bool | Prop v}</span><span class='hs-varid'>lAssert</span></a> <a class=annot href="#"><span class=annottext>Bool</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>Int</span><span class='hs-varid'>length</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == xs}</span><span class='hs-varid'>xs</span></a> <a class=annot href="#"><span class=annottext>x1:Int -&gt; x2:Int -&gt; {v : Bool | Prop v &lt;=&gt; x1 == x2}</span><span class='hs-varop'>==</span></a> <a class=annot href="#"><span class=annottext>Int</span><span class='hs-varid'>length</span></a> <a class=annot href="#"><span class=annottext>(List a)</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>(a -&gt; b) -&gt; x3:(List a) -&gt; {v : (List b) | size v == size x3}</span><span class='hs-varid'>map</span></a> <a class=annot href="#"><span class=annottext>a -&gt; b</span><span class='hs-varid'>f</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == xs}</span><span class='hs-varid'>xs</span></a><span class='hs-layout'>)</span><span class='hs-layout'>)</span>
</pre>

(e) Fold
--------

Fix the specification for `foldr1` so that the call to `die` is
verified by LH:


<pre><span class=hs-linenum>176: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>foldr1</span> <span class='hs-keyglyph'>::</span> <span class='hs-layout'>(</span><span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>a</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-keyword'>{v:</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyword'>| size v &gt; 0}</span>  <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>a</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>177: </span><a class=annot href="#"><span class=annottext>(a -&gt; a -&gt; a) -&gt; {v : (List a) | size v &gt; 0} -&gt; a</span><span class='hs-definition'>foldr1</span></a> <a class=annot href="#"><span class=annottext>a -&gt; a -&gt; a</span><span class='hs-varid'>op</span></a> <span class='hs-layout'>(</span><span class='hs-varid'>x</span> <span class='hs-conop'>:+:</span> <span class='hs-varid'>xs</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>(a -&gt; b -&gt; b) -&gt; b -&gt; (List a) -&gt; b</span><span class='hs-varid'>foldr</span></a> <a class=annot href="#"><span class=annottext>a -&gt; a -&gt; a</span><span class='hs-varid'>op</span></a> <a class=annot href="#"><span class=annottext>{VV : a | VV == x}</span><span class='hs-varid'>x</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == xs}</span><span class='hs-varid'>xs</span></a>
<span class=hs-linenum>178: </span><span class='hs-definition'>foldr1</span> <span class='hs-varid'>op</span> <span class='hs-conid'>Emp</span>        <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : [Char] | false} -&gt; a</span><span class='hs-varid'>die</span></a> <a class=annot href="#"><span class=annottext>[Char]</span><span class='hs-str'>"Cannot call foldr1 with empty list"</span></a>
<span class=hs-linenum>179: </span>
<span class=hs-linenum>180: </span>
<span class=hs-linenum>181: </span><span class='hs-definition'>foldr</span> <span class='hs-keyglyph'>::</span> <span class='hs-layout'>(</span><span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>b</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>b</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>b</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>b</span>
<span class=hs-linenum>182: </span><a class=annot href="#"><span class=annottext>(a -&gt; b -&gt; b) -&gt; b -&gt; (List a) -&gt; b</span><span class='hs-definition'>foldr</span></a> <span class='hs-keyword'>_</span>  <a class=annot href="#"><span class=annottext>a</span><span class='hs-varid'>b</span></a> <span class='hs-conid'>Emp</span>        <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{VV : a | VV == b}</span><span class='hs-varid'>b</span></a>
<span class=hs-linenum>183: </span><span class='hs-definition'>foldr</span> <span class='hs-varid'>op</span> <span class='hs-varid'>b</span> <span class='hs-layout'>(</span><span class='hs-varid'>x</span> <span class='hs-conop'>:+:</span> <span class='hs-varid'>xs</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{VV : a | VV == x}</span><span class='hs-varid'>x</span></a> <a class=annot href="#"><span class=annottext>a -&gt; b -&gt; b</span><span class='hs-varop'>`op`</span></a> <a class=annot href="#"><span class=annottext>a</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>(a -&gt; b -&gt; b) -&gt; b -&gt; (List a) -&gt; b</span><span class='hs-varid'>foldr</span></a> <a class=annot href="#"><span class=annottext>a -&gt; b -&gt; b</span><span class='hs-varid'>op</span></a> <a class=annot href="#"><span class=annottext>{VV : a | VV == b}</span><span class='hs-varid'>b</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == xs}</span><span class='hs-varid'>xs</span></a><span class='hs-layout'>)</span>
</pre>

(f) ZipWith
-----------

Fix the specification of `zipWith` so that LH verifies:

+ The call to `die` inside `zipWith` and
+ The assert inside `prop_zipwith`.


<pre><span class=hs-linenum>195: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>zipWith</span> <span class='hs-keyglyph'>::</span> <span class='hs-layout'>(</span><span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>b</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>c</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>l1</span><span class='hs-conop'>:</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>ListN</span> <span class='hs-varid'>b</span> <span class='hs-keyword'>{size l1}</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>ListN</span> <span class='hs-varid'>c</span> <span class='hs-keyword'>{size l1}</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>196: </span><a class=annot href="#"><span class=annottext>(a -&gt; b -&gt; c) -&gt; x4:(List a) -&gt; {v : (List b) | size v == size x4} -&gt; {v : (List c) | size v == size x4}</span><span class='hs-definition'>zipWith</span></a> <span class='hs-keyword'>_</span> <span class='hs-conid'>Emp</span> <span class='hs-conid'>Emp</span>               <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : (List a) | allSize v == 0 &amp;&amp; size v == 0}</span><span class='hs-conid'>Emp</span></a>
<span class=hs-linenum>197: </span><span class='hs-definition'>zipWith</span> <span class='hs-varid'>f</span> <span class='hs-layout'>(</span><span class='hs-varid'>x</span> <span class='hs-conop'>:+:</span> <span class='hs-varid'>xs</span><span class='hs-layout'>)</span> <span class='hs-layout'>(</span><span class='hs-varid'>y</span> <span class='hs-conop'>:+:</span> <span class='hs-varid'>ys</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>a -&gt; b -&gt; c</span><span class='hs-varid'>f</span></a> <a class=annot href="#"><span class=annottext>{VV : a | VV == x}</span><span class='hs-varid'>x</span></a> <a class=annot href="#"><span class=annottext>{VV : a | VV == y}</span><span class='hs-varid'>y</span></a> <span class='hs-conop'>:+:</span> <a class=annot href="#"><span class=annottext>(a -&gt; b -&gt; c) -&gt; x4:(List a) -&gt; {v : (List b) | size v == size x4} -&gt; {v : (List c) | size v == size x4}</span><span class='hs-varid'>zipWith</span></a> <a class=annot href="#"><span class=annottext>a -&gt; b -&gt; c</span><span class='hs-varid'>f</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == xs}</span><span class='hs-varid'>xs</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == ys}</span><span class='hs-varid'>ys</span></a>
<span class=hs-linenum>198: </span><span class='hs-definition'>zipWith</span> <span class='hs-varid'>f</span> <span class='hs-keyword'>_</span>          <span class='hs-keyword'>_</span>          <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : [Char] | false} -&gt; a</span><span class='hs-varid'>die</span></a>  <a class=annot href="#"><span class=annottext>[Char]</span><span class='hs-str'>"Bad call to zipWith"</span></a>
<span class=hs-linenum>199: </span>
<span class=hs-linenum>200: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>prop_zipWith</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>Num</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>=&gt;</span> <span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>TRUE</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>201: </span><a class=annot href="#"><span class=annottext>(Num a) =&gt; (List a) -&gt; {v : Bool | Prop v}</span><span class='hs-definition'>prop_zipWith</span></a> <a class=annot href="#"><span class=annottext>(List a)</span><span class='hs-varid'>xs</span></a> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : Bool | Prop v} -&gt; {v : Bool | Prop v}</span><span class='hs-varid'>lAssert</span></a> <a class=annot href="#"><span class=annottext>Bool</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>Int</span><span class='hs-varid'>length</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == xs}</span><span class='hs-varid'>xs</span></a> <a class=annot href="#"><span class=annottext>x1:Int -&gt; x2:Int -&gt; {v : Bool | Prop v &lt;=&gt; x1 == x2}</span><span class='hs-varop'>==</span></a> <a class=annot href="#"><span class=annottext>Int</span><span class='hs-varid'>length</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == x2s}</span><span class='hs-varid'>x2s</span></a><span class='hs-layout'>)</span>
<span class=hs-linenum>202: </span>  <span class='hs-keyword'>where</span>
<span class=hs-linenum>203: </span>    <a class=annot href="#"><span class=annottext>{v : (List a) | size v == size xs}</span><span class='hs-varid'>x2s</span></a>         <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>(a -&gt; b -&gt; c) -&gt; x4:(List a) -&gt; {v : (List b) | size v == size x4} -&gt; {v : (List c) | size v == size x4}</span><span class='hs-varid'>zipWith</span></a> <a class=annot href="#"><span class=annottext>x1:a -&gt; x2:a -&gt; {VV : a | VV == x1 + x2}</span><span class='hs-layout'>(</span></a><span class='hs-varop'>+</span><span class='hs-layout'>)</span> <a class=annot href="#"><span class=annottext>{v : (List a) | v == xs}</span><span class='hs-varid'>xs</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == xs}</span><span class='hs-varid'>xs</span></a>
</pre>

(g) List Concatenation *(Hard?)*
--------------------------------

Fill in the (refinement type) specification and
implementation for the function `concat` such that
when you are done, the assert inside `prop_concat`
is verified by LH. Feel free to write any other code
or specification (types, measures) that you need.


<pre><span class=hs-linenum>216: </span>
<span class=hs-linenum>217: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>measure</span> <span class='hs-varid'>allSize</span>      <span class='hs-keyglyph'>::</span> <span class='hs-conid'>List</span> <span class='hs-layout'>(</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>Int</span>
<span class=hs-linenum>218: </span>    <span class='hs-varid'>allSize</span> <span class='hs-layout'>(</span><span class='hs-conid'>Emp</span><span class='hs-layout'>)</span>        <span class='hs-keyglyph'>=</span> <span class='hs-num'>0</span>
<span class=hs-linenum>219: </span>    <span class='hs-varid'>allSize</span> <span class='hs-layout'>(</span><span class='hs-layout'>(</span><span class='hs-conop'>:+:</span><span class='hs-layout'>)</span> <span class='hs-varid'>x</span> <span class='hs-varid'>xs</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>=</span> <span class='hs-layout'>(</span><span class='hs-varid'>size</span> <span class='hs-varid'>x</span><span class='hs-layout'>)</span> <span class='hs-varop'>+</span> <span class='hs-varid'>allSize</span> <span class='hs-varid'>xs</span>
<span class=hs-linenum>220: </span><span class='hs-keyword'>@-}</span>
<span class=hs-linenum>221: </span>
<span class=hs-linenum>222: </span>
<span class=hs-linenum>223: </span>
<span class=hs-linenum>224: </span>
<span class=hs-linenum>225: </span>
<span class=hs-linenum>226: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>concat'</span> <span class='hs-keyglyph'>::</span> <span class='hs-varid'>l1</span><span class='hs-conop'>:</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>l2</span><span class='hs-conop'>:</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>ListN</span> <span class='hs-varid'>a</span> <span class='hs-keyword'>{size l1 + size l2}</span>  <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>227: </span><a class=annot href="#"><span class=annottext>x1:(List a) -&gt; x2:(List a) -&gt; {v : (List a) | size v == size x1 + size x2}</span><span class='hs-definition'>concat'</span></a> <span class='hs-conid'>Emp</span> <span class='hs-conid'>Emp</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : (List a) | allSize v == 0 &amp;&amp; size v == 0}</span><span class='hs-conid'>Emp</span></a>
<span class=hs-linenum>228: </span><span class='hs-definition'>concat'</span> <span class='hs-conid'>Emp</span> <span class='hs-varid'>l2</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>(List a)</span><span class='hs-varid'>l2</span></a>
<span class=hs-linenum>229: </span><span class='hs-definition'>concat'</span> <span class='hs-varid'>l1</span> <span class='hs-conid'>Emp</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>(List a)</span><span class='hs-varid'>l1</span></a>
<span class=hs-linenum>230: </span><span class='hs-definition'>concat'</span> <span class='hs-layout'>(</span><span class='hs-varid'>x</span> <span class='hs-conop'>:+:</span> <span class='hs-varid'>xs</span><span class='hs-layout'>)</span> <span class='hs-varid'>l2</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>x1:(List a) -&gt; x2:(List a) -&gt; {v : (List a) | size v == size x1 + size x2}</span><span class='hs-varid'>concat'</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == xs}</span><span class='hs-varid'>xs</span></a>  <a class=annot href="#"><span class=annottext>(List a)</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>{VV : a | VV == x}</span><span class='hs-varid'>x</span></a> <span class='hs-conop'>:+:</span> <a class=annot href="#"><span class=annottext>(List a)</span><span class='hs-varid'>l2</span></a><span class='hs-layout'>)</span>
<span class=hs-linenum>231: </span>
<span class=hs-linenum>232: </span>
<span class=hs-linenum>233: </span>
<span class=hs-linenum>234: </span>
<span class=hs-linenum>235: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>concat</span> <span class='hs-keyglyph'>::</span> <span class='hs-varid'>lst</span><span class='hs-conop'>:</span><span class='hs-conid'>List</span> <span class='hs-layout'>(</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-keyword'>{v:</span><span class='hs-conid'>List</span> <span class='hs-varid'>a</span> <span class='hs-keyword'>| size(v) == allSize(lst)}</span>  <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>236: </span><a class=annot href="#"><span class=annottext>x1:(List (List a)) -&gt; {v : (List a) | size v == allSize x1}</span><span class='hs-definition'>concat</span></a> <span class='hs-conid'>Emp</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : (List a) | allSize v == 0 &amp;&amp; size v == 0}</span><span class='hs-conid'>Emp</span></a>
<span class=hs-linenum>237: </span><span class='hs-definition'>concat</span> <span class='hs-layout'>(</span><span class='hs-varid'>x</span> <span class='hs-conop'>:+:</span> <span class='hs-varid'>xs</span><span class='hs-layout'>)</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>x1:(List a) -&gt; x2:(List a) -&gt; {v : (List a) | size v == size x1 + size x2}</span><span class='hs-varid'>concat'</span></a> <a class=annot href="#"><span class=annottext>{v : (List a) | v == x}</span><span class='hs-varid'>x</span></a> <a class=annot href="#"><span class=annottext>(List a)</span><span class='hs-layout'>(</span></a><span class='hs-varid'>concat</span> <a class=annot href="#"><span class=annottext>{v : (List (List a)) | v == xs}</span><span class='hs-varid'>xs</span></a><span class='hs-layout'>)</span>
<span class=hs-linenum>238: </span>
<span class=hs-linenum>239: </span><a class=annot href="#"><span class=annottext>Bool</span><span class='hs-definition'>prop_concat</span></a> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : Bool | Prop v} -&gt; {v : Bool | Prop v}</span><span class='hs-varid'>lAssert</span></a> <a class=annot href="#"><span class=annottext>Bool</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>Int</span><span class='hs-varid'>length</span></a> <a class=annot href="#"><span class=annottext>(List Int)</span><span class='hs-layout'>(</span></a><span class='hs-varid'>concat</span> <a class=annot href="#"><span class=annottext>{v : (List (List Int)) | v == xss}</span><span class='hs-varid'>xss</span></a><span class='hs-layout'>)</span> <a class=annot href="#"><span class=annottext>x1:Int -&gt; x2:Int -&gt; {v : Bool | Prop v &lt;=&gt; x1 == x2}</span><span class='hs-varop'>==</span></a> <a class=annot href="#"><span class=annottext>Int</span><span class='hs-num'>6</span></a><span class='hs-layout'>)</span>
<span class=hs-linenum>240: </span>  <span class='hs-keyword'>where</span>
<span class=hs-linenum>241: </span>    <a class=annot href="#"><span class=annottext>(List (List Int))</span><span class='hs-varid'>xss</span></a>     <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : (List Int) | v == List.l0}</span><span class='hs-varid'>l0</span></a> <span class='hs-conop'>:+:</span> <a class=annot href="#"><span class=annottext>{v : (List Int) | v == List.l1}</span><span class='hs-varid'>l1</span></a> <span class='hs-conop'>:+:</span> <a class=annot href="#"><span class=annottext>{v : (List Int) | v == List.l2}</span><span class='hs-varid'>l2</span></a> <span class='hs-conop'>:+:</span> <a class=annot href="#"><span class=annottext>{v : (List Int) | v == List.l3}</span><span class='hs-varid'>l3</span></a> <span class='hs-conop'>:+:</span> <a class=annot href="#"><span class=annottext>{v : (List a) | allSize v == 0 &amp;&amp; size v == 0}</span><span class='hs-conid'>Emp</span></a>
</pre>
