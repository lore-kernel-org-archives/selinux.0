Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAUL4YIi021074
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 16:04:35 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAUL4boh022266
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 21:04:37 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
In-Reply-To: <1101839242.4401.85.camel@moss-spartans.epoch.ncsc.mil>
References: <4182959B.4080503@trustedcs.com>
	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
	 <20041112184232.GK15243@golconda.mitre.org>
	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>
	 <nhau0rm54ra.fsf@malabar.mitre.org>
	 <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>
	 <419E1F76.9080803@trustedcs.com>
	 <1100884644.15944.181.camel@moss-spartans.epoch.ncsc.mil>
	 <41A4A921.9060105@trustedcs.com>
	 <1101310307.22014.148.camel@moss-spartans.epoch.ncsc.mil>
	 <41AB383B.3020006@trustedcs.com>
	 <1101763456.2630.67.camel@moss-spartans.epoch.ncsc.mil>
	 <41ABB3C2.2090809@trustedcs.com>
	 <1101819480.4401.9.camel@moss-spartans.epoch.ncsc.mil>
	 <41AC8E57.9000103@trustedcs.com>
	 <1101830525.4401.67.camel@moss-spartans.epoch.ncsc.mil>
	 <1101839242.4401.85.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1101848406.4401.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 30 Nov 2004 16:00:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-30 at 13:27, Stephen Smalley wrote:
> I've committed the dynamic context transition support to our tree
> (changes to linux-2.6, libselinux, and policy).  It should be available
> in the sourceforge CVS tree soon (but the read-only mirrors take time to
> sync with the master).  The final version of the kernel patch is
> attached for reference.  We'll look into getting the kernel patch
> upstreamed after 2.6.10 is released.  Thanks.

I extended the setcon() comment in selinux.h, added documentation for
setcon() to the getcon.3 man page and added a reference for setcon.3. 
Description is:

<snip>
setcon sets the current security context of the process to a new value. 
Note that use of this function requires that the entire application be
trusted to maintain any desired separation between the old and new
security contexts, unlike exec-based transitions performed via
setexeccon(3).  When possible, decompose your applicaiton and use
setexeccon() and execve() instead.

Since access to file descriptors is revalidated upon use by SELinux, the
new context must be explicitly authorized in the policy to use the
descriptors opened by the old context if that is desired.  Otherwise,
attempts by the process to use any existing descriptors (including
stdin, stdout, and stderr) after performing the setcon() will fail.

A multi-threaded application can perform a setcon() prior to creating
any child threads, in which case all of the child threads will inherit
the new context.  However, setcon() will fail if there are any other
threads running in the same process.

If the process was being ptraced at the time of the setcon() operation,
ptrace permission will be revalidated against the new context and the
setcon() will fail if it is not allowed by policy.
<snip>

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
