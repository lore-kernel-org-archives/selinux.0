Subject: Re: Updated policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1106727722.17956.3.camel@cobra.ivg2.net>
References: <41F6A47E.9010407@redhat.com>
	 <1106727722.17956.3.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1106841036.28623.128.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 27 Jan 2005 10:50:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-26 at 03:22, Ivan Gyurdiev wrote:
> On Tue, 2005-01-25 at 14:56 -0500, Daniel J Walsh wrote:
> > Many changes to allow policy to support telnetd, rlogind and rshd.
> > 
> > allow mount_t binfmt_misc_fs_t:dir mounton;
> > Required to run wine.
> 
> Now there is:
> 
> allow mount_t binfmt_misc_fs_t:dir mounton;
> ...
> # mount binfmt_misc on /proc/sys/fs/binfmt_misc
> allow mount_t sysctl_t:dir { mounton search };
> 
> Are both of those necessary?

Shouldn't be.  mounton permission is required to the mount point
directory, which should be sysctl_t.  binfmt_misc_fs_t should only be on
the mounted directory.  Duplicate mount?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
