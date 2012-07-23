MIME-Version: 1.0
In-Reply-To: <1343049641.23118.22.camel@moss-pluto.epoch.ncsc.mil>
References: <1342734563-32644-1-git-send-email-hqjiang1988@gmail.com>
	<1342734563-32644-4-git-send-email-hqjiang1988@gmail.com>
	<1343049641.23118.22.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 23 Jul 2012 09:17:48 -0700
Message-ID: <CAO-4OdGsumWMtLPyDEDsfpqHynqEoXdaB2v35BFfHuQf8vAQgw@mail.gmail.com>
Subject: Re: [PATCH 3/3] external/sepolicy: system r/w udp_socket of untrusted apps
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=f46d042c5ed73bfa3d04c58196ad
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d042c5ed73bfa3d04c58196ad
Content-Type: text/plain; charset=ISO-8859-1

That will be fine. Appdomain is more general. Thanks.

On Mon, Jul 23, 2012 at 6:20 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2012-07-19 at 14:49 -0700, Haiqing Jiang wrote:
> > From: hqjiang <hqjiang1988@gmail.com>
> >
> > ---
> >  system.te |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/system.te b/system.te
> > index a4065cf..5c34f81 100644
> > --- a/system.te
> > +++ b/system.te
> > @@ -196,3 +196,6 @@ allow system domain:file r_file_perms;
> >  # to uart driver and ctrl proc entry
> >  allow system gps_device:chr_file rw_file_perms;
> >  allow system gps_control:file rw_file_perms;
> > +
> > +# system Read/Write udp_socket of untrusted_app
> > +allow system untrusted_app:udp_socket { read write };
>
> So an app is passing a socket fd to the system_server over Binder and
> the system_server is then writing to the socket?  Wonder why.  Anyway,
> rather than writing this only in terms of one app domain
> (untrusted_app), cover all cases by using the appdomain attribute, i.e.
> allow system appdomain:udp_socket { read write };
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

--f46d042c5ed73bfa3d04c58196ad
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

That will be fine. Appdomain is more general. Thanks.=A0<br><br><div class=
=3D"gmail_quote">On Mon, Jul 23, 2012 at 6:20 AM, Stephen Smalley <span dir=
=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tyc=
ho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, 2012-07-19 at 14:49 -0700, Haiqing Jiang wrote:<br>
&gt; From: hqjiang &lt;<a href=3D"mailto:hqjiang1988@gmail.com">hqjiang1988=
@gmail.com</a>&gt;<br>
&gt;<br>
&gt; ---<br>
&gt; =A0system.te | =A0 =A03 +++<br>
&gt; =A01 files changed, 3 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/system.te b/system.te<br>
&gt; index a4065cf..5c34f81 100644<br>
&gt; --- a/system.te<br>
&gt; +++ b/system.te<br>
&gt; @@ -196,3 +196,6 @@ allow system domain:file r_file_perms;<br>
&gt; =A0# to uart driver and ctrl proc entry<br>
&gt; =A0allow system gps_device:chr_file rw_file_perms;<br>
&gt; =A0allow system gps_control:file rw_file_perms;<br>
&gt; +<br>
&gt; +# system Read/Write udp_socket of untrusted_app<br>
&gt; +allow system untrusted_app:udp_socket { read write };<br>
<br>
</div></div>So an app is passing a socket fd to the system_server over Bind=
er and<br>
the system_server is then writing to the socket? =A0Wonder why. =A0Anyway,<=
br>
rather than writing this only in terms of one app domain<br>
(untrusted_app), cover all cases by using the appdomain attribute, i.e.<br>
allow system appdomain:udp_socket { read write };<br>
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

--f46d042c5ed73bfa3d04c58196ad--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
