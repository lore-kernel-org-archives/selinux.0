Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KMsbrT007702
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 18:54:37 -0400 (EDT)
Received: from rwcrmhc12.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KMrs4v006972
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 22:53:55 GMT
Message-ID: <4126812A.2050004@tresys.com>
Date: Fri, 20 Aug 2004 18:54:34 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Colin Walters <walters@redhat.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: conflict between libselinux and libsepol
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>	 <1092972342.29540.35.camel@nexus.verbum.private>	 <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>	 <1093013527.9495.0.camel@nexus.verbum.private>	 <1093015484.16585.199.camel@moss-spartans.epoch.ncsc.mil>	 <1093028441.16585.265.camel@moss-spartans.epoch.ncsc.mil>	 <1093030667.4212.4.camel@nexus.verbum.private> <1093035295.4212.9.camel@nexus.verbum.private>
In-Reply-To: <1093035295.4212.9.camel@nexus.verbum.private>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin Walters wrote:

>On Fri, 2004-08-20 at 15:37 -0400, Colin Walters wrote:
>  
>
>>On Fri, 2004-08-20 at 15:00 -0400, Stephen Smalley wrote:
>>    
>>
>>>On Fri, 2004-08-20 at 11:24, Stephen Smalley wrote:
>>>      
>>>
>>>>Hence, I would recommend that we add a function to libsepol to provide a
>>>>higher level interface for context validation against a given binary
>>>>policy, add it to libsepol.map, and declare the prototype in sepol.h for
>>>>use by setfiles.
>>>>        
>>>>
>>>Patch for libsepol attached, along with a sample program.  I'll add it
>>>to the sourceforge CVS.
>>>      
>>>
>
>And a patch for the policy Makefile to cause it to verify the file
>contexts under the "policy" target.  I think this makes sense because
>conceptually the file contexts is part of the whole system security
>policy.
>  
>
>  
>
How is this the case at all? Conceptually the file contexts is *not* 
part of the system policy, afaik that is a major design feature of 
SELinux, that the enforcement and labeling is totally seperate (with the 
exception of ocontext stuff ofcourse)

I believe this is the case, unless Steve disagrees ofcourse :)

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
