Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA25114
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 10:44:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA13121
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 15:44:21 GMT
Received: from csoc-mail-msfc.csoconline.com (csoc-mail-msfc.csoconline.com [140.169.36.3])
	by jazzband.ncsc.mil  with ESMTP id PAA13117
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 15:44:21 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015240A2@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: compute sid
Date: Wed, 21 Feb 2001 09:44:12 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

To Selinux List

I am at a lost of how to fix this.

                  kernel: security_compute_sid:
                 invalid context system_u:system_r:user_t for
                 scontext=system_u:system_r:gdm_t
                 tcontext=system_u:object_r:shell_exec_t tclass=process
Mark Westerman
mark.westerman@csoconline.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
