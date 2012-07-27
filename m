MIME-Version: 1.0
In-Reply-To: <1343415170.17570.83.camel@moss-pluto.epoch.ncsc.mil>
References: <1343414653-3998-1-git-send-email-hqjiang1988@gmail.com>
	<1343415170.17570.83.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 27 Jul 2012 12:46:09 -0700
Message-ID: <CAO-4OdFAqFkF02_Vv_2j3ryzEVb-GeOfsmCKcm7RX+OWYN0Sqg@mail.gmail.com>
Subject: Re: [PATCH 1/1] installd unlink platform_app_data_file
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=f46d04083de7b43ed804c5d4f618
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04083de7b43ed804c5d4f618
Content-Type: text/plain; charset=ISO-8859-1

Could you update the patch to branches? Thanks.

On Fri, Jul 27, 2012 at 11:52 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2012-07-27 at 11:44 -0700, Haiqing Jiang wrote:
> > ---
> >  installd.te |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/installd.te b/installd.te
> > index ce9122b..a2c7bb4 100644
> > --- a/installd.te
> > +++ b/installd.te
> > @@ -20,5 +20,6 @@ dontaudit installd self:capability sys_admin;
> >  selinux_check_context(installd)
> >  # Read /seapp_contexts, presently on the rootfs.
> >  allow installd rootfs:file r_file_perms;
> > -# Unlink app_data_file
> > +# Unlink app_data_file and platform_app_data_file
> >  allow installd app_data_file:lnk_file unlink;
> > +allow installd platform_app_data_file:lnk_file unlink;
>
> Just add lnk_file to the earlier rule for data_file_type and drop these
> two rules altogether.
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

--f46d04083de7b43ed804c5d4f618
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Could you update the patch to branches? Thanks.=A0<br><br><div class=3D"gma=
il_quote">On Fri, Jul 27, 2012 at 11:52 AM, Stephen Smalley <span dir=3D"lt=
r">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa=
.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On F=
ri, 2012-07-27 at 11:44 -0700, Haiqing Jiang wrote:<br>
&gt; ---<br>
&gt; =A0installd.te | =A0 =A03 ++-<br>
&gt; =A01 files changed, 2 insertions(+), 1 deletions(-)<br>
&gt;<br>
&gt; diff --git a/installd.te b/installd.te<br>
&gt; index ce9122b..a2c7bb4 100644<br>
&gt; --- a/installd.te<br>
&gt; +++ b/installd.te<br>
&gt; @@ -20,5 +20,6 @@ dontaudit installd self:capability sys_admin;<br>
&gt; =A0selinux_check_context(installd)<br>
&gt; =A0# Read /seapp_contexts, presently on the rootfs.<br>
&gt; =A0allow installd rootfs:file r_file_perms;<br>
&gt; -# Unlink app_data_file<br>
&gt; +# Unlink app_data_file and platform_app_data_file<br>
&gt; =A0allow installd app_data_file:lnk_file unlink;<br>
&gt; +allow installd platform_app_data_file:lnk_file unlink;<br>
<br>
</div></div>Just add lnk_file to the earlier rule for data_file_type and dr=
op these<br>
two rules altogether.<br>
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

--f46d04083de7b43ed804c5d4f618--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
