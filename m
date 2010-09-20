Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o8K97OIY015476
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2010 05:07:24 -0400
Received: from new1.smtp.messagingengine.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o8K97NZ3016126
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2010 09:07:24 GMT
From: Roberto Sassu <roberto.sassu@polito.it>
To: selinux@lists.fedoraproject.org, selinux@tycho.nsa.gov
Subject: genfscon question
Date: Mon, 20 Sep 2010 11:07:26 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201009201107.27478.roberto.sassu@polito.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all

i want to create a custom filesystem policy using the genfscon statement for labelling 
files. I need to specify rules with the wildcard character, in order to obtain the same behaviour 
for multiple subdirectories but this is currently unsupported (building of the policy fails).
There are security/design concerns in order to introduce this feature or it can be added
by patching the code?
Thanks in advance for replies.

Roberto Sassu

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
