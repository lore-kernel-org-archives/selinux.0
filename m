Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7L2PhxY020350
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2012 22:25:43 -0400
Received: by wibhm2 with SMTP id hm2so3548571wib.0
        for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2012 19:25:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADQgGG2_xbPNy-HYjeD6jSf9+3_3Arfhv6FiRBPAT+jVLDzXVA@mail.gmail.com>
References: <CAN93Rk+MnaUMaG_2r-S11TWpsOuDjomCjmZtJ7jiVQ6agLrkEg@mail.gmail.com>
	<CADQgGG2_xbPNy-HYjeD6jSf9+3_3Arfhv6FiRBPAT+jVLDzXVA@mail.gmail.com>
Date: Mon, 20 Aug 2012 22:25:40 -0400
Message-ID: <CADQgGG22RppyavV=Mi5ZC99v7pzdpYK-YmdfALPxqXeH08FnXg@mail.gmail.com>
Subject: Re: Porting seandroid to qualcomm MSM8960
From: Robert Craig <robertpcraig@gmail.com>
To: Cesar Maiorino <cesar.maiorino@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf30207fc4a80d9e04c7bd571d
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf30207fc4a80d9e04c7bd571d
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Aug 20, 2012 at 10:25 PM, Robert Craig <robertpcraig@gmail.com>wrote:

> What version of the kernel would you be targeting?  The emulator kernel is
> 2.6.29 and the omap and samsung kernels are 3.0 kernels. You'll need to
> enable the right options in the kernel config file and apply the right set
> of patches. However, the set of patches can vary slightly depending on your
> targeted version. Your best bet is to pick one of the supplied seandroid
> kernels that matches your kernel version and mimic what was done.  I would
> try to git format-patch the seandroid specific commits and see if they
> apply cleanly to your kernel.  You can see this set of commits by running:
>
> git log --author=Smalley
>
> I would stick to the more recent ones though as Steve Smalley has a long
> history of commits to the linux kernel.  From here I would pick out each
> commit with:
>
> git format-patch -1 <sha1>
>
> then apply them to your tree with
>
> git am <patch>
>
>
>
>
>

--20cf30207fc4a80d9e04c7bd571d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Aug 20, 2012 at 10:25 PM, Robert=
 Craig <span dir=3D"ltr">&lt;<a href=3D"mailto:robertpcraig@gmail.com" targ=
et=3D"_blank">robertpcraig@gmail.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
What version of the kernel would you be targeting? =A0The emulator kernel i=
s 2.6.29 and the omap and samsung kernels are 3.0 kernels. You&#39;ll need =
to enable the right options in the kernel config file and apply the right s=
et of patches. However, the set of patches can vary slightly depending on y=
our targeted version. Your best bet is to pick one of the supplied seandroi=
d kernels that matches your kernel version and mimic what was done. =A0I wo=
uld try to git format-patch the seandroid specific commits and see if they =
apply cleanly to your kernel. =A0You can see this set of commits by running=
:<div>

<div><br></div><div>git log --author=3DSmalley</div><div><br></div><div>I w=
ould stick to the more recent ones though as Steve Smalley has a long histo=
ry of commits to the linux kernel. =A0From here I would pick out each commi=
t with:</div>

<div><br></div><div>git format-patch -1 &lt;sha1&gt;</div><div><br></div><d=
iv>then apply them to your tree with</div><div><br></div><div>git am &lt;pa=
tch&gt;</div><div><br></div><div><br></div><div><br></div><div><div><div>

<div>=A0</div></div></div></div></div>
</blockquote></div><br>

--20cf30207fc4a80d9e04c7bd571d--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
