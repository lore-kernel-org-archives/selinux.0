Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <45A7D773.8040800@redhat.com>
References: <45A7D773.8040800@redhat.com>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 13:55:00 -0500
Message-Id: <1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-12 at 13:46 -0500, Daniel J Walsh wrote:
> Currently in policy we do NOT have the following rule
> 
> allow iso9660_t fs_t:filesystem associate;
> 
> This causes cp -a to blow up when copying a cdrom to ext3.   I notice in 
> policy we do allow this for nfs_t and dosfs_t to be assicoated with fs_t.
> 
> So this causes two problems, if we use cp -a from nfs_t or dosfs_t we 
> end up with files on local disk labeled as nfs_t/dosfs_t when I believe 
> we would be better off if they had transitioned.  So I could change 
> policy to similarly allow iso9660_t files to be created and fix the cp 
> -a problem.
> 
> Or I could remove the nfs_t and dosfs_t association and make the cp -a 
> problem worse.  Since cp -a gets permission denied it really has no way 
> of knowing what the correct behavior should be. 
> 
> Maybe a fix would be to allow cp to ask the kernel what to do if it can 
> not setfscreatecon a particular context on a file system.
> 
> Thoughts?

First, I seem to recall debates about whether -p (and thus -a) should
automatically enable preservation of SELinux context or whether that
should remain a separate option only.  Pros and cons to both sides.

I agree that allowing the association isn't the right thing to do.  Part
of the problem here is that setfscreatecon() doesn't know where you are
going to put the file, so it cannot report an error at that time, and
the open/mkdir failure could happen for a variety of reasons, not just
this one.

cp could fall back to resetting fscreate to NULL and try again in that
case (as long as the user didn't explicitly request preservation via
--preserve=context).

What does the coreutils maintainer think?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
