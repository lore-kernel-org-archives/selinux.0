Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6A9M25D027743
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 05:22:02 -0400
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6A9Lu5L018061
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 09:21:56 GMT
Received: by wa-out-1112.google.com with SMTP id k22so1482674waf
        for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 02:21:56 -0700 (PDT)
Message-ID: <46934EA3.2050500@gmail.com>
Date: Tue, 10 Jul 2007 17:17:23 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: SELinux user root
References: <B850829A-A7A6-4B2A-B6A2-51EE83B6DC48@sf-net.com> <1184004466.12430.121.camel@moss-spartans.epoch.ncsc.mil> <ABA6C50B-476A-4775-BCAC-DD4ECD98B610@sf-net.com>
In-Reply-To: <ABA6C50B-476A-4775-BCAC-DD4ECD98B610@sf-net.com>
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stefan Schulze Frielinghaus wrote:
> 
> On 09.07.2007, at 20:07, Stephen Smalley wrote:
> 
>>> But if I try to modify the login context of root to use user_u I get
>>> the following error:
>>>
>>> $ semanage login -m -s user_u root
>>>
>>> libsemanage.validate_handler: MLS range s0-s15:c0.c1023 for Unix user
>>> root exceeds allowed range s0 for SELinux user user_u
>>> libsemanage.validate_handler: seuser mapping [root -> (user_u, s0-
>>> s15:c0.c1023)] is invalid
>>> libsemanage.dbase_llist_iterate: could not iterate over records
>>> /usr/sbin/semanage: Could not modify login mapping for root
>>>
>>> I'm not really sure how to interprete this message. I would guess
>>> it's because user_u has only a valid MLS range SystemLow and root has
>>> a SystemLow-SystemHigh range. But why could this be a problem?
>>
>> Because, as you said, user_u isn't authorized for that range.  The Linux
>> user is limited by the permissions of the SELinux user to which he is
>> mapped.
>>
>> Also, the above semanage command would not actually remove the "root"
>> SELinux user from the kernel policy; it would only remove the mapping
>> from the seusers file.  The seusers file was introduced as a way to
>> allow Linux users to be added/modified/removed without needing to change
>> the kernel policy each time, by letting you map each Linux user to one
>> of the predefined SELinux users.
>>
>> It would make more sense to map "root" to "staff_u" than to "user_u".
>> But you aren't achieving much by doing so, you still need "root" in the
>> kernel policy for compatibility with your on-disk file contexts.
> 
> But how to limit the linux user root to not switch to sysadm_r? I would
> change his SELinux user to user_u (but that's not working like we
> pointed out). Or would you change the SELinux user root to not include
> the sysadm_r role?

IMHO, you can use semanage to make "root" not have sysadm_r mapping

> 
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
