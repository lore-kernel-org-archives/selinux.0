MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: UNCLASSIFIED - Realtime Scheduling...
Date: Thu, 31 Jan 2008 19:03:55 -0000
Message-ID: <7F6B06837A5DBD49AC6E1650EFF5490601C64C1B@auk52177.ukr.astrium.corp>
From: "HAWKER, Dan 2 \(external\)" <Dan.HAWKER@uk4.astrium.eads.net>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> 
> At present, SELinux acts as an orthogonal mechanism to Linux 
> discretionary controls, and thus you must be authorized by 
> both Linux DAC and by SELinux MAC checks to perform any 
> operation.  So to invoke a call that requires privilege (in 
> Linux, "capability"), your program has to at least start with 
> uid 0 in addition to running in a SELinux domain that is 
> allowed the capability by policy.  The program can shed uid 0 
> upon startup while retaining certain capabilities; you can 
> see an example of that in newrole.  If your kernel supports 
> file capabilities, you could try using that instead of setuid 0.
> 
> We have previously proposed a patch to selinux that would 
> allow it to authoritatively grant a capability to a non-uid-0 
> process based on policy (see mailing list archives), and we 
> may proceed with that patch to support that kind of need, but 
> it isn't in any distro kernels today.

Hi Stephen,

Thanks for that, its as I thought. I'll pass on the info to the
developer.

Regarding the patch, I see that was back in June 07, (not that far back
admitedly, but SELinux moves apace), however I presume it *does what it
says on the tin* and applies simply enough???

I'll take a look and see how we get on.

Thanks

Dan

--

Dan Hawker
Linux System Administrator
Astrium
http://www.astrium.eads.net

-- 

This email (including any attachments) may contain confidential and/or
privileged information or information otherwise protected from disclosure.
If you are not the intended recipient, please notify the sender
immediately, do not copy this message or any attachments and do not use it
for any purpose or disclose its content to any person, but delete this
message and any attachments from your system. Astrium disclaims any and all
liability if this email transmission was virus corrupted, altered or
falsified.
---------------------------------------------------------------------
Astrium Limited, Registered in England and Wales No. 2449259
REGISTERED OFFICE:-
Gunnels Wood Road, Stevenage, Hertfordshire, SG1 2AS, England


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
