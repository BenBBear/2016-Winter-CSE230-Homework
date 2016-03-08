Assertions
==========

<div class="hidden">

<pre><span class=hs-linenum>6: </span><span class='hs-keyword'>module</span> <span class='hs-conid'>Assert</span> <span class='hs-layout'>(</span><span class='hs-varid'>die</span><span class='hs-layout'>,</span> <span class='hs-varid'>fixme</span><span class='hs-layout'>,</span> <span class='hs-varid'>lAssert</span><span class='hs-layout'>,</span> <span class='hs-varid'>divide</span><span class='hs-layout'>)</span> <span class='hs-keyword'>where</span>
<span class=hs-linenum>7: </span>
<span class=hs-linenum>8: </span><span class='hs-definition'>divide</span>     <span class='hs-keyglyph'>::</span> <span class='hs-conid'>Double</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>Int</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>Double</span>
<span class=hs-linenum>9: </span><span class='hs-keyword'>{-@</span> <span class='hs-conid'>LIQUID</span> <span class='hs-str'>"--short-names"</span>    <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>10: </span><span class='hs-keyword'>{-@</span> <span class='hs-conid'>LIQUID</span> <span class='hs-str'>"--no-termination"</span> <span class='hs-keyword'>@-}</span>
</pre>
</div>

As a warm up, first lets recall how we can specify and verify *assertions*
with Refinement Types.

Dead Code
---------


Recall from lecture, that we can define a function that should *never* be called.


<pre><span class=hs-linenum>24: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>die</span> <span class='hs-keyglyph'>::</span> <span class='hs-keyword'>{v:</span><span class='hs-conid'>String</span> <span class='hs-keyword'>| false}</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>a</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>25: </span><a class=annot href="#"><span class=annottext>{VV : [Char] | false} -&gt; a</span><span class='hs-definition'>die</span></a> <a class=annot href="#"><span class=annottext>{VV : [Char] | false}</span><span class='hs-varid'>str</span></a> <span class='hs-keyglyph'>=</span> <span class='hs-varid'>error</span> <a class=annot href="#"><span class=annottext>[Char]</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>[Char]</span><span class='hs-str'>"Oops, I died!"</span></a> <span class='hs-varop'>++</span> <a class=annot href="#"><span class=annottext>{v : [Char] | v == str}</span><span class='hs-varid'>str</span></a><span class='hs-layout'>)</span>
</pre>

We can use this function in all those places where we need to handle some case that we
can know (and want to prove) will never happen at run-time.

Here's a variant of `die` that we will use for those places where *you* need to fill in code:

<pre><span class=hs-linenum>33: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>fixme</span> <span class='hs-keyglyph'>::</span> <span class='hs-keyword'>{v:</span><span class='hs-conid'>String</span> <span class='hs-keyword'>| false}</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-varid'>a</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>34: </span><a class=annot href="#"><span class=annottext>{VV : [Char] | false} -&gt; a</span><span class='hs-definition'>fixme</span></a> <a class=annot href="#"><span class=annottext>{VV : [Char] | false}</span><span class='hs-varid'>str</span></a> <span class='hs-keyglyph'>=</span> <span class='hs-varid'>error</span> <a class=annot href="#"><span class=annottext>[Char]</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>[Char]</span><span class='hs-str'>"Oops, you didn't fill in the code for: "</span></a><span class='hs-varop'>++</span> <a class=annot href="#"><span class=annottext>{v : [Char] | v == str}</span><span class='hs-varid'>str</span></a><span class='hs-layout'>)</span>
</pre>


Assertions
----------

Lets define a refined type for the `Bool` that is *always* true:


<pre><span class=hs-linenum>44: </span><span class='hs-keyword'>{-@</span> <span class='hs-keyword'>type</span> <span class='hs-conid'>TRUE</span> <span class='hs-keyglyph'>=</span> <span class='hs-layout'>{</span><span class='hs-varid'>v</span><span class='hs-conop'>:</span><span class='hs-conid'>Bool</span> <span class='hs-keyglyph'>|</span> <span class='hs-conid'>Prop</span> <span class='hs-varid'>v</span><span class='hs-layout'>}</span> <span class='hs-keyword'>@-}</span>
</pre>

