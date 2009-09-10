Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8AKMtu6028438
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 16:22:55 -0400
Received: from e35.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8AKOEuO003252
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 20:24:15 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8AKD7fG016136
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 14:13:07 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n8AKMlZk117890
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 14:22:47 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n8AKMk8h028396
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 14:22:47 -0600
Date: Thu, 10 Sep 2009 15:22:48 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Oren Laadan <orenl@cs.columbia.edu>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 1/4] cr: define ckpt_debug if CONFIG_CHECKPOINT=n
Message-ID: <20090910202248.GA7072@us.ibm.com>
References: <20090910202219.GA6778@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090910202219.GA6778@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So not all c/r code has to be ifdefed...

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/linux/checkpoint.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/checkpoint.h b/include/linux/checkpoint.h
index 761cad5..06e3eb0 100644
--- a/include/linux/checkpoint.h
+++ b/include/linux/checkpoint.h
@@ -337,6 +337,9 @@ extern unsigned long ckpt_debug_level;
 
 #endif /* CONFIG_CHECKPOINT_DEBUG */
 
+#else /* CONFIG_CHECKPOINT */
+#define _ckpt_debug(level, fmt, args...)	do { } while (0)
+#define ckpt_debug(fmt, args...)		do { } while (0)
 #endif /* CONFIG_CHECKPOINT */
 #endif /* __KERNEL__ */
 
-- 
1.6.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
