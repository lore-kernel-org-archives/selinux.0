Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27F0C3F2D1
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 21:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60C820828
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 21:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQUehDgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgCDV2f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:28:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38753 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDV2f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 16:28:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id e20so2570907qto.5
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 13:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kZFStZrNl7SNTMSmK9wW56lqQVBfi3v4mbi7otducNc=;
        b=MQUehDgT6GFNHEX4csN/2wb/X/X8B6T+TGu4vrjlWP7qDvf2GZr/+TDzVisw3B+QS3
         jl/x1av8/8Neue2hiXROszhfPu43lejOo7ddejwloGVPvenKHTCG6xMCxTMWXEcQG1JG
         oEhG6Jjh1R/wMWAp52ze2C24ZwpIRQj3Yd2NvXrPcVHkP3Roy6l0QWj97GCsdY3kYlbb
         qSZAmRjWZdRUQk9fNn3TFlt1h8+sLxyg9b7J63MkkSrJDI7sDu4F7VR2L2U2NaA9+EhF
         /UfoRuoS6VMBb1iCow5R+3iWvLDupPDIlk0eMli7s13bLOx3/f9CV4P1y+GB/0nRhbEj
         /rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kZFStZrNl7SNTMSmK9wW56lqQVBfi3v4mbi7otducNc=;
        b=nzg8zjcZRwcYQZ4QiqzmruGigNETLO6T2gHYXapiGSwZgJToFUNraR4kKXOZMPeemg
         Lf7TBe2XVoXybrDmrSmx0dKFG/jtpn4kt3EGsl0hv0mnAiRc38Oc/ZVKcQEaky50T/Md
         wtU0XdPnal3dHasTNBEvklo6o0HleQ8u3DXA3ia8qLkf2HPjWu5W8uq1Xs0abySqnsxF
         DFkqo0LhdyPbHflxhSW3jdD/aSxdlC9GbMRlxG3iUSpq8s/gmI4O7uOq5uIlr+0s0adq
         FmBTkxULF+rqurxuLAOvihjadGDuxwvjYu4LG5mXH5EEw+fW9Oz0UJDc/UjLKNJ40jup
         hKOA==
X-Gm-Message-State: ANhLgQ2t5CJO8NODQakOEwH3z1QHO85ntfYZQz8lqbx9aqnij4unXKeS
        TQi2Yn87yMElz5xhhiFv03TmgIi6
X-Google-Smtp-Source: ADFU+vu1ahh9G1LP2JygccL2JqQENLwQW287oFC8x8GwpzmSJYieX9wVNY3efE9Gs9vNWP/5sGH2ww==
X-Received: by 2002:aed:2a5c:: with SMTP id k28mr4366390qtf.132.1583357314230;
        Wed, 04 Mar 2020 13:28:34 -0800 (PST)
Received: from r21-ubuntu-01.ltsnet.net ([65.127.220.137])
        by smtp.googlemail.com with ESMTPSA id 62sm11857094qkk.84.2020.03.04.13.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:28:33 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     jwcart2@tycho.nsa.gov, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Do not check flavor when checking for duplicate parameters
Date:   Wed,  4 Mar 2020 16:28:31 -0500
Message-Id: <20200304212831.18292-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A parameter of a macro was only considered to be a duplicate if it
matched both the name and flavor of another parameter. While it is
true that CIL is able to differentiate between those two parameters,
there is no reason to use the same name for two macro parameters and
it is better to return an error for what is probably an error.

Remove the check of the flavors when checking for duplicate parameters.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 307b1ee3..fcecdc4f 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -5304,11 +5304,9 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		struct cil_list_item *curr_param;
 		cil_list_for_each(curr_param, macro->params) {
 			if (param->str == ((struct cil_param*)curr_param->data)->str) {
-				if (param->flavor == ((struct cil_param*)curr_param->data)->flavor) {
-					cil_log(CIL_ERR, "Duplicate parameter\n");
-					cil_destroy_param(param);
-					goto exit;
-				}
+				cil_log(CIL_ERR, "Duplicate parameter\n");
+				cil_destroy_param(param);
+				goto exit;
 			}
 		}
 
-- 
2.17.1

