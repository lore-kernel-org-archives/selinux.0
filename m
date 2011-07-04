Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p64G7VoT002714
	for <selinux@tycho.nsa.gov>; Mon, 4 Jul 2011 12:07:31 -0400
Received: from a.mx.secunet.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p64G7UKr013146
	for <selinux@tycho.nsa.gov>; Mon, 4 Jul 2011 16:07:30 GMT
Received: from localhost (alg1 [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2871B1A007A
	for <selinux@tycho.nsa.gov>; Mon,  4 Jul 2011 18:04:25 +0200 (CEST)
Received: from mail-srv1.secumail.de (unknown [10.53.40.200])
	by a.mx.secunet.com (Postfix) with ESMTP id E6C731A005D
	for <selinux@tycho.nsa.gov>; Mon,  4 Jul 2011 18:04:19 +0200 (CEST)
Message-ID: <4E11E53A.6080003@secunet.com>
Date: Mon, 04 Jul 2011 18:07:22 +0200
From: Martin Christian <martin.christian@secunet.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Sec context of unix domain sockets
Content-Type: text/plain; charset=ISO-8859-15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

how are unix domain sockets handeled regarding the default context?
Please comment on the following statement or fill my gaps:

a. Processes inherit the label of their parent, except for the init
process which gets the label of the kernel sid

b. Ext{2-4} files/directories get the label of their parent directory.
Root (/) gets its label from the file system context (fs_use) on creation.

c. Inet sockets get the label specified with the portcon statement or
the context of kernel sid (?)

d. Unix domain sockets are split in 2 parts: the socket file is treated
as b. The socket object gets the label of the kernel sid (?) Is there a
way to define the context of a unix domain socket object? The only way I
can see would be to define a transition.

Explanations and clarification much appreciated.

Martin.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOEeU0AAoJEGpTkDITRjmo14EIAJstcDIklJK8ZSRz+4nGqd+s
VWtrbzE71RXuSnWJZZo77Hx2Fs4jqh5dEKED6gJdiVE/5yQb5VskQ+b6wFHj9q87
IKihqGioZiP1rLDer5Wyhv/ZgJ7uhJab5j6xNlRgSy8JphQVyG+7piJIkbX2ui3q
TSC8vh55WQe2jqvtznXbWlbxDv924t+rJC3suNCIn5dvTFv2zfmMwTRfzp7ItZYM
93h3ZWlq2faYPhHE3eP68VmLUINzW20hRhIl2J4aIqzewa3x27zPg+0yJ1T6ghrV
E2NgH+eH5LyFZ6ddqMGlnu18VGuGfsSwMMCz7/ideiEJpYCXZNGDsaE7X9e5U/Y=
=wEgh
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
