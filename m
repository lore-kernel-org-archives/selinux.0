Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6JJp96Q011382
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2011 15:51:09 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6JJp7r3012869
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2011 19:51:08 GMT
Received: from [192.168.2.2] (151.46.146.238) by cp-out8.libero.it (8.5.133)
        id 4DD241540920ECB6 for selinux@tycho.nsa.gov; Tue, 19 Jul 2011 21:51:06 +0200
Subject: [PATCH] Further clarification of the usage of run_init in the
 manual page
From: Guido Trentalancia <guido@trentalancia.com>
To: selinux@tycho.nsa.gov
Date: Tue, 19 Jul 2011 21:51:06 +0200
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1311105066.2550.21.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It's a very minor thing really, but I believe (on the basis of an
off-list question) that the manual page for policycoreutils/run_init can
be improved by the following short patch which aims to further clarify
the intended usage of such tool and mention that it caters for one
(somewhat hidden) compile-time option.

diff -pruN selinux-09062011/policycoreutils/run_init/run_init.8 selinux-09062011-run_init-auth-manpage/policycoreutils/run_init/run_init.8
--- selinux-09062011/policycoreutils/run_init/run_init.8        2011-05-09 01:04:17.075842476 +0200
+++ selinux-09062011-run_init-auth-manpage/policycoreutils/run_init/run_init.8  2011-06-09 23:06:53.350242852 +0200
@@ -9,6 +9,8 @@ run_init \- run an init script in the pr
 .PP
 Run a init script under the proper context, which is specified in
 /etc/selinux/POLICYTYPE/contexts/initrc_context.
+It is generally used interactively as it requires either shadow or
+PAM user authentication (depending on compile-time options).
 .SH FILES
 /etc/passwd - user account information
 .br



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
