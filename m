MIME-Version: 1.0
In-Reply-To: <32dd55fe-ff71-c6ea-8f00-f552d9523676@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC561CD0E4E2@ORSMSX103.amr.corp.intel.com>
 <32dd55fe-ff71-c6ea-8f00-f552d9523676@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 21 Sep 2016 13:11:32 -0700
Message-ID: <CAFftDdox4a7Enrgcj1qmbDBcbZ4KfdFfpnmwXcinQUw4UQvF6g@mail.gmail.com>
Subject: Re: unlocked stdio
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: seandroid-list@tycho.nsa.gov, selinux@tycho.nsa.gov,
 "Roberts, William C" <william.c.roberts@intel.com>
Content-Type: multipart/alternative; boundary=94eb2c05b874ca09a8053d0a266d
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c05b874ca09a8053d0a266d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sep 21, 2016 13:06, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 09/21/2016 03:57 PM, Roberts, William C wrote:
> > Correction, it=E2=80=99s just fgets_unlocked, it appears to support the=
 others.
>
> Seems like a bug in bionic, but we can work around it by:
> #ifdef ANDROID
> #define fgets_unlocked(x) fgets(x)
> #endif
>
> in selinux_internal.h or some similar internal header.
>
> It avoids unnecessary locking overheads when dealing with FILE
> descriptors that are only used locally and guaranteed to not be shared
> by multiple threads.

I know what it does and why, but was it really that necessary?

>
> >
> >
> >
> > *From:* Roberts, William C
> > *Sent:* Wednesday, September 21, 2016 12:53 PM
> > *To:* 'seandroid-list@tycho.nsa.gov' <seandroid-list@tycho.nsa.gov>;
> > 'selinux@tycho.nsa.gov' <selinux@tycho.nsa.gov>; 'sds@tycho.nsa.gov'
> > <sds@tycho.nsa.gov>
> > *Subject:* unlocked stdio
> >
> >
> >
> > What was the purpose of using unlocked stdio in libselinux? Bionic
> > doesn=E2=80=99t support it, is it really necessary?
> >
> >
> >
> > Bill
> >
> >
> >
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--94eb2c05b874ca09a8053d0a266d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 21, 2016 13:06, &quot;Stephen Smalley&quot; &lt;<a hr=
ef=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 09/21/2016 03:57 PM, Roberts, William C wrote:<br>
&gt; &gt; Correction, it=E2=80=99s just fgets_unlocked, it appears to suppo=
rt the others.<br>
&gt;<br>
&gt; Seems like a bug in bionic, but we can work around it by:<br>
&gt; #ifdef ANDROID<br>
&gt; #define fgets_unlocked(x) fgets(x)<br>
&gt; #endif<br>
&gt;<br>
&gt; in selinux_internal.h or some similar internal header.<br>
&gt;<br>
&gt; It avoids unnecessary locking overheads when dealing with FILE<br>
&gt; descriptors that are only used locally and guaranteed to not be shared=
<br>
&gt; by multiple threads.</p>
<p dir=3D"ltr">I know what it does and why, but was it really that necessar=
y?</p>
<p dir=3D"ltr">&gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; *From:* Roberts, William C<br>
&gt; &gt; *Sent:* Wednesday, September 21, 2016 12:53 PM<br>
&gt; &gt; *To:* &#39;<a href=3D"mailto:seandroid-list@tycho.nsa.gov">seandr=
oid-list@tycho.nsa.gov</a>&#39; &lt;<a href=3D"mailto:seandroid-list@tycho.=
nsa.gov">seandroid-list@tycho.nsa.gov</a>&gt;;<br>
&gt; &gt; &#39;<a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.g=
ov</a>&#39; &lt;<a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.=
gov</a>&gt;; &#39;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a=
>&#39;<br>
&gt; &gt; &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt=
;<br>
&gt; &gt; *Subject:* unlocked stdio<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; What was the purpose of using unlocked stdio in libselinux? Bioni=
c<br>
&gt; &gt; doesn=E2=80=99t support it, is it really necessary?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Bill<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>=
</p>

--94eb2c05b874ca09a8053d0a266d--
