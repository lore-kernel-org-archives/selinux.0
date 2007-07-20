Subject: Re: [Fwd: cups AVC...]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>
In-Reply-To: <46A0D780.6020405@redhat.com>
References: <46A0C494.7060000@redhat.com>
	 <1184941981.17338.801.camel@moss-spartans.epoch.ncsc.mil>
	 <46A0D780.6020405@redhat.com>
Content-Type: text/plain
Date: Fri, 20 Jul 2007 13:13:41 -0400
Message-Id: <1184951621.17338.848.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-07-20 at 11:40 -0400, Daniel J Walsh wrote:
> I am just adding:
> 
> genfscon anon_inodefs / gen_context(system_u:object_r:eventpollfs_t,s0)
> 
> Does that look ok?
> 
>  I also notice in /proc/filesystem that there is a securityfs which we 
> do not define in policy.
> Any idea what this is for?

Calling it eventpollfs might be misleading given that it can also be
used for other purposes now.  I suppose you could make eventpollfs_t a
typealias to a new anon_inodefs_t type.

Greg KH created securityfs in 2005 to avoid having every security module
introduce their own pseudo filesystem and mount point. Motivated by
AppArmor, I think, and only used by it so far AFAIK.  In theory, we
should replace selinuxfs with nodes in securityfs, but doing so would be
rather disruptive to userspace and provide us with no real gain in
functionality.

http://marc.info/?l=git-commits-head&m=112663824224465&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