Notice that we can now assign the type `TRUE` to any `Bool` expression
that is guaranteed to evaluate to `True`:


<pre><span class=hs-linenum>51: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>one_plus_one_eq_two</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>TRUE</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>52: </span><a class=annot href="#"><span class=annottext>{v : Bool | Prop v}</span><span class='hs-definition'>one_plus_one_eq_two</span></a> <span class='hs-keyglyph'>=</span> <span class='hs-layout'>(</span><a class=annot href="#"><span class=annottext>Integer</span><span class='hs-num'>1</span></a> <a class=annot href="#"><span class=annottext>x1:Integer -&gt; x2:Integer -&gt; {v : Integer | v == x1 + x2}</span><span class='hs-varop'>+</span></a> <a class=annot href="#"><span class=annottext>Integer</span><span class='hs-num'>1</span></a> <a class=annot href="#"><span class=annottext>x1:Integer -&gt; x2:Integer -&gt; {v : Bool | Prop v &lt;=&gt; x1 == x2}</span><span class='hs-varop'>==</span></a> <a class=annot href="#"><span class=annottext>Integer</span><span class='hs-num'>2</span></a><span class='hs-layout'>)</span>
</pre>

But of course, not to expressions that are `False`:


<pre><span class=hs-linenum>58: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>one_plus_one_eq_three</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>TRUE</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>59: </span><a class=annot href="#"><span class=annottext>{v : Bool | Prop v}</span><span class='hs-definition'>one_plus_one_eq_three</span></a> <span class='hs-keyglyph'>=</span> <span class='hs-layout'>(</span><a class=annot href="#"><span class=annottext>Integer</span><span class='hs-num'>1</span></a> <a class=annot href="#"><span class=annottext>x1:Integer -&gt; x2:Integer -&gt; {v : Integer | v == x1 + x2}</span><span class='hs-varop'>+</span></a> <a class=annot href="#"><span class=annottext>Integer</span><span class='hs-num'>2</span></a> <a class=annot href="#"><span class=annottext>x1:Integer -&gt; x2:Integer -&gt; {v : Bool | Prop v &lt;=&gt; x1 == x2}</span><span class='hs-varop'>==</span></a> <a class=annot href="#"><span class=annottext>Integer</span><span class='hs-num'>3</span></a><span class='hs-layout'>)</span>  <span class='hs-comment'>-- TYPE ERROR</span>
</pre>

We can now use `TRUE` to define a `lAssert` function:


<pre><span class=hs-linenum>65: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>lAssert</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>TRUE</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>TRUE</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>66: </span><a class=annot href="#"><span class=annottext>{v : Bool | Prop v} -&gt; {v : Bool | Prop v}</span><span class='hs-definition'>lAssert</span></a> <span class='hs-conid'>True</span>  <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : Bool | v == GHC.Types.True}</span><span class='hs-conid'>True</span></a>
<span class=hs-linenum>67: </span><span class='hs-definition'>lAssert</span> <span class='hs-conid'>False</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : [Char] | false} -&gt; a</span><span class='hs-varid'>die</span></a> <a class=annot href="#"><span class=annottext>[Char]</span><span class='hs-str'>"Assert Fails!"</span></a>
</pre>

Now, we can call `lAssert` only on expressions that we want to prove
always hold, for example:


