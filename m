Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2HJdkDo017523
	for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2005 14:39:46 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2HJXWte025108
	for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2005 19:33:32 GMT
Message-ID: <4239DAD7.8030803@redhat.com>
Date: Thu, 17 Mar 2005 14:30:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: David Hampton <hampton-rh@rainbolthampton.net>
CC: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
Subject: Re: New policy for yam
References: <1110671442.7641.15.camel@hampton-pc.rainbolthampton.net>	 <4236EF2E.8090104@redhat.com> <1110912692.14212.29.camel@hampton-pc.rainbolthampton.net>
In-Reply-To: <1110912692.14212.29.camel@hampton-pc.rainbolthampton.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Hampton wrote:

>On Tue, 2005-03-15 at 09:20 -0500, Daniel J Walsh wrote:
>
>  
>
>>Why did you create a yam_crond_t?  Why not just transition to yam_t from 
>>crond?
>>    
>>
>
>When I first started working on the policy I was trying to be as
>restrictive as possible and differentiate between what peripheral files
>could be opened when running yam from the command line vs. when running
>from cron.  For example, the cron version requires less access to the
>terminal and no access to a ssh file descriptor.  The two instances also
>try reading their dot files from different directories.
>
>I wrote this policy just after writing an exim policy that distinguished
>between user, sysadm, and system invocations of the program.  Perhaps I
>went overboard here.
>
>David
>
>P.S. I'm still tweaking the exim policy.  I'll probably post it in a
>week or so.
>
>
>  
>
I was just question almost doubling of rules and increase in complexity 
for little gain in security.

Dan


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
