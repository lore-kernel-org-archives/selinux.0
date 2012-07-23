MIME-Version: 1.0
In-Reply-To: <1343049432.23118.19.camel@moss-pluto.epoch.ncsc.mil>
References: <1342734563-32644-1-git-send-email-hqjiang1988@gmail.com>
	<1342734563-32644-2-git-send-email-hqjiang1988@gmail.com>
	<1343049432.23118.19.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 23 Jul 2012 09:08:28 -0700
Message-ID: <CAO-4OdGCByGa_PfVy-T_LEgwNeJBSTptiZMm4aunDwCWOpGQqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] external/sepolicy: the media apps from third-party
 are labeled with media_app instead of untrusted_app
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=f46d042184d9d5182204c5817428
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d042184d9d5182204c5817428
Content-Type: text/plain; charset=ISO-8859-1

Right.. It could be. We are thinking of adding bool-enabled scheme in
seapp_contexts.

On Mon, Jul 23, 2012 at 6:17 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2012-07-19 at 14:49 -0700, Haiqing Jiang wrote:
> > From: hqjiang <hqjiang1988@gmail.com>
> >
> > ---
> >  seapp_contexts |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/seapp_contexts b/seapp_contexts
> > index 502206a..1e98f91 100644
> > --- a/seapp_contexts
> > +++ b/seapp_contexts
> > @@ -38,3 +38,4 @@ user=app_* seinfo=shared domain=shared_app
> levelFromUid=true
> >  user=app_* seinfo=media domain=media_app levelFromUid=true
> >  user=app_* seinfo=release domain=release_app levelFromUid=true
> >  user=app_* seinfo=release name=com.android.browser domain=browser_app
> levelFromUid=true
> > +user=app_* name=android.process.media domain=media_app levelFromUid=true
>
> Wouldn't this allow an arbitrary third party app to run in media_app,
> just by using android.process.media as its package name?
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
-----------------------------------
Haiqing Jiang, PH.D student

Computer Science Department, North Carolina State University

--f46d042184d9d5182204c5817428
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Right.. It could be. We are thinking of adding bool-enabled scheme in seapp=
_contexts.=A0<br><br><div class=3D"gmail_quote">On Mon, Jul 23, 2012 at 6:1=
7 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa=
.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, 2012-07-19 at 14:49 -0700, Haiqing Jiang wrote:<br>
&gt; From: hqjiang &lt;<a href=3D"mailto:hqjiang1988@gmail.com">hqjiang1988=
@gmail.com</a>&gt;<br>
&gt;<br>
&gt; ---<br>
&gt; =A0seapp_contexts | =A0 =A01 +<br>
&gt; =A01 files changed, 1 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/seapp_contexts b/seapp_contexts<br>
&gt; index 502206a..1e98f91 100644<br>
&gt; --- a/seapp_contexts<br>
&gt; +++ b/seapp_contexts<br>
&gt; @@ -38,3 +38,4 @@ user=3Dapp_* seinfo=3Dshared domain=3Dshared_app lev=
elFromUid=3Dtrue<br>
&gt; =A0user=3Dapp_* seinfo=3Dmedia domain=3Dmedia_app levelFromUid=3Dtrue<=
br>
&gt; =A0user=3Dapp_* seinfo=3Drelease domain=3Drelease_app levelFromUid=3Dt=
rue<br>
&gt; =A0user=3Dapp_* seinfo=3Drelease name=3Dcom.android.browser domain=3Db=
rowser_app levelFromUid=3Dtrue<br>
&gt; +user=3Dapp_* name=3Dandroid.process.media domain=3Dmedia_app levelFro=
mUid=3Dtrue<br>
<br>
</div></div>Wouldn&#39;t this allow an arbitrary third party app to run in =
media_app,<br>
just by using android.process.media as its package name?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div>-----------------------------------</div>Haiqing Jiang, PH.D student=
<div><br></div><div>Computer Science Department, North Carolina State Unive=
rsity<br>
<div><br></div></div><br>

--f46d042184d9d5182204c5817428--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
