Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA00186
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 08:51:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA05009
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 12:51:18 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA05005
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 12:51:17 GMT
Date: Tue, 3 Jul 2001 08:51:01 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: checkpolicy fails
In-Reply-To: <Pine.LNX.4.30.0107031422570.18924-100000@linux45.zdv.uni-tuebingen.de>
Message-ID: <Pine.SOL.3.95.1010703083521.5583B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 3 Jul 2001, Jan Petranek wrote:

> ./setfiles:  invalid context system_u:object_r:user_netscape_rw_ti on line number 66

This error has been previously reported by Hugo Martinez and by Rajan
Ravindran, but I haven't been able to replicate it.  Try using gdb
on the setfiles program, setting a breakpoint immediately after the sscanf
call (line 458) and a breakpoint before the security_context_to_sid call
(line 553).  Examine context at each breakpoint.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
