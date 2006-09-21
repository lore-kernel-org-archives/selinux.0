Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LE70eg012248
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 10:07:00 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LE6TRL005437
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 14:06:30 GMT
Message-ID: <45129C7F.6090801@redhat.com>
Date: Thu, 21 Sep 2006 10:06:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <45116881.3060406@redhat.com> <1158846352.3920.33.camel@sgc.columbia.tresys.com>
In-Reply-To: <1158846352.3920.33.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2006-09-20 at 12:12 -0400, Daniel J Walsh wrote:
>
> I haven't looked at the patch but I have some initial reactions from
> your description:
>
>   
>> http://people.redhat.com/dwalsh/SELinux/policy.diff
>>
>> Changed to allow 1024 categories.
>>     
>
> Why do we need this many?  This isn't even an incremental change up to
> something like 384 or 512.
>
>   
MLS People have past 256 and wanted a big jump to prevent hitting this 
problem again.  I put it in for both to prevent confusion between MCS/MLS
>> +corecmd_etc_runtime_alias(firstboot_rw_t)
>> Adding a new alias is a pain in reference policy.  We need a better way of doing this.
>>     
>
> No.  We don't want aliases that cross module boundaries.  Otherwise it
> turns into a way to access other module's types directly instead of
> through an interface.  The ones that cross modules in the policy right
> now are for compatibility in targeted policy.
>   
So how do I get rid of firstboot_rw_t which should be etc_runtime_t?
>   
>> ntp needs to talk to unconfined_t for setting date from gnome.
>>     
>
> Thats weird, it seems like it would be the other way around.
>
>   
I think it is, it is just a chat.  The Date GUI code is requesting that 
the ntp code change the date of the machine.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
