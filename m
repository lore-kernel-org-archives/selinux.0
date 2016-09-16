MIME-Version: 1.0
In-Reply-To: <20160916140636.GA11391@meriadoc.perfinion.com>
References: <CAFftDdqDF1vC8-JQmZWPd2VZ7HpOQ7S5WagCfuxULtGU6+Q72w@mail.gmail.com>
 <CAAdwW5O6O630ORMOPBd0-2hg7xXGhgX=e6JEA2Poirz=8TFK6g@mail.gmail.com>
 <CAFftDdr+DqYSDOdjE7d5f6uz3++gvQqi2heJX7CJJXaHQQibVA@mail.gmail.com>
 <CAAdwW5PQvft0ZzFuG52Eid2Z=vZtvnmuOLw-_p+0x9bY+GZDGg@mail.gmail.com>
 <CAFftDdpN7Dzmt+5C1rADZh71wyoy+GrYf8eXUhv5GrOS-8_Leg@mail.gmail.com>
 <CAAdwW5M+qzpzZKqM0vvtCRvv14re_ahTLW_4E+wpezAiK8qqaA@mail.gmail.com>
 <CAFftDdodugeHpjiZRvr8J_5_UXQ92+iE+pO7Yq9RDSgPfrLTtw@mail.gmail.com>
 <20160916133146.GA8294@meriadoc.perfinion.com>
 <CAFftDdq1wiYt7Bvs9f2v-CrwY7uMOFhqPg2PSomd93zxmBf9=w@mail.gmail.com>
 <CAFftDdpuJUmvntWZq7TM+cDnr84iT5QBVS1TB2OOj190AV-2Cg@mail.gmail.com>
 <20160916140636.GA11391@meriadoc.perfinion.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 16 Sep 2016 07:14:49 -0700
Message-ID: <CAFftDdpbEZzyWje5ByhxoH_-inG34GdB+qmWRgFT34vkwE-w1Q@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add support for pcre2
To: Jason Zaman <jason@perfinion.com>
Cc: seandroid-list@tycho.nsa.gov, selinux@tycho.nsa.gov,
 Janis Danisevskis <jdanis@google.com>,
 Janis Danisevskis <jdanis@android.com>, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c05a22adc15e9053ca09519
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c05a22adc15e9053ca09519
Content-Type: text/plain; charset=UTF-8

On Sep 16, 2016 07:06, "Jason Zaman" <jason@perfinion.com> wrote:
>
> On Fri, Sep 16, 2016 at 06:51:25AM -0700, William Roberts wrote:
> > On Fri, Sep 16, 2016 at 6:43 AM, William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > > On Fri, Sep 16, 2016 at 6:31 AM, Jason Zaman <jason@perfinion.com>
wrote:
> > >> On Fri, Sep 16, 2016 at 06:15:01AM -0700, William Roberts wrote:
> > >>> On Fri, Sep 16, 2016 at 6:09 AM, Janis Danisevskis <
jdanis@google.com> wrote:
> > >>> > I don't mind. Then before sefcontext_compile -r gets widely
adapted we
> > >>> > should change the semantic quickly. I'll prepare a patch.
> > >>>
> > >>> Did I miss something and this was merged? Iv'e been out recovering
> > >>> from a surgery so I haven't been
> > >>> following this as well as I normally would have,
> > >>>
> > >>> If its merged, just leave it.
> > >>
> > >> Its the very latest thing in master yeah, but I do also agree with
changing it.
> > >
> > > I'd prefer it changed myself. Another argument pro-change is that one
doesn't
> > > know if its a PCRE2 or PCRE1 compatable version of the libraries, we
should
> > > probably have an ability to intergoate that via API so we can print it
> > > out in help
> > > dialogue, that this tool so we at least know what it can support.
> > >
> > > The biggest thing that needs to get fixed with this, is that no matter
> > > if it contains the
> > > pre-compiled regexs or not, it should always load and work on Android.
> > > In distros,
> > > it will fall back to file_contexts, but we don't have this in Android.
> > > This ties into the arch
> > > version information below. But if the arch differs, always recompile.
> > > The alternative to
> > > this, is just go back to textual fc file son Android, since we won't
> > > be using any of the
> > > features of binary fc's. Better yet, in the Android build, I would
> > > check to see if host arch
> > > is the same as target arch, or let an OEM set a flag, to do the
> > > compilation. But I would
> > > consider those stretch goals, and just revert android back to textual
files.
> >
> > My ramblings might not be clear here. If we just version it with arch
> > and require
> > an exact match, we don't need -r, so that option goes away.
>
> This is what I was aiming for too, currently the pcre_version() is just
> strcmp'd so changing it to cat(pcre2_version(), arch_string()) should
> avoid any problems. It may turn out to be overzealous but it will always
> be safe. I dont think splitting pcre_version and arch into separate
> fields makes a huge difference if you prefer that. Currently the version

