Subject: Re: [RFC][PATCH v2] selinux:  support deferred mapping of contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <Xine.LNX.4.64.0805012318440.4703@us.intercode.com.au>
References: <1209588984.25678.389.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805010853300.2731@us.intercode.com.au>
	 <1209639872.25678.409.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805012209480.24536@us.intercode.com.au>
	 <1209645099.25678.434.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805012318440.4703@us.intercode.com.au>
Content-Type: text/plain
Date: Thu, 01 May 2008 09:49:20 -0400
Message-Id: <1209649760.25678.455.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-05-01 at 23:22 +1000, James Morris wrote:
> On Thu, 1 May 2008, Stephen Smalley wrote:
> 
> > the build host with no way to define it).  Or a mechanism for a
> > hierarchy of policies (complex, and not clear how to handle objects as
> > they may be visible to processes operating under more than one policy,
> > e.g. both inside and outside of the chroot).
> 
> Indeed, this might be helped by encoding DOIs into labels but would likely 
> add lots of complexity and performance overhead.  AFAICT, entities in 
> different policy namespaces would need to be totally separated (unless 
> purely hierarchical).

Pure isolation would be cleaner, but won't work in the buildsys example,
as there we have rpm (running outside the chroot) installing files into
the chroot tree and then launching scriptlets within the chroot, so we
have processes both outside and within the chroot acting on the files.

In any event, of the available alternatives, I think the
set-unknown-label option may be the only practical one. So if you have
any comments on the code in the patch or if you want it split into two
stages, let me know.  Otherwise, I'll re-spin it with Casey's suggested
change.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
