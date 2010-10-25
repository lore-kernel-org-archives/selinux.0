Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9PCYEHb019879
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 08:34:17 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9PAAcw3028562
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 10:10:38 GMT
Received: by wyb40 with SMTP id 40so2501348wyb.12
        for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 03:10:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201010251039.58440.russell@coker.com.au>
References: <4CBE21ED.4050706@gmail.com>
	<4CC042CD.4000501@gmail.com>
	<AANLkTinSFCbxNP9Ps=0rMsgR5idqvdyJ1t_pVUVG5N00@mail.gmail.com>
	<201010251039.58440.russell@coker.com.au>
Date: Mon, 25 Oct 2010 15:10:31 +0500
Message-ID: <AANLkTikfs13Ck937X1VVsy3CB=4KMOYEKVDSFr+7GUy=@mail.gmail.com>
Subject: Re: [refpolicy] load_policy() with upstart on mint 9 fluxbox
From: Shaz <shazalive@gmail.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov, "Justin P. Mattock" <justinmattock@gmail.com>
Content-Type: multipart/alternative; boundary=e0cb4e3853dad28f7804936e3397
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e0cb4e3853dad28f7804936e3397
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Oct 25, 2010 at 4:39 AM, Russell Coker <russell@coker.com.au> wrote:

> On Fri, 22 Oct 2010, Shaz <shazalive@gmail.com> wrote:
> > Why do you expect Upstart or init to know if initrd was used or not? Is
> > this a feature that upstart should handle? I guess not because initrd is
> > used for early drivers and configuration before the rootfs can be
> utilized
> > properly.
>
> /sbin/init can easily determine whether policy was already loaded, whether
> an
> initrd/initramfs was used isn't the relevant issue.
>
> It's easy to load policy from /sbin/init, and as Systemd will have to have
> SE
> Linux support (it can't do any of it's advanced features without it) it
> wouldn't make sense to have anything other than /sbin/init load policy on a
> Systemd system.
>
>
Dear Russel,

I would like to have a look at the Debian init solution for SELinux. Can you
attach or link to a sample inittab and substitute for what is done at
initrd?

Thanks.

-- 
Shahbaz Khan
Assist. R&D Engineer

http://shazkhan.wordpress.com/
http://pk.linkedin.com/pub/shahbaz-khan/20/116/b49
http://imsciences.edu.pk/serg/
http://csrdu.org/
+92-91-332-9915828

--e0cb4e3853dad28f7804936e3397
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Oct 25, 2010 at 4:39 AM, Russell=
 Coker <span dir=3D"ltr">&lt;<a href=3D"mailto:russell@coker.com.au">russel=
l@coker.com.au</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204=
); padding-left: 1ex;">
<div class=3D"im">On Fri, 22 Oct 2010, Shaz &lt;<a href=3D"mailto:shazalive=
@gmail.com">shazalive@gmail.com</a>&gt; wrote:<br>
&gt; Why do you expect Upstart or init to know if initrd was used or not? I=
s<br>
&gt; this a feature that upstart should handle? I guess not because initrd =
is<br>
&gt; used for early drivers and configuration before the rootfs can be util=
ized<br>
&gt; properly.<br>
<br>
</div>/sbin/init can easily determine whether policy was already loaded, wh=
ether an<br>
initrd/initramfs was used isn&#39;t the relevant issue.<br>
<br>
It&#39;s easy to load policy from /sbin/init, and as Systemd will have to h=
ave SE<br>
Linux support (it can&#39;t do any of it&#39;s advanced features without it=
) it<br>
wouldn&#39;t make sense to have anything other than /sbin/init load policy =
on a<br>
Systemd system.<br>
<font color=3D"#888888"><br></font></blockquote><div><br>Dear Russel,<br><b=
r>I would like to have a look at the Debian init solution for SELinux. Can =
you attach or link to a sample inittab and substitute for what is done at i=
nitrd?<br>
<br>Thanks.<br><br></div></div>-- <br>Shahbaz Khan<br>Assist. R&amp;D Engin=
eer<br><br><a href=3D"http://shazkhan.wordpress.com/" target=3D"_blank">htt=
p://shazkhan.wordpress.com/</a><br><a href=3D"http://pk.linkedin.com/pub/sh=
ahbaz-khan/20/116/b49" target=3D"_blank">http://pk.linkedin.com/pub/shahbaz=
-khan/20/116/b49</a><br>
<a href=3D"http://imsciences.edu.pk/serg/" target=3D"_blank">http://imscien=
ces.edu.pk/serg/</a><br><a href=3D"http://csrdu.org/" target=3D"_blank">htt=
p://csrdu.org/</a><br>+92-91-332-9915828<br><br>

--e0cb4e3853dad28f7804936e3397--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
