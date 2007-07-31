Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6VJdgkR004694
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 15:39:42 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6VJdgM8000387
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 19:39:42 GMT
From: Paul Moore <paul.moore@hp.com>
To: linux-audit@redhat.com
Subject: New audit record types for static network labels
Date: Tue, 31 Jul 2007 15:37:14 -0400
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707311537.14940.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am currently working on a series of patches to add support for static 
external network labels to NetLabel/SELinux.  The idea is that a user could 
define a physical interface, IP address, address mask, and context which 
would be applied as an external label to the packet when an explicit label 
was not present.  This is similar to other trusted OSs which allow 
administrators to assign labels to single level, unlabeled networks.  For 
those of you following the SELinux list it was discussed a month or two ago.

This is relevant to the audit subsystem because adding/removing these 
address/context entries should most likely be audited for the same reasons we 
audit other NetLabel or XFRM labeling related configuration changes.  To 
accomplish this I would like to suggest the addition of the following record 
types, comments?

#define AUDIT_MAC_UNLBL_STATICADD 14XX  /* NetLabel: add a static label */
#define AUDIT_MAC_UNLBL_STATICDEL 14XX  /* NetLabel: del a static label */

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
