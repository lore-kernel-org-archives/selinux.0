MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Policy compiler issues.
Date: Thu, 20 May 2004 11:54:19 -0400
Message-ID: <E7E29FA7C732D146887C784B34AEF6A0044E412B@xch-ne-01.ne.nos.boeing.com>
From: "Bush, Daniel" <Daniel.Bush@boeing.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SELinux" <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

First and foremost: Thank you all for your help. I REALLY appreciate it. 
That said:

>>   I'm trying to deploy SELInux in an embedded environment. Footprint 
>> space is tight, every kilobyte counts. The environment is also fairly 
>> dynamic, the users list and assigned roles can change fairly rapidly.
>
>That seems like an odd combination - embedded but highly dynamic users and roles?  
    Yes, it's an odd combination, but _is_ the case. 

>How do you plan on distributing updates to the users list and user-role authorizations?
   That's another part of the problem... We have a server/management mechanisim planned, but it's a Win2k environment (Yeah, yeah, I know. Wasn't my decision...) I figure we can deploy the compilers on a suitably modified CygWin, mount either the CygWin or the SELinux device as an NFS device on the other, and get the necessary functionality that way. We're still working on that.
   As it stands the whole system needs to weigh in at less than about 64M with smaller being MUCH better (32M would be ideal.) So you can see, there's not much room for a full compiler/linker suite.

>> Can a user be assigned a set of (non-default user) roles without 
>> re-compiling the security system?

>If you want the user to be recognized by SELinux as an individual user, then you need to >modify the policy (either directly patching the binary policy or modifying the source and >recompiling) and reload it.  There is already a user_u user that is a fallback for 
>ordinary users who do not have a specific entry in the SELinux policy, so if you don't 
>add the user to the SELinux policy, he will be mapped to user_u and limited to the roles >authorized for user_u. 
    "user_u" isn't really the problem. The other, higher orders are. The specification calls for a couple of new user classes (I'm pretty sure I can institute those.) and those  classes have a forseeable need to have their membership lists changed in the field. If we need to re-compile the policy when that happens, this presents a problem.

> Direct manipulation of the binary policy is possible, and I expect that libraries and 
>tools for doing so will become available; note the earlier work by Tresys on binary 
>policy patching that was posted to this list, plus the posting re future work on loadable >binary policy modules. 

This sounds promising... Could you please direct me to the date range of the messages you're referring to?

>>   Can SELinux be compiled under uClibc? 
>I haven't tried.  What kind of problem are you encountering?
   I just wanted to know if it was definitely known Impossible before I went any further. I've just made a couple of wild stabs at it, and it could be things in my environment that are mucking up the works. (It's definitely not ready for prime-time yet...) Since I seem to be cutting new trail here, I'll keep everybody posted on my progress. 

-=Dan Bush
"Peace through superior surrealism"



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
