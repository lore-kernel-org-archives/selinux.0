MIME-Version: 1.0
In-Reply-To: <1347543187.15047.23.camel@moss-pluto.epoch.ncsc.mil>
References: <1347486228-12390-1-git-send-email-w.roberts@sta.samsung.com>
	<E24EB765E1998A40A0C06DE52672C482017B68C84984@staex7mb1.telecom.sna.samsung.com>
	<1347543187.15047.23.camel@moss-pluto.epoch.ncsc.mil>
Date: Thu, 13 Sep 2012 10:00:18 -0700
Message-ID: <CAFftDdrWONXsbPCsasbPtb8EsU9f1CZrtSHB4e9hyaUJ9bHMsw@mail.gmail.com>
Subject: Re: [PATCH] Allow domain access to /dev/ion
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Content-Type: multipart/alternative; boundary=14dae9cfc88af52c0404c9983d99
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--14dae9cfc88af52c0404c9983d99
Content-Type: text/plain; charset=ISO-8859-1

No but I can today.
On Sep 13, 2012 6:35 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> On Wed, 2012-09-12 at 16:48 -0500, William Roberts wrote:
> > Just wanted to get some feedback before submitting this to AOSP. I think
> everyone is going to need access to this, it seems to be cropping up more
> and more. I wrestled with r or rw perms on this, but it looks like rw is
> the way to go IMO.
> >
> > If this gets a blessing Ill submit upstream....
>
> Have you looked at the ion driver to see if any of its operations are
> security-sensitive?
>
> >
> > -----Original Message-----
> > From: William Roberts [mailto:bill.c.roberts@gmail.com]
> > Sent: Wednesday, September 12, 2012 2:44 PM
> > To: selinux@tycho.nsa.gov
> > Cc: sds@tycho.nsa.gov; William Roberts
> > Subject: [PATCH] Allow domain access to /dev/ion
> >
> > Change-Id: I87f81a632ed61f284f2fe09726f5c4529d36f252
> > ---
> >  domain.te      |    3 +++
> >  mediaserver.te |    1 -
> >  2 files changed, 3 insertions(+), 1 deletions(-)
> >
> > diff --git a/domain.te b/domain.te
> > index 6be7ddd..47ad05a 100644
> > --- a/domain.te
> > +++ b/domain.te
> > @@ -83,6 +83,9 @@ allow domain cache_file:lnk_file read;  allow domain
> cgroup:dir { search write };  allow domain cgroup:file w_file_perms;
> >
> > +#Allow access to ion memory allocation device allow domain
> > +ion_device:chr_file rw_file_perms;
> > +
> >  # For /sys/qemu_trace files in the emulator.
> >  bool in_qemu false;
> >  if (in_qemu) {
> > diff --git a/mediaserver.te b/mediaserver.te index e124db0..4b299a0
> 100644
> > --- a/mediaserver.te
> > +++ b/mediaserver.te
> > @@ -25,7 +25,6 @@ allow mediaserver qemu_device:chr_file rw_file_perms;
>  allow mediaserver sysfs:file rw_file_perms;  # XXX Why?
> >  allow mediaserver apk_data_file:file { read getattr }; -allow
> mediaserver ion_device:chr_file rw_file_perms;
> >
> >  # To use remote processor
> >  allow mediaserver rpmsg_device:chr_file rw_file_perms;
> > --
> > 1.7.0.4
> >
>
> --
> Stephen Smalley
> National Security Agency
>
>

--14dae9cfc88af52c0404c9983d99
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">No but I can today.</p>
<div class=3D"gmail_quote">On Sep 13, 2012 6:35 AM, &quot;Stephen Smalley&q=
uot; &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wro=
te:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On Wed, 2012-09-12 at 16:48 -0500, William Roberts wrote:<br>
&gt; Just wanted to get some feedback before submitting this to AOSP. I thi=
nk everyone is going to need access to this, it seems to be cropping up mor=
e and more. I wrestled with r or rw perms on this, but it looks like rw is =
the way to go IMO.<br>

&gt;<br>
&gt; If this gets a blessing Ill submit upstream....<br>
<br>
Have you looked at the ion driver to see if any of its operations are<br>
security-sensitive?<br>
<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: William Roberts [mailto:<a href=3D"mailto:bill.c.roberts@gmail.c=
om">bill.c.roberts@gmail.com</a>]<br>
&gt; Sent: Wednesday, September 12, 2012 2:44 PM<br>
&gt; To: <a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a>=
<br>
&gt; Cc: <a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>; Willia=
m Roberts<br>
&gt; Subject: [PATCH] Allow domain access to /dev/ion<br>
&gt;<br>
&gt; Change-Id: I87f81a632ed61f284f2fe09726f5c4529d36f252<br>
&gt; ---<br>
&gt; =A0domain.te =A0 =A0 =A0| =A0 =A03 +++<br>
&gt; =A0mediaserver.te | =A0 =A01 -<br>
&gt; =A02 files changed, 3 insertions(+), 1 deletions(-)<br>
&gt;<br>
&gt; diff --git a/domain.te b/domain.te<br>
&gt; index 6be7ddd..47ad05a 100644<br>
&gt; --- a/domain.te<br>
&gt; +++ b/domain.te<br>
&gt; @@ -83,6 +83,9 @@ allow domain cache_file:lnk_file read; =A0allow doma=
in cgroup:dir { search write }; =A0allow domain cgroup:file w_file_perms;<b=
r>
&gt;<br>
&gt; +#Allow access to ion memory allocation device allow domain<br>
&gt; +ion_device:chr_file rw_file_perms;<br>
&gt; +<br>
&gt; =A0# For /sys/qemu_trace files in the emulator.<br>
&gt; =A0bool in_qemu false;<br>
&gt; =A0if (in_qemu) {<br>
&gt; diff --git a/mediaserver.te b/mediaserver.te index e124db0..4b299a0 10=
0644<br>
&gt; --- a/mediaserver.te<br>
&gt; +++ b/mediaserver.te<br>
&gt; @@ -25,7 +25,6 @@ allow mediaserver qemu_device:chr_file rw_file_perms=
; =A0allow mediaserver sysfs:file rw_file_perms; =A0# XXX Why?<br>
&gt; =A0allow mediaserver apk_data_file:file { read getattr }; -allow media=
server ion_device:chr_file rw_file_perms;<br>
&gt;<br>
&gt; =A0# To use remote processor<br>
&gt; =A0allow mediaserver rpmsg_device:chr_file rw_file_perms;<br>
&gt; --<br>
&gt; 1.7.0.4<br>
&gt;<br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</blockquote></div>

--14dae9cfc88af52c0404c9983d99--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
