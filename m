Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9PCgheg025664
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 08:42:55 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o9PCg8Qx029589
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 12:42:09 GMT
Received: by wyb40 with SMTP id 40so2638625wyb.12
        for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 05:42:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201010252316.03872.russell@coker.com.au>
References: <4CBE21ED.4050706@gmail.com>
	<201010251039.58440.russell@coker.com.au>
	<AANLkTikfs13Ck937X1VVsy3CB=4KMOYEKVDSFr+7GUy=@mail.gmail.com>
	<201010252316.03872.russell@coker.com.au>
Date: Mon, 25 Oct 2010 17:42:07 +0500
Message-ID: <AANLkTi=Bnvn+VbaP-OEYrXMFQ2WtRaGBy-eq6fCUBf9T@mail.gmail.com>
Subject: Re: [refpolicy] load_policy() with upstart on mint 9 fluxbox
From: Shaz <shazalive@gmail.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov, "Justin P. Mattock" <justinmattock@gmail.com>
Content-Type: multipart/alternative; boundary=0016367fb867fd479604937051c2
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016367fb867fd479604937051c2
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Oct 25, 2010 at 5:16 PM, Russell Coker <russell@coker.com.au> wrote:

> On Mon, 25 Oct 2010, Shaz <shazalive@gmail.com> wrote:
> > I would like to have a look at the Debian init solution for SELinux. Can
> > you attach or link to a sample inittab and substitute for what is done at
> > initrd?
>
> In Debian sysvinit loads the policy, as everyone has done with sysvinit for
> 5+
> years.  Upstart didn't, but I believe that there has been progress towards
> getting it to do so too.  There are quite a few Debian users who don't use
> an
> initrd and we want to support them.
>

By init I meant including the sysvinit scripts. I might not be very accurate
with terminology here but what I actually wanted to analyze was the behavior
of how init is relabeled after selinux is initialized. And the rest of the
process is straight forward.

Thanks.


>
> There was never a need to change inittab.
>
> --
> russell@coker.com.au
> http://etbe.coker.com.au/          My Main Blog
> http://doc.coker.com.au/           My Documents Blog
>



-- 
Shahbaz Khan
Assist. R&D Engineer

http://shazkhan.wordpress.com/
http://pk.linkedin.com/pub/shahbaz-khan/20/116/b49
http://imsciences.edu.pk/serg/
http://csrdu.org/
+92-91-332-9915828

--0016367fb867fd479604937051c2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Oct 25, 2010 at 5:16 PM, Russell=
 Coker <span dir=3D"ltr">&lt;<a href=3D"mailto:russell@coker.com.au">russel=
l@coker.com.au</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204=
); padding-left: 1ex;">
<div class=3D"im">On Mon, 25 Oct 2010, Shaz &lt;<a href=3D"mailto:shazalive=
@gmail.com">shazalive@gmail.com</a>&gt; wrote:<br>
&gt; I would like to have a look at the Debian init solution for SELinux. C=
an<br>
&gt; you attach or link to a sample inittab and substitute for what is done=
 at<br>
&gt; initrd?<br>
<br>
</div>In Debian sysvinit loads the policy, as everyone has done with sysvin=
it for 5+<br>
years. =A0Upstart didn&#39;t, but I believe that there has been progress to=
wards<br>
getting it to do so too. =A0There are quite a few Debian users who don&#39;=
t use an<br>
initrd and we want to support them.<br></blockquote><div><br>By init I mean=
t including the sysvinit scripts. I might not be very accurate with termino=
logy here but what I actually wanted to analyze was the behavior of how ini=
t is relabeled after selinux is initialized. And the rest of the process is=
 straight forward.<br>
<br>Thanks.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: =
0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left:=
 1ex;">
<br>
There was never a need to change inittab.<br>
<div><div></div><div class=3D"h5"><br>
--<br>
<a href=3D"mailto:russell@coker.com.au">russell@coker.com.au</a><br>
<a href=3D"http://etbe.coker.com.au/" target=3D"_blank">http://etbe.coker.c=
om.au/</a> =A0 =A0 =A0 =A0 =A0My Main Blog<br>
<a href=3D"http://doc.coker.com.au/" target=3D"_blank">http://doc.coker.com=
.au/</a> =A0 =A0 =A0 =A0 =A0 My Documents Blog<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Shahbaz Kha=
n<br>Assist. R&amp;D Engineer<br><br><a href=3D"http://shazkhan.wordpress.c=
om/" target=3D"_blank">http://shazkhan.wordpress.com/</a><br><a href=3D"htt=
p://pk.linkedin.com/pub/shahbaz-khan/20/116/b49" target=3D"_blank">http://p=
k.linkedin.com/pub/shahbaz-khan/20/116/b49</a><br>
<a href=3D"http://imsciences.edu.pk/serg/" target=3D"_blank">http://imscien=
ces.edu.pk/serg/</a><br><a href=3D"http://csrdu.org/" target=3D"_blank">htt=
p://csrdu.org/</a><br>+92-91-332-9915828<br><br>

--0016367fb867fd479604937051c2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
