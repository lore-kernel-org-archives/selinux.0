Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77FCYv4025291
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 11:12:34 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m77FCQjg004570
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 15:12:26 GMT
Message-ID: <489B10B7.1030206@redhat.com>
Date: Thu, 07 Aug 2008 11:11:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: david@hardeman.nu, selinux@tycho.nsa.gov
Subject: Re: [patch 17/35] brctl policy update
References: <20080804123456.679565839@hardeman.nu>	 <20080804123737.432616785@hardeman.nu> <1218116869.5345.18.camel@gorn.columbia.tresys.com>
In-Reply-To: <1218116869.5345.18.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
>> plain text document attachment (policy_modules_admin_brctl.patch)
>> One minor change
> 
> I need justification for this change.
> 
>> Index: refpolicy/policy/modules/admin/brctl.te
>> ===================================================================
>> --- refpolicy.orig/policy/modules/admin/brctl.te	2008-08-03 16:47:00.000000000 +0200
>> +++ refpolicy/policy/modules/admin/brctl.te	2008-08-03 18:01:42.000000000 +0200
>> @@ -33,6 +33,8 @@
>>  
>>  files_read_etc_files(brctl_t)
>>  
>> +term_use_console(brctl_t)
>> +
>>  libs_use_ld_so(brctl_t)
>>  libs_use_shared_libs(brctl_t)
>>  
>>
I believe this comes from libvirt or qemu interacting with the console.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
