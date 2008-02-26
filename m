Subject: Re: [PATCH][RFC] Unify printk messgaes
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.64.0802262049370.10387@us.intercode.com.au>
References: <Xine.LNX.4.64.0802262049370.10387@us.intercode.com.au>
Content-Type: text/plain
Date: Tue, 26 Feb 2008 08:48:48 -0500
Message-Id: <1204033728.2846.35.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-02-26 at 20:53 +1100, James Morris wrote:
> I noticed that we had a mix of "SELinux:" and "security:" prefixes in our 
> kernel boot messages, so I've unified these to "SELinux:" with the patch 
> below to reduce user confusion.  (It doesn't try and fix every printk, 
> just the ones with "security:").
> 
> Also simplified the avtab hash message, from:
> 
>   SELinux:8192 avtab hash slots allocated. Num of rules:163922
> 
> to
> 
>   SELinux: 8192 avtab hash slots, 163922 rules.
> 
> 
> Comments?

If you are going to do this can you add a KERN_* prefix to everything
that doesn't have one?  Or do we really prefer things to get
default_message_loglevel ??

-Eric



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
