MIME-Version: 1.0
In-Reply-To: <1343049530.23118.20.camel@moss-pluto.epoch.ncsc.mil>
References: <1342734563-32644-1-git-send-email-hqjiang1988@gmail.com>
	<1342734563-32644-3-git-send-email-hqjiang1988@gmail.com>
	<1343049530.23118.20.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 23 Jul 2012 09:15:59 -0700
Message-ID: <CAO-4OdGyfO2GeXCD+1SyrjMQtn4OKrc+wPzPXMpF=cCp8Qt7DA@mail.gmail.com>
Subject: Re: [PATCH 2/3] external/sepolicy: install daemon link/unlink
 application data files
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=14dae9d71976bbea9404c5818f49
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--14dae9d71976bbea9404c5818f49
Content-Type: text/plain; charset=ISO-8859-1

You are right. Only required permission is unlink.

On Mon, Jul 23, 2012 at 6:18 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2012-07-19 at 14:49 -0700, Haiqing Jiang wrote:
> > From: hqjiang <hqjiang1988@gmail.com>
> >
> > ---
> >  installd.te |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/installd.te b/installd.te
> > index 466125e..5211f0a 100644
> > --- a/installd.te
> > +++ b/installd.te
> > @@ -20,3 +20,5 @@ dontaudit installd self:capability sys_admin;
> >  selinux_check_context(installd)
> >  # Read /seapp_contexts, presently on the rootfs.
> >  allow installd rootfs:file r_file_perms;
> > +# Link/Unlink app_data_file
> > +allow installd app_data_file:lnk_file link_file_perms;
>
> What actual permissions were required?  link (create a hard link)
> doesn't make sense on a symlink (lnk_file).  unlink and rename are
> legitimate, but wondering whether anything other than unlink was
> required.
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

--14dae9d71976bbea9404c5818f49
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

You are right. Only required permission is unlink.=A0<br><br><div class=3D"=
gmail_quote">On Mon, Jul 23, 2012 at 6:18 AM, Stephen Smalley <span dir=3D"=
ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.n=
sa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, 2012-07-19 at 14:49 -0700, Haiqing Jiang wrote:<br>
&gt; From: hqjiang &lt;<a href=3D"mailto:hqjiang1988@gmail.com">hqjiang1988=
@gmail.com</a>&gt;<br>
&gt;<br>
&gt; ---<br>
&gt; =A0installd.te | =A0 =A02 ++<br>
&gt; =A01 files changed, 2 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/installd.te b/installd.te<br>
&gt; index 466125e..5211f0a 100644<br>
&gt; --- a/installd.te<br>
&gt; +++ b/installd.te<br>
&gt; @@ -20,3 +20,5 @@ dontaudit installd self:capability sys_admin;<br>
&gt; =A0selinux_check_context(installd)<br>
&gt; =A0# Read /seapp_contexts, presently on the rootfs.<br>
&gt; =A0allow installd rootfs:file r_file_perms;<br>
&gt; +# Link/Unlink app_data_file<br>
&gt; +allow installd app_data_file:lnk_file link_file_perms;<br>
<br>
</div></div>What actual permissions were required? =A0link (create a hard l=
ink)<br>
doesn&#39;t make sense on a symlink (lnk_file). =A0unlink and rename are<br=
>
legitimate, but wondering whether anything other than unlink was<br>
required.<br>
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

--14dae9d71976bbea9404c5818f49--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
