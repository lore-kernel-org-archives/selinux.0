Subject: Re: warning: the frame size of 1072 bytes is larger than 1024 bytes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4C106F0F.8020000@gmail.com>
References: <4C106F0F.8020000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 08:27:35 -0400
Message-ID: <1276172855.25808.17.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-06-09 at 21:50 -0700, Justin P. Mattock wrote:
> I've racked my brain with this one today
> with no results, but only what/where(maybe)
> is the cause for this:
> 
> policydb_destroy(&oldpolicydb);
> 
> if I change the &oldpolicydb to
> either &newpolicydb or &policydb
> I can get a clean compile without any
> warning message like below.
> 
> security/selinux/ss/services.c: In function 'security_load_policy':
> security/selinux/ss/services.c:1882: warning: the frame size of 1072 
> bytes is larger than 1024 bytes
> 
> is this a bug in policydb?
> any ideas on this one?

This is just a warning that the stack frame size for
security_load_policy() exceeds the limit specified by CONFIG_FRAME_WARN
(set under the Kernel hacking menu). On 64-bit it defaults to 2048; else
it defaults to 1024.

You can just change your CONFIG_FRAME_WARN setting (to 0 to disable
checking altogether, or increase it to retain checking but allow this
case).

The code fix would be to change security_load_policy() to allocate
oldpolicydb and newpolicydb on the heap rather than temporarily storing
them on the stack.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
