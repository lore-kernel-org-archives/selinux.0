Date: Wed, 10 Dec 2008 10:47:41 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] SELinux: open perms on sockets, AF_UNIX
In-Reply-To: <1228865476.3737.13.camel@localhost.localdomain>
Message-ID: <alpine.LRH.1.10.0812101047080.15836@tundra.namei.org>
References: <1228865476.3737.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 9 Dec 2008, Eric Paris wrote:

> 
> This is pretty much untested (just compiled) as I can't get linux-next
> to boot. (i'm a bit scared to turn off the redzone overwrite detection
> that is killing it, but I'll try in the morning) 

Can you test it against security-testing?


-- 
James Morris <jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
