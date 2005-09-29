Subject: Re: getseuserbyname patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <433BEB18.7000703@redhat.com>
References: <43398EB2.1050100@redhat.com>
	 <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>
	 <433BEB18.7000703@redhat.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 09:35:16 -0400
Message-Id: <1128000916.27495.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-29 at 09:24 -0400, Daniel J Walsh wrote:
> Is s0:c1-s0:c2  a valid range?  Is s0:c1-s0:c1,c2 implied or required?

No, the first one is not valid.  You have to explicitly specify the
latter (s0:c1-s0:c1,c2) or the kernel will reject it because the high
won't dominate the low and the high does not implicitly inherit
categories from the low.

> Can this range read/write s0 files in MCS?  MLS?

>From the constraint definitions in the MCS policy, it appears that MCS
would allow such a process to read/write s0 files, because its high
level dominates the file level.  But I would never expect such a process
to exist under MCS, as MCS wants processes to run with a low level of s0
at all times so that any files they create default to s0 as well.

For MLS, such a process could read a s0 file (since it dominates the
file level), but could not write a s0 file (because of the "no write
down" restriction, to prevent leaking the category data to s0).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
