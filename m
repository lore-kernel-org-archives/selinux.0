Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9HFcuWt010023
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 11:38:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9HFctmR021297
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 15:38:55 GMT
Received: from dymwsm17.mailwatch.com (dymwsm17.mailwatch.com [204.253.83.165])
        by jazzband.ncsc.mil  with ESMTP id h9HFctjp021292 for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 15:38:55 GMT
Received: from MWSC0217.MW4.MAILWATCH.COM (mwsc0217.mw4.mailwatch.com [204.253.83.118])
	by dymwsm17.mailwatch.com (8.12.9/8.12.9) with ESMTP id h9HFckkS011524
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 11:38:48 -0400
Received: from fmpo1.azell.com (fmpo1.azell.com [136.1.7.9])
	by dymwsm15.mailwatch.com (8.12.9/8.12.9) with ESMTP id h9HFcinm020735
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 11:38:45 -0400
Message-ID: <752E6D5014672D458A593B5E7A3CD5F56165CD@na1fcm51.dearborn.ford.com>
From: "Inger, Slav (S.B.)" <vinger@ford.com>
To: "SELinux ML (E-mail)" <selinux@tycho.nsa.gov>
Subject: Sample config
Date: Fri, 17 Oct 2003 11:38:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

In my environment, 'root' has a role of sysadm_r.  Running SELinux in permissive mode and looking at the avc messages, all violations apply to the kernel_t context.  Also, all of the processes on the system seem to be running in kernel_t context as well.  I can use newrules.pl to relax the rules (basically add a bunch of 'allow kernel_t' lines, but that's not the point.  What I would like to demonstrate is that user 'root' can do all of his normal sysadmin chores EXCEPT kill some process or rm some file.  Let's say he shouldn't be able to kill sshd and overwrite or remove /var/log/messages (but appending is fine).  This is pretty easy to do with LIDS, I need to know how administratively intensive it is to set up these rules in SELinux.  What specific rules do I need to add/remove/change to make what I'm asking for happen?  Thanks in advance.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