It can make a difference if we ever need to parse any information for some
reason in the future. We'd then have to split them back apart. This is just
a bit more future proof IMO.

> numbers are not parsed tho, so checking arch only for pcre2 seems like a
> lot more work.
>
> -- Jason

--94eb2c05a22adc15e9053ca09519
Content-Type: text/html; charset=UTF-8

<p dir="ltr"></p>
<p dir="ltr">On Sep 16, 2016 07:06, &quot;Jason Zaman&quot; &lt;<a href="mailto:jason@perfinion.com">jason@perfinion.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Sep 16, 2016 at 06:51:25AM -0700, William Roberts wrote:<br>
&gt; &gt; On Fri, Sep 16, 2016 at 6:43 AM, William Roberts<br>
&gt; &gt; &lt;<a href="mailto:bill.c.roberts@gmail.com">bill.c.roberts@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt; On Fri, Sep 16, 2016 at 6:31 AM, Jason Zaman &lt;<a href="mailto:jason@perfinion.com">jason@perfinion.com</a>&gt; wrote:<br>
&gt; &gt; &gt;&gt; On Fri, Sep 16, 2016 at 06:15:01AM -0700, William Roberts wrote:<br>
&gt; &gt; &gt;&gt;&gt; On Fri, Sep 16, 2016 at 6:09 AM, Janis Danisevskis &lt;<a href="mailto:jdanis@google.com">jdanis@google.com</a>&gt; wrote:<br>
&gt; &gt; &gt;&gt;&gt; &gt; I don&#39;t mind. Then before sefcontext_compile -r gets widely adapted we<br>
&gt; &gt; &gt;&gt;&gt; &gt; should change the semantic quickly. I&#39;ll prepare a patch.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Did I miss something and this was merged? Iv&#39;e been out recovering<br>
&gt; &gt; &gt;&gt;&gt; from a surgery so I haven&#39;t been<br>
&gt; &gt; &gt;&gt;&gt; following this as well as I normally would have,<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; If its merged, just leave it.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Its the very latest thing in master yeah, but I do also agree with changing it.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I&#39;d prefer it changed myself. Another argument pro-change is that one doesn&#39;t<br>
&gt; &gt; &gt; know if its a PCRE2 or PCRE1 compatable version of the libraries, we should<br>
&gt; &gt; &gt; probably have an ability to intergoate that via API so we can print it<br>
&gt; &gt; &gt; out in help<br>
&gt; &gt; &gt; dialogue, that this tool so we at least know what it can support.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The biggest thing that needs to get fixed with this, is that no matter<br>
&gt; &gt; &gt; if it contains the<br>
&gt; &gt; &gt; pre-compiled regexs or not, it should always load and work on Android.<br>
&gt; &gt; &gt; In distros,<br>
&gt; &gt; &gt; it will fall back to file_contexts, but we don&#39;t have this in Android.<br>
&gt; &gt; &gt; This ties into the arch<br>
&gt; &gt; &gt; version information below. But if the arch differs, always recompile.<br>
&gt; &gt; &gt; The alternative to<br>
&gt; &gt; &gt; this, is just go back to textual fc file son Android, since we won&#39;t<br>
&gt; &gt; &gt; be using any of the<br>
&gt; &gt; &gt; features of binary fc&#39;s. Better yet, in the Android build, I would<br>
&gt; &gt; &gt; check to see if host arch<br>
&gt; &gt; &gt; is the same as target arch, or let an OEM set a flag, to do the<br>
&gt; &gt; &gt; compilation. But I would<br>
&gt; &gt; &gt; consider those stretch goals, and just revert android back to textual files.<br>
&gt; &gt;<br>
&gt; &gt; My ramblings might not be clear here. If we just version it with arch<br>
&gt; &gt; and require<br>
&gt; &gt; an exact match, we don&#39;t need -r, so that option goes away.<br>
&gt;<br>
&gt; This is what I was aiming for too, currently the pcre_version() is just<br>
&gt; strcmp&#39;d so changing it to cat(pcre2_version(), arch_string()) should<br>
&gt; avoid any problems. It may turn out to be overzealous but it will always<br>
&gt; be safe. I dont think splitting pcre_version and arch into separate<br>
&gt; fields makes a huge difference if you prefer that. Currently the version</p>
<p dir="ltr">It can make a difference if we ever need to parse any information for some reason in the future. We&#39;d then have to split them back apart. This is just a bit more future proof IMO. <br></p>
<p dir="ltr">&gt; numbers are not parsed tho, so checking arch only for pcre2 seems like a<br>
&gt; lot more work.<br>
&gt;<br>
&gt; -- Jason<br></p>

--94eb2c05a22adc15e9053ca09519--
