Subject: Re: Adding alternate root patch to restorecon (setfiles?)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
In-Reply-To: <41741A2C.8040408@redhat.com>
References: <41741A2C.8040408@redhat.com>
Content-Type: text/plain
Message-Id: <1098129355.27895.224.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 18 Oct 2004 15:55:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-18 at 15:31, Daniel J Walsh wrote:
> We are beginning to look into how we could support clusters with SELinux. 
> Usually in clusters you move your configuration off on to some shared 
> storage.
> 
> So you might do a cp -a  /var/named /shared/var/named
> 
> We need some way of relabeling these directories with file context.  My 
> idea is to add an alternate
> root qualifier to restorecon
> 
> So in the above example you would do a
> 
> restorecon -R -p /shared /shared/var/named
> 
> I think this would work fairly well for chroot environments also.

setfiles already has such an option (-r).  setfiles and restorecon
increasingly resemble one another except in their default behaviors.

Previously, you indicated that you viewed the important difference as
being that setfiles takes a specified file_contexts while restorecon
only uses the system one, thereby imposing different trust burdens on
the caller.  But note that setfiles policy already limits the set of
types that it can read, and this could possibly be pruned further to
avoid any types writable by a less trusted caller if there are such
types.

Merging them into one program and re-visiting whether setfiles can
leverage matchpathcon(3) might be worthwhile.  At present, it doesn't do
so because it wants the spec info for use in conflict detection, IIRC.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
