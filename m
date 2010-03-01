Subject: Re: denials with filesystem associate
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20100301165602.GH3990@myhost.felk.cvut.cz>
References: <20100228223834.GE3990@myhost.felk.cvut.cz>
	 <1267452601.601.3.camel@moss-pluto.epoch.ncsc.mil>
	 <20100301165602.GH3990@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Mon, 01 Mar 2010 12:09:16 -0500
Message-Id: <1267463356.601.26.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-03-01 at 17:56 +0100, Michal Svoboda wrote:
> Stephen Smalley wrote:
> > On file creation, there is an associate check between the security
> > context of the file and the security context of the containing
> > filesystem.  
> 
> Is there anything I could read up to understand this mechanism?

The particular permission checks for operations were described in:
http://www.nsa.gov/research/_files/selinux/papers/slinux-abs.shtml
and
http://www.nsa.gov/research/_files/selinux/papers/module-abs.shtml

There is also a wiki page with information on classes and permissions,
http://www.selinuxproject.org/page/ObjectClassesPerms

> > In your particular case though the real issue is that you
> > have an unlabeled filesystem type that needs a genfscon or fs_use rule
> > added to your policy.   Look for a log message that says something along
> > the lines of:
> > SELinux:  initialized (dev ..., type ...), not configured for labeling
> 
> [    2.780406] SELinux: initialized (dev devtmpfs, type devtmpfs), not
> configured for labeling
> 
> I think this is the new kernel-make dev filesystem that appears in .32
> or so. So I need to recompile the base module to use transition SIDs,
> like on normal tmpfs, right?

Yes.  Looks like Fedora policy has:
fs_use_trans devtmpfs gen_context(system_u:object_r:tmpfs_t,s0);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
