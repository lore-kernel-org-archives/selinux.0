Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA01511
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 12:04:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA24309
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 16:04:07 GMT
Received: from rospo1.bbn.com (rospo1.bbn.com [192.233.49.145])
	by jazzband.ncsc.mil  with ESMTP id QAA24305
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 16:04:06 GMT
Received: from sharktooth (sharktooth.bbn.com [192.233.52.210])
	by rospo1.bbn.com (8.9.1a/8.9.1) with SMTP id LAA25964
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 11:52:17 -0400 (EDT)
From: "Pranav Saha" <psaha@bbn.com>
To: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: RE: checkpolicy fails
Date: Tue, 3 Jul 2001 12:04:24 -0400
Message-ID: <HNEGLGGHLLAGJNNIEPHCOEBECAAA.psaha@bbn.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <Pine.SOL.3.95.1010703083521.5583B-100000@clipper.gw.tislabs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am having the exact same problem when trying to do a 'make relabel' - I
have a feeling it is tied to RedHat 7.0 in some way.  Please let the list
know if a solution is found!


-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Stephen Smalley
Sent: Tuesday, July 03, 2001 8:51 AM
To: Jan Petranek
Cc: NSA Selinux Mailinglist
Subject: Re: checkpolicy fails



On Tue, 3 Jul 2001, Jan Petranek wrote:

> ./setfiles:  invalid context system_u:object_r:user_netscape_rw_ti on line
number 66

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
