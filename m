MIME-Version: 1.0
In-Reply-To: <1342010691.29461.22.camel@moss-pluto.epoch.ncsc.mil>
References: <CAFftDdrwpSDqaPVVpiHDFYrvBK-f-MkaVHcUU5Z+x6=GLqnO=w@mail.gmail.com>
	<1342010691.29461.22.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 11 Jul 2012 10:45:02 -0700
Message-ID: <CAFftDdq3Ow7gpUjO9bBjGg1MJgd4_+Wtq+xp+AWDCW58=06Z_Q@mail.gmail.com>
Subject: Re: external/strace build breakage
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b10ce631c62bb04c491683e
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b10ce631c62bb04c491683e
Content-Type: text/plain; charset=ISO-8859-1

I am using the prebuilt toolchain including in the repo, what are you using?

On Wed, Jul 11, 2012 at 5:44 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2012-07-10 at 15:57 -0700, William Roberts wrote:
> > I got a build breakage when building SE Android master. It stems from
> > external/strace and it is on branch aosp/master spewing error: #if
> > with no expression.
> >
> >
> > You can apply this patch to fix it:
> >
> >
> > git fetch https://android.googlesource.com/platform/external/strace
> > refs/changes/91/38991/1 && git cherry-pick FETCH_HEAD
> >
> >
> > https://android-review.googlesource.com/#/c/38991/
> >
> >
> > I don't think this the "best" fix as their is
> > another similar patch submitted to the project, but it works for now.
> > I think that macro should be assigned a 1 or 0 vs defined/not defined.
>
> I'm not experiencing any build breakage; wondering if this is toolchain
> specific.
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Respectfully,

William C Roberts

--047d7b10ce631c62bb04c491683e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am using the prebuilt toolchain including in the repo, what are you using=
?<br><br><div class=3D"gmail_quote">On Wed, Jul 11, 2012 at 5:44 AM, Stephe=
n Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=
=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
ue, 2012-07-10 at 15:57 -0700, William Roberts wrote:<br>
&gt; I got a build breakage when building SE Android master. It stems from<=
br>
&gt; external/strace and it is on branch aosp/master spewing error: #if<br>
&gt; with no expression.<br>
&gt;<br>
&gt;<br>
&gt; You can apply this patch to fix it:<br>
&gt;<br>
&gt;<br>
&gt; git fetch <a href=3D"https://android.googlesource.com/platform/externa=
l/strace" target=3D"_blank">https://android.googlesource.com/platform/exter=
nal/strace</a><br>
&gt; refs/changes/91/38991/1 &amp;&amp; git cherry-pick FETCH_HEAD<br>
&gt;<br>
&gt;<br>
&gt; <a href=3D"https://android-review.googlesource.com/#/c/38991/" target=
=3D"_blank">https://android-review.googlesource.com/#/c/38991/</a><br>
&gt;<br>
&gt;<br>
&gt; I don&#39;t think this the &quot;best&quot; fix as their is<br>
&gt; another similar patch submitted to the project, but it works for now.<=
br>
&gt; I think that macro should be assigned a 1 or 0 vs defined/not defined.=
<br>
<br>
</div></div>I&#39;m not experiencing any build breakage; wondering if this =
is toolchain<br>
specific.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Respectfully,<br><br>William C Roberts<br><br><br>

--047d7b10ce631c62bb04c491683e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
