Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7VIFto5004572
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 14:15:55 -0400
Received: from mx-out-manc2.simplymailsolutions.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7VIFsKk015107
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 18:15:54 GMT
Message-ID: <4E5E7A12.9080009@roboreus.com>
Date: Wed, 31 Aug 2011 19:14:42 +0100
From: Roy Badami <roy.badami@roboreus.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: CentOS 5 RBAC
References: <4E5E68DB.1030101@roboreus.com> <20110831174805.GC11607@localhost.localdomain>
In-Reply-To: <20110831174805.GC11607@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 31/08/2011 18:48, Dominick Grift wrote:
> On Wed, Aug 31, 2011 at 06:01:15PM +0100, Roy Badami wrote:
>> I'm trying to understand the RBAC features in the version of the mls
>> (and also strict) policies that ship with CentOS 5.6 - I'm not sure
>> if this is the best place to ask or if there's a more appropriate
>> list.
> refpolicy@oss.tresys.com is more appropriate.

Thanks - I'll bear that one in mind.
>
> When you build mls policy you get a seperate secadm role when you build strict policy then sysadm role also has the capabilities that secadm role in mls has.

Yes, so looks like it does makes sense for me to use the mls policy in 
that case.  Unfortunately in the mls policy on el5 it appears that both 
sysadm_r and secadm_r can both administer security.  secadm_r is 
preveneted from performing other systems administration, but 
unfortunately sysadm_r is not prevented from changint the selinux 
policy, etc.  This wasn't how I was hoping it would work :-(

>
> well whether the modules are installed (semodule -l | grep secadm) that i guess would be defined manually in the modules.conf for strict. if the secadm module is installed then it could be that the role is just not mapped to staff_u unless policy is mls ( see above: users file snippet)
Ah, I'd been trying to figure out how to verify what modules really were 
present in the loaded binary policy - that's very useful, thanks!  As as 
your other pointers to bits of the policy.

Regards

roy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
