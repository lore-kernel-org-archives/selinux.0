Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA26499
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 10:36:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA25620
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 15:33:37 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA25616
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 15:33:36 GMT
Received: from localhost (wsalamon@localhost)
	by vox.gw.tislabs.com (8.11.2/8.11.2) with ESMTP id h0SFaIu03697
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 10:36:18 -0500
Date: Tue, 28 Jan 2003 10:36:18 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: run_init policy
Message-ID: <Pine.LNX.4.33.0301281029520.1754-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  The existing policy only allows run_init to execute file with the
initrc_exec_t type. In the current file contexts, only the rc files in
/etc have the type; the /etc/init.d, /etc/rc?.d scripts have the etc_t.
Therefore, run_init cannot execute the individual rc scripts.

  The relevant line from initrc.te is this:
run_program(sysadm_t, sysadm_r, init, initrc_exec_t, initrc_t)

  The question is this: Would it be better to change the above line to
run_program(sysadm_t, sysadm_r, init, {initrc_exec_t etc_t}, initrc_t)

  or, change the types on the rc files in /etc/init.d, /etc/rc?.d?
The initrc_t has execute permission on those types.  Is there a reason we
keep the mass of rc files typed as etc_t?

  Thanks,
-- 
Wayne Salamon
wsalamon@tislabs.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
