Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA03145
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 16:11:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA06384
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 20:11:27 GMT
Received: from ole.augie.edu (ole.augie.edu [192.103.41.37])
	by jazzband.ncsc.mil  with ESMTP id UAA06380
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 20:11:26 GMT
Message-Id: <200107032011.UAA06380@jazzband.ncsc.mil>
Subject: checkpolicy fails - compiler probs
From: Levi A Bard <labard@ole.augie.edu>
To: selinux@tycho.nsa.gov
Date: Tue, 03 Jul 2001 20:12:37 GMT
MIME-Version: 1.0
Content-type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There have been notorious and well-documented problems with
the C compiler installed by Redhat 7.0, hence the need for
kgcc (just an earlier version of gcc) with that
distribution.  

> I am having the exact same problem when trying to do a
'make relabel' - I
> have a feeling it is tied to RedHat 7.0 in some way. 
Please let the list
> know if a solution is found!
> 
> 
> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov
[mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Stephen Smalley
> Sent: Tuesday, July 03, 2001 8:51 AM
> To: Jan Petranek
> Cc: NSA Selinux Mailinglist
> Subject: Re: checkpolicy fails
> 
> 
> 
> On Tue, 3 Jul 2001, Jan Petranek wrote:
> 
> > ./setfiles:  invalid context
system_u:object_r:user_netscape_rw_ti on line
> number 66
> 
> This error has been previously reported by Hugo Martinez
and by Rajan
> Ravindran, but I haven't been able to replicate it.  Try
using gdb
> on the setfiles program, setting a breakpoint immediately
after the sscanf
> call (line 458) and a breakpoint before the
security_context_to_sid call
> (line 553).  Examine context at each breakpoint.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> --
> You have received this message because you are subscribed
to the selinux list.
> If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the
message.
> 



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
