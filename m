Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
	overridden
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
        Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
        steved@redhat.com
In-Reply-To: <XMMS.LNX.4.64.0611141618300.25022@d.namei>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
	 <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>
	 <XMMS.LNX.4.64.0611141618300.25022@d.namei>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 13:41:13 -0500
Message-Id: <1164048073.13758.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-11-14 at 16:19 -0500, James Morris wrote:
> On Tue, 14 Nov 2006, David Howells wrote:
> 
> > +static u32 selinux_set_fscreate_secid(u32 secid)
> > +{
> > +	struct task_security_struct *tsec = current->security;
> > +	u32 oldsid = tsec->create_sid;
> > +
> > +	tsec->create_sid = secid;
> > +	return oldsid;
> > +}
> 
> The ability to set this needs to be mediated via MAC policy.
> 
> See selinux_setprocattr()

That's different - selinux_set_fscreate_secid() is for internal use by a
kernel module that wishes to temporarily assume a particular fscreate
SID, whereas selinux_setprocattr() handles userspace writes
to /proc/self/attr nodes.  Imposing a permission check here makes no
sense.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
