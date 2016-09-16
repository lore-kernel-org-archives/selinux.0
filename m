Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8GIigje028196
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 14:44:46 -0400
Received: by mail-qk0-f177.google.com with SMTP id t7so96995984qkh.2
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 11:44:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdrr+bVQ41kATRNCjme8g5QvL4W91g8j0AumkdWiq=QgBQ@mail.gmail.com>
References: <1474031328-29743-1-git-send-email-jdanis@android.com>
 <1fa3c006-bfa9-357e-7f88-1c8dfa50a0d2@tycho.nsa.gov>
 <CAFftDdrwgiFBsA182ZT-q=9P3Vi01E4jq0EY=C2vc6usFr_kyA@mail.gmail.com>
 <f43aad14-f573-2b24-8293-b51a2e111324@tycho.nsa.gov>
 <CAFftDdrr+bVQ41kATRNCjme8g5QvL4W91g8j0AumkdWiq=QgBQ@mail.gmail.com>
From: Janis Danisevskis <jdanis@android.com>
Date: Fri, 16 Sep 2016 19:44:39 +0100
Message-ID: <CA+xTVEskEa6Rt-zkGBMmdSQUT57ErVq5Mvz3o9hiLAHgcu8goQ@mail.gmail.com>
Subject: Re: [PATCH] Change semantic of -r in sefcontext_compile
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>,
 seandroid-list@tycho.nsa.gov,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11474b5cdc7fce053ca45ad1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11474b5cdc7fce053ca45ad1
Content-Type: text/plain; charset=UTF-8

I don't really care much about the behavior of sefcontext_compile. I just
thought making the default behavior the safest would be the best option.
Before android is using it, I will have to sync the (now modified and
improved - thank you) patches back into AOSP, which I intend to do. I have
some benchmarks measuring load and lookup time for file contexts. I am
eager to review and benchmark William's patches and explore a bit myself.
And once all options are on the table I can make a case for the fastest
solution to make it into Android.

Concerning the arch string I respond in the other add support for pcre2
thread.

On Fri, Sep 16, 2016 at 4:20 PM, William Roberts <bill.c.roberts@gmail.com>
wrote:

> On Sep 16, 2016 08:12, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> >
> > On 09/16/2016 11:08 AM, William Roberts wrote:
> > > On Fri, Sep 16, 2016 at 7:41 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > >> On 09/16/2016 09:08 AM, Janis Danisevskis wrote:
> > >>> This patch reestablishes the default behavior of sefcontext_compile
> > >>> to include precompiled regular expressions in the output. If linked
> > >>> against PCRE2 the flag "-r" now causes the precompiled regular
> > >>> expressions to be omitted from the output.
> > >>
> > >> I thought your original rationale was more compelling.  If we add
> > >> detection of the relevant arch properties, then we can do this.
> > >> Otherwise, I don't think we should.
> > >
> > > I was assuming based on the thread earlier that those patches would be
> coming.
> > > If we cant detect and compile on the current "undefined behavior"
> > > case, then this
> > > needs to stay as is.
> > >
> > > But I thought someone had a list of PCRE things that can be checked
> for "arch",
> > > so its just a matter of encoding those, assuming that list is correct.
> > >
> > > Binary file_contexts only make sense if you compile in the regex info,
> else
> > > just use the textual representation.
> >
> > That was my thought originally, but Janis did say that it was still
> > faster, and Android presently only ships file_contexts.bin, so we can't
> > just break that.
>
> I'm not saying that we break anything, but I think we should really
> scrutinize the decision to keep binary fc's on Android. The only way it
> could be faster at the moment is mmap and pcre2. We need to get some raw
> numbers of pcre2 textual vs binary load times. If it's within 30% I'll have
> that gap closed soon. It also takes up about 3 times the disk space for
> binary.
>

--001a11474b5cdc7fce053ca45ad1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I don&#39;t really care much about the behavior of sefcont=
ext_compile. I just thought making the default behavior the safest would be=
 the best option. Before android is using it, I will have to sync the (now =
modified and improved - thank you) patches back into AOSP, which I intend t=
o do. I have some benchmarks measuring load and lookup time for file contex=
ts. I am eager to review and benchmark William&#39;s patches and explore a =
bit myself. And once all options are on the table I can make a case for the=
 fastest solution to make it into Android.<div><br></div><div>Concerning th=
e arch string I respond in the other add support for pcre2 thread.</div></d=
iv><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Sep 16=
, 2016 at 4:20 PM, William Roberts <span dir=3D"ltr">&lt;<a href=3D"mailto:=
bill.c.roberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><di=
v class=3D"h5"><p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 16, 2016 08:12, &quot;Stephen Smalley&quot; &lt;<a hr=
ef=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;=
 wrote:<br>
&gt;<br>
&gt; On 09/16/2016 11:08 AM, William Roberts wrote:<br>
&gt; &gt; On Fri, Sep 16, 2016 at 7:41 AM, Stephen Smalley &lt;<a href=3D"m=
ailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt; wrote:=
<br>
&gt; &gt;&gt; On 09/16/2016 09:08 AM, Janis Danisevskis wrote:<br>
&gt; &gt;&gt;&gt; This patch reestablishes the default behavior of sefconte=
xt_compile<br>
&gt; &gt;&gt;&gt; to include precompiled regular expressions in the output.=
 If linked<br>
&gt; &gt;&gt;&gt; against PCRE2 the flag &quot;-r&quot; now causes the prec=
ompiled regular<br>
&gt; &gt;&gt;&gt; expressions to be omitted from the output.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I thought your original rationale was more compelling.=C2=A0 =
If we add<br>
&gt; &gt;&gt; detection of the relevant arch properties, then we can do thi=
s.<br>
&gt; &gt;&gt; Otherwise, I don&#39;t think we should.<br>
&gt; &gt;<br>
&gt; &gt; I was assuming based on the thread earlier that those patches wou=
ld be coming.<br>
&gt; &gt; If we cant detect and compile on the current &quot;undefined beha=
vior&quot;<br>
&gt; &gt; case, then this<br>
&gt; &gt; needs to stay as is.<br>
&gt; &gt;<br>
&gt; &gt; But I thought someone had a list of PCRE things that can be check=
ed for &quot;arch&quot;,<br>
&gt; &gt; so its just a matter of encoding those, assuming that list is cor=
rect.<br>
&gt; &gt;<br>
&gt; &gt; Binary file_contexts only make sense if you compile in the regex =
info, else<br>
&gt; &gt; just use the textual representation.<br>
&gt;<br>
&gt; That was my thought originally, but Janis did say that it was still<br=
>
&gt; faster, and Android presently only ships file_contexts.bin, so we can&=
#39;t<br>
&gt; just break that.</p>
</div></div><p dir=3D"ltr">I&#39;m not saying that we break anything, but I=
 think we should really scrutinize the decision to keep binary fc&#39;s on =
Android. The only way it could be faster at the moment is mmap and pcre2. W=
e need to get some raw numbers of pcre2 textual vs binary load times. If it=
&#39;s within 30% I&#39;ll have that gap closed soon. It also takes up abou=
t 3 times the disk space for binary.</p>
</blockquote></div><br></div>

--001a11474b5cdc7fce053ca45ad1--
