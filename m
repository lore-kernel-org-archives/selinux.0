Subject: Re: Updated policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41F917F6.8060602@redhat.com>
References: <41F6A47E.9010407@redhat.com>
	 <1106842924.28623.151.camel@moss-spartans.epoch.ncsc.mil>
	 <41F917F6.8060602@redhat.com>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 10:27:32 -0700
Message-Id: <1106846852.28103.8.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> >>allow mount_t binfmt_misc_fs_t:dir mounton;
> >>Required to run wine.
> >>    
> >>
> I got this one from Ivan Gyurdiev, I have never run wine.

Yes, it's a duplicate mount.

I put it in fstab, so it's mounted with all the rest of the filesystems.

Then rc.sysinit decides to do that again. Why, I don't know.
I don't like this. All my other filesystems are in fstab, so 
why does this one have to be special?

# Set up binfmt_misc
/bin/mount -t binfmt_misc none /proc/sys/fs/binfmt_misc > /dev/null 2>&1

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
