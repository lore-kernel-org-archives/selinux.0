Message-ID: <3C45A786.8010009@pcez.com>
Date: Wed, 16 Jan 2002 08:17:10 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tislabs.com>
Subject: Re: /etc/security/default_context vs. /etc/security/default_contexts
References: <Pine.GSO.4.33.0201160934050.7787-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What is it format of the /etc/security/default_contexts?   It would be 
easy to convert the utils to the new get_user_sids,  but the format of 
the file for setting the default would need to be defined.

Ideas?

Shaun

>The new libsecure functions and the /etc/security/default_contexts file
>doesn't address the issue of a generic user.  It merely eliminates the
>need to maintain per-user entries in default_context and cron_context.
>There is still the problem of maintaining policy/users.  As Mark Westerman
>suggested (and I agreed), this can be addressed through the definition of
>a generic user and some minor modifications to the libsecure functions to
>use this as the default, as long as you do not need to distinguish among
>such users in the policy.  If you want to maintain distinct role sets for
>these users, then you will need to update policy/users in some manner.
>
>



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
