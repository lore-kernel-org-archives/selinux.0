MIME-Version: 1.0
In-Reply-To: <1345668870.7532.2.camel@moss-pluto.epoch.ncsc.mil>
References: <CAN93RkL87Hscd1pdG8SUKqpNjZiwZ6Xyih=g+8HhL-vtP549Hw@mail.gmail.com>
 <1345668870.7532.2.camel@moss-pluto.epoch.ncsc.mil>
From: Cesar Maiorino <cesar.maiorino@gmail.com>
Date: Wed, 22 Aug 2012 17:05:07 -0400
Message-ID: <CAN93Rk+5-kAjSE6rk0qy8Ez_23SQA76+b1+3t3CoXc3FG4a=TQ@mail.gmail.com>
Subject: Re: Problems getting source using repo sync
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00504502d5315cfb8b04c7e11bab
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00504502d5315cfb8b04c7e11bab
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Aug 22, 2012 at 4:54 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2012-08-22 at 16:46 -0400, Cesar Maiorino wrote:
> > I'm following the instructions on
> > http://selinuxproject.org/page/SEAndroid to get the ICS seandroid
> > source, but keep getting messages like this when syncing (the second
> > sync with the seandroid manifest):
> >
> > error:
> >
> '/home/cmaiorin/seandroid-4.0.4/.repo/projects/external/libsepol.git/clone.bundle'
> does not look like a v2 bundle file
> > fatal: Could not read bundle
> >
> '/home/cmaiorin/seandroid-4.0.4/.repo/projects/external/libsepol.git/clone.bundle'.
> >
> > Any ideas what the problem is?
>
> Does it happen if you pass -j1 to repo sync, i.e.
>         repo sync -j1
>
>
Yes, I am using
repo sync -j1

--00504502d5315cfb8b04c7e11bab
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Aug 22, 2012 at 4:54 PM, Stephen=
 Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=
=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">

<div class=3D"HOEnZb"><div class=3D"h5">On Wed, 2012-08-22 at 16:46 -0400, =
Cesar Maiorino wrote:<br>
&gt; I&#39;m following the instructions on<br>
&gt; <a href=3D"http://selinuxproject.org/page/SEAndroid" target=3D"_blank"=
>http://selinuxproject.org/page/SEAndroid</a> to get the ICS seandroid<br>
&gt; source, but keep getting messages like this when syncing (the second<b=
r>
&gt; sync with the seandroid manifest):<br>
&gt;<br>
&gt; error:<br>
&gt; &#39;/home/cmaiorin/seandroid-4.0.4/.repo/projects/external/libsepol.g=
it/clone.bundle&#39; does not look like a v2 bundle file<br>
&gt; fatal: Could not read bundle<br>
&gt; &#39;/home/cmaiorin/seandroid-4.0.4/.repo/projects/external/libsepol.g=
it/clone.bundle&#39;.<br>
&gt;<br>
&gt; Any ideas what the problem is?<br>
<br>
</div></div>Does it happen if you pass -j1 to repo sync, i.e.<br>
=A0 =A0 =A0 =A0 repo sync -j1<br>
<span class=3D"HOEnZb"><font color=3D"#888888"></font></span><br></blockquo=
te><div><br>Yes, I am using<br>
repo sync -j1<br>=A0<br></div></div>

--00504502d5315cfb8b04c7e11bab--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
