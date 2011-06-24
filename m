MIME-Version: 1.0
Date: Fri, 24 Jun 2011 08:04:28 -0400
Message-ID: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
Subject: Wrong context for user
From: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016368e2388ec31ce04a6740066
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016368e2388ec31ce04a6740066
Content-Type: text/plain; charset=ISO-8859-1

Hi All,


I have meego configured with SELinux refpolicy. I have enabled SELinux user
to linux user mapping, and though it shows correct selinux user and selinux
role,
the domain/type appears to be wrong.

For example, when I login linux user "meego", and say ps -Z, it shows me,

user_u:user_r:insmod_t          773   tty1   00:00:00 bash
user_u:user_r:insmod_t          795   tty1   00:00:00 ps

where I expect this has to be user_u:user_r:user_t, any pointers?


Regards,
Madhu

--0016368e2388ec31ce04a6740066
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,<div><br></div><div><br></div><div>I have meego configured with SELi=
nux refpolicy. I have enabled SELinux user to linux user mapping, and thoug=
h it shows correct selinux user and selinux role,=A0</div><div>the domain/t=
ype appears to be wrong.</div>
<div><br></div><div>For example, when I login linux user &quot;meego&quot;,=
 and say ps -Z, it shows me,</div><div><br></div><div>user_u:user_r:insmod_=
t =A0 =A0 =A0 =A0 =A0773 =A0 tty1 =A0 00:00:00 bash</div><div>user_u:user_r=
:insmod_t =A0 =A0 =A0 =A0 =A0795 =A0 tty1 =A0 00:00:00 ps</div>
<div><br></div><div>where I expect this has to be user_u:user_r:user_t, any=
 pointers?</div><div><br></div><div><br></div><div>Regards,</div><div>Madhu=
</div>

--0016368e2388ec31ce04a6740066--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
