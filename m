Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9IKgfRw015879
	for <selinux@tycho.nsa.gov>; Wed, 18 Oct 2006 16:42:41 -0400
Subject: ANN:  Updated SELinux Release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1142456354.4933.121.camel@moss-spartans.epoch.ncsc.mil>
References: <1142456354.4933.121.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 16:43:22 -0400
Message-Id: <1161204202.14632.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An updated SELinux release is available from the NSA SELinux web site;
see:
http://www.nsa.gov/selinux/news.cfm#R061018

The policy toolchain includes fixed support for optionals in the base
module, extended range transition support (policy.21), and proper
support for MLS constructs in modules.  libselinux includes direct
client-side support for context translation via an external translation
daemon (vs. the older approach of dlopen'ing libsetrans if present) and
new interfaces for accessing the keycreate and sockcreate attributes.
libsemanage includes the file context sorting code based on the
reference policy fc_sort helper, and now keeps file_contexts.local
separate so that it is properly prioritized by libselinux.  libsepol,
libsemanage and policycoreutils also include preliminary
netfilter_contexts support, although the details may still be subject to
change.  policycoreutils includes the secon utility for displaying
contexts and their components, the restorecond daemon, and the
semodule_deps utility for displaying module dependencies.  Numerous bug
fixes have been merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
