Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B572EB64D9
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 14:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGFOVd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 10:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjGFOVd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 10:21:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D1DB
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 07:21:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e29913c35so1159817a12.0
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688653290; x=1691245290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MByCFnI3Q5rkN3bmUuLey+8kzRekEFoz/aGRG9g2T2s=;
        b=Vs64nZw6KF7IToPAISSHm9W9SVU8khSq8Px0a6UHm9pjobwpCusKbiDUmT4PoQp0QY
         TeC+gTy4Z2Sjy4M1WNJQH633p2E6Scp2GSV2QMDPwdTzrwFql61onDag1xkmYa7hPaD1
         6AGmBayZSf58U0ehD0PcVwNLtxmV+p+9qYN9PaNiUeXsSdsur55IFoxjHyDs5mhC+EKj
         aDhLiKjbu4APshO/tZEx+Wu7MXNtJUZ8FVq8Y22n9almy4x5ZTAqDqJJ3wOOEV5d0okx
         CPlWqUxjTIplqT7EBVMjueF25jitrVAKqidW57mR2pF783QkKqlwPlYGD7DCHMCxJlPP
         +Tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688653290; x=1691245290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MByCFnI3Q5rkN3bmUuLey+8kzRekEFoz/aGRG9g2T2s=;
        b=RNmV8c+H8xI/vxb3TYfZPykbvLbAOVsCKVWPdWuu0YmnLlUAIvJ4eoiIG+hFIick45
         HKP2aK3gz2ghI6dJ73wFJelwx0gN9NZn1034JYoG9Do25Jub+TaDhBN4RhuoIVZ95ovG
         WyYcCOy+7Cty/yz6Jk/6V0SM2U015a//BKC9Gj++z08RFuAs6uck6L+KW9VMEbrfrOUI
         luZMpVu43gCv+uk9qTuedfySHqIsdZWcT0WEGqQTasrwUQxrrhWdZjQbGSNPIcXY7Obt
         vcf05xwGzp9JMs2KgwLzkJxEiVFdtTLtUfU0rjsPBoSf7t7v9FqRyPGQL4ml7dnugNvA
         20Ig==
X-Gm-Message-State: ABy/qLbo9aP14K/8lmmu4BkV8oMEejTL4CxpOR7AZO0O41YOyoRjfszw
        5ARG9eokoFDCMO4HXn7vOEgUaCRXCmeNE0sP
X-Google-Smtp-Source: APBJJlFDBcBixYHKC8uLBn58LqFm6mPlUtBHJheFDHHVEvtEaSk2zcrP/yWTQcAXUhyB2ICnDh4CBQ==
X-Received: by 2002:aa7:cb0c:0:b0:51d:a724:48d1 with SMTP id s12-20020aa7cb0c000000b0051da72448d1mr855786edt.23.1688653290058;
        Thu, 06 Jul 2023 07:21:30 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id bf25-20020a0564021a5900b0051dd1c10c13sm827427edb.29.2023.07.06.07.21.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:21:29 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] setsebool: improve bash-completion script
Date:   Thu,  6 Jul 2023 16:21:26 +0200
Message-Id: <20230706142126.59907-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Support the usage format of multiple booleans to change, e.g.:

    setsebool bool1=on bool2=off

Support the options -N and -V.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .../setsebool/setsebool-bash-completion.sh    | 54 ++++++++++++++-----
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/policycoreutils/setsebool/setsebool-bash-completion.sh b/policycoreutils/setsebool/setsebool-bash-completion.sh
index d0f3b424..f7fe0c0c 100644
--- a/policycoreutils/setsebool/setsebool-bash-completion.sh
+++ b/policycoreutils/setsebool/setsebool-bash-completion.sh
@@ -15,26 +15,56 @@
 # You should have received a copy of the GNU General Public License
 # along with systemd; If not, see <http://www.gnu.org/licenses/>.
 
-__contains_word () {
-        local word=$1; shift
-        for w in $*; do [[ $w = $word ]] && return 0; done
-        return 1
-}
-
 __get_all_booleans () {
     getsebool -a | cut -f1 -d' '
 }
 
 _setsebool () {
-        local command=${COMP_WORDS[1]}
         local cur=${COMP_WORDS[COMP_CWORD]} prev=${COMP_WORDS[COMP_CWORD-1]}
-        local verb comps
 
-	if   [ "$verb" = "" -a "$prev" = "setsebool" -o "$prev" = "-P" ]; then
-	        COMPREPLY=( $(compgen -W "-P $( __get_all_booleans ) " -- "$cur") )
-		return 0
+        if [ "$prev" = '=' ]; then
+                COMPREPLY=( $(compgen -W "on off" -- "$cur") )
+                return 0
         fi
-        COMPREPLY=( $(compgen -W "0 1 -P" -- "$cur") )
+
+        case "$cur" in
+        '0')
+                COMPREPLY=( $(compgen -W "0 1" -- "$cur") )
+                return 0
+        ;;
+        '1')
+                COMPREPLY=( $(compgen -W "0 1" -- "$cur") )
+                return 0
+        ;;
+        =)
+                COMPREPLY=( $(compgen -W "on off" -- "") )
+                return 0
+        ;;
+        -*)
+                COMPREPLY=( $(compgen -W "-N -P -V" -- "$cur") )
+                return 0
+        ;;
+        '')
+                if [ "$prev" = '0' ] || [ "$prev" = '1' ]; then
+                        COMPREPLY=( $(compgen -W "-N -P -V" -- "$cur") )
+                        return 0
+                fi
+                if getsebool "$prev" > /dev/null 2>&1; then
+                        COMPREPLY=( $(compgen -W "0 1" -- "$cur") )
+                        return 0
+                fi
+        ;;
+        *)
+                if getsebool "$cur" > /dev/null 2>&1; then
+                        COMPREPLY=( $(compgen -W '$( __get_all_booleans ) "$cur=on " "$cur=off "' -- "$cur") )
+                        compopt -o nospace
+                        return 0
+                fi
+        ;;
+        esac
+
+        COMPREPLY=( $(compgen -W '"-N " "-P " "-V " $( __get_all_booleans ) ' -- "$cur") )
+        compopt -o nospace
         return 0
 }
 
-- 
2.40.1

