MIME-Version: 1.0
In-Reply-To: <1343050097.23118.29.camel@moss-pluto.epoch.ncsc.mil>
References: <1342739276-1686-5-git-send-email-hqjiang1988@gmail.com>
	<1343050097.23118.29.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 23 Jul 2012 09:29:54 -0700
Message-ID: <CAO-4OdFEj7_6z=BLD2cpqpY=HW=+XZYpgZNqxZVLiRnRw0rWtQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] external/sepolicy: system talk to rild via socket
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=f46d0401240b84e30304c581c16e
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d0401240b84e30304c581c16e
Content-Type: text/plain; charset=ISO-8859-1

I find the denial is from "GpsLocationProvider" which is labeled with
"system". And for somehow it requires socket connection.

On Mon, Jul 23, 2012 at 6:28 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:
> > ---
> >  system.te |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/system.te b/system.te
> > index 5c34f81..1a25fd3 100644
> > --- a/system.te
> > +++ b/system.te
> > @@ -107,6 +107,7 @@ unix_socket_connect(system, dbus, dbusd)
> >  unix_socket_connect(system, gps, gpsd)
> >  unix_socket_connect(system, bluetooth, bluetoothd)
> >  unix_socket_send(system, wpa, wpa)
> > +unix_socket_connect(system, rild, rild)
> >
> >  # Communicate over a socket created by surfaceflinger.
> >  allow system surfaceflinger:unix_stream_socket { read write setopt };
>
> Same as prior one.
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

--f46d0401240b84e30304c581c16e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I find the denial is from &quot;GpsLocationProvider&quot; which is labeled =
with &quot;system&quot;. And for somehow it requires socket connection.=A0<=
br><br><div class=3D"gmail_quote">On Mon, Jul 23, 2012 at 6:28 AM, Stephen =
Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=
=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:<br>
&gt; ---<br>
&gt; =A0system.te | =A0 =A01 +<br>
&gt; =A01 files changed, 1 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/system.te b/system.te<br>
&gt; index 5c34f81..1a25fd3 100644<br>
&gt; --- a/system.te<br>
&gt; +++ b/system.te<br>
&gt; @@ -107,6 +107,7 @@ unix_socket_connect(system, dbus, dbusd)<br>
&gt; =A0unix_socket_connect(system, gps, gpsd)<br>
&gt; =A0unix_socket_connect(system, bluetooth, bluetoothd)<br>
&gt; =A0unix_socket_send(system, wpa, wpa)<br>
&gt; +unix_socket_connect(system, rild, rild)<br>
&gt;<br>
&gt; =A0# Communicate over a socket created by surfaceflinger.<br>
&gt; =A0allow system surfaceflinger:unix_stream_socket { read write setopt =
};<br>
<br>
</div></div>Same as prior one.<br>
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

--f46d0401240b84e30304c581c16e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
