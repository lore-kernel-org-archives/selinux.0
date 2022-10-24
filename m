Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB79AC38A2D
	for <selinux@archiver.kernel.org>; Mon, 24 Oct 2022 09:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJXJOv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Oct 2022 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiJXJOq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Oct 2022 05:14:46 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F4210FCD
        for <selinux@vger.kernel.org>; Mon, 24 Oct 2022 02:14:27 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id i19-20020aa787d3000000b0056bd68d713cso750524pfo.17
        for <selinux@vger.kernel.org>; Mon, 24 Oct 2022 02:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnMmmenO3Z6xhx6n/n6yKT565qZLwfdm6Yu2HAVrDZ8=;
        b=IcX/WrI/UvCe09o4Shj8UkVVXYEqrQEaGoYkQjokptM7wYr1nXgZfaLHvYz0/6g4OX
         i1IpYjh5daWCC9khF6UqWwpdr0m3oDTcD8aFL3W5Fk0zQZRFRQ3lVFnouzWuE/oWq08l
         ykr7C2CzO5KCgt/tGmb1saxOPpDWgQ7XjRsy5JynbiYxUePhryl7sIz9tts9TDrq+4nk
         1cACXMAY4fjufPAR1R4Lb6/FqH9vdTt2zuOXMmMPcMMookyxbwDvMb6sKWEFSz+J8GJZ
         gXYD7NLAPho4iGAkgOY9I7uwhvDUymjXEsi6mukuxPh/+BaIZLT8XtutQRm2C38FClyH
         tIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnMmmenO3Z6xhx6n/n6yKT565qZLwfdm6Yu2HAVrDZ8=;
        b=61FtbDzgcl6Ttowy/zREbMi5CGg0xv9GLmZP4PCx3OjbGFhDuy3i7SESGZaSTsJgHp
         6Fiv+STebtZDlvBHL4KDyckDox5elnaYrsO72fv6DnwrZnrZy1gu9lnPKTdVw+/S7FB5
         RShBsKwIrM9LDjo9jW8v1gJv30OoJx9K9tBNNwsXrGWhEalG3A7GFkD2DS5kPr/QnaVv
         gEzFHdJ/BUfQ84oB0sdcICz9K/H7MZP+VFlIqveaN81m0kjCKKVChFM1XgZ9k2nKeU+d
         HiKUowlEHfez/u/NHdUTAP4KKeI4qJanggq5z4Ed6QEHk3y9P7s883qQgONnXoDv5jVx
         7hfw==
X-Gm-Message-State: ACrzQf1YipOzk+TDnVey8l0rNzSyAYQgRFV8IT6aHAcQLOD+XCDihmxn
        M+l20/sv8ZWTXlQzTcI1g3347NEXzO9vE10VEk9nfofx9dix0xi4k8p7ckG96tRhy8TuWD+Iyzj
        FjjqKV76ELXZXqAbG1vjQRDqLV8YunkIXCpTCIWt1Mholy+wMLFawDyJpsw/Q
X-Google-Smtp-Source: AMsMyM4xT/AHchtdwVAn233384mOTaVDO0gc3Eqar055je1iPqhP9OGNp4RBPULFOZ1ZX1h9qbtPXhc2mg==
X-Received: from tweek-sin.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2bfd])
 (user=tweek job=sendgmr) by 2002:a17:902:b942:b0:178:be25:203f with SMTP id
 h2-20020a170902b94200b00178be25203fmr33054139pls.101.1666602853650; Mon, 24
 Oct 2022 02:14:13 -0700 (PDT)
Date:   Mon, 24 Oct 2022 20:13:54 +1100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221024091354.2253669-1-tweek@google.com>
Subject: [PATCH] libselinux: ignore invalid class name lookup
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>, Paul Moore <paul@paul-moore.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selinux_check_access relies on string_to_security_class to resolve the
class index from its char* argument. There is no input validation done
on the string provided. It is possible to supply an argument containing
trailing backslashes (i.e., "sock_file//////") so that the paths built
in discover_class get truncated. The processing will then reference the
same permission file multiple time (e.g., perms/watch_reads will be
truncated to perms/watch). This will leak the memory allocated when
strdup'ing the permission name. The discover_class_cache will end up in
an invalid state (but not corrupted).

Ensure that the class provided does not contain any path separator.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libselinux/src/stringrep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index 2fe69f43..592410e5 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -63,6 +63,9 @@ static struct discover_class_node * discover_class(const =
char *s)
 		return NULL;
 	}
=20
+	if (strchr(s, '/') !=3D NULL)
+		return NULL;
+
 	/* allocate a node */
 	node =3D malloc(sizeof(struct discover_class_node));
 	if (node =3D=3D NULL)
--=20
2.38.0.135.g90850a2211-goog

