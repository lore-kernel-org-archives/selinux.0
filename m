Subject: Re: [RFC][PATCH] security:  split ptrace checking in proc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <Xine.LNX.4.64.0805121039170.22560@us.intercode.com.au>
References: <1210358948.6434.244.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805121039170.22560@us.intercode.com.au>
Content-Type: text/plain
Date: Mon, 12 May 2008 08:47:29 -0400
Message-Id: <1210596449.6206.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-05-12 at 10:39 +1000, James Morris wrote:
> On Fri, 9 May 2008, Stephen Smalley wrote:
> 
> > This is a first cut at a patch to address the issue raised in:
> > http://marc.info/?t=121034132000001&r=1&w=2
> > which was first raised in:
> > http://marc.info/?t=115937617100001&r=1&w=2
> > 
> > After we get agreement here on what we want for SELinux, I'll circulate
> > it on lsm and lkml for wider discussion.
> 
> Looks good to me.

Ok, I've posted this RFC to lsm and lkml now.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
