Subject: Re: New test program for libselinux/utils that helped with testing
	MLS/Role/Level coding
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40707200718n67a4844dx4a8afc0ff88e5092@mail.gmail.com>
References: <45A68F43.3050101@redhat.com> <469E8622.3070309@gmail.com>
	 <46A0A981.9060703@gmail.com>
	 <cadfc0e40707200718n67a4844dx4a8afc0ff88e5092@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 20 Jul 2007 10:35:07 -0400
Message-Id: <1184942107.17338.804.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-07-20 at 09:18 -0500, Xavier Toth wrote:
> Here's an strace log. A write to /selinux/context is failing, any idea why?

It means the kernel rejected the context as being invalid, e.g. user not
authorized for role, role not authorized for type, user not authorized
for level, or any component not defined in policy.  You can emulate in
userspace via checkpolicy -d -b /etc/selinux/mls/policy/policy.20, and
run that under gdb to step through context_to_sid to see the precise
point at which it fails.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
