Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2KEtax6016313
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 09:55:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2KEq7n8006718
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 14:52:07 GMT
Received: from venere.mat.uniroma1.it ([151.100.50.3])
	by jazzswing.ncsc.mil  with ESMTP id h2KEq6pk006672
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 14:52:06 GMT
Received: from inwind.it (archimede.mat.uniroma1.it [151.100.50.200])
	by venere.mat.uniroma1.it (8.9.1b+Sun/8.9.1) with ESMTP id PAA27503
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 15:52:50 +0100 (MET)
Message-ID: <3E79D684.5020306@inwind.it>
Date: Thu, 20 Mar 2003 15:56:04 +0100
From: Giorgio Zanin <giorgio.zanin@inwind.it>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: about policy configuration language grammar
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm studing the policy configuration language of SELinux.
Anyone knows what is the difference between those non-terminals ending 
with "_push" and their versions without that suffix?

I mean, why there is a difference between names and names_push, 
identifier and identifier_push, and so on?

Is there any semantic difference or  I can consider them the same (maybe 
it is just convenient to split some productions for giving different 
actions in yacc...)

Thanks


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
