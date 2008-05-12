Date: Mon, 12 May 2008 10:39:33 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][PATCH] security:  split ptrace checking in proc
In-Reply-To: <1210358948.6434.244.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0805121039170.22560@us.intercode.com.au>
References: <1210358948.6434.244.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 9 May 2008, Stephen Smalley wrote:

> This is a first cut at a patch to address the issue raised in:
> http://marc.info/?t=121034132000001&r=1&w=2
> which was first raised in:
> http://marc.info/?t=115937617100001&r=1&w=2
> 
> After we get agreement here on what we want for SELinux, I'll circulate
> it on lsm and lkml for wider discussion.

Looks good to me.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
