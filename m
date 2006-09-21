Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LFAHi2014738
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 11:10:17 -0400
Received: from ranger.argus-systems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LF9ISR023993
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 15:09:19 GMT
Message-ID: <4512AB6C.9080709@argus-systems.com>
Date: Thu, 21 Sep 2006 10:10:36 -0500
From: "Mikel L. Matthews" <mikel@argus-systems.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <45116881.3060406@redhat.com>	 <1158846352.3920.33.camel@sgc.columbia.tresys.com>	 <45129CD0.5040507@argus-systems.com> <1158850172.11048.2.camel@twoface.columbia.tresys.com>
In-Reply-To: <1158850172.11048.2.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Once it is in the customers hands, they use it as they feel they need 
to. It is not always the way we, as developers/designers, intended.

Joshua Brindle wrote:
> On Thu, 2006-09-21 at 09:08 -0500, Mikel L. Matthews wrote:
>> Christopher J. PeBenito wrote:
>>> On Wed, 2006-09-20 at 12:12 -0400, Daniel J Walsh wrote:
>>>
>>> I haven't looked at the patch but I have some initial reactions from
>>> your description:
>>>
>>>> http://people.redhat.com/dwalsh/SELinux/policy.diff
>>>>
>>>> Changed to allow 1024 categories.
>>> Why do we need this many?  This isn't even an incremental change up to
>>> something like 384 or 512.
>> We have customers that use all of our 1024 categories and want more. 
>> They have requested 10,000 categories.
>>
> 
> That is because they are probably using categories as an integrity
> mechanism which is entirely inappropriate for SELinux since TE should be
> used for integrity and mls should only be used for confidentiality. I
> seriously doubt that a reasonable system could have 10000 useful
> categories.
> 
> I don't think this change should be made to the refpolicy policy without
> a good justification, saying "MLS people want it" isn't good, its
> possible that they are also misusing categories.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

-- 
Thanks,
Mike

Mikel L. Matthews
Chief Technology Officer
Innovative Security Systems, Inc.
(dba Argus Systems Group)
1809 Woodfield Dr.
Savoy IL 61874
+1-217-355-6308
www.argus-systems.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
