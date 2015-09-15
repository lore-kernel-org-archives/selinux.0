Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8FBuKrP016221
 for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2015 07:56:21 -0400
Received: by wicfx3 with SMTP id fx3so23668880wic.0
 for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2015 04:56:17 -0700 (PDT)
MIME-Version: 1.0
From: Divya Vyas <dvyas@mvista.com>
Date: Tue, 15 Sep 2015 17:25:58 +0530
Message-ID: <CA+=dQ-_wPGkCzK9EC0tdUbm+CTf2mLo9TY94fVaoJ5hCLR1gKw@mail.gmail.com>
Subject: Policy disable error
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c1b96aa1051b051fc7dee7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c1b96aa1051b051fc7dee7
Content-Type: text/plain; charset=UTF-8

Hi,

I am getting below error while disabling the apache module policy

semodule -d apache
libsepol.context_from_record: type httpd_sys_content_t is not defined (No
such file or directory).
libsepol.context_from_record: could not create context structure (Invalid
argument).
libsemanage.validate_handler: invalid context
system_u:object_r:httpd_sys_content_t:s0 specified for htdocs/ [all files]
(Invalid argument).
libsemanage.dbase_llist_iterate: could not iterate over records (Invalid
argument).
semodule:  Failed!

--001a11c1b96aa1051b051fc7dee7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I am getting below error while disabling the ap=
ache module policy <br><br>semodule -d apache<br>libsepol.context_from_reco=
rd: type httpd_sys_content_t is not defined (No such file or directory).<br=
>libsepol.context_from_record: could not create context structure (Invalid =
argument).<br>libsemanage.validate_handler: invalid context system_u:object=
_r:httpd_sys_content_t:s0 specified for htdocs/ [all files] (Invalid argume=
nt).<br>libsemanage.dbase_llist_iterate: could not iterate over records (In=
valid argument).<br>semodule:=C2=A0 Failed!<br><br></div>

--001a11c1b96aa1051b051fc7dee7--
