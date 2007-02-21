Subject: Re: libselinux patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20070221131211.72950.qmail@web51506.mail.yahoo.com>
References: <20070221131211.72950.qmail@web51506.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 21 Feb 2007 08:20:15 -0500
Message-Id: <1172064015.14363.266.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-21 at 05:12 -0800, Steve G wrote:
> >I also have to wonder whether we'd be better off just switching from
> >direct open+read of /proc/filesystems to just using fopen+getline,
> >thereby automatically picking up glibc's internal support of dynamic
> >buffer allocation and EINTR handling.  Just read the file line-by-line
> >and bail out if we find selinuxfs or hit the end of file.
> 
> There might be a more robust, higher performance way of doing this. Is there ever
> a situation where the selinux filesystem is _not_ "/selinux" ? If there never is
> a case where this happens, then we could change over to statfs and check for
> SELINUX_MAGIC in the f_type field of the structure. Its only 1 syscall instead of
> several.

At present, libselinux dynamically determines where selinuxfs is mounted
via /proc/mounts in init_selinuxmnt() and uses that path for all calls
that operate on selinuxfs.  Also, statfs'ing /selinux requires selinuxfs
to already be mounted before you can call is_selinux_enabled(), whereas
checking /proc/filesystems only requires that the selinux kernel code
have registered selinuxfs as a filesystem (much earlier) and that proc
be mounted.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
