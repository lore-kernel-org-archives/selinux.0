Subject: Re: [PATCH] Dropping compat support for /etc/security policy file
	paths
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <946736.41505.qm@web51509.mail.yahoo.com>
References: <946736.41505.qm@web51509.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 07:54:45 -0500
Message-Id: <1173358485.10467.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-03-07 at 14:27 -0800, Steve G wrote:
> >Are any active distributions still using the old /etc/security/ location
> >and layout for SELinux policy files?  If not, we could drop the compat
> >file path support from libselinux on the trunk.
> 
> Here's a patch dropping support.

diff -urpN libselinux-2.0.4.orig/src/selinux_config.c libselinux-2.0.4/src/selinux_config.c
--- libselinux-2.0.4.orig/src/selinux_config.c	2007-02-25 14:52:16.000000000 -0500
+++ libselinux-2.0.4/src/selinux_config.c	2007-03-07 15:15:50.000000000 -0500
@@ -10,6 +10,7 @@
 #include "selinux_internal.h"
 #include "get_default_type_internal.h"
 
+#define SECURITYCONFIG "/etc/sysconfig/selinux"

I think we can drop this altogether, along with the use of it - it too
reflects the legacy locations (/etc/sysconfig/selinux
vs. /etc/selinux/config).  On modern distros, if they have
an /etc/sysconfig/selinux at all, it is a symlink
to /etc/selinux/config.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
