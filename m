Message-ID: <42FDCA1E.8020701@redhat.com>
Date: Sat, 13 Aug 2005 06:23:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Colin Walters <walters@verbum.org>,
   selinux@tycho.nsa.gov
Subject: Re: Red Hat's passwd
References: <42F3904F.5080401@tresys.com>	<1123261941.20237.9.camel@nexus.verbum.private>	<42F3ACF2.9050905@tresys.com> <42F3B235.3080701@redhat.com>	<42F3B900.1090700@tresys.com> <1123772451.7810.33.camel@moss-spartans.epoch.ncsc.mil> <42FB7440.1000209@tresys.com>
In-Reply-To: <42FB7440.1000209@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:

> Stephen Smalley wrote:
>
>> The patches to rename checkPasswdAccess (while temporarily retaining the
>> old symbol for compatibility) were merged as of libselinux 1.25.1.  So
>> if/when people convert all users of it over to the new name, we can wait
>> a bit and then drop the old symbol altogether.
>>  
>>
> Dan, are you going to be able to merge those changes into passwd?
>
> We need to eliminate as many hard coded class references as possible 
> to make transitioning to the userspace security server easier.

yes

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
