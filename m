Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9F4B5Wt023284
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 00:11:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9F4Aw0p012315
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 04:10:58 GMT
Received: from mailhost.unt.edu (mailhost.unt.edu [129.120.209.40])
	by jazzswing.ncsc.mil  with ESMTP id h9F4Avr7012309
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 04:10:57 GMT
Message-ID: <1066191058.3f8cc8d257e4c@eaglemail.unt.edu>
Date: Tue, 14 Oct 2003 23:10:58 -0500
From: Ignacio Tripodi <ijt0003@unt.edu>
To: selinux@tycho.nsa.gov
Subject: Filesystem problems
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I had a 2.4 kernel with SELinux enabled, could load a policy, relabeled the 
filesystem (ext3) and was able to see the extended attributes of all files. 
However, after I upgraded to the 2.6 SELinux kernel, I wasn't able to load 
the policy again. It still lets me in since I enabled the development mode 
but the tools don't recognize the running kernel as an SELinux-enabled 
kernel. Besides, this is what I get in the dmesg after it mounts the root 
filesystem:

security_context_to_sid: called before initial load_policy on unknown 
context system_u:object_
r:file_t
security_context_to_sid: called before initial load_policy on unknown 
context system_u:object_
r:root_t

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
