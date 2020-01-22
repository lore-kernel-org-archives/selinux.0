Return-Path: <SRS0=wfQh=3L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479A2C33CB6
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A372465B
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 15:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U37Ga25A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAVPrE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:47:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20398 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725868AbgAVPrE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jan 2020 10:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579708022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJD9KK2G0X/amXefpzPuZ1hfpfBQvveBFoJkaAkQiXg=;
        b=U37Ga25A3PtkdUG2f8czQhSKnQn8I+kJEG22qiF/c7BNclmhP2Xfj3BPsYuYYrxGgGjQQy
        0THNqGoJhW1uSOO0XmsnH7P319RhJErOV59gDe81j+zt9YBGGDo6BbJLpSqLaz46J6Hia2
        Riq3AQEpfnVQ5nR1D/SdTbaGrM6/Uio=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-ssXJPFFSNsC9UVKFtXpupg-1; Wed, 22 Jan 2020 10:47:00 -0500
X-MC-Unique: ssXJPFFSNsC9UVKFtXpupg-1
Received: by mail-wm1-f72.google.com with SMTP id g26so1559249wmk.6
        for <selinux@vger.kernel.org>; Wed, 22 Jan 2020 07:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJD9KK2G0X/amXefpzPuZ1hfpfBQvveBFoJkaAkQiXg=;
        b=iFhfsbkQTTfH9t6ZYcI2PaQV3MuDdtfQwDB8klgRVAum92Gg0XORWyRdF4cGhrQET6
         zv6fcESe1mGu0taTRBEYqZtMyY7c28gxQGWRaECYa5h/lfHuXd8sB6Egf5vrYl4/BgiL
         4/JTU7UljObr5RbVT3gRaDXegdv1rd2jNh+0vqZVv0dOn3x1oUNqBTE9Dc06cGAScKDA
         6zTUc8mYMq863iok2SpWYVUq79gVWdCwSihvSJzkPWP0aNBsZRLYyMPapv2evrLaq+31
         rtq0s/4aU78iky/mV44qNOf6+iUmO5e7IJhJntpYXPgh6WtUeSvcxr4rur7LOAIqCFEP
         bUUA==
X-Gm-Message-State: APjAAAVupFPhnFrTRYbDCsMF7Gvj7UvesE86SDA0RYT5CGLkS+MSUhIG
        0/KE7opYrd+eszT8+97TSsgrhb9QGsj3E29zstcHOOpJF/SNb8+VJMot1UjSO6Vc6mgkqYzmLK5
        FNQSFQQBGpPO96gWa6A==
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr3542836wmk.97.1579708018829;
        Wed, 22 Jan 2020 07:46:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4GwjhWzfyczFeaxNuNpeotLSkGwjWMiRUhzTYAkHw2isp8uN9m57W7mQ3pjqDM64JvSA3jg==
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr3542813wmk.97.1579708018512;
        Wed, 22 Jan 2020 07:46:58 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c5sm4811788wmb.9.2020.01.22.07.46.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 07:46:58 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 1/4] libsepol: fix CIL_KEY_* build errors with -fno-common
Date:   Wed, 22 Jan 2020 16:46:52 +0100
Message-Id: <20200122154655.257233-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122154655.257233-1-omosnace@redhat.com>
References: <20200122154655.257233-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

GCC 10 comes with -fno-common enabled by default - fix the CIL_KEY_*
global variables to be defined only once in cil.c and declared in the
header file correctly with the 'extern' keyword, so that other units
including the file don't generate duplicate definitions.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/cil/src/cil.c          | 162 ++++++++++++++++
 libsepol/cil/src/cil_internal.h | 322 ++++++++++++++++----------------
 2 files changed, 323 insertions(+), 161 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index de729cf8..d222ad3a 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -77,6 +77,168 @@ int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
 	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
 };
 
