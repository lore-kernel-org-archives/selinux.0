Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00075
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 11:39:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA07359
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 15:37:52 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id PAA07355 for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 15:37:51 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524373@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: insmod
Date: Mon, 29 Apr 2002 10:39:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have made an ipsec as a module to the selinux kernel.
I am having to adjust the rules. I do have a question.


The ipsec needs to write to the sysctl_t

I conservative about overwriting some of the assertions.

neverallow ~{initrc_t admin} sysctl_t:file { write append };

I would have to add insmod_t

neverallow ~{insmod_t initrc_t admin} sysctl_t:file { write append };

Comment or suggestions about another way of doing this.


Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
