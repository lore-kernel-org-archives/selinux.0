Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0NFkCRb014801
	for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2004 10:46:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0NFkBCa014928
	for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2004 15:46:11 GMT
Received: from s3cin.xetron.com (fw.xetron.com [216.68.89.2])
        by jazzband.ncsc.mil  with ESMTP id i0NFk7VC014907 for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2004 15:46:11 GMT
Message-ID: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A8A@s3cin>
From: "Kratzer, James R." <JamesK@xetron.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "SE Linux Mail List (E-mail)" <selinux@tycho.nsa.gov>
Subject: RE: transition failure
Date: Fri, 23 Jan 2004 10:46:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Thanks Stephen.  The script's context was indeed the problem. Using chcon
fixed the problem.  The context for the swatchd script was correct after a
"make relabel", but I later edited the file with vi, and vi corrupted the
context.  The chcon command corrected the context.  Is there a patched
version of vi available that will preserve contexts of files?

James

-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil]
Sent: Thursday, January 22, 2004 10:14 AM
To: James R. Kratzer
Cc: 'russell@coker.com.au'; SE Linux Mail List (E-mail)
Subject: RE: transition failure


On Thu, 2004-01-22 at 09:56, Kratzer, James R. wrote:
> Thanks Russ.  I was not aware of the constraints.  I'm am using "runcon"
> because when I use "run_init" I get the following error:
> 
>     execvp: Permission Denied
> 
> I forgot to mention previously that the "runcon" command gives this same
> error as well along with the "avc: denied { transition }" message.  
> 
> BTW, these errors only occur with enforcing=1 as run_init and runcon
execute
> swatch just fine with enforcing=0.
> What does execvp mean?

execvp(3) is a library function that is a front-end for execve(2);
run_init calls it to execute the script.  The most likely cause for
failure here is that the type on the /etc/rc.d/init.d/swatchd script is
wrong; it needs to have the initrc_exec_t type.  Try 'chcon -t
initrc_exec_t /etc/init.d/swatchd'.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
