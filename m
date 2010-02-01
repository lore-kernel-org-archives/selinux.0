Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o11D3XlU011574
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 08:03:33 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o11D3YaI017892
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 13:03:35 GMT
Message-Id: <201002011303.o11D3TQR030787@vivaldi36.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Refpolicy Mailing List <refpolicy@oss1.tresys.com>
Subject: Allowing MLS->non-MLS and vice versa upon policy reload
Date: Mon, 01 Feb 2010 14:03:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello !

When switching at runtime from the standard reference policy and the MLS/MCS reference policy (2.20091117), the ssh server on a Debian Lenny system does not accept new connections until it is restarted.

The following denials are generated:

type=1400 audit(1265028026.079:19): avc:  denied  { transition } for  pid=8973 comm="sshd" path="/bin/bash" dev=dm-1 ino=146597 scontext=system_u:system_r:sshd_t:s0 tcontext=root:staff_r:staff_t:s0-s0:c0.c1023 tclass=process

Unfortunately, simply adding a custom module such as the following:

require {
        type staff_t;
        type sshd_t;
        class process transition;
}

#============= sshd_t ==============
allow sshd_t staff_t:process transition;

does not help.

I believe the problem arises as soon as the ssh server opens a shell for the user as I get "/bin/bash: Permission denied" after the initial /etc/motd banner (and the connection is dropped at that point).

Does anybody have an idea on how to sort out this issue ?

I believe the server is OpenSSH version 5.1p1, while bash is version 3.2.39(1). I have not had time to test other distributions.

Kind regards,

Guido Trentalancia 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
