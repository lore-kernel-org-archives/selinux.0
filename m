Subject: Re: SELinux user root
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <B850829A-A7A6-4B2A-B6A2-51EE83B6DC48@sf-net.com>
References: <B850829A-A7A6-4B2A-B6A2-51EE83B6DC48@sf-net.com>
Content-Type: text/plain
Date: Mon, 09 Jul 2007 14:07:46 -0400
Message-Id: <1184004466.12430.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-07-08 at 10:35 +0200, Stefan Schulze Frielinghaus wrote:
> Like from the RHEL4 manuel (http://www.redhat.com/docs/manuals/ 
> enterprise/RHEL-4-Manual/selinux-guide/rhlcommon-section-0038.html)  
> the SELinux user root exists only for legacy reasons:
> 
> # root is retained as a separate user identity simply as a
> # compatibility measure with the "strict" policy.  It could
> # be dropped and mapped to user_u but this allows existing
> # file contexts that have "root" as the user identity to
> # remain valid.
> 
>    user root roles { user_r sysadm_r system_r };

That is true under the default targeted policy.  It is not true of
strict policy or mls policy.  The difference is that targeted policy has
no notion of user roles and does not try to control users, only specific
programs/daemons, whereas strict and mls policies include user roles and
limit what users can do.

> But if I try to modify the login context of root to use user_u I get  
> the following error:
> 
> $ semanage login -m -s user_u root
> 
> libsemanage.validate_handler: MLS range s0-s15:c0.c1023 for Unix user  
> root exceeds allowed range s0 for SELinux user user_u
> libsemanage.validate_handler: seuser mapping [root -> (user_u, s0- 
> s15:c0.c1023)] is invalid
> libsemanage.dbase_llist_iterate: could not iterate over records
> /usr/sbin/semanage: Could not modify login mapping for root
> 
> I'm not really sure how to interprete this message. I would guess  
> it's because user_u has only a valid MLS range SystemLow and root has  
> a SystemLow-SystemHigh range. But why could this be a problem?

Because, as you said, user_u isn't authorized for that range.  The Linux
user is limited by the permissions of the SELinux user to which he is
mapped.

Also, the above semanage command would not actually remove the "root"
SELinux user from the kernel policy; it would only remove the mapping
from the seusers file.  The seusers file was introduced as a way to
allow Linux users to be added/modified/removed without needing to change
the kernel policy each time, by letting you map each Linux user to one
of the predefined SELinux users.

It would make more sense to map "root" to "staff_u" than to "user_u".
But you aren't achieving much by doing so, you still need "root" in the
kernel policy for compatibility with your on-disk file contexts.

> The system I'm testing this is a CentOS5 with a MLS policy installed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
