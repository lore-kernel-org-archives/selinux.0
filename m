Subject: Re: Proposed patch for libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
In-Reply-To: <41790999.3080709@redhat.com>
References: <41782BBA.9090101@redhat.com>
	 <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil>
	 <41790999.3080709@redhat.com>
Content-Type: text/plain
Message-Id: <1098452654.7614.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 22 Oct 2004 09:44:14 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-22 at 09:22, Daniel J Walsh wrote:
> I originally did this because the man page said to.  I also was looking 
> using ENOATTR in a previous
> attempt at this patch, described in the man page but only defined in 
> attr/xattr, not sys/xattr.  So  I have no problem
> removing the change.

Ok, the man page is out of date.  ENOATTR doesn't exist anyway as a
separate error code; the kernel returns ENODATA.

> I was looking at this as more of a TRUE/FALSE proposition.  So maybe 
> changing it to
> three functions
> 
> setfileconperm(path)
> isfileconperm(path)
> clearfileconperm(path)

Possibly, with "fileconperm" replaced by "customcon" or similar, but
don't you still want the stored "true" value to be consistent regardless
of local cpu endianness?  You could setxattr on a single byte I suppose
to avoid the issue entirely.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
