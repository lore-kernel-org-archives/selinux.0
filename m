Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA06379
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 13:17:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA22905
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 17:15:32 GMT
Received: from crypt.netvision.net.il ([80.178.103.243])
	by jazzswing.ncsc.mil  with ESMTP id RAA22896
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 17:15:28 GMT
Received: from localhost (yoavw@localhost)
	by crypt.netvision.net.il (8.11.2/8.11.2) with ESMTP id g91IKSM06795
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 20:20:28 +0200
Date: Tue, 1 Oct 2002 20:20:28 +0200 (IST)
From: <ml-selinux@unpatched.net>
To: <selinux@tycho.nsa.gov>
Subject: Bug in selinux_task_reparent_to_init (?)
Message-ID: <Pine.LNX.4.33.0210011937280.6143-100000@crypt.netvision.net.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

During a brief code review of selinux-lsm I noticed that in the function
hooks.c:selinux_task_reparent_to_init() there is:

tsec = current->security;

I assume this code was copied from selinux_task_kmod_set_label(), but
shouldn't it be 'tsec = p->security;' and act on p instead of current in
this case ?

I didn't verify exploitability yet, but it may be possible to gain
SECINITSID_INIT as a normal process this way, using a syscall that creates
a kernel thread.  (opening a loop blockdev comes to mind but I didn't
verify it).

btw, can anyone explain how this dereferencing of current never caused a
problem when selinux_task_reparent_to_init is called from somewhere
taskless like usb hotplug ?

	Yoav Weiss



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
