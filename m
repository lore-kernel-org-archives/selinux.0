Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2TCPU2x021576
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2010 08:25:30 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2TCQCbE015158
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2010 12:26:12 GMT
Message-ID: <4BB09C36.9010404@redhat.com>
Date: Mon, 29 Mar 2010 08:25:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Caleb Case <ccase@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: libsemanage Next Generation in Fedora 14?
References: <4BACFED2.70508@redhat.com> <4BAD120B.3070705@tresys.com>
In-Reply-To: <4BAD120B.3070705@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/26/2010 03:59 PM, Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> Caleb and Josh,
>>
>> What do you think of putting the new version of libsemanage into F14? Do
>> you think it is ready?
>>
>
> I don't think it is advisable. The current patchset makes use of a 
> 'new' kind of policy that is really the 3 parts of a refpolicy module 
> combined into a single file. The end system then pulls out all the 
> interface files and uses the entire Refpolicy build infrastructure to 
> build a policy.
>
> While that has uses (changing interfaces changes callers of the 
> interface, for example) it also means every end system would have to 
> have m4, sed, awk, checkpolicy and all the magic unicorns that are 
> part of building refpolicy.
>
> Once we have a minimal CIL (without the transformation language, for 
> example) and a proper Refpolicy compiler much of this will be hidden 
> away behind the library it will be much more suitable.
>
> I believe waiting until F15 is definitely the best idea, we never 
> really intended for a wider audience to use the current way because it 
> is non-ideal and has a number of hacks to make it work. It is mainly 
> available for people who want to work on it, see what it going to be 
> coming up or otherwise curious.
Ok I will ping again in September.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
