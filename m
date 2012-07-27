MIME-Version: 1.0
In-Reply-To: <1343411694.17570.70.camel@moss-pluto.epoch.ncsc.mil>
References: <1343411642-3444-1-git-send-email-hqjiang1988@gmail.com>
	<1343411694.17570.70.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 27 Jul 2012 11:19:28 -0700
Message-ID: <CAO-4OdGxc0V_HMK9NNzRO=cASUeJLk1H=eM49aq1Wa9Nrnih4w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Platform app domain sdcard accesses
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=f46d0421824dac4b8504c5d3c0b3
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d0421824dac4b8504c5d3c0b3
Content-Type: text/plain; charset=ISO-8859-1

YES..... correct...

On Fri, Jul 27, 2012 at 10:54 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2012-07-27 at 10:54 -0700, Haiqing Jiang wrote:
> > ---
> >  app.te |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/app.te b/app.te
> > index df0f5df..818f5c0 100644
> > --- a/app.te
> > +++ b/app.te
> > @@ -86,6 +86,9 @@ net_domain(browser_app)
> >  # App sandbox file accesses.
> >  allow platformappdomain platform_app_data_file:dir create_dir_perms;
> >  allow platformappdomain platform_app_data_file:notdevfile_class_set
> create_file_perms;
> > +# App sdcard file accesses
> > +allow platformappdomain sdcard:dir create_dir_perms;
> > +allow platformappdomain sdcard:file create_file_perms;
> >
> >  #
> >  # Untrusted apps.
>
> In that case, we should be able to delete the rules for platform_app and
> media_app to sdcard, right?
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

--f46d0421824dac4b8504c5d3c0b3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

YES..... correct...=A0<br><br><div class=3D"gmail_quote">On Fri, Jul 27, 20=
12 at 10:54 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds=
@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On Fri, 2012-07-27 at 10:54 -0700, =
Haiqing Jiang wrote:<br>
&gt; ---<br>
&gt; =A0app.te | =A0 =A03 +++<br>
&gt; =A01 files changed, 3 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/app.te b/app.te<br>
&gt; index df0f5df..818f5c0 100644<br>
&gt; --- a/app.te<br>
&gt; +++ b/app.te<br>
&gt; @@ -86,6 +86,9 @@ net_domain(browser_app)<br>
&gt; =A0# App sandbox file accesses.<br>
&gt; =A0allow platformappdomain platform_app_data_file:dir create_dir_perms=
;<br>
&gt; =A0allow platformappdomain platform_app_data_file:notdevfile_class_set=
 create_file_perms;<br>
&gt; +# App sdcard file accesses<br>
&gt; +allow platformappdomain sdcard:dir create_dir_perms;<br>
&gt; +allow platformappdomain sdcard:file create_file_perms;<br>
&gt;<br>
&gt; =A0#<br>
&gt; =A0# Untrusted apps.<br>
<br>
</div></div>In that case, we should be able to delete the rules for platfor=
m_app and<br>
media_app to sdcard, right?<br>
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

--f46d0421824dac4b8504c5d3c0b3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
