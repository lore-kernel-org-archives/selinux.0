MIME-Version: 1.0
In-Reply-To: <200903162137.29582.russell@coker.com.au>
References: <19716145.1610101236870456814.JavaMail.coremail@bj126app71.126.com>
	 <200903150424.13140.russell@coker.com.au>
	 <7b740b700903152334g70c7f421y88e9e0a7852cfb23@mail.gmail.com>
	 <200903162137.29582.russell@coker.com.au>
Date: Mon, 16 Mar 2009 16:22:29 +0500
Message-ID: <7b740b700903160422p7ad171dekf8d0ea9b5e5f76f3@mail.gmail.com>
Subject: Re: questions
From: Shaz <shazalive@gmail.com>
To: russell@coker.com.au
Cc: SELinux@tycho.nsa.gov,
        Security Engineering Archive <groupsecurityengineering@gmail.com>
Content-Type: multipart/alternative; boundary=000e0cd2bd0082465b04653aaaa8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd2bd0082465b04653aaaa8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Mar 16, 2009 at 3:37 PM, Russell Coker <russell@coker.com.au> wrote:

> On Mon, 16 Mar 2009, Shaz <shazalive@gmail.com> wrote:
> > I have been trying some of the SELinux packages from the repos but can't
> > even enable it on boot! I wanted to have multiple platform experience
> > although I am pretty easy with FC8. Next I will try Gentoo.
>
> Which distributions did you try?


Just FC6 and FC8. Then went embedded with Debian derivatives. The
dependencies are a bit difficult to handle when working on different layers
of the software stack with different requirements. I am working on busybox
at the moment to get things started. I am using Willis' GSoC work and taking
ahead. It has policy19 while I am interested in policy21. Will that be a
problem?


>
>
> Debian/Lenny should work well if you follow my instructions:
> http://doc.coker.com.au/computers/installing-se-linux-on-lenny/


I studied some of your initial work for Debian and I am just going to read
the above and update accordingly. The earlier work was helpful to understand
all the things put together ... integration. Has anyone tried the IBM
SELinux from scratch tutorial. I assigned an internee to check it. Will it
be useful?

I am arranging a team who will maintain documentation and code for Debian
derivatives for ARMel. That should help the rest of us :)


>
>
> > I am also working on getting SELinux enabled in some of our mobile
> devices
> > so if there is any useful public domain work then please indicate it.
>
> In the past I did some work on getting it running on Familiar on the iPaQ
> platform (ARM).  But when SE Linux migrated to XATTRs that was broken
> because
> JFFS2 didn't have XATTR support.  Recently XATTR support has been written,
> so
> it should be possible to get it going.


The userspace support gives me problem because of the dependencies but it
should be getting fine in a few days. If the userspace had been
autoconficated then things would have been easy. Sometime ago someone at
some place identified autotools support for this purpose. I was looking for
it to try it. Has anyone tried it? The principal who submitted it was not
very friendly and at that time I was busy with learning policy models and
how they are being converged with SELinux infra.


>
>
> --
> russell@coker.com.au
> http://etbe.coker.com.au/          My Main Blog
> http://doc.coker.com.au/           My Documents Blog
>



-- 
Shaz

--000e0cd2bd0082465b04653aaaa8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Mon, Mar 16, 2009 at 3:37 PM, Russell Cok=
er <span dir=3D"ltr">&lt;<a href=3D"mailto:russell@coker.com.au">russell@co=
ker.com.au</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
<div class=3D"im">On Mon, 16 Mar 2009, Shaz &lt;<a href=3D"mailto:shazalive=
@gmail.com">shazalive@gmail.com</a>&gt; wrote:<br>
&gt; I have been trying some of the SELinux packages from the repos but can=
&#39;t<br>
&gt; even enable it on boot! I wanted to have multiple platform experience<=
br>
&gt; although I am pretty easy with FC8. Next I will try Gentoo.<br>
<br>
</div>Which distributions did you try?</blockquote><div><br>Just FC6 and FC=
8. Then went embedded with Debian derivatives. The dependencies are a bit d=
ifficult to handle when working on different layers of the software stack w=
ith different requirements. I am working on busybox at the moment to get th=
ings started. I am using Willis&#39; GSoC work and taking ahead. It has pol=
icy19 while I am interested in policy21. Will that be a problem?<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Debian/Lenny should work well if you follow my instructions:<br>
<a href=3D"http://doc.coker.com.au/computers/installing-se-linux-on-lenny/"=
 target=3D"_blank">http://doc.coker.com.au/computers/installing-se-linux-on=
-lenny/</a></blockquote><div><br>I studied some of your initial work for De=
bian and I am just going to read the above and update accordingly. The earl=
ier work was helpful to understand all the things put together ... integrat=
ion. Has anyone tried the IBM SELinux from scratch tutorial. I assigned an =
internee to check it. Will it be useful?<br>
<br>I am arranging a team who will maintain documentation and code for Debi=
an derivatives for ARMel. That should help the rest of us :)<br>=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<div class=3D"im"><br>
&gt; I am also working on getting SELinux enabled in some of our mobile dev=
ices<br>
&gt; so if there is any useful public domain work then please indicate it.<=
br>
<br>
</div>In the past I did some work on getting it running on Familiar on the =
iPaQ<br>
platform (ARM). =A0But when SE Linux migrated to XATTRs that was broken bec=
ause<br>
JFFS2 didn&#39;t have XATTR support. =A0Recently XATTR support has been wri=
tten, so<br>
it should be possible to get it going.</blockquote><div><br>The userspace s=
upport gives me problem because of the dependencies but it should be gettin=
g fine in a few days. If the userspace had been autoconficated then things =
would have been easy. Sometime ago someone at some place identified autotoo=
ls support for this purpose. I was looking for it to try it. Has anyone tri=
ed it? The principal who submitted it was not very friendly and at that tim=
e I was busy with learning policy models and how they are being converged w=
ith SELinux infra.<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<font color=3D"#888888"><br>
--<br>
</font><div><div></div><div class=3D"h5"><a href=3D"mailto:russell@coker.co=
m.au">russell@coker.com.au</a><br>
<a href=3D"http://etbe.coker.com.au/" target=3D"_blank">http://etbe.coker.c=
om.au/</a> =A0 =A0 =A0 =A0 =A0My Main Blog<br>
<a href=3D"http://doc.coker.com.au/" target=3D"_blank">http://doc.coker.com=
.au/</a> =A0 =A0 =A0 =A0 =A0 My Documents Blog<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Shaz<br><br=
>

--000e0cd2bd0082465b04653aaaa8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
