Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q561YRGE024194
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2012 21:34:27 -0400
Received: by lbbgk8 with SMTP id gk8so4902711lbb.12
        for <selinux@tycho.nsa.gov>; Tue, 05 Jun 2012 18:34:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ff7c28e8f022fc5bd217bb5ed7321fa6@countercultured.net>
References: <CAO-AVB7hN1sODoEyE3pXv0mz0SN1KagdNFcHrb1Tt24DC+_dDA@mail.gmail.com>
	<ff7c28e8f022fc5bd217bb5ed7321fa6@countercultured.net>
Date: Wed, 6 Jun 2012 09:34:25 +0800
Message-ID: <CAO-AVB4D4=LLMqaifLqOE8v6APndkMkkHwspx4+kazcs3Fo=ow@mail.gmail.com>
Subject: Re: "operation not support" when execute #restorecon -R /
From: casinee app <appcasinee@gmail.com>
To: David Quigley <selinux@davequigley.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=e89a8f22c72b6fd91704c1c3c425
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8f22c72b6fd91704c1c3c425
Content-Type: text/plain; charset=ISO-8859-1

the NFS. I had applied a patch to the kernel to support the xattr of NFS
filesystem.

2012/6/5 David Quigley <selinux@davequigley.com>

> On 06/05/2012 02:51, casinee app wrote:
>
>> Hi,
>> when i execute #restorecon -R / , all the output is "... operation
>> not support".  I had check the source code, and in
>> linux/security/selinux/hooks.c :
>>
>>          ...
>>  sbsec = inode->i_sb->s_security;
>>  if (!(sbsec->flags & SE_SBLABELSUPP))
>>  {
>>  return -EOPNOTSUPP;
>>  }
>>         ...
>> it returned. The  SE_SBLABELSUPP defined as 0x40, i want to know how
>> can i do to make the filesystem to support the SecurityContext of
>> selinux.
>> Thanks.
>>
>
> Which filesystem is this?
>
> Dave
>
>

--e89a8f22c72b6fd91704c1c3c425
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

the NFS. I had=A0applied a patch to the kernel to support the xattr of NFS =
filesystem.<br><br><div class=3D"gmail_quote">2012/6/5 David Quigley <span =
dir=3D"ltr">&lt;<a href=3D"mailto:selinux@davequigley.com" target=3D"_blank=
">selinux@davequigley.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 0=
6/05/2012 02:51, casinee app wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
when i execute #restorecon -R / , all the output is &quot;... operation<br>
not support&quot;. =A0I had check the source code, and in<br>
linux/security/selinux/hooks.c :<br>
<br>
=A0 =A0 =A0 =A0 =A0...<br>
=A0sbsec =3D inode-&gt;i_sb-&gt;s_security;<br>
=A0if (!(sbsec-&gt;flags &amp; SE_SBLABELSUPP))<br>
=A0{<br>
=A0return -EOPNOTSUPP;<br>
=A0}<br>
=A0 =A0 =A0 =A0 ...<br>
it returned. The=A0=A0SE_SBLABELSUPP defined as 0x40, i want to know how<br=
>
can i do to make the filesystem to support the SecurityContext of<br>
selinux.=A0<br>
Thanks.<br>
</blockquote>
<br></div></div>
Which filesystem is this?<br>
<br>
Dave<br>
<br>
</blockquote></div><br>

--e89a8f22c72b6fd91704c1c3c425--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
