Subject: Re: policy directory structure - Debian and Tresys tools
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Roger Brunell <rog_brunell@yahoo.com>
Cc: SELinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <20050512175506.46422.qmail@web60413.mail.yahoo.com>
References: <20050512175506.46422.qmail@web60413.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 12 May 2005 14:27:29 -0400
Message-Id: <1115922449.32202.171.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-05-12 at 10:55 -0700, Roger Brunell wrote:
> As a follow-on to a prior comment; I am trying to
> build the Tresys "SELinux Tools (setools), version
> 2.0" on a Knoppix 3.8.1 (Debian derived) system. I
> already have the selinux running with the default
> strict policy. I want to now start exploring what is
> in a policy.
> 
> It (the Tresys package) appears to have a different
> idea of where a policy is located, compiled into one
> of the tools; than where the policy actually ends up .
> And they are both from the same website.
> 
> -------
> root@lppda:/p/selinux/nsa/setools-2.0# make
> cd libapol; make libapol libapolso
> make[1]: Entering directory
> `/p/selinux/nsa/setools-2.0/libapol'
> cc -Wall -O2 -fPIC   -DLIBSELINUX -DLIBSEFS
> -DLIBAPOL_VERSION_STRING='"2.0"'
> -DAPOL_INSTALL_DIR='"/usr/share/setools"'
> -DLIBAPOL_POLICY_INSTALL_DIR='"/etc/security/selinux"'
> -DLIBAPOL_SELINUX_DIR='"/selinux"'
> -DLIBAPOL_DEFAULT_POLICY='"/etc/security/selinux/src/policy/policy.conf"'
> -I. -o cond.o -c cond.c
> cond.c:20:28: sys/capability.h: No such file or
> directory
> make[1]: *** [cond.o] Error 1
> make[1]: Leaving directory
> `/p/selinux/nsa/setools-2.0/libapol'
> -----
> I think that is expecting the default policy path to
> be  under '/etc/security/selinux'.
> 
> I haven't investigated the missing include yet.

The policy directory was moved and reorganized when the multiple policy
support was introduced in Fedora Core 3; libselinux supports either
location/structure, and some distros may be using the old location still
(e.g. Hardened Gentoo was for a while I think).  setools should be able
to find the active policy file using libselinux rather than hardcoding
any paths, and it looks like setools does so unless you disable
USE_LIBSELINUX in the Makefile for building on a non-SELinux system, so
I'm not sure whether these definitions are even used in the default
build.  Looks like the Fedora package by Dan Walsh does patch the
Makefile to adjust the definitions; not sure if that is necessary.  I've
cc'd the Tresys team since they developed and maintain setools; we only
include a copy with our releases on nsa.gov as a convenience to users.
Manoj Srivastava has packaged setools for Debian previously; looks like
2.1.0 isn't packaged for Debian yet though.

Not sure about the sys/capability.h issue, as I don't see where it is
included by the setools code directly.  On Fedora, it is provided by
libcap-devel, but I don't know why there would be a dependency.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
