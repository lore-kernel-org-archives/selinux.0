MIME-Version: 1.0
In-Reply-To: <1347994362.31966.109.camel@moss-pluto.epoch.ncsc.mil>
References: <4FFCC3C7.8080602@tresys.com>
	<1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil>
	<4FFDD7C7.4020703@tresys.com>
	<1342036191.29461.75.camel@moss-pluto.epoch.ncsc.mil>
	<1347989611.31966.66.camel@moss-pluto.epoch.ncsc.mil>
	<CAFftDdqjtYd0RGoZ12dcJnyWpD42MPYf_KwkJitwYcaF=+ptgA@mail.gmail.com>
	<CAFftDdpDkSWWzgKiCyTLuJpAZNRtihgmoRE0WhBcbGa2tdfwPA@mail.gmail.com>
	<1347992127.31966.93.camel@moss-pluto.epoch.ncsc.mil>
	<CAFftDdorhQYcJ4_76cFg-Nj49vLNJYkKHyM=Zz6RvZ+3jH31vw@mail.gmail.com>
	<1347994362.31966.109.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 18 Sep 2012 11:59:12 -0700
Message-ID: <CAFftDdrMqcg-q4LmyG+xSgZfD-2m_K_+PsSApFQj2TfDaBEbYg@mail.gmail.com>
Subject: Re: seandroid and policy version
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        Joman Chu <jcchu@tycho.ncsc.mil>
Content-Type: multipart/alternative; boundary=bcaec51b150d60409f04c9fe7c8a
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec51b150d60409f04c9fe7c8a
Content-Type: text/plain; charset=ISO-8859-1

Those look fine with me.

Only a few will export the POLICYVERS, but it would be nice to override in
the of chance you need to. The biggest thing will be to worry about AOSP
but make it easy to support oem's so they can configure it without having
to edit the base code.

Bill

On Tue, Sep 18, 2012 at 11:52 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Attached are patches for libselinux and sepolicy to drop the policy
> version suffix.  We still force generation of a version 24 policy by
> default, although this can be overridden via make command-line or
> environment setting (e.g. export POLICYVERS=26).  Does this seem sane?
> Note that seandroid-4.0.4 requires changes to system/core as well, so
> this only fixes it for master and 4.1.1.
>
>
> --
> Stephen Smalley
> National Security Agency
>



-- 
Respectfully,

William C Roberts

--bcaec51b150d60409f04c9fe7c8a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Those look fine with me.<div><br></div><div>Only a few will export the POLI=
CYVERS, but it would be nice to override in the of chance you need to. The =
biggest thing will be to worry about AOSP but make it easy to support oem&#=
39;s so they can configure it without having to edit the base code.</div>
<div><br></div><div>Bill=A0</div><div><br><div class=3D"gmail_quote">On Tue=
, Sep 18, 2012 at 11:52 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Attached are patches for libselinux and sepo=
licy to drop the policy<br>
version suffix. =A0We still force generation of a version 24 policy by<br>
default, although this can be overridden via make command-line or<br>
environment setting (e.g. export POLICYVERS=3D26). =A0Does this seem sane?<=
br>
Note that seandroid-4.0.4 requires changes to system/core as well, so<br>
this only fixes it for master and 4.1.1.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
Respectfully,<br><br>William C Roberts<br><br><br>
</div>

--bcaec51b150d60409f04c9fe7c8a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
