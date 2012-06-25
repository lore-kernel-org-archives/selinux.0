MIME-Version: 1.0
In-Reply-To: <1340626369.22057.29.camel@moss-pluto.epoch.ncsc.mil>
References: <CAFftDdqF5WPAx3ESGbzFFaXvW8jb5Qxsk6oqz-f47UH3fqQkyA@mail.gmail.com>
	<1340626369.22057.29.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 25 Jun 2012 09:35:01 -0700
Message-ID: <CAFftDdpD9ycPA60HSVLBpC_t7P2fcxRoEn2zUEMhhhLzPQVqTA@mail.gmail.com>
Subject: Re: [PATCH] hiding SELinux status on Settings app if HAVE_SELINUX:=false
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b10ce793bd33104c34e904b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b10ce793bd33104c34e904b
Content-Type: text/plain; charset=ISO-8859-1

Ahh your comment in Garret said, "willing to abandon", didn't realize you
did. How can you go about getting that patchset marked as (abandoned) in
Garret and can you please do that?

On another note, I see at times that it's hard getting around the
HAVE_SELINUX in java code since their is no conditional compilation. It
looks like the build prop is a cleaner way of handling this. Should we keep
the change in libcore and merge that?

I still think having the selinux status in Settings is useful as it doesn't
require me to bake in an app for it.

Bill

On Mon, Jun 25, 2012 at 5:12 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2012-06-22 at 13:43 -0700, William Roberts wrote:
> > This should hide the SELinux status in settings if you don't have
> > HAVE_SELINUX:=true during the build.
> >
> >
> > Please verify these patches before merging them. I only tested on
> > Maguro.
> >
> >
> > Right now, you must do a CLEAN build to get these to work right. For
> > some reason props doesn't get updated right for me.
> >
> >
> > These for addressing the issues in Change-Id:
> > I69529fb7a3adfe31eccb16d79740fc4952ff5e68 on garret
>
> I was going to just drop the Settings app change since we now have
> SEAndroidManager and it provides a superset of the Settings app
> functionality (and has the benefit of being easily included/excluded in
> different product builds).
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Respectfully,

William C Roberts

--047d7b10ce793bd33104c34e904b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ahh your comment in Garret said, &quot;willing to abandon&quot;, didn&#39;t=
 realize you did. How can you go about getting that patchset marked as (aba=
ndoned) in Garret and can you please do that?<div><br></div><div>On another=
 note, I see at times that it&#39;s hard getting around the HAVE_SELINUX in=
 java code since their is no conditional compilation. It looks like the bui=
ld prop is a cleaner way of handling this. Should we keep the change in lib=
core and merge that?</div>
<div><br></div><div>I still think having the selinux status in Settings is =
useful as it doesn&#39;t require me to bake in an app for it.</div><div><br=
></div><div>Bill</div><div><div><div><br><div class=3D"gmail_quote">On Mon,=
 Jun 25, 2012 at 5:12 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"=
mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span=
> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On F=
ri, 2012-06-22 at 13:43 -0700, William Roberts wrote:<br>
&gt; This should hide the SELinux status in settings if you don&#39;t have<=
br>
&gt; HAVE_SELINUX:=3Dtrue during the build.<br>
&gt;<br>
&gt;<br>
&gt; Please verify these patches before merging them. I only tested on<br>
&gt; Maguro.<br>
&gt;<br>
&gt;<br>
&gt; Right now, you must do a CLEAN build to get these to work right. For<b=
r>
&gt; some reason props doesn&#39;t get updated right for me.<br>
&gt;<br>
&gt;<br>
&gt; These for addressing the issues in Change-Id:<br>
&gt; I69529fb7a3adfe31eccb16d79740fc4952ff5e68 on garret<br>
<br>
</div></div>I was going to just drop the Settings app change since we now h=
ave<br>
SEAndroidManager and it provides a superset of the Settings app<br>
functionality (and has the benefit of being easily included/excluded in<br>
different product builds).<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Respectfully,<br><br>William C Roberts<br><br><br>
</div></div></div>

--047d7b10ce793bd33104c34e904b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
