Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2GCF1FR001530
	for <selinux@tycho.nsa.gov>; Sat, 16 Mar 2013 08:15:01 -0400
Received: by mail-wi0-f175.google.com with SMTP id l13so1291611wie.2
        for <selinux@tycho.nsa.gov>; Sat, 16 Mar 2013 05:14:53 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 16 Mar 2013 13:06:47 +0100
Message-ID: <CAOFt0CRpFTOD8S2iktjUdLDPVOhG9Cvq9j51sqxDsQLVno=irQ@mail.gmail.com>
Subject: Compiling Selinux from Source
From: Kernel freak <kernelfreak@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d043be13009fdf404d809971d
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d043be13009fdf404d809971d
Content-Type: text/plain; charset=ISO-8859-1

Hello,
         I want to make some modifications to SElinux itself for some of my
work. I am currently using Fedora v18 with KDE. I downloaded the Linux
kernel, and also the reference policy source. Both seem to give me an
error. The errors are
While compiling the policy '@localhost serefpolicy-3.11.1]$ sudo make conf
make: *** No rule to make target `policy/modules/contrib/metadata.xml',
needed by `tmp/admin.xml'.  Stop.'

While compiling Selinux  from Linux kernel 3.7.10
'@localhost selinux]$ make
make: *** No rule to make target `/include/classmap.h', needed by
`/flask.h'.  Stop.'

I fail to understand what am i missing here. I checked the contrib
directory, it turns out to be empty. Also, i downloaded the serefpolicy
using yum-utils. Kindly let me know or some links. Thank you for your time.

--f46d043be13009fdf404d809971d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br>=A0=A0=A0=A0=A0=A0=A0=A0 I want to make some modifications to SEl=
inux itself for some of my work. I am currently using Fedora v18 with KDE. =
I downloaded the Linux kernel, and also the reference policy source. Both s=
eem to give me an error. The errors are<br>
While compiling the policy &#39;@localhost serefpolicy-3.11.1]$ sudo make c=
onf<br>make: *** No rule to make target `policy/modules/contrib/metadata.xm=
l&#39;, needed by `tmp/admin.xml&#39;.=A0 Stop.&#39;<br><br>While compiling=
 Selinux=A0 from Linux kernel 3.7.10<br>
&#39;@localhost selinux]$ make<br>make: *** No rule to make target `/includ=
e/classmap.h&#39;, needed by `/flask.h&#39;.=A0 Stop.&#39;<br><br>I fail to=
 understand what am i missing here. I checked the contrib directory, it tur=
ns out to be empty. Also, i downloaded the serefpolicy using yum-utils. Kin=
dly let me know or some links. Thank you for your time.<br>

--f46d043be13009fdf404d809971d--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