<pre><span class=hs-linenum>74: </span><a class=annot href="#"><span class=annottext>{VV : Bool | VV /= GHC.Types.False &amp;&amp; Prop VV}</span><span class='hs-definition'>propOk</span></a>   <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : Bool | Prop v} -&gt; {v : Bool | Prop v}</span><span class='hs-varid'>lAssert</span></a> <a class=annot href="#"><span class=annottext>Bool</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>Integer</span><span class='hs-num'>1</span></a> <a class=annot href="#"><span class=annottext>x1:Integer -&gt; x2:Integer -&gt; {v : Integer | v == x1 + x2}</span><span class='hs-varop'>+</span></a> <a class=annot href="#"><span class=annottext>Integer</span><span class='hs-num'>1</span></a> <a class=annot href="#"><span class=annottext>x1:Integer -&gt; x2:Integer -&gt; {v : Bool | Prop v &lt;=&gt; x1 == x2}</span><span class='hs-varop'>==</span></a> <a class=annot href="#"><span class=annottext>Integer</span><span class='hs-num'>2</span></a><span class='hs-layout'>)</span>
</pre>

But if we try to `lAssert` bogus facts then they are rejected:


<pre><span class=hs-linenum>80: </span><a class=annot href="#"><span class=annottext>{VV : Bool | VV /= GHC.Types.False &amp;&amp; Prop VV}</span><span class='hs-definition'>propFail</span></a> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : Bool | Prop v} -&gt; {v : Bool | Prop v}</span><span class='hs-varid'>lAssert</span></a> <a class=annot href="#"><span class=annottext>Bool</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>Integer</span><span class='hs-num'>2</span></a> <a class=annot href="#"><span class=annottext>x1:Integer -&gt; x2:Integer -&gt; {v : Integer | v == x1 + x2}</span><span class='hs-varop'>+</span></a> <a class=annot href="#"><span class=annottext>Integer</span><span class='hs-num'>1</span></a> <a class=annot href="#"><span class=annottext>x1:Integer -&gt; x2:Integer -&gt; {v : Bool | Prop v &lt;=&gt; x1 == x2}</span><span class='hs-varop'>==</span></a> <a class=annot href="#"><span class=annottext>Integer</span><span class='hs-num'>3</span></a><span class='hs-layout'>)</span> <span class='hs-comment'>-- TYPE ERROR</span>
</pre>

Divide By Zero
--------------

Finally, lets write a *safe* divide by zero operator (that we will use later)


<pre><span class=hs-linenum>89: </span><span class='hs-keyword'>{-@</span> <span class='hs-varid'>divide</span> <span class='hs-keyglyph'>::</span> <span class='hs-conid'>Double</span> <span class='hs-keyglyph'>-&gt;</span> <span class='hs-keyword'>{v:</span><span class='hs-conid'>Int</span> <span class='hs-keyword'>| v /= 0}</span><span class='hs-keyglyph'>-&gt;</span> <span class='hs-conid'>Double</span> <span class='hs-keyword'>@-}</span>
<span class=hs-linenum>90: </span><a class=annot href="#"><span class=annottext>Double -&gt; {v : Int | v /= 0} -&gt; Double</span><span class='hs-definition'>divide</span></a> <a class=annot href="#"><span class=annottext>Double</span><span class='hs-varid'>n</span></a> <span class='hs-num'>0</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : [Char] | false} -&gt; a</span><span class='hs-varid'>die</span></a> <a class=annot href="#"><span class=annottext>[Char]</span><span class='hs-str'>"oops divide by zero"</span></a>
<span class=hs-linenum>91: </span><span class='hs-definition'>divide</span> <span class='hs-varid'>n</span> <span class='hs-varid'>d</span> <span class='hs-keyglyph'>=</span> <a class=annot href="#"><span class=annottext>{v : Double | v == n}</span><span class='hs-varid'>n</span></a> <a class=annot href="#"><span class=annottext>x1:Double -&gt; x2:{v : Double | v /= 0} -&gt; {v : Double | v == x1 / x2}</span><span class='hs-varop'>/</span></a> <a class=annot href="#"><span class=annottext>Double</span><span class='hs-layout'>(</span></a><a class=annot href="#"><span class=annottext>x1:Int -&gt; {v : Double | v == x1}</span><span class='hs-varid'>fromIntegral</span></a> <a class=annot href="#"><span class=annottext>Int</span><span class='hs-varid'>d</span></a><span class='hs-layout'>)</span>
</pre>
