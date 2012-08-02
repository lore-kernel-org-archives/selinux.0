Message-ID: <1343913036.30052.9.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: init and /data/system policies
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 02 Aug 2012 09:10:36 -0400
In-Reply-To: <CAFftDdqABcoJbH+yEoe8dSRUuUxG2M72BCj0e27b=ZsWmYC6aA@mail.gmail.com>
References: 
	<CAFftDdqABcoJbH+yEoe8dSRUuUxG2M72BCj0e27b=ZsWmYC6aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-08-01 at 13:48 -0700, William Roberts wrote:
> Currently the policy file is loaded early in init, before any
> filesystems are mounted. This means that if their is a policy file in
> data/system that should be used instead of the on in the rootdir
> ramfs, and the data/system policy is ignored until you do a reload. I
> was wondering what the security implications are of loading the policy
> after the mount, or is it better just to do a setprop to reload policy
> in an on fs section of init.rc?

Initial policy load needs to occur as early as possible so that all
processes and files are properly labeled.  When we looked at this issue
originally, we decided we needed to load policy from the rootfs
(initramfs image) and couldn't even wait until the system partition was
mounted, much less the data partition - too much happens before then.

So the plan is to either setprop selinux.reload_policy 1 (note that the
property name has changed due to AOSP review) as part of the init.rc
post-fs-data section or do the equivalent from SEAndroidManager or some
similar system app (or device admin API implementation in the
system_server).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
