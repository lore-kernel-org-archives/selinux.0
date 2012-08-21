Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7LDr7Cs024077
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2012 09:53:07 -0400
Received: by wgbez12 with SMTP id ez12so5300490wgb.30
        for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2012 06:53:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADQgGG22RppyavV=Mi5ZC99v7pzdpYK-YmdfALPxqXeH08FnXg@mail.gmail.com>
References: <CAN93Rk+MnaUMaG_2r-S11TWpsOuDjomCjmZtJ7jiVQ6agLrkEg@mail.gmail.com>
 <CADQgGG2_xbPNy-HYjeD6jSf9+3_3Arfhv6FiRBPAT+jVLDzXVA@mail.gmail.com> <CADQgGG22RppyavV=Mi5ZC99v7pzdpYK-YmdfALPxqXeH08FnXg@mail.gmail.com>
From: Cesar Maiorino <cesar.maiorino@gmail.com>
Date: Tue, 21 Aug 2012 09:52:24 -0400
Message-ID: <CAN93Rk+5OSUiG7KJ-GhLcxNddepN+uYwpn+iXjYDbr9dnW2kQg@mail.gmail.com>
Subject: Re: Porting seandroid to qualcomm MSM8960
To: Robert Craig <robertpcraig@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d043c8188fea91604c7c6f146
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d043c8188fea91604c7c6f146
Content-Type: text/plain; charset=ISO-8859-1

I am targeting kernel version 3.0.8, so I guess I will start with one of
the 3.0 kernels.
Thanks for the detailed reply. It's a big help

On Mon, Aug 20, 2012 at 10:25 PM, Robert Craig <robertpcraig@gmail.com>wrote:
>
>> What version of the kernel would you be targeting?  The emulator kernel
>> is 2.6.29 and the omap and samsung kernels are 3.0 kernels. You'll need to
>> enable the right options in the kernel config file and apply the right set
>> of patches. However, the set of patches can vary slightly depending on your
>> targeted version. Your best bet is to pick one of the supplied seandroid
>> kernels that matches your kernel version and mimic what was done.  I would
>> try to git format-patch the seandroid specific commits and see if they
>> apply cleanly to your kernel.  You can see this set of commits by running:
>>
>> git log --author=Smalley
>>
>> I would stick to the more recent ones though as Steve Smalley has a long
>> history of commits to the linux kernel.  From here I would pick out each
>> commit with:
>>
>> git format-patch -1 <sha1>
>>
>> then apply them to your tree with
>>
>> git am <patch>
>>
>>
>>
>>
>>
>
>

--f46d043c8188fea91604c7c6f146
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am targeting kernel version 3.0.8, so I guess I will start with one of th=
e 3.0 kernels.<br>Thanks for the detailed reply. It&#39;s a big help<br><br=
><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_quote">On Mon, =
Aug 20, 2012 at 10:25 PM, Robert Craig <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:robertpcraig@gmail.com" target=3D"_blank">robertpcraig@gmail.com</a>&gt=
;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
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
</div></div></blockquote></div><br>

--f46d043c8188fea91604c7c6f146--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
