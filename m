Subject: Re: Java Policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <4203C18F.8030609@redhat.com>
References: <4203B048.5070607@redhat.com>
	 <1107538571.8078.98.camel@moss-spartans.epoch.ncsc.mil>
	 <4203C18F.8030609@redhat.com>
Content-Type: text/plain
Message-Id: <1107543502.8078.136.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Feb 2005 13:58:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-04 at 13:40, Daniel J Walsh wrote:
> Well I don't think of this policy as a legacy binary  (Not that I would 
> know what that means, I don't think
> of Java as being legacy).  My goal was to create something for the java 
> plugin not the java runtime.

"legacy" binary == lacks PT_GNU_STACK header, i.e. built with an old
toolchain.  They cause the kernel to automatically start translating all
read protection requests to read|execute for backward compatibility on
x86.  They will all need execmem and execmod, including execmod to
shlib_t and ld_so_t unlike non-legacy binaries.
This does apply to more than just the java plugin, so if you make it
java-specific, you'll end up making more of these little domains down
the road.

> I don't know if I agree with that.  I know people who say they refuse to 
> run any code that allows
> execmem/execmod.  If you don't have the global boolean you could 
> accidently run them.

Those people wouldn't have these binaries installed.  But you could
provide both a global boolean that disables all occurrences as well as
finer-grained ones and use compound boolean expressions, e.g.

	if (allow_execmod && allow_legacy_execmod) {
		...
	}
	if (allow_execmod && allow_xserver_execmod) {
		...
	}
	if (allow_execmod && allow_user_execmod) {
		...
	}

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
