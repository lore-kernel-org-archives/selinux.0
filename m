In-Reply-To: <1184004466.12430.121.camel@moss-spartans.epoch.ncsc.mil>
References: <B850829A-A7A6-4B2A-B6A2-51EE83B6DC48@sf-net.com> <1184004466.12430.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ABA6C50B-476A-4775-BCAC-DD4ECD98B610@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: SELinux user root
Date: Tue, 10 Jul 2007 10:17:34 +0200
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 09.07.2007, at 20:07, Stephen Smalley wrote:

>> But if I try to modify the login context of root to use user_u I get
>> the following error:
>>
>> $ semanage login -m -s user_u root
>>
>> libsemanage.validate_handler: MLS range s0-s15:c0.c1023 for Unix user
>> root exceeds allowed range s0 for SELinux user user_u
>> libsemanage.validate_handler: seuser mapping [root -> (user_u, s0-
>> s15:c0.c1023)] is invalid
>> libsemanage.dbase_llist_iterate: could not iterate over records
>> /usr/sbin/semanage: Could not modify login mapping for root
>>
>> I'm not really sure how to interprete this message. I would guess
>> it's because user_u has only a valid MLS range SystemLow and root has
>> a SystemLow-SystemHigh range. But why could this be a problem?
>
> Because, as you said, user_u isn't authorized for that range.  The  
> Linux
> user is limited by the permissions of the SELinux user to which he is
> mapped.
>
> Also, the above semanage command would not actually remove the "root"
> SELinux user from the kernel policy; it would only remove the mapping
> from the seusers file.  The seusers file was introduced as a way to
> allow Linux users to be added/modified/removed without needing to  
> change
> the kernel policy each time, by letting you map each Linux user to one
> of the predefined SELinux users.
>
> It would make more sense to map "root" to "staff_u" than to "user_u".
> But you aren't achieving much by doing so, you still need "root" in  
> the
> kernel policy for compatibility with your on-disk file contexts.

But how to limit the linux user root to not switch to sysadm_r? I  
would change his SELinux user to user_u (but that's not working like  
we pointed out). Or would you change the SELinux user root to not  
include the sysadm_r role?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
