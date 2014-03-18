Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2I9Q3xG031665
 for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2014 05:26:03 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so6797722pdj.40
 for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2014 02:25:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1403181326240.10830@tundra.namei.org>
References: <2794067.Wx0yCIiBrQ@sifl>
 <alpine.LRH.2.02.1403171445570.2002@tundra.namei.org>
 <CACLa4pukOH8TLmRorra4Wh0962y-QF4D2eFzgvr7KSSJnSLKZw@mail.gmail.com>
 <1685091.iJm6M33sra@sifl>
 <alpine.LRH.2.02.1403181326240.10830@tundra.namei.org>
Date: Tue, 18 Mar 2014 05:25:36 -0400
Message-ID: <CAHC9VhQUOr_v-x+Ngf6V_JeSp_-KG8-mWyRzPNUenD0zUysv6A@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for 3.15
From: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
Content-Type: multipart/alternative; boundary=047d7b33ca7c60ae4304f4de1e90
Cc: LSM List <linux-security-module@vger.kernel.org>,
 SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b33ca7c60ae4304f4de1e90
Content-Type: text/plain; charset=ISO-8859-1

My apologies, the new branch is "next-jmorris".

--
paul moore
www.paul-moore.com
On Mar 17, 2014 10:26 PM, "James Morris" <jmorris@namei.org> wrote:

> On Mon, 17 Mar 2014, Paul Moore wrote:
>
> > On Monday, March 17, 2014 07:21:59 AM Eric Paris wrote:
> > > You think a security tree based on 3.13-rc7 is good and Paul, who
> > > tested on the actual release of 3.13 is bad?
> > >
> > > I know you got yelled at for randomly picking fast forward-ish merge
> > > points, but now you've got a crappy merge point.  Apparently, it was
> > > needed it for the Xen/TPM work (not sure why YOU merged it instead of
> > > the TPM people, but that's beside the point).
> > >
> > > But the problem stands.  You are based on a crummy location.  When are
> > > you going to pick up 3.13?  After 3.14 is out?
> > >
> > > Seems like Paul's move to include 3.13 made a lot of sense...
> >
> > This issue with the linux-security tree keeps coming up and I stand by my
> > earlier statements that I would much prefer if the linux-security is
> based off
> > the latest kernel release, e.g. 3.13 as of today.  This seems to be in
> keeping
> > with Linus' comments, fits with what Eric was doing back when he managed
> the
> > SELinux tree, and strikes a nice balance between stability and
> "newness".  I
> > plan on continuing with this approach for the SELinux tree.
> >
> > However, I don't want the 3.15 patches to get lost due to these stupid
> > differences so I've created a new branch that has the SELinux 3.15
> patches
> > applied on top of linux-security#next.
> >
> >  * git://git.infradead.org/users/pcmoore/selinux next
>
> What's the new branch?  That seems to be the same.
>
>
> --
> James Morris
> <jmorris@namei.org>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--047d7b33ca7c60ae4304f4de1e90
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">My apologies, the new branch is &quot;next-jmorris&quot;.</p=
>
<p dir=3D"ltr">--<br>
paul moore<br>
<a href=3D"http://www.paul-moore.com">www.paul-moore.com</a></p>
<div class=3D"gmail_quote">On Mar 17, 2014 10:26 PM, &quot;James Morris&quo=
t; &lt;<a href=3D"mailto:jmorris@namei.org">jmorris@namei.org</a>&gt; wrote=
:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On Mon, 17 Mar 2014, Paul Moore wrote:<br>
<br>
&gt; On Monday, March 17, 2014 07:21:59 AM Eric Paris wrote:<br>
&gt; &gt; You think a security tree based on 3.13-rc7 is good and Paul, who=
<br>
&gt; &gt; tested on the actual release of 3.13 is bad?<br>
&gt; &gt;<br>
&gt; &gt; I know you got yelled at for randomly picking fast forward-ish me=
rge<br>
&gt; &gt; points, but now you&#39;ve got a crappy merge point. =A0Apparentl=
y, it was<br>
&gt; &gt; needed it for the Xen/TPM work (not sure why YOU merged it instea=
d of<br>
&gt; &gt; the TPM people, but that&#39;s beside the point).<br>
&gt; &gt;<br>
&gt; &gt; But the problem stands. =A0You are based on a crummy location. =
=A0When are<br>
&gt; &gt; you going to pick up 3.13? =A0After 3.14 is out?<br>
&gt; &gt;<br>
&gt; &gt; Seems like Paul&#39;s move to include 3.13 made a lot of sense...=
<br>
&gt;<br>
&gt; This issue with the linux-security tree keeps coming up and I stand by=
 my<br>
&gt; earlier statements that I would much prefer if the linux-security is b=
ased off<br>
&gt; the latest kernel release, e.g. 3.13 as of today. =A0This seems to be =
in keeping<br>
&gt; with Linus&#39; comments, fits with what Eric was doing back when he m=
anaged the<br>
&gt; SELinux tree, and strikes a nice balance between stability and &quot;n=
ewness&quot;. =A0I<br>
&gt; plan on continuing with this approach for the SELinux tree.<br>
&gt;<br>
&gt; However, I don&#39;t want the 3.15 patches to get lost due to these st=
upid<br>
&gt; differences so I&#39;ve created a new branch that has the SELinux 3.15=
 patches<br>
&gt; applied on top of linux-security#next.<br>
&gt;<br>
&gt; =A0* git://<a href=3D"http://git.infradead.org/users/pcmoore/selinux" =
target=3D"_blank">git.infradead.org/users/pcmoore/selinux</a> next<br>
<br>
What&#39;s the new branch? =A0That seems to be the same.<br>
<br>
<br>
--<br>
James Morris<br>
&lt;<a href=3D"mailto:jmorris@namei.org">jmorris@namei.org</a>&gt;<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-securi=
ty-module&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</blockquote></div>

--047d7b33ca7c60ae4304f4de1e90--
