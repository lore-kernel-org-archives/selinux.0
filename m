Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCDA78E68
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RlrtgdbW"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7811d1e68b0so81126585a.2
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197570; x=1703802370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/zy4gq+2FQbNCqcjzKYFx9nwkWmqOWF1W6sZajYv8s=;
        b=RlrtgdbWwByWFki0f8H0AKX/MxQxNp8qkpVPzgXofpIgY83EdyxgU0+N5jF6AKU0gh
         4eUjRHkhP7ERCEnbNzwvf03rHfUTIOTY5crutyb7D5K+z9OnUa5D/yfv9XGWK7Krbva3
         TYylA8LzRlaUl6rYKsu0GWDjIyF75onNHpT8vrO0guEDVzN8jVhx4AidD/q/EyUnpRjO
         IbqUo4i3qE86BOe7wbi7E+DGehnrkHuGR5VFzdmBsiIoKrv5sdRCk2E2fMCto6I8Oxns
         GSUfwkdDogvfG9JdfgVRbBRVvk00G4XK+D2WhD15Z4/LeB/Z3N+XQIs0l8y6npd2a4og
         3wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197570; x=1703802370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/zy4gq+2FQbNCqcjzKYFx9nwkWmqOWF1W6sZajYv8s=;
        b=vAF1tuFGWlCAmJMyQP5P9nnrE2l5l+uT+7PWqnwxbzTz+ezfph4YpHLQIv/NftD72y
         yLe5gM6lCKJszAdX2CtfK1JmA8f5q5UqQxLB2C2GJqzpMUzqMpHOd+2KMUP+jupV5Yr0
         7bDA5QyuZ36NN4VsiIRcjgsz9W2AxKSL2mBKCv+38yMZI+7oQuMGzQsX1oZPvvwmHxYR
         rqk6RpLUQLaRScFRgok4oC0QTRp+NsBNO6/gQrnB5zuX+6o7c5hyi4rmi4/6SbtAWbFu
         2u6AimdfgTfX9GCozV9xHTAWutItz5/+rN3glyEFsFw0GtBkPUyqeKOQYqvbXPf9C16+
         yluw==
X-Gm-Message-State: AOJu0YzSW6MC/HDGoLqQx9it+cojcfhLabw4JZbVASUcB1D+mQuSO+KV
	fkVtLl+6zFNdc1ZfFLKxICCXL+Bg2VV6bVB7Mc8xXTP5eg==
X-Google-Smtp-Source: AGHT+IGPwF+R9NwwdtMoqcUzkFpZtFMA+rAZ2zfGoe/Veh6u1YkiFb3KkmcFPEuxwNZk5LHghj12Jw==
X-Received: by 2002:a05:6214:f63:b0:67a:35e9:3a93 with SMTP id iy3-20020a0562140f6300b0067a35e93a93mr612950qvb.8.1703197570579;
        Thu, 21 Dec 2023 14:26:10 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ez9-20020ad45909000000b0067f53e25d1esm920079qvb.14.2023.12.21.14.26.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:10 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 10/15] selinux: fix style issues in security/selinux/include/objsec.h
Date: Thu, 21 Dec 2023 17:18:53 -0500
Message-ID: <20231221222342.334026-27-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8230; i=paul@paul-moore.com; h=from:subject; bh=HInlRbIUms+h1mQSUOOtLOc/Hxv4K8KaCqHVZpITSDk=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLtN25Ha4zksh8eq65P6OJjYSc5J2oSHbXdmh GmFpHIxkSKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS7TQAKCRDqIPLalzeJ cyuQEADZ/s068qw5Xm1G/mi0MwRcrzWQ812cymSuUcevItTd/0/M5VEv8kwpAROfyBlLyckFjSx Ecv48AZg2IzuPopuE0PDRwNuhSa9tHM0QKBlODNBkQPu4qptnqqg+aH48E8flfEZlFIA//KxaF/ xGYq4MhNkR82bLSkzlmwgRdg+691uwJFnC7vE4RwpyJBtRtEJuqOqhMa39KM+XejPaScCMz7ZKB DaPKd15Yln5RUEGqVNQWzHaM7/4p24uKLhs/J6aO1oTev36HhTy4sP/FLlKK265FMJLA9H6KXrz gGUBR6ckffXR1PMX9Jga8lRoVLkD0PwLnIhNX+C1baVWdCoQtje7y5HuHHY5dHkw0kutuJMdBok v+/PtIdMDutKR9g678gzdWpOoFDh4+PelTEMZkTDtQ2d/1NcBovO9XT9ScRzesGOCuxKQ8K5vQ1 AZ3usQFndTfUMtZEi+Av4EhxSc9Ze2pBC2j90hArHHmYcJPr8QIsXds7aem6KBGlNd9QQ9fGUMn QHwWPRId4D/bUK9bRdKYyDP8mYv6O9jUer2PWoOAUrcWRRN7NhDTHzbKHmgyNM/mET30pRwcBb4 EGV9Um5lxMrtiVErXrORioTqw95+ercYLo8jJ7ZBYME9S/ROTcwC4Ck4w7W8BVJVeB0NjmETz0l iFIYoYeixxJYdAg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/include/objsec.h | 129 +++++++++++++++---------------
 1 file changed, 65 insertions(+), 64 deletions(-)

diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 8159fd53c3de..dea1d6f3ed2d 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -13,6 +13,7 @@
  *  Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *  Copyright (C) 2016 Mellanox Technologies
  */
+
 #ifndef _SELINUX_OBJSEC_H_
 #define _SELINUX_OBJSEC_H_
 
@@ -29,122 +30,122 @@
 #include "avc.h"
 
 struct task_security_struct {
-	u32 osid;		/* SID prior to last execve */
-	u32 sid;		/* current SID */
-	u32 exec_sid;		/* exec SID */
-	u32 create_sid;		/* fscreate SID */
-	u32 keycreate_sid;	/* keycreate SID */
-	u32 sockcreate_sid;	/* fscreate SID */
+	u32 osid; /* SID prior to last execve */
+	u32 sid; /* current SID */
+	u32 exec_sid; /* exec SID */
+	u32 create_sid; /* fscreate SID */
+	u32 keycreate_sid; /* keycreate SID */
+	u32 sockcreate_sid; /* fscreate SID */
 } __randomize_layout;
 
 enum label_initialized {
-	LABEL_INVALID,		/* invalid or not initialized */
-	LABEL_INITIALIZED,	/* initialized */
+	LABEL_INVALID, /* invalid or not initialized */
+	LABEL_INITIALIZED, /* initialized */
 	LABEL_PENDING
 };
 
 struct inode_security_struct {
-	struct inode *inode;	/* back pointer to inode object */
-	struct list_head list;	/* list of inode_security_struct */
-	u32 task_sid;		/* SID of creating task */
-	u32 sid;		/* SID of this object */
-	u16 sclass;		/* security class of this object */
-	unsigned char initialized;	/* initialization flag */
+	struct inode *inode; /* back pointer to inode object */
+	struct list_head list; /* list of inode_security_struct */
+	u32 task_sid; /* SID of creating task */
+	u32 sid; /* SID of this object */
+	u16 sclass; /* security class of this object */
+	unsigned char initialized; /* initialization flag */
 	spinlock_t lock;
 };
 
 struct file_security_struct {
-	u32 sid;		/* SID of open file description */
-	u32 fown_sid;		/* SID of file owner (for SIGIO) */
-	u32 isid;		/* SID of inode at the time of file open */
-	u32 pseqno;		/* Policy seqno at the time of file open */
+	u32 sid; /* SID of open file description */
+	u32 fown_sid; /* SID of file owner (for SIGIO) */
+	u32 isid; /* SID of inode at the time of file open */
+	u32 pseqno; /* Policy seqno at the time of file open */
 };
 
 struct superblock_security_struct {
-	u32 sid;			/* SID of file system superblock */
-	u32 def_sid;			/* default SID for labeling */
-	u32 mntpoint_sid;		/* SECURITY_FS_USE_MNTPOINT context for files */
-	unsigned short behavior;	/* labeling behavior */
-	unsigned short flags;		/* which mount options were specified */
+	u32 sid; /* SID of file system superblock */
+	u32 def_sid; /* default SID for labeling */
+	u32 mntpoint_sid; /* SECURITY_FS_USE_MNTPOINT context for files */
+	unsigned short behavior; /* labeling behavior */
+	unsigned short flags; /* which mount options were specified */
 	struct mutex lock;
 	struct list_head isec_head;
 	spinlock_t isec_lock;
 };
 
 struct msg_security_struct {
-	u32 sid;	/* SID of message */
+	u32 sid; /* SID of message */
 };
 
 struct ipc_security_struct {
-	u16 sclass;	/* security class of this object */
-	u32 sid;	/* SID of IPC resource */
+	u16 sclass; /* security class of this object */
+	u32 sid; /* SID of IPC resource */
 };
 
 struct netif_security_struct {
-	struct net *ns;			/* network namespace */
-	int ifindex;			/* device index */
-	u32 sid;			/* SID for this interface */
+	struct net *ns; /* network namespace */
+	int ifindex; /* device index */
+	u32 sid; /* SID for this interface */
 };
 
 struct netnode_security_struct {
 	union {
-		__be32 ipv4;		/* IPv4 node address */
-		struct in6_addr ipv6;	/* IPv6 node address */
+		__be32 ipv4; /* IPv4 node address */
+		struct in6_addr ipv6; /* IPv6 node address */
 	} addr;
-	u32 sid;			/* SID for this node */
-	u16 family;			/* address family */
+	u32 sid; /* SID for this node */
+	u16 family; /* address family */
 };
 
 struct netport_security_struct {
-	u32 sid;			/* SID for this node */
-	u16 port;			/* port number */
-	u8 protocol;			/* transport protocol */
+	u32 sid; /* SID for this node */
+	u16 port; /* port number */
+	u8 protocol; /* transport protocol */
 };
 
 struct sk_security_struct {
 #ifdef CONFIG_NETLABEL
-	enum {				/* NetLabel state */
-		NLBL_UNSET = 0,
-		NLBL_REQUIRE,
-		NLBL_LABELED,
-		NLBL_REQSKB,
-		NLBL_CONNLABELED,
+	enum { /* NetLabel state */
+	       NLBL_UNSET = 0,
+	       NLBL_REQUIRE,
+	       NLBL_LABELED,
+	       NLBL_REQSKB,
+	       NLBL_CONNLABELED,
 	} nlbl_state;
 	struct netlbl_lsm_secattr *nlbl_secattr; /* NetLabel sec attributes */
 #endif
-	u32 sid;			/* SID of this object */
-	u32 peer_sid;			/* SID of peer */
-	u16 sclass;			/* sock security class */
-	enum {				/* SCTP association state */
-		SCTP_ASSOC_UNSET = 0,
-		SCTP_ASSOC_SET,
+	u32 sid; /* SID of this object */
+	u32 peer_sid; /* SID of peer */
+	u16 sclass; /* sock security class */
+	enum { /* SCTP association state */
+	       SCTP_ASSOC_UNSET = 0,
+	       SCTP_ASSOC_SET,
 	} sctp_assoc_state;
 };
 
 struct tun_security_struct {
-	u32 sid;			/* SID for the tun device sockets */
+	u32 sid; /* SID for the tun device sockets */
 };
 
 struct key_security_struct {
-	u32 sid;	/* SID of key */
+	u32 sid; /* SID of key */
 };
 
 struct ib_security_struct {
-	u32 sid;        /* SID of the queue pair or MAD agent */
+	u32 sid; /* SID of the queue pair or MAD agent */
 };
 
 struct pkey_security_struct {
-	u64	subnet_prefix; /* Port subnet prefix */
-	u16	pkey;	/* PKey number */
-	u32	sid;	/* SID of pkey */
+	u64 subnet_prefix; /* Port subnet prefix */
+	u16 pkey; /* PKey number */
+	u32 sid; /* SID of pkey */
 };
 
 struct bpf_security_struct {
-	u32 sid;  /* SID of bpf obj creator */
+	u32 sid; /* SID of bpf obj creator */
 };
 
 struct perf_event_security_struct {
-	u32 sid;  /* SID of perf_event obj creator */
+	u32 sid; /* SID of perf_event obj creator */
 };
 
 extern struct lsm_blob_sizes selinux_blob_sizes;
@@ -158,22 +159,22 @@ static inline struct file_security_struct *selinux_file(const struct file *file)
 	return file->f_security + selinux_blob_sizes.lbs_file;
 }
 
-static inline struct inode_security_struct *selinux_inode(
-						const struct inode *inode)
+static inline struct inode_security_struct *
+selinux_inode(const struct inode *inode)
 {
 	if (unlikely(!inode->i_security))
 		return NULL;
 	return inode->i_security + selinux_blob_sizes.lbs_inode;
 }
 
-static inline struct msg_security_struct *selinux_msg_msg(
-						const struct msg_msg *msg_msg)
+static inline struct msg_security_struct *
+selinux_msg_msg(const struct msg_msg *msg_msg)
 {
 	return msg_msg->security + selinux_blob_sizes.lbs_msg_msg;
 }
 
-static inline struct ipc_security_struct *selinux_ipc(
-						const struct kern_ipc_perm *ipc)
+static inline struct ipc_security_struct *
+selinux_ipc(const struct kern_ipc_perm *ipc)
 {
 	return ipc->security + selinux_blob_sizes.lbs_ipc;
 }
@@ -188,8 +189,8 @@ static inline u32 current_sid(void)
 	return tsec->sid;
 }
 
-static inline struct superblock_security_struct *selinux_superblock(
-					const struct super_block *superblock)
+static inline struct superblock_security_struct *
+selinux_superblock(const struct super_block *superblock)
 {
 	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
 }
-- 
2.43.0

