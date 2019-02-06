Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1F4C169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 04:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4ED2184E
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 04:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20150623.gappssmtp.com header.i=@wkennington-com.20150623.gappssmtp.com header.b="acRjZrqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfBFESD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 23:18:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46298 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBFESD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 23:18:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so2351507pgp.13
        for <selinux@vger.kernel.org>; Tue, 05 Feb 2019 20:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cZJ3s2/nBh1mvWPEUKP5tCLU+xQ+VkwjrZTZKBLkjQ0=;
        b=acRjZrqg3R7fI8vuuCBLJN3IvnCE6stB0oeU9kjVoCpJtckVP6B0lnJEOSwWHQVSFB
         GJj+y3lPgzesCttJW3Mf6n55eFVtdL3wD3KTS10q/hXc/nGsIsi8i6QKmp8k0V83Twgm
         iJy8djKBen3HCd01A2Rf9mitVfVVqI1Yhh3n0voXssGQpTD6vnDeb77Szo6FskP7lHnw
         1o2tQNSAyfjoJUH+nJ54Q5u1FWyOt0WJ4eZ46oF3K5/efVdnPdpktG+SFuxhzwb3XIzc
         acbhUWsn9WjG8TsWACHqWaxbs6u+3F5c5crUQHofK9xnlDWZQO4dfxOeHRM4oF5wzAMn
         fR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cZJ3s2/nBh1mvWPEUKP5tCLU+xQ+VkwjrZTZKBLkjQ0=;
        b=qJvG4GiSjJ5VtcJaDLViwi2Wn4XCRCeMOYkUO5XGCuNjURWVqQ0R3FU5KjI7ZhLvNt
         vG9tVbW0zjLSp1sxd7aMwJA8w5A72vWOi71nqJ613sG4X1UI1lYG1UU1KdYpN+5jgzLS
         M8hnJfxyux7FSrcxwNV5+a9y6n7i1WdQzXKyu020ZM7gmHPKnzCcXmJVQAlKAsfl+iBV
         uLIeJFilcFsHV/YPPg5e/XuZSIjBIIN6Ou1FEgglq30Ufk57P14uQLvxiBNJHp+jscaT
         nPLUwAdUFaxyhUzJH2msfKDLyayV0R6pOM9Wej0oflAkNU0v/aus8WP2E43Cu8pKU33T
         ROLg==
X-Gm-Message-State: AHQUAuZjbZOMiwT69BvSexUYRFP+30EG0byoXUDn0PGhQpSaDAOuavGF
        E5rV/7G2UhRJ4z2JgSWHpTI8ds676L/57A==
X-Google-Smtp-Source: AHgI3IaGxueBxkxfFxTZTI1W7OHIZ4g8q8CTHy9oSxWkXWVRMfMgRAZbEF9tRfV/v57+dXzBZT64GA==
X-Received: by 2002:a62:5007:: with SMTP id e7mr8592237pfb.92.1549426681714;
        Tue, 05 Feb 2019 20:18:01 -0800 (PST)
Received: from nevada.wak.io (gw.fmt-1.wak.io. [65.19.134.254])
        by smtp.gmail.com with ESMTPSA id f13sm5259220pgq.82.2019.02.05.20.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 20:18:01 -0800 (PST)
From:   "William A. Kennington III" <william@wkennington.com>
To:     selinux@vger.kernel.org
Cc:     "William A. Kennington III" <william@wkennington.com>
Subject: [PATCH] selinux: Fix classmap for BPF
Date:   Tue,  5 Feb 2019 20:17:47 -0800
Message-Id: <20190206041747.11377-1-william@wkennington.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Entries in the secclass_map are expexted to be null terminated. The BPF
entry was added without the NULL terminating and incosistent formatting.
This patch cleans that up.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 security/selinux/include/classmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index bd5fe0d3204a..7ff68a5e4c58 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -239,7 +239,7 @@ struct security_class_mapping secclass_map[] = {
 	{ "infiniband_endport",
 	  { "manage_subnet", NULL } },
 	{ "bpf",
-	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
+	  { "map_create", "map_read", "map_write", "prog_load", "prog_run", NULL } },
 	{ "xdp_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ NULL }
-- 
2.20.1

