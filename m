MIME-Version: 1.0
In-Reply-To: <1343049740.23118.24.camel@moss-pluto.epoch.ncsc.mil>
References: <1342739276-1686-2-git-send-email-hqjiang1988@gmail.com>
	<1343049740.23118.24.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 23 Jul 2012 09:19:10 -0700
Message-ID: <CAO-4OdFH2aPRzHMd5g33ZatDCxCKxuJ9=M19Vv=z2WBdCcbFvw@mail.gmail.com>
Subject: Re: [PATCH 1/6] external/sepolicy: allow media_app more permissions
 on sdcard
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=f46d042c6c4d17863904c5819bbb
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d042c6c4d17863904c5819bbb
Content-Type: text/plain; charset=ISO-8859-1

I made a mistake. Sorry for that.

On Mon, Jul 23, 2012 at 6:22 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:
> > ---
> >  app.te |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/app.te b/app.te
> > index 0866e95..a5ff295 100644
> > --- a/app.te
> > +++ b/app.te
> > @@ -41,7 +41,7 @@ allow media_app cache_file:dir rw_dir_perms;
> >  allow media_app cache_file:file create_file_perms;
> >  # Access sdcard.
> >  allow media_app sdcard:dir create_dir_perms;
> > -allow media_app sdcard:file create_file_perms;
> > +allow media_app sdcard:file { create_file_perms link_file_perms };
> >  # Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
> >  allow media_app qtaguid_proc:file rw_file_perms;
> >  allow media_app qtaguid_device:chr_file r_file_perms;
>
> create_file_perms already contains link_file_perms, so this does
> nothing.
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

--f46d042c6c4d17863904c5819bbb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I made a mistake. Sorry for that.=A0<br><br><div class=3D"gmail_quote">On M=
on, Jul 23, 2012 at 6:22 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:<br>
&gt; ---<br>
&gt; =A0app.te | =A0 =A02 +-<br>
&gt; =A01 files changed, 1 insertions(+), 1 deletions(-)<br>
&gt;<br>
&gt; diff --git a/app.te b/app.te<br>
&gt; index 0866e95..a5ff295 100644<br>
&gt; --- a/app.te<br>
&gt; +++ b/app.te<br>
&gt; @@ -41,7 +41,7 @@ allow media_app cache_file:dir rw_dir_perms;<br>
&gt; =A0allow media_app cache_file:file create_file_perms;<br>
&gt; =A0# Access sdcard.<br>
&gt; =A0allow media_app sdcard:dir create_dir_perms;<br>
&gt; -allow media_app sdcard:file create_file_perms;<br>
&gt; +allow media_app sdcard:file { create_file_perms link_file_perms };<br=
>
&gt; =A0# Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid<br>
&gt; =A0allow media_app qtaguid_proc:file rw_file_perms;<br>
&gt; =A0allow media_app qtaguid_device:chr_file r_file_perms;<br>
<br>
</div></div>create_file_perms already contains link_file_perms, so this doe=
s<br>
nothing.<br>
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

--f46d042c6c4d17863904c5819bbb--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
