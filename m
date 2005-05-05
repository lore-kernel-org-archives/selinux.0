Subject: Re: attributes on the other end of a network connection
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kodungallur Varma <ramgwu@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <fa8ec5d805050408307808096b@mail.gmail.com>
References: <fa8ec5d80503082008161e5619@mail.gmail.com>
	 <20050309084655.GC5236@thorium.jmh.mhn.de>
	 <fa8ec5d805031118353197f745@mail.gmail.com>
	 <1110812772.21378.79.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d8050328195571c9d4fc@mail.gmail.com>
	 <1112107028.4339.34.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d8050329194145add881@mail.gmail.com>
	 <1112186117.8012.5.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d805041919096c4391a0@mail.gmail.com>
	 <1113999576.1028.41.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d805050408307808096b@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 05 May 2005 07:28:12 -0400
Message-Id: <1115292492.8428.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-05-04 at 11:30 -0400, Kodungallur Varma wrote:
> Hi Stephen and all,
> 
>          is there any way to determine if a particular operation is
> permitted given a security identifier (security_context_t)? basically
> I want a function or a way to determine if any process/user in the
> domain returned by the getpeercon() is allowed to do an operation, say
> socket connect for example.

Yes.  There are two interfaces for doing this:
1) avc_has_perm(3).  This performs permission checks based on SIDs
(obtained via avc_context_to_sid(3)) and caches the results for
subsequent permission checks.   You need to invoke avc_init(3) to
perform initial setup.  These functions are part of the interface to the
userspace AVC (access vector cache), which is the userspace equivalent
to the kernel AVC used by the SELinux module for its permission
checking.  The userspace AVC is discussed in the selinux-doc/uavc
report.  See dbus for an example of using this interface.
2) security_compute_av(3).  This is the lower level interface for
computing an access vector (set of permissions) based on contexts,
without any caching of decisions.  It requires no setup to use, and may
be simpler if you don't need caching of the decisions for performance.
Internally, avc_has_perm(3) ends up calling this interface if the
decision is not already in the cache.  Example callers include:
- libselinux/src/checkAccess.c
- libselinux/utils/compute_av.c
- SELinux patch for cron

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
