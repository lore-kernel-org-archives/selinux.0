Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OI9GrT029393
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 14:09:16 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OI8UMZ025290
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 18:08:31 GMT
Subject: Re: named policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Jason Vas Dias <jvdias@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200408250249.01418.russell@coker.com.au>
References: <200408241840.58207.russell@coker.com.au>
	 <1093349343.1800.57.camel@moss-spartans.epoch.ncsc.mil>
	 <200408250249.01418.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093370858.1800.221.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 14:07:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-24 at 12:49, Russell Coker wrote:
> > 3) /var/named/chroot labeling changes seem wrong to me; the current .fc
> > file provides consistent labels with a normal filesystem layout.
> 
> The .fc file in CVS does use more consistent labels with a normal file system.  
> However I don't think that this is a benefit.

If you were to remove named_t's access to base system types (like
root_t, etc_t, var_t, tmp_t, ...) entirely and only support chroot'd
operation, then it would make sense to only use named-specific types for
the chroot environment and use the policy to prohibit any access by
named outside of the chroot.  Otherwise, I think you want consistency
between the chroot and non-chroot environment labeling for policy
consistency between the two setups and to avoid overly permissive access
to named even within the chroot. 

Do you really want named_conf_t assigned to the chroot's /, /dev, /etc,
/var, /var/run and any otherwise unspecified files within them?  Audit
messages will be rather interesting there.  Nits:  Your .fc file also
has no entries for /dev/zero or /var/named within the chroot.  Finally,
I don't see why chroot'd named is redhat-specific.

> For example using tmp_t for the tmp directory is a bad idea IMHO.  If somehow 
> (due to a mistake in policy or a policy which matches a configuration that's 
> significantly altered from the default) a process in another gets access to 
> the chroot then it would be allowed to create temporary files there even 
> though the policy may correctly prevent it writing to all types associated 
> with named.  I think that tmp_t should be reserved for directories that are 
> designed for use by a large number of domains for temporary files.
>
> The same applies for the dev directory, we don't need to allow all domains to 
> search that directory, just named_t, sysadm_t, and a small number of others.

As above, if you wanted strong isolation, you could put each daemon into
a chroot with its own set of types, not allow any access to any of the
base system types or to another domain's types by the daemon's domain. 
But if you are going to give them access to the base system types anyway
(e.g. if they can access the system /tmp directory or the system /dev
directory), then what does it matter?  They are unlikely to be able to
reach each other's chroot environments anyway due to base protections on
the containing directory (e.g. /var/named itself), but even if they did,
they can't do any more harm than they can do to the base system (and
your policy has to be written from that perspective anyway, as you are
writing it for non-chroot setups as well as chroot setups). 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
