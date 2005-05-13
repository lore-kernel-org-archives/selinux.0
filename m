Message-ID: <42848C53.4040108@redhat.com>
Date: Fri, 13 May 2005 07:15:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: russell@coker.com.au, Chad Sellers <cdselle@tycho.nsa.gov>,
   selinux@tycho.nsa.gov
Subject: Re: [RFC]{Patch 0/5] Polyinstantation
References: <1115825335.28084.27.camel@moss-huskies.epoch.ncsc.mil> <1115896944.32202.22.camel@moss-spartans.epoch.ncsc.mil> <1115904167.30162.7.camel@moss-huskies.epoch.ncsc.mil>            <200505131440.42410.russell@coker.com.au> <200505130553.j4D5rAHI014973@turing-police.cc.vt.edu>
In-Reply-To: <200505130553.j4D5rAHI014973@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:

>On Fri, 13 May 2005 14:40:39 +1000, Russell Coker said:
>  
>
>>Per user /tmp directories break the typical uses of Unix systems.  On Unix 
>>multi-user systems it's expected that you can copy a file to /tmp and give it
>>mode 0644 to share it with other people.
>>    
>>
>
>  
>

>Right. Unfortunately, we're swimming upstream against a quarter century
>of common practice that happens to be almost "couldn't design a worse security
>model if we *tried*". A shared /tmp makes sense when everybody's in the same
>security domain, is essentially root anyhow, and file ownerships/permissions
>are there mostly to limit friendly-fire accidents to ones *own* feet, and not
>the co-workers as well.  Of course, if you're deploying SELinux, you're no
>longer in Kansas anymore....
>
>Is the polyinstantation addressing:
>
>1) the fact that userB may be able to see/interfere with what userA is doing
>in /tmp, when userA may not desire userB doing so? (If we give userA his own
>instance of /tmp, userB can't interfere).
>
>2) The problem of userA intentionally using /tmp as a zone to pass sensitive
>data to userB, when the site security officer has other ideas? (If we give
>userA his own instance of /tmp, he can't drop a file where userB can get it).
>
>3) Attempting to solve both problems at the same time?
>
>And Russell is correct - although it *does* work when A and B *shouldn't*
>communicate, we *do* need to make *some* provision for the case where users A
>and B are cooperating and allowed to do so by site policy. I suspect that
>"share via /tmp" won't be easily workable, but "share via other file system
>means" will be (we're already looking at a '~/Downloads' type of directory - a
>~/Shared perhaps?)
>
>
>
>  
>

None of this stuff will work until we have the ability for the 
administrator to change every users view
of the file system.  So some kind of shared file system will be 
required.   I think the idea of the  required
shared /tmp is fairly old idea, and not needed much any more,  and can 
be easily be done using other means. 
I figure the ability to use a non shared /tmp should be configurable.  
And as Valdis can easily be worked
around by creating another directory for cross machine sharing.   

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
