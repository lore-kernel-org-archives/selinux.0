Subject: Re: [Patch 1/3] Loadable policy module infrastructure
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <1117128423.3483.19.camel@localhost>
References: <1117128423.3483.19.camel@localhost>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 08:33:48 -0400
Message-Id: <1118320428.30110.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The call to sepol_set_policyvers() in sepol_genusers() passes the
arguments in the wrong order, thereby ending up with an invalid policy
version, which causes a failure upon the attempt to generate the new
binary policy image.  This breaks load_policy and /sbin/init in FC4 (to
be precise, it prevents proper loading of local user definitions).

Unrelated note:  While the diff -b reduces the "noise" in the patch, it
also leads to inappropriate indentation in the resulting code because
you don't end up adjusting indentation when it is appropriate to do so
due to your code modifications.  So you should just diff normally and
review the resulting diff.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