+char *CIL_KEY_CONS_T1;
+char *CIL_KEY_CONS_T2;
+char *CIL_KEY_CONS_T3;
+char *CIL_KEY_CONS_R1;
+char *CIL_KEY_CONS_R2;
+char *CIL_KEY_CONS_R3;
+char *CIL_KEY_CONS_U1;
+char *CIL_KEY_CONS_U2;
+char *CIL_KEY_CONS_U3;
+char *CIL_KEY_CONS_L1;
+char *CIL_KEY_CONS_L2;
+char *CIL_KEY_CONS_H1;
+char *CIL_KEY_CONS_H2;
+char *CIL_KEY_AND;
+char *CIL_KEY_OR;
+char *CIL_KEY_NOT;
+char *CIL_KEY_EQ;
+char *CIL_KEY_NEQ;
+char *CIL_KEY_CONS_DOM;
+char *CIL_KEY_CONS_DOMBY;
+char *CIL_KEY_CONS_INCOMP;
+char *CIL_KEY_CONDTRUE;
+char *CIL_KEY_CONDFALSE;
+char *CIL_KEY_SELF;
+char *CIL_KEY_OBJECT_R;
+char *CIL_KEY_STAR;
+char *CIL_KEY_TCP;
+char *CIL_KEY_UDP;
+char *CIL_KEY_DCCP;
+char *CIL_KEY_SCTP;
+char *CIL_KEY_AUDITALLOW;
+char *CIL_KEY_TUNABLEIF;
+char *CIL_KEY_ALLOW;
+char *CIL_KEY_DONTAUDIT;
+char *CIL_KEY_TYPETRANSITION;
+char *CIL_KEY_TYPECHANGE;
+char *CIL_KEY_CALL;
+char *CIL_KEY_TUNABLE;
+char *CIL_KEY_XOR;
+char *CIL_KEY_ALL;
+char *CIL_KEY_RANGE;
+char *CIL_KEY_GLOB;
+char *CIL_KEY_FILE;
+char *CIL_KEY_DIR;
+char *CIL_KEY_CHAR;
+char *CIL_KEY_BLOCK;
+char *CIL_KEY_SOCKET;
+char *CIL_KEY_PIPE;
+char *CIL_KEY_SYMLINK;
+char *CIL_KEY_ANY;
+char *CIL_KEY_XATTR;
+char *CIL_KEY_TASK;
+char *CIL_KEY_TRANS;
+char *CIL_KEY_TYPE;
+char *CIL_KEY_ROLE;
+char *CIL_KEY_USER;
+char *CIL_KEY_USERATTRIBUTE;
+char *CIL_KEY_USERATTRIBUTESET;
+char *CIL_KEY_SENSITIVITY;
+char *CIL_KEY_CATEGORY;
+char *CIL_KEY_CATSET;
+char *CIL_KEY_LEVEL;
+char *CIL_KEY_LEVELRANGE;
+char *CIL_KEY_CLASS;
+char *CIL_KEY_IPADDR;
+char *CIL_KEY_MAP_CLASS;
+char *CIL_KEY_CLASSPERMISSION;
+char *CIL_KEY_BOOL;
+char *CIL_KEY_STRING;
+char *CIL_KEY_NAME;
+char *CIL_KEY_SOURCE;
+char *CIL_KEY_TARGET;
+char *CIL_KEY_LOW;
+char *CIL_KEY_HIGH;
+char *CIL_KEY_LOW_HIGH;
+char *CIL_KEY_GLBLUB;
+char *CIL_KEY_HANDLEUNKNOWN;
+char *CIL_KEY_HANDLEUNKNOWN_ALLOW;
+char *CIL_KEY_HANDLEUNKNOWN_DENY;
+char *CIL_KEY_HANDLEUNKNOWN_REJECT;
+char *CIL_KEY_MACRO;
+char *CIL_KEY_IN;
+char *CIL_KEY_MLS;
+char *CIL_KEY_DEFAULTRANGE;
+char *CIL_KEY_BLOCKINHERIT;
+char *CIL_KEY_BLOCKABSTRACT;
+char *CIL_KEY_CLASSORDER;
+char *CIL_KEY_CLASSMAPPING;
+char *CIL_KEY_CLASSPERMISSIONSET;
+char *CIL_KEY_COMMON;
+char *CIL_KEY_CLASSCOMMON;
+char *CIL_KEY_SID;
+char *CIL_KEY_SIDCONTEXT;
+char *CIL_KEY_SIDORDER;
+char *CIL_KEY_USERLEVEL;
+char *CIL_KEY_USERRANGE;
+char *CIL_KEY_USERBOUNDS;
+char *CIL_KEY_USERPREFIX;
+char *CIL_KEY_SELINUXUSER;
+char *CIL_KEY_SELINUXUSERDEFAULT;
+char *CIL_KEY_TYPEATTRIBUTE;
+char *CIL_KEY_TYPEATTRIBUTESET;
+char *CIL_KEY_EXPANDTYPEATTRIBUTE;
+char *CIL_KEY_TYPEALIAS;
+char *CIL_KEY_TYPEALIASACTUAL;
+char *CIL_KEY_TYPEBOUNDS;
+char *CIL_KEY_TYPEPERMISSIVE;
+char *CIL_KEY_RANGETRANSITION;
+char *CIL_KEY_USERROLE;
+char *CIL_KEY_ROLETYPE;
+char *CIL_KEY_ROLETRANSITION;
+char *CIL_KEY_ROLEALLOW;
+char *CIL_KEY_ROLEATTRIBUTE;
+char *CIL_KEY_ROLEATTRIBUTESET;
+char *CIL_KEY_ROLEBOUNDS;
+char *CIL_KEY_BOOLEANIF;
+char *CIL_KEY_NEVERALLOW;
+char *CIL_KEY_TYPEMEMBER;
+char *CIL_KEY_SENSALIAS;
+char *CIL_KEY_SENSALIASACTUAL;
+char *CIL_KEY_CATALIAS;
+char *CIL_KEY_CATALIASACTUAL;
+char *CIL_KEY_CATORDER;
+char *CIL_KEY_SENSITIVITYORDER;
+char *CIL_KEY_SENSCAT;
+char *CIL_KEY_CONSTRAIN;
+char *CIL_KEY_MLSCONSTRAIN;
+char *CIL_KEY_VALIDATETRANS;
+char *CIL_KEY_MLSVALIDATETRANS;
+char *CIL_KEY_CONTEXT;
+char *CIL_KEY_FILECON;
+char *CIL_KEY_IBPKEYCON;
+char *CIL_KEY_IBENDPORTCON;
+char *CIL_KEY_PORTCON;
+char *CIL_KEY_NODECON;
+char *CIL_KEY_GENFSCON;
+char *CIL_KEY_NETIFCON;
+char *CIL_KEY_PIRQCON;
+char *CIL_KEY_IOMEMCON;
+char *CIL_KEY_IOPORTCON;
+char *CIL_KEY_PCIDEVICECON;
+char *CIL_KEY_DEVICETREECON;
+char *CIL_KEY_FSUSE;
+char *CIL_KEY_POLICYCAP;
+char *CIL_KEY_OPTIONAL;
+char *CIL_KEY_DEFAULTUSER;
+char *CIL_KEY_DEFAULTROLE;
+char *CIL_KEY_DEFAULTTYPE;
+char *CIL_KEY_ROOT;
+char *CIL_KEY_NODE;
+char *CIL_KEY_PERM;
+char *CIL_KEY_ALLOWX;
+char *CIL_KEY_AUDITALLOWX;
+char *CIL_KEY_DONTAUDITX;
+char *CIL_KEY_NEVERALLOWX;
+char *CIL_KEY_PERMISSIONX;
+char *CIL_KEY_IOCTL;
+char *CIL_KEY_UNORDERED;
+char *CIL_KEY_SRC_INFO;
+char *CIL_KEY_SRC_CIL;
+char *CIL_KEY_SRC_HLL;
+
 static void cil_init_keys(void)
 {
 	/* Initialize CIL Keys into strpool */
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 30fab649..9bdcbdd0 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -74,167 +74,167 @@ enum cil_pass {
 /*
 	Keywords
 */
-char *CIL_KEY_CONS_T1;
-char *CIL_KEY_CONS_T2;
-char *CIL_KEY_CONS_T3;
-char *CIL_KEY_CONS_R1;
-char *CIL_KEY_CONS_R2;
-char *CIL_KEY_CONS_R3;
-char *CIL_KEY_CONS_U1;
-char *CIL_KEY_CONS_U2;
-char *CIL_KEY_CONS_U3;
-char *CIL_KEY_CONS_L1;
-char *CIL_KEY_CONS_L2;
-char *CIL_KEY_CONS_H1;
-char *CIL_KEY_CONS_H2;
-char *CIL_KEY_AND;
-char *CIL_KEY_OR;
-char *CIL_KEY_NOT;
-char *CIL_KEY_EQ;
-char *CIL_KEY_NEQ;
-char *CIL_KEY_CONS_DOM;
-char *CIL_KEY_CONS_DOMBY;
-char *CIL_KEY_CONS_INCOMP;
-char *CIL_KEY_CONDTRUE;
-char *CIL_KEY_CONDFALSE;
-char *CIL_KEY_SELF;
-char *CIL_KEY_OBJECT_R;
-char *CIL_KEY_STAR;
-char *CIL_KEY_TCP;
-char *CIL_KEY_UDP;
-char *CIL_KEY_DCCP;
-char *CIL_KEY_SCTP;
-char *CIL_KEY_AUDITALLOW;
-char *CIL_KEY_TUNABLEIF;
-char *CIL_KEY_ALLOW;
-char *CIL_KEY_DONTAUDIT;
-char *CIL_KEY_TYPETRANSITION;
-char *CIL_KEY_TYPECHANGE;
-char *CIL_KEY_CALL;
-char *CIL_KEY_TUNABLE;
-char *CIL_KEY_XOR;
-char *CIL_KEY_ALL;
-char *CIL_KEY_RANGE;
-char *CIL_KEY_GLOB;
-char *CIL_KEY_FILE;
-char *CIL_KEY_DIR;
-char *CIL_KEY_CHAR;
-char *CIL_KEY_BLOCK;
-char *CIL_KEY_SOCKET;
-char *CIL_KEY_PIPE;
-char *CIL_KEY_SYMLINK;
-char *CIL_KEY_ANY;
-char *CIL_KEY_XATTR;
-char *CIL_KEY_TASK;
-char *CIL_KEY_TRANS;
-char *CIL_KEY_TYPE;
-char *CIL_KEY_ROLE;
-char *CIL_KEY_USER;
-char *CIL_KEY_USERATTRIBUTE;
-char *CIL_KEY_USERATTRIBUTESET;
-char *CIL_KEY_SENSITIVITY;
-char *CIL_KEY_CATEGORY;
-char *CIL_KEY_CATSET;
-char *CIL_KEY_LEVEL;
-char *CIL_KEY_LEVELRANGE;
-char *CIL_KEY_CLASS;
-char *CIL_KEY_IPADDR;
-char *CIL_KEY_MAP_CLASS;
-char *CIL_KEY_CLASSPERMISSION;
-char *CIL_KEY_BOOL;
-char *CIL_KEY_STRING;
-char *CIL_KEY_NAME;
-char *CIL_KEY_SOURCE;
-char *CIL_KEY_TARGET;
-char *CIL_KEY_LOW;
-char *CIL_KEY_HIGH;
-char *CIL_KEY_LOW_HIGH;
-char *CIL_KEY_GLBLUB;
-char *CIL_KEY_HANDLEUNKNOWN;
-char *CIL_KEY_HANDLEUNKNOWN_ALLOW;
-char *CIL_KEY_HANDLEUNKNOWN_DENY;
-char *CIL_KEY_HANDLEUNKNOWN_REJECT;
-char *CIL_KEY_MACRO;
-char *CIL_KEY_IN;
-char *CIL_KEY_MLS;
-char *CIL_KEY_DEFAULTRANGE;
-char *CIL_KEY_BLOCKINHERIT;
-char *CIL_KEY_BLOCKABSTRACT;
-char *CIL_KEY_CLASSORDER;
-char *CIL_KEY_CLASSMAPPING;
-char *CIL_KEY_CLASSPERMISSIONSET;
-char *CIL_KEY_COMMON;
-char *CIL_KEY_CLASSCOMMON;
-char *CIL_KEY_SID;
-char *CIL_KEY_SIDCONTEXT;
-char *CIL_KEY_SIDORDER;
-char *CIL_KEY_USERLEVEL;
-char *CIL_KEY_USERRANGE;
-char *CIL_KEY_USERBOUNDS;
-char *CIL_KEY_USERPREFIX;
-char *CIL_KEY_SELINUXUSER;
-char *CIL_KEY_SELINUXUSERDEFAULT;
-char *CIL_KEY_TYPEATTRIBUTE;
-char *CIL_KEY_TYPEATTRIBUTESET;
-char *CIL_KEY_EXPANDTYPEATTRIBUTE;
-char *CIL_KEY_TYPEALIAS;
-char *CIL_KEY_TYPEALIASACTUAL;
-char *CIL_KEY_TYPEBOUNDS;
-char *CIL_KEY_TYPEPERMISSIVE;
-char *CIL_KEY_RANGETRANSITION;
-char *CIL_KEY_USERROLE;
-char *CIL_KEY_ROLETYPE;
-char *CIL_KEY_ROLETRANSITION;
-char *CIL_KEY_ROLEALLOW;
-char *CIL_KEY_ROLEATTRIBUTE;
-char *CIL_KEY_ROLEATTRIBUTESET;
-char *CIL_KEY_ROLEBOUNDS;
-char *CIL_KEY_BOOLEANIF;
-char *CIL_KEY_NEVERALLOW;
-char *CIL_KEY_TYPEMEMBER;
-char *CIL_KEY_SENSALIAS;
-char *CIL_KEY_SENSALIASACTUAL;
-char *CIL_KEY_CATALIAS;
-char *CIL_KEY_CATALIASACTUAL;
-char *CIL_KEY_CATORDER;
-char *CIL_KEY_SENSITIVITYORDER;
-char *CIL_KEY_SENSCAT;
-char *CIL_KEY_CONSTRAIN;
-char *CIL_KEY_MLSCONSTRAIN;
-char *CIL_KEY_VALIDATETRANS;
-char *CIL_KEY_MLSVALIDATETRANS;
-char *CIL_KEY_CONTEXT;
-char *CIL_KEY_FILECON;
-char *CIL_KEY_IBPKEYCON;
-char *CIL_KEY_IBENDPORTCON;
-char *CIL_KEY_PORTCON;
-char *CIL_KEY_NODECON;
-char *CIL_KEY_GENFSCON;
-char *CIL_KEY_NETIFCON;
-char *CIL_KEY_PIRQCON;
-char *CIL_KEY_IOMEMCON;
-char *CIL_KEY_IOPORTCON;
-char *CIL_KEY_PCIDEVICECON;
-char *CIL_KEY_DEVICETREECON;
-char *CIL_KEY_FSUSE;
-char *CIL_KEY_POLICYCAP;
-char *CIL_KEY_OPTIONAL;
-char *CIL_KEY_DEFAULTUSER;
-char *CIL_KEY_DEFAULTROLE;
-char *CIL_KEY_DEFAULTTYPE;
-char *CIL_KEY_ROOT;
-char *CIL_KEY_NODE;
-char *CIL_KEY_PERM;
-char *CIL_KEY_ALLOWX;
-char *CIL_KEY_AUDITALLOWX;
-char *CIL_KEY_DONTAUDITX;
-char *CIL_KEY_NEVERALLOWX;
-char *CIL_KEY_PERMISSIONX;
-char *CIL_KEY_IOCTL;
-char *CIL_KEY_UNORDERED;
-char *CIL_KEY_SRC_INFO;
-char *CIL_KEY_SRC_CIL;
-char *CIL_KEY_SRC_HLL;
+extern char *CIL_KEY_CONS_T1;
+extern char *CIL_KEY_CONS_T2;
+extern char *CIL_KEY_CONS_T3;
+extern char *CIL_KEY_CONS_R1;
+extern char *CIL_KEY_CONS_R2;
+extern char *CIL_KEY_CONS_R3;
+extern char *CIL_KEY_CONS_U1;
+extern char *CIL_KEY_CONS_U2;
+extern char *CIL_KEY_CONS_U3;
+extern char *CIL_KEY_CONS_L1;
+extern char *CIL_KEY_CONS_L2;
+extern char *CIL_KEY_CONS_H1;
+extern char *CIL_KEY_CONS_H2;
+extern char *CIL_KEY_AND;
+extern char *CIL_KEY_OR;
+extern char *CIL_KEY_NOT;
+extern char *CIL_KEY_EQ;
+extern char *CIL_KEY_NEQ;
+extern char *CIL_KEY_CONS_DOM;
+extern char *CIL_KEY_CONS_DOMBY;
+extern char *CIL_KEY_CONS_INCOMP;
+extern char *CIL_KEY_CONDTRUE;
+extern char *CIL_KEY_CONDFALSE;
+extern char *CIL_KEY_SELF;
+extern char *CIL_KEY_OBJECT_R;
+extern char *CIL_KEY_STAR;
+extern char *CIL_KEY_TCP;
+extern char *CIL_KEY_UDP;
+extern char *CIL_KEY_DCCP;
+extern char *CIL_KEY_SCTP;
+extern char *CIL_KEY_AUDITALLOW;
+extern char *CIL_KEY_TUNABLEIF;
+extern char *CIL_KEY_ALLOW;
+extern char *CIL_KEY_DONTAUDIT;
+extern char *CIL_KEY_TYPETRANSITION;
+extern char *CIL_KEY_TYPECHANGE;
+extern char *CIL_KEY_CALL;
+extern char *CIL_KEY_TUNABLE;
+extern char *CIL_KEY_XOR;
+extern char *CIL_KEY_ALL;
+extern char *CIL_KEY_RANGE;
+extern char *CIL_KEY_GLOB;
+extern char *CIL_KEY_FILE;
+extern char *CIL_KEY_DIR;
+extern char *CIL_KEY_CHAR;
+extern char *CIL_KEY_BLOCK;
+extern char *CIL_KEY_SOCKET;
+extern char *CIL_KEY_PIPE;
+extern char *CIL_KEY_SYMLINK;
+extern char *CIL_KEY_ANY;
+extern char *CIL_KEY_XATTR;
+extern char *CIL_KEY_TASK;
+extern char *CIL_KEY_TRANS;
+extern char *CIL_KEY_TYPE;
+extern char *CIL_KEY_ROLE;
+extern char *CIL_KEY_USER;
+extern char *CIL_KEY_USERATTRIBUTE;
+extern char *CIL_KEY_USERATTRIBUTESET;
+extern char *CIL_KEY_SENSITIVITY;
+extern char *CIL_KEY_CATEGORY;
+extern char *CIL_KEY_CATSET;
+extern char *CIL_KEY_LEVEL;
+extern char *CIL_KEY_LEVELRANGE;
+extern char *CIL_KEY_CLASS;
+extern char *CIL_KEY_IPADDR;
+extern char *CIL_KEY_MAP_CLASS;
+extern char *CIL_KEY_CLASSPERMISSION;
+extern char *CIL_KEY_BOOL;
+extern char *CIL_KEY_STRING;
+extern char *CIL_KEY_NAME;
+extern char *CIL_KEY_SOURCE;
+extern char *CIL_KEY_TARGET;
+extern char *CIL_KEY_LOW;
+extern char *CIL_KEY_HIGH;
+extern char *CIL_KEY_LOW_HIGH;
+extern char *CIL_KEY_GLBLUB;
+extern char *CIL_KEY_HANDLEUNKNOWN;
+extern char *CIL_KEY_HANDLEUNKNOWN_ALLOW;
+extern char *CIL_KEY_HANDLEUNKNOWN_DENY;
+extern char *CIL_KEY_HANDLEUNKNOWN_REJECT;
+extern char *CIL_KEY_MACRO;
+extern char *CIL_KEY_IN;
+extern char *CIL_KEY_MLS;
+extern char *CIL_KEY_DEFAULTRANGE;
+extern char *CIL_KEY_BLOCKINHERIT;
+extern char *CIL_KEY_BLOCKABSTRACT;
+extern char *CIL_KEY_CLASSORDER;
+extern char *CIL_KEY_CLASSMAPPING;
+extern char *CIL_KEY_CLASSPERMISSIONSET;
+extern char *CIL_KEY_COMMON;
+extern char *CIL_KEY_CLASSCOMMON;
+extern char *CIL_KEY_SID;
+extern char *CIL_KEY_SIDCONTEXT;
+extern char *CIL_KEY_SIDORDER;
+extern char *CIL_KEY_USERLEVEL;
+extern char *CIL_KEY_USERRANGE;
+extern char *CIL_KEY_USERBOUNDS;
+extern char *CIL_KEY_USERPREFIX;
+extern char *CIL_KEY_SELINUXUSER;
+extern char *CIL_KEY_SELINUXUSERDEFAULT;
+extern char *CIL_KEY_TYPEATTRIBUTE;
+extern char *CIL_KEY_TYPEATTRIBUTESET;
+extern char *CIL_KEY_EXPANDTYPEATTRIBUTE;
+extern char *CIL_KEY_TYPEALIAS;
+extern char *CIL_KEY_TYPEALIASACTUAL;
+extern char *CIL_KEY_TYPEBOUNDS;
+extern char *CIL_KEY_TYPEPERMISSIVE;
+extern char *CIL_KEY_RANGETRANSITION;
+extern char *CIL_KEY_USERROLE;
+extern char *CIL_KEY_ROLETYPE;
+extern char *CIL_KEY_ROLETRANSITION;
+extern char *CIL_KEY_ROLEALLOW;
+extern char *CIL_KEY_ROLEATTRIBUTE;
+extern char *CIL_KEY_ROLEATTRIBUTESET;
+extern char *CIL_KEY_ROLEBOUNDS;
+extern char *CIL_KEY_BOOLEANIF;
+extern char *CIL_KEY_NEVERALLOW;
+extern char *CIL_KEY_TYPEMEMBER;
+extern char *CIL_KEY_SENSALIAS;
+extern char *CIL_KEY_SENSALIASACTUAL;
+extern char *CIL_KEY_CATALIAS;
+extern char *CIL_KEY_CATALIASACTUAL;
+extern char *CIL_KEY_CATORDER;
+extern char *CIL_KEY_SENSITIVITYORDER;
+extern char *CIL_KEY_SENSCAT;
+extern char *CIL_KEY_CONSTRAIN;
+extern char *CIL_KEY_MLSCONSTRAIN;
+extern char *CIL_KEY_VALIDATETRANS;
+extern char *CIL_KEY_MLSVALIDATETRANS;
+extern char *CIL_KEY_CONTEXT;
+extern char *CIL_KEY_FILECON;
+extern char *CIL_KEY_IBPKEYCON;
+extern char *CIL_KEY_IBENDPORTCON;
+extern char *CIL_KEY_PORTCON;
+extern char *CIL_KEY_NODECON;
+extern char *CIL_KEY_GENFSCON;
+extern char *CIL_KEY_NETIFCON;
+extern char *CIL_KEY_PIRQCON;
+extern char *CIL_KEY_IOMEMCON;
+extern char *CIL_KEY_IOPORTCON;
+extern char *CIL_KEY_PCIDEVICECON;
+extern char *CIL_KEY_DEVICETREECON;
+extern char *CIL_KEY_FSUSE;
+extern char *CIL_KEY_POLICYCAP;
+extern char *CIL_KEY_OPTIONAL;
+extern char *CIL_KEY_DEFAULTUSER;
+extern char *CIL_KEY_DEFAULTROLE;
+extern char *CIL_KEY_DEFAULTTYPE;
+extern char *CIL_KEY_ROOT;
+extern char *CIL_KEY_NODE;
+extern char *CIL_KEY_PERM;
+extern char *CIL_KEY_ALLOWX;
+extern char *CIL_KEY_AUDITALLOWX;
+extern char *CIL_KEY_DONTAUDITX;
+extern char *CIL_KEY_NEVERALLOWX;
+extern char *CIL_KEY_PERMISSIONX;
+extern char *CIL_KEY_IOCTL;
+extern char *CIL_KEY_UNORDERED;
+extern char *CIL_KEY_SRC_INFO;
+extern char *CIL_KEY_SRC_CIL;
+extern char *CIL_KEY_SRC_HLL;
 
 /*
 	Symbol Table Array Indices
-- 
2.24.1

