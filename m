Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA01083
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 11:52:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA14769
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 16:50:49 GMT
Received: from vorpal.mcs.drexel.edu (vorpal.mcs.drexel.edu [129.25.6.250])
	by jazzswing.ncsc.mil  with ESMTP id QAA14765
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 16:50:48 GMT
Subject: suggested policy change
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 06 Mar 2002 11:49:19 -0500
Message-Id: <1015433359.1457.1.camel@vorpal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Adding the rules:
# policy/domains/system/kmod.te
allow kmod_t sysctl_kernel_t:file rw_file_perms;

# policy/domains/program/modutil.te
allow insmod_t sysctl_kernel_t:file rw_file_perms;

results in the error messages:

error in the statement ending on line 25688 (token ';'): assertion
failed:  allow kmod_t sysctl_kernel_t:file { write append } was granted.


error in the statement ending on line 25688 (token ';'): assertion
failed:  allow insmod_t sysctl_kernel_t:file { write append } was
granted.

i.e., they conflict with some of the neverallow rules. Should I simply
get rid of the appropriate neverallow rules?

--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
