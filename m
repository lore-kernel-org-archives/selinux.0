Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q556pC7K001441
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2012 02:51:12 -0400
Received: by lbbgk8 with SMTP id gk8so4094425lbb.12
        for <selinux@tycho.nsa.gov>; Mon, 04 Jun 2012 23:51:06 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 5 Jun 2012 14:51:06 +0800
Message-ID: <CAO-AVB7hN1sODoEyE3pXv0mz0SN1KagdNFcHrb1Tt24DC+_dDA@mail.gmail.com>
Subject: "operation not support" when execute #restorecon -R /
From: casinee app <appcasinee@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=f46d040169632a387604c1b413df
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d040169632a387604c1b413df
Content-Type: text/plain; charset=ISO-8859-1

Hi,
when i execute #restorecon -R / , all the output is "... operation not
support".  I had check the source code, and in
linux/security/selinux/hooks.c :
         ...
sbsec = inode->i_sb->s_security;
if (!(sbsec->flags & SE_SBLABELSUPP))
{
return -EOPNOTSUPP;
}
        ...
it returned. The  SE_SBLABELSUPP defined as 0x40, i want to know how can i
do to make the filesystem to support the SecurityContext of selinux.
Thanks.

--f46d040169632a387604c1b413df
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font color=3D"#222222" face=3D"arial, sans-serif"><span style=3D"font-size=
:14px;white-space:nowrap"><span class=3D"Apple-style-span" style>Hi,<div>wh=
en i execute #restorecon -R / , all the output is &quot;... operation not s=
upport&quot;. =A0I had check the source code, and in linux/security/selinux=
/hooks.c :</div>
<div><div>=A0 =A0 =A0 =A0 =A0...</div><div><span style=3D"white-space:pre-w=
rap">	</span>sbsec =3D inode-&gt;i_sb-&gt;s_security;</div><div><span style=
=3D"white-space:pre-wrap">	</span>if (!(sbsec-&gt;flags &amp; SE_SBLABELSUP=
P))</div><div>
<span style=3D"white-space:pre-wrap">	</span>{</div><div><span style=3D"whi=
te-space:pre-wrap">		</span>return -EOPNOTSUPP;</div><div><span style=3D"wh=
ite-space:pre-wrap">	</span>}</div></div><div>=A0 =A0 =A0 =A0 ...</div><div=
>it returned. The=A0=A0SE_SBLABELSUPP defined as 0x40, i want to know how c=
an i do to make the filesystem to support the SecurityContext of selinux.=
=A0</div>
<div>Thanks.</div></span></span></font>

--f46d040169632a387604c1b413df--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
