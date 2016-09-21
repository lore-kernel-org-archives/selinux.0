MIME-Version: 1.0
In-Reply-To: <d3dcf9af-2bd0-5650-1fc6-f0e89e26d955@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC561CD0E4E2@ORSMSX103.amr.corp.intel.com>
 <32dd55fe-ff71-c6ea-8f00-f552d9523676@tycho.nsa.gov>
 <CAFftDdox4a7Enrgcj1qmbDBcbZ4KfdFfpnmwXcinQUw4UQvF6g@mail.gmail.com>
 <d3dcf9af-2bd0-5650-1fc6-f0e89e26d955@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 21 Sep 2016 14:48:43 -0700
Message-ID: <CAFftDdpWzqwVRwGsgLTt03TxtEtoB3awO_3gpGutQw95r+4u9g@mail.gmail.com>
Subject: Re: unlocked stdio
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113edf345ebf87053d0b8240
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113edf345ebf87053d0b8240
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sep 21, 2016 13:16, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 09/21/2016 04:11 PM, William Roberts wrote:
> > On Sep 21, 2016 13:06, "Stephen Smalley" <sds@tycho.nsa.gov
> > <mailto:sds@tycho.nsa.gov>> wrote:
> >>
> >> On 09/21/2016 03:57 PM, Roberts, William C wrote:
> >> > Correction, it=E2=80=99s just fgets_unlocked, it appears to support =
the
others.
> >>
> >> Seems like a bug in bionic, but we can work around it by:
> >> #ifdef ANDROID
> >> #define fgets_unlocked(x) fgets(x)
> >> #endif
> >>
> >> in selinux_internal.h or some similar internal header.
> >>
> >> It avoids unnecessary locking overheads when dealing with FILE
> >> descriptors that are only used locally and guaranteed to not be shared
> >> by multiple threads.
> >
> > I know what it does and why, but was it really that necessary?
>
> The patch came from Red Hat.  Anyway, we use the _unlocked functions
> throughout, and the fact that bionic supports all of them except that
> one function suggests that we should just use a fix like the above
> rather than dropping it.

I'm not arguing the fix, just wondering if it was blazingly fast. I didn't
find the definition or a define in bionic for fgets_unlocked, but when I
set _GNUC define, it seemed to build OK.

>
>

--001a113edf345ebf87053d0b8240
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 21, 2016 13:16, &quot;Stephen Smalley&quot; &lt;<a hr=
ef=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 09/21/2016 04:11 PM, William Roberts wrote:<br>
&gt; &gt; On Sep 21, 2016 13:06, &quot;Stephen Smalley&quot; &lt;<a href=3D=
"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov=
</a>&gt;&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 09/21/2016 03:57 PM, Roberts, William C wrote:<br>
&gt; &gt;&gt; &gt; Correction, it=E2=80=99s just fgets_unlocked, it appears=
 to support the others.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Seems like a bug in bionic, but we can work around it by:<br>
&gt; &gt;&gt; #ifdef ANDROID<br>
&gt; &gt;&gt; #define fgets_unlocked(x) fgets(x)<br>
&gt; &gt;&gt; #endif<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; in selinux_internal.h or some similar internal header.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; It avoids unnecessary locking overheads when dealing with FIL=
E<br>
&gt; &gt;&gt; descriptors that are only used locally and guaranteed to not =
be shared<br>
&gt; &gt;&gt; by multiple threads.<br>
&gt; &gt;<br>
&gt; &gt; I know what it does and why, but was it really that necessary?<br=
>
&gt;<br>
&gt; The patch came from Red Hat.=C2=A0 Anyway, we use the _unlocked functi=
ons<br>
&gt; throughout, and the fact that bionic supports all of them except that<=
br>
&gt; one function suggests that we should just use a fix like the above<br>
&gt; rather than dropping it.</p>
<p dir=3D"ltr">I&#39;m not arguing the fix, just wondering if it was blazin=
gly fast. I didn&#39;t find the definition or a define in bionic for fgets_=
unlocked, but when I set _GNUC define, it seemed to build OK.</p>
<p dir=3D"ltr">&gt;<br>
&gt;</p>

--001a113edf345ebf87053d0b8240--
