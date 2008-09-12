Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8CHRbw4008783
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 13:27:37 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m8CHRWAE009718
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 17:27:37 GMT
Message-ID: <48CAA67C.5090006@manicmethod.com>
Date: Fri, 12 Sep 2008 13:27:24 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Changes to semanage to allow it to handle transactions.
References: <48C57780.6090408@redhat.com> <48CA8062.7000808@manicmethod.com> <48CA903F.6080109@redhat.com>
In-Reply-To: <48CA903F.6080109@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Joshua Brindle wrote:
>> Daniel J Walsh wrote:
>> semanage -S targeted -i - << __eof
>> user -a -P user -R "unconfined_r system_r" -r s0-s0:c0.c1023 unconfined_u
>> user -a -P user -R guest_r guest_u
>> user -a -P user -R xguest_r xguest_u
>> __eof
>> semanage -S targeted -i - << __eof
>> login -m  -s unconfined_u -r s0-s0:c0.c1023 __default__
>> login -m  -s unconfined_u -r s0-s0:c0.c1023 root
>> __eof
>>
>> So you can add multiple records in a single pass.
> 
>> This patch seems to cause some issues:
> 
>> [root@misterfreeze selinux-pristine]# semanage --help
>> Traceback (most recent call last):
>>   File "/usr/sbin/semanage", line 433, in <module>
>>     usage(_("Requires 2 or more arguments"))
>>   File "/usr/sbin/semanage", line 98, in usage
>>     """) % message)
>> TypeError: float argument required
> 
> 
> 
> 
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
> 
> Patch off your latest policycoreutils.
> 

Ok, merged in (with no version bump)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
