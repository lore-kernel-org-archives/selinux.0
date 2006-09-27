Subject: Re: disabling selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: abcde efghi <svmdcv@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6a9b0ede0609262348i513406t78028f986de8cf42@mail.gmail.com>
References: <6a9b0ede0609140355i4eeb58a7na4306260bdff7d72@mail.gmail.com>
	 <1158235692.25629.25.camel@moss-spartans.epoch.ncsc.mil>
	 <6a9b0ede0609142230u6db9a10fqf4f4059e7a90695e@mail.gmail.com>
	 <1158337309.18951.9.camel@moss-spartans.epoch.ncsc.mil>
	 <6a9b0ede0609190031p7f7610cfy87d8c54ab90a32d4@mail.gmail.com>
	 <1158671354.15340.41.camel@moss-spartans.epoch.ncsc.mil>
	 <6a9b0ede0609190852y4fe7cffqbb97178c008abe3b@mail.gmail.com>
	 <1158777383.15340.118.camel@moss-spartans.epoch.ncsc.mil>
	 <6a9b0ede0609262348i513406t78028f986de8cf42@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 07:30:15 -0400
Message-Id: <1159356615.32075.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-27 at 12:18 +0530, abcde efghi wrote:
> i am using NFS and OCFS(oracle cluster file system) filesystems, does
> xattr (extended attributes) supports these filesystems?
> as of man pages it's no!.
> i think my pbm is bcoz of these filesystems?

NFS doesn't yet support SELinux attributes, although there is work in
progress there.

I'm not aware of any ocfs support for xattrs.

For such filesystems, you can map all files to a single context via
policy or via the context= mount option.  But all of this only matters
when SELinux is actually enabled, of course.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
