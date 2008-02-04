MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: UNCLASSIFIED - Realtime Scheduling...
Date: Mon, 4 Feb 2008 12:39:38 -0000
Message-ID: <7F6B06837A5DBD49AC6E1650EFF5490601C64C1F@auk52177.ukr.astrium.corp>
From: "HAWKER, Dan 2 \(external\)" <Dan.HAWKER@uk4.astrium.eads.net>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> 
> I deferred submitting it for mainline because there was a 
> fair amount of concern from others about the implications of 
> the change, as you can see from the responses.
> 
> Nonetheless, I think it would be a useful feature for certain 
> user communities, so we should likely re-base and submit it.
> 
> It won't apply cleanly against the latest kernel because the 
> class value I used for it has since been taken for another class.
> 
> Unless you are already using a patched kernel for some 
> reason, I think you'd be better off just using the mechanisms 
> present in your existing kernel, e.g. make the program 
> setuid, have it shed unnecessary capabilities and uid 0 at 
> startup, and use policy to protect and confine it.  See 
> newrole for an example.  Otherwise you have to carry the 
> patch yourself, deal with any side effects, invalidate any 
> support agreements you might have with the vendor, etc.
> 

I did notice that there was some concern from other parties regarding
its submission. The minefield that is Linux Kernel politics :)

We're already using a patched, not-that-recent kernel anyway (embedded
hardware), so I'll pass along the info to our resident kernel hacker to
have a look and see what he can come up with and if its worth the
effort. The developer has already started moving his app around slightly
to get around this, so it may not be needed anyway.

Thanks again

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
