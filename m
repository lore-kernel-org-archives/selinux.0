Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA27681
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 12:17:07 -0400 (EDT)
From: jbyrd@vspacegroup.com
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA25436
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 16:15:29 GMT
Received: from sprout.phpwebhosting.com ([216.218.184.226])
        by jazzband.ncsc.mil  with SMTP id QAA25432 for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 16:15:28 GMT
Message-ID: <00c901c24540$5c1a5bd0$0100a8c0@vspaceprs2>
To: <selinux@tycho.nsa.gov>
Subject: Re: Needing some direction
Date: Fri, 16 Aug 2002 12:15:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ok ... failure again

Most non-essential modules marked for exclusion, Telephony and MLS removed
(along with all experimental options as well)

here are a few lines of errors right before a total make error and exit
(there are literally many screens of others)

services.o:  In function 'context_struct_compute_av'
/selinux/selinux/module/checkpolicy/ ../ ../
../lsm-2.4/security/selinux/selinux/ss/services.c:174: undefined reference
to 'mls_compute_av'
services.o:  In function 'context_struct_to_string':
/selinux/selinux/module/checkpolicy/ ../ ../
../lsm-2.4/security/selinux/selinux/ss/services.c:276: undefined reference
to 'mls_compute_context_len'
/selinux/selinux/module/checkpolicy/ ../ ../
../lsm-2.4/security/selinux/selinux/ss/services.c:294: undefined reference
to 'mls_sid_to_context'
services.o: In function 'security_context_to_sid':
/selinux/selinux/module/checkpolicy/ ../ ../
../lsm-2.4/security/selinux/selinux/ss/services.c:444: undefined reference
to 'mls_context_to_sid'

Hopefully this is a little more insightful.

(is there a way somehow to pipe the output that goes to the screen during
kernal build to a textfile?)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
