Subject: Re: [Patch 1/3] Loadable policy module infrastructure
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <1117128423.3483.19.camel@localhost>
References: <1117128423.3483.19.camel@localhost>
Content-Type: text/plain
Date: Tue, 31 May 2005 14:00:14 -0400
Message-Id: <1117562414.28924.217.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I assume that these will be addressed by later patches, but not clear
why they were omitted from this patchset:

$ grep FIX 01-module.patch
+        /* FIX ME: do the alternate read here for modules */
+                        /* FIX ME: policy-server will need the SID
+/* FIX ME: do policycon write here */
+                /* FIX ME: write module version here */

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
