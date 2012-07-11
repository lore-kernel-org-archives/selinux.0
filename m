MIME-Version: 1.0
In-Reply-To: <1342010590.29461.21.camel@moss-pluto.epoch.ncsc.mil>
References: <1341956182-1071-1-git-send-email-hqjiang1988@gmail.com>
	<1342010590.29461.21.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 11 Jul 2012 14:29:19 -0700
Message-ID: <CAFftDdo0QvywXw9wTQtLTtD2bvn-5cDktQkADQi_GNiaWxqG+g@mail.gmail.com>
Subject: Re: Patches to target denies of LocationManager (GPS).
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: hqjiang <hqjiang1988@gmail.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf307abeed2d404c04c4948ab1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf307abeed2d404c04c4948ab1
Content-Type: text/plain; charset=ISO-8859-1

Ok we will submit patches for this soon.

On Wed, Jul 11, 2012 at 5:43 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2012-07-10 at 14:36 -0700, hqjiang wrote:
> > LocationManger needs to access GPS over UART devices. Two core
> functionalities are
> > required in order to access GPS. The first one is the uart driver.
> /dev/ttyO0 is
> > for UART Driver. It's defined in CSR SiRF policy file. We can find it on
> both maguro
> > and toro devices. But it's Samsung tuna board specific. We define it as
> "gps_device".
> >
> > The second one is the uart rts level ctrl. The uart1 is for GPS and CSR
> GPS chip
> > should control uart1 rts level for GPS firmware download.
> /proc/mcspi1_cs3_ctrl is
> > the proc entry assigned "uart1 rts level" control. It is also Samsung
> Tuna Board
> > specific.
> >
> > But we find one problem that we cannot label contexts of
> /proc/mcspi1_cs3_ctrl out
> > of file "ocontext". Could someone help us to label it in the file of
> > "/device/samsung/tuna/sepolicy.fc" to make it device-specific?
>
> You'd need to modify sepolicy/Android.mk to look for a new file in the
> per-device directories, maybe sepolicy.ocontexts, and merge its contents
> into the base ocontexts configuration.  But it isn't a simple matter of
> concatenating as with the .fc files or .te files as it has multiple
> sections and you can't just intermingle them.  One option would be to
> split up ocontexts into separate files for each kind of statement (as in
> the refpolicy) and then you could in fact just look for a corresponding
> sepolicy.X file in the per-device directory and concatenate it.  The
> individual files would be initial_sid_contexts (the sid statements),
> fs_use (the fs_use_* statements), genfs_contexts (the genfscon
> statements), etc.
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Respectfully,

William C Roberts

--20cf307abeed2d404c04c4948ab1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ok we will submit patches for this soon.<br><br><div class=3D"gmail_quote">=
On Wed, Jul 11, 2012 at 5:43 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt=
;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
ue, 2012-07-10 at 14:36 -0700, hqjiang wrote:<br>
&gt; LocationManger needs to access GPS over UART devices. Two core functio=
nalities are<br>
&gt; required in order to access GPS. The first one is the uart driver. /de=
v/ttyO0 is<br>
&gt; for UART Driver. It&#39;s defined in CSR SiRF policy file. We can find=
 it on both maguro<br>
&gt; and toro devices. But it&#39;s Samsung tuna board specific. We define =
it as &quot;gps_device&quot;.<br>
&gt;<br>
&gt; The second one is the uart rts level ctrl. The uart1 is for GPS and CS=
R GPS chip<br>
&gt; should control uart1 rts level for GPS firmware download. /proc/mcspi1=
_cs3_ctrl is<br>
&gt; the proc entry assigned &quot;uart1 rts level&quot; control. It is als=
o Samsung Tuna Board<br>
&gt; specific.<br>
&gt;<br>
&gt; But we find one problem that we cannot label contexts of /proc/mcspi1_=
cs3_ctrl out<br>
&gt; of file &quot;ocontext&quot;. Could someone help us to label it in the=
 file of<br>
&gt; &quot;/device/samsung/tuna/sepolicy.fc&quot; to make it device-specifi=
c?<br>
<br>
</div></div>You&#39;d need to modify sepolicy/Android.mk to look for a new =
file in the<br>
per-device directories, maybe sepolicy.ocontexts, and merge its contents<br=
>
into the base ocontexts configuration. =A0But it isn&#39;t a simple matter =
of<br>
concatenating as with the .fc files or .te files as it has multiple<br>
sections and you can&#39;t just intermingle them. =A0One option would be to=
<br>
split up ocontexts into separate files for each kind of statement (as in<br=
>
the refpolicy) and then you could in fact just look for a corresponding<br>
sepolicy.X file in the per-device directory and concatenate it. =A0The<br>
individual files would be initial_sid_contexts (the sid statements),<br>
fs_use (the fs_use_* statements), genfs_contexts (the genfscon<br>
statements), etc.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Respectfully,<br><br>William C Roberts<br><br><br>

--20cf307abeed2d404c04c4948ab1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
