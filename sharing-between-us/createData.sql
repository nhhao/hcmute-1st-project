EXEC dbo.insPost @title = N'Everything About Callback Functions in JavaScript',
  @description = N'The callback function is one of those concepts that every JavaScript developer should know. Callbacks are used in arrays, timer functions, promises, event handlers, and much more.
In this post, I will explain the concept of a callback function. Also, I’ll help you distinguish the 2 types of callbacks: synchronous and asynchronous.',
  @content = N`<div class="y_bd"><p>The callback function is one of those concepts that every JavaScript developer should know. Callbacks are used in arrays, timer functions, promises, event handlers, and much more.    </p>
<p>In this post, I will explain the concept of a callback function. Also, I’ll help you distinguish the 2 types of callbacks: synchronous and asynchronous.  </p>
<h2 id="1-the-callback-function" style="position:relative;"><a href="#1-the-callback-function" aria-label="1 the callback function permalink" class="anchor before"><svg aria-hidden="true" height="20" version="1.1" viewBox="0 0 16 16" width="20"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>1. The callback function</h2>
<p>How can you compose a message to greet a person?  </p>
<p>Let’s create a function <code class="language-text">greet(name)</code> that accepts a <code class="language-text">name</code> argument. The function should return the greeting message:</p>
<div class="gatsby-highlight" data-language="javascript"><pre class="language-javascript"><code class="language-javascript"><span class="token keyword">function</span> <span class="token function">greet</span><span class="token punctuation">(</span><span class="token parameter">name</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
  <span class="token keyword">return</span> <span class="token template-string"><span class="token template-punctuation string">\`</span><span class="token string">Hello, </span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${</span>name<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string">!</span><span class="token template-punctuation string">\`</span></span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token function">greet</span><span class="token punctuation">(</span><span class="token string">'Cristina'</span><span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// =&gt; 'Hello, Cristina!'</span></code></pre></div>
<p>What about greeting a list of persons? That’s possible using a special array method  <code class="language-text">array.map()</code>:</p>
<div class="gatsby-highlight" data-language="javascript"><pre class="language-javascript"><code class="language-javascript"><span class="token keyword">const</span> persons <span class="token operator">=</span> <span class="token punctuation">[</span><span class="token string">'Cristina'</span><span class="token punctuation">,</span> <span class="token string">'Ana'</span><span class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token keyword">const</span> messages <span class="token operator">=</span> persons<span class="token punctuation">.</span><span class="token function">map</span><span class="token punctuation">(</span>greet<span class="token punctuation">)</span><span class="token punctuation">;</span>
messages<span class="token punctuation">;</span> <span class="token comment">// =&gt; ['Hello, Cristina!', 'Hello, Ana!'] </span></code></pre></div>
<p><code class="language-text">persons.map(greet)</code> takes each item of the <code class="language-text">persons</code> array, and invokes the function <code class="language-text">greet()</code> using each item as an invocation argument: <code class="language-text">greet('Cristina')</code>, <code class="language-text">greet('Ana')</code>.  </p>
<p>What’s interesting is that <code class="language-text">persons.map(greet)</code> method accepts <code class="language-text">greet()</code> function as an argument. Doing so makes the <code class="language-text">greet()</code> a <em>callback function</em>.  </p>
<p>The <code class="language-text">persons.map(greet)</code> is a function that accepts another function as an argument, so it is named a <em>higher-order function</em>.  </p>
<blockquote>
<p>The <em>callback function</em> is supplied as an argument to a <em>higher-order function</em>  that invokes (“calls back”) the callback function to perform an operation.  </p>
</blockquote>
<p>What’s important is that the higher-order function takes the full responsibility of invoking the callback and supplying it with the right arguments. </p>
<p>In the previous example, the higher-order function <code class="language-text">persons.map(greet)</code> takes the responsibility to invoke the <code class="language-text">greet()</code> callback function with each item of the array as an argument: <code class="language-text">'Cristina'</code> and <code class="language-text">'Ana'</code>.  </p>
<p>That brings to an easy rule for identifying callbacks. If you’ve defined a function and you’re not invoking it by yourself — but rather supply as an argument to another function — then you’ve created a callback.  </p>
<p>You can always write by yourself higher-order functions that use callbacks. For example, here’s an equivalent version the <code class="language-text">array.map()</code> method:</p>
<div class="gatsby-highlight has-highlighted-lines" data-language="javascript"><pre class="language-javascript"><code class="language-javascript"><span class="token keyword">function</span> <span class="token function">map</span><span class="token punctuation">(</span><span class="token parameter">array<span class="token punctuation">,</span> callback</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
  <span class="token keyword">const</span> mappedArray <span class="token operator">=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
  <span class="token keyword">for</span> <span class="token punctuation">(</span><span class="token keyword">const</span> item <span class="token keyword">of</span> array<span class="token punctuation">)</span> <span class="token punctuation">{</span> 
    mappedArray<span class="token punctuation">.</span><span class="token function">push</span><span class="token punctuation">(</span>
<span class="gatsby-highlight-code-line">      <span class="token function">callback</span><span class="token punctuation">(</span>item<span class="token punctuation">)</span></span>    <span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span>
  <span class="token keyword">return</span> mappedArray<span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">function</span> <span class="token function">greet</span><span class="token punctuation">(</span><span class="token parameter">name</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
  <span class="token keyword">return</span> <span class="token template-string"><span class="token template-punctuation string">\`</span><span class="token string">Hello, </span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${</span>name<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string">!</span><span class="token template-punctuation string">\`</span></span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">const</span> persons <span class="token operator">=</span> <span class="token punctuation">[</span><span class="token string">'Cristina'</span><span class="token punctuation">,</span> <span class="token string">'Ana'</span><span class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="gatsby-highlight-code-line"><span class="token keyword">const</span> messages <span class="token operator">=</span> <span class="token function">map</span><span class="token punctuation">(</span>persons<span class="token punctuation">,</span> greet<span class="token punctuation">)</span><span class="token punctuation">;</span></span>messages<span class="token punctuation">;</span> <span class="token comment">// =&gt; ['Hello, Cristina!', 'Hello, Ana!'] </span></code></pre></div>
<p><code class="language-text">map(array, callback)</code> is a higher-order function since it accepts a callback function as an argument, and then inside of its body invokes that callback function: <code class="language-text">callback(item)</code>.  </p>
<p>Note that a regular function (defined using <code class="language-text">function</code> keyword) or an arrow function (defined using the fat arrow <code class="language-text">=&gt;</code>) can equally serve as callbacks.  </p>
<h2 id="2-the-synchronous-callback" style="position:relative;"><a href="#2-the-synchronous-callback" aria-label="2 the synchronous callback permalink" class="anchor before"><svg aria-hidden="true" height="20" version="1.1" viewBox="0 0 16 16" width="20"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>2. The synchronous callback</h2>
<p>There are 2 types of callbacks by the way they’re invoked: <em>synchronous</em> and <em>asynchronous</em> callbacks.  </p>
<blockquote>
<p>The <em>synchronous callback</em> is executed <em>during</em> the execution of the higher-order function that uses the callback.  </p>
</blockquote>
<p>In other words, the synchronous callbacks are <em>blocking</em>: the higher-order function doesn’t complete its execution until the callback is done executing.</p>
<p>For example, recall the <code class="language-text">map()</code> and <code class="language-text">greet()</code> functions.  </p>
<div class="gatsby-highlight" data-language="javascript"><pre class="language-javascript"><code class="language-javascript"><span class="token keyword">function</span> <span class="token function">map</span><span class="token punctuation">(</span><span class="token parameter">array<span class="token punctuation">,</span> callback</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
  console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'map() starts'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token keyword">const</span> mappedArray <span class="token operator">=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
  <span class="token keyword">for</span> <span class="token punctuation">(</span><span class="token keyword">const</span> item <span class="token keyword">of</span> array<span class="token punctuation">)</span> <span class="token punctuation">{</span> mappedArray<span class="token punctuation">.</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token function">callback</span><span class="token punctuation">(</span>item<span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">}</span>
  console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'map() completed'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token keyword">return</span> mappedArray<span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">function</span> <span class="token function">greet</span><span class="token punctuation">(</span><span class="token parameter">name</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
  console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'greet() called'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token keyword">return</span> <span class="token template-string"><span class="token template-punctuation string">\`</span><span class="token string">Hello, </span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${</span>name<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string">!</span><span class="token template-punctuation string">\`</span></span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">const</span> persons <span class="token operator">=</span> <span class="token punctuation">[</span><span class="token string">'Cristina'</span><span class="token punctuation">]</span><span class="token punctuation">;</span>

<span class="token function">map</span><span class="token punctuation">(</span>persons<span class="token punctuation">,</span> greet<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token comment">// logs 'map() starts'</span>
<span class="token comment">// logs 'greet() called'</span>
<span class="token comment">// logs 'map() completed'</span></code></pre></div>
<p><code class="language-text">greet()</code> is a synchronous callback because it’s being executed at the same time as the higher-order function <code class="language-text">map()</code>. You can try the <a href="https://jsitor.com/MZVUzLzql">demo</a>.</p>
<p>The synchronous way to invoke the callbacks:  </p>
<ol>
<li>The higher-order function starts execution: <code class="language-text">'map() starts'</code></li>
<li>The callback function executes: <code class="language-text">'greet() called'</code></li>
<li>Finally, the higher-order function completes its execution: <code class="language-text">'map() completed'</code>  </li>
</ol>
<h3 id="21-examples-of-synchronous-callbacks" style="position:relative;"><a href="#21-examples-of-synchronous-callbacks" aria-label="21 examples of synchronous callbacks permalink" class="anchor before"><svg aria-hidden="true" height="20" version="1.1" viewBox="0 0 16 16" width="20"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>2.1 Examples of synchronous callbacks</h3>
<p>A lot of methods of native JavaScript types use synchronous callbacks. </p>
<p>The most used ones are the <a href="/operations-on-arrays-javascript/">array methods</a> like <code class="language-text">array.map(callback)</code>, <code class="language-text">array.forEach(callback)</code>, <code class="language-text">array.find(callback)</code>, <code class="language-text">array.filter(callback)</code>, <code class="language-text">array.reduce(callback, init)</code>:  </p>
<div class="gatsby-highlight has-highlighted-lines" data-language="javascript"><pre class="language-javascript"><code class="language-javascript"><span class="token comment">// Examples of synchronous callbacks on arrays</span>
<span class="token keyword">const</span> persons <span class="token operator">=</span> <span class="token punctuation">[</span><span class="token string">'Ana'</span><span class="token punctuation">,</span> <span class="token string">'Elena'</span><span class="token punctuation">]</span><span class="token punctuation">;</span>

persons<span class="token punctuation">.</span><span class="token function">forEach</span><span class="token punctuation">(</span>
<span class="gatsby-highlight-code-line">  <span class="token keyword">function</span> <span class="token function">callback</span><span class="token punctuation">(</span><span class="token parameter">name</span><span class="token punctuation">)</span> <span class="token punctuation">{</span></span>    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>name<span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token comment">// logs 'Ana'</span>
<span class="token comment">// logs 'Elena'</span>

<span class="token keyword">const</span> nameStartingA <span class="token operator">=</span> persons<span class="token punctuation">.</span><span class="token function">find</span><span class="token punctuation">(</span>
<span class="gatsby-highlight-code-line">  <span class="token keyword">function</span> <span class="token function">callback</span><span class="token punctuation">(</span><span class="token parameter">name</span><span class="token punctuation">)</span> <span class="token punctuation">{</span></span>    <span class="token keyword">return</span> name<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span><span class="token punctuation">.</span><span class="token function">toLowerCase</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">===</span> <span class="token string">'a'</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span>
nameStartingA<span class="token punctuation">;</span> <span class="token comment">// =&gt; 'Ana'</span>

<span class="token keyword">const</span> countStartingA <span class="token operator">=</span> persons<span class="token punctuation">.</span><span class="token function">reduce</span><span class="token punctuation">(</span>
<span class="gatsby-highlight-code-line">  <span class="token keyword">function</span> <span class="token function">callback</span><span class="token punctuation">(</span><span class="token parameter">count<span class="token punctuation">,</span> name</span><span class="token punctuation">)</span> <span class="token punctuation">{</span></span>    <span class="token keyword">const</span> startsA <span class="token operator">=</span> name<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span><span class="token punctuation">.</span><span class="token function">toLowerCase</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">===</span> <span class="token string">'a'</span><span class="token punctuation">;</span>
    <span class="token keyword">return</span> startsA <span class="token operator">?</span> count <span class="token operator">+</span> <span class="token number">1</span> <span class="token operator">:</span> count<span class="token punctuation">;</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span> 
  <span class="token number">0</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span>
countStartingA<span class="token punctuation">;</span> <span class="token comment">// =&gt; 1</span></code></pre></div>
<p><code class="language-text">string.replace(callback)</code> method of the string type also accepts a callback that is executed synchronously:</p>
<div class="gatsby-highlight has-highlighted-lines" data-language="javascript"><pre class="language-javascript"><code class="language-javascript"><span class="token comment">// Examples of synchronous callbacks on strings</span>
<span class="token keyword">const</span> person <span class="token operator">=</span> <span class="token string">'Cristina'</span><span class="token punctuation">;</span>

<span class="token comment">// Replace 'i' with '1'</span>
person<span class="token punctuation">.</span><span class="token function">replace</span><span class="token punctuation">(</span><span class="token regex"><span class="token regex-delimiter">/</span><span class="token regex-source language-regex">.</span><span class="token regex-delimiter">/</span><span class="token regex-flags">g</span></span><span class="token punctuation">,</span> 
<span class="gatsby-highlight-code-line">  <span class="token keyword">function</span><span class="token punctuation">(</span><span class="token parameter">char</span><span class="token punctuation">)</span> <span class="token punctuation">{</span></span>    <span class="token keyword">return</span> char<span class="token punctuation">.</span><span class="token function">toLowerCase</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">===</span> <span class="token string">'i'</span> <span class="token operator">?</span> <span class="token string">'1'</span> <span class="token operator">:</span> char<span class="token punctuation">;</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// =&gt; 'Cr1st1na'</span></code></pre></div>
<h2 id="3-the-asynchronous-callback" style="position:relative;"><a href="#3-the-asynchronous-callback" aria-label="3 the asynchronous callback permalink" class="anchor before"><svg aria-hidden="true" height="20" version="1.1" viewBox="0 0 16 16" width="20"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>3. The asynchronous callback</h2>
<blockquote>
<p>The <em>asynchronous callback</em> is executed <em>after</em> the execution of the higher-order function.  </p>
</blockquote>
<p>Simply saying, the asynchronous callbacks are <em>non-blocking</em>: the higher-order function completes its execution without waiting for the callback. The higher-order function makes sure to execute the callback later on a certain event. </p>
<p>In the following example, the <code class="language-text">later()</code> function is executed with a delay of 2 seconds:</p>
<div class="gatsby-highlight" data-language="javascript"><pre class="language-javascript"><code class="language-javascript">console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'setTimeout() starts'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token function">setTimeout</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token function">later</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
  console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'later() called'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token number">2000</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'setTimeout() completed'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// logs 'setTimeout() starts'</span>
<span class="token comment">// logs 'setTimeout() completed'</span>
<span class="token comment">// logs 'later() called' (after 2 seconds)</span></code></pre></div>
<p><code class="language-text">later()</code> is an asynchornous callback because <code class="language-text">setTimeout(later, 2000)</code> starts and completes its execution, but <code class="language-text">later()</code> is executed after passing 2 seconds. Try the <a href="https://jsitor.com/MhhozrnIj">demo</a>.   </p>
<p>The asynchronous way to invoke the callbacks:</p>
<ol>
<li>The higher-order function starts execution: <code class="language-text">'setTimeout() starts'</code></li>
<li>The higher-order function completes its execution: <code class="language-text">'setTimeout() completed'</code></li>
<li>The callback function executes after 2 seconds: <code class="language-text">'later() called'</code></li>
</ol>
<h3 id="31-examples-of-asynchronous-callbacks" style="position:relative;"><a href="#31-examples-of-asynchronous-callbacks" aria-label="31 examples of asynchronous callbacks permalink" class="anchor before"><svg aria-hidden="true" height="20" version="1.1" viewBox="0 0 16 16" width="20"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>3.1 Examples of asynchronous callbacks</h3>
<p>The timer functions invoke the callbacks asynchronously:</p>
<div class="gatsby-highlight" data-language="javascript"><pre class="language-javascript"><code class="language-javascript"><span class="token function">setTimeout</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token function">later</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
  console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'2 seconds have passed!'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token number">2000</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token comment">// After 2 seconds logs '2 seconds have passed!' </span>

<span class="token function">setInterval</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token function">repeat</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
  console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'Every 2 seconds'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token number">2000</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token comment">// Each 2 seconds logs 'Every 2 seconds!' </span></code></pre></div>
<p>DOM event listeners also invoke the event handler function (a subtype of callback functions) asynchronously:</p>
<div class="gatsby-highlight" data-language="javascript"><pre class="language-javascript"><code class="language-javascript"><span class="token keyword">const</span> myButton <span class="token operator">=</span> document<span class="token punctuation">.</span><span class="token function">getElementById</span><span class="token punctuation">(</span><span class="token string">'myButton'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

myButton<span class="token punctuation">.</span><span class="token function">addEventListener</span><span class="token punctuation">(</span><span class="token string">'click'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token function">handler</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
  console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'Button clicked!'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token comment">// Logs 'Button clicked!' when the button is clicked</span></code></pre></div>
<h2 id="4-summary" style="position:relative;"><a href="#4-summary" aria-label="4 summary permalink" class="anchor before"><svg aria-hidden="true" height="20" version="1.1" viewBox="0 0 16 16" width="20"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>4. Summary</h2>
<p>The callback is a function that’s accepted as an argument and executed by another function (the higher-order function).  </p>
<p>There are 2 kinds of callback functions: synchronous and asynchronous.  </p>
<p>The synchronous callbacks are executed at the same time as the higher-order function that uses the callback. Synchronous callbacks are <em>blocking</em>.</p>
<p>On the other side, the asynchronous callbacks are executed at a later time than the higher-order function. Asynchronous callbacks are <em>non-blocking</em>.  </p>
<p><em>Quiz: does <code class="language-text">setTimeout(callback, 0)</code> execute the <code class="language-text">callback</code> synchronously or asynchronously?</em></p></div>`,
  @author = 'Dmitri Pavlutin',
  @aurl = N'article/javascript-callback/', @category = N'front-end', @thumbUrl = N'https://techvccloud.mediacdn.vn/zoom/650_406/2018/11/23/js-15429579443112042672363-crop-1542957949936317424252.png'
GO