Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C29C3527D
	for <selinux@archiver.kernel.org>; Tue,  5 Apr 2022 21:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbiDEVlh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391026AbiDEPdj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Apr 2022 11:33:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FE34AE2B
        for <selinux@vger.kernel.org>; Tue,  5 Apr 2022 06:40:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg10so26821259ejb.4
        for <selinux@vger.kernel.org>; Tue, 05 Apr 2022 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ets4y11vEqdCFUKXiCZb839pOE0bfEf4L2YjS8uHhl0=;
        b=gxFz5Kugw9U2jKXQ8redqBJdzaaUgoxd210NsbC9XofNiFuErDVqjNZs8SrQSdR1xv
         rBjSuD+dt17VV5hxv0LnBl+Ac/Y98YlRGDZUUrhG+g7eWh045AFlrh7zEmVdYjv1l8bU
         fybBIQyBJHepkhAoxr3wPq0md9jGRUAdDKpBi56DOnExDXjtz5TdsOhof/HhRhTr7N0g
         mbnD7gERCHsskyUhjOIamnYHsnFkSPcYkLZQdVEtfn7Q3rVo2W8zFRWFT9Vqaabx/Ymb
         38heccVXZawgW/wnjTmhBgv/DNxDEp7qZ47D8wwemVL98WebTP86FAyumutFBA0RSMUh
         SnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ets4y11vEqdCFUKXiCZb839pOE0bfEf4L2YjS8uHhl0=;
        b=6NUywVZiLNqY5gXp0ukNYd1f3wWLnyMxlyJbiaCk8v70ic4JKtBO5W7rb/H9GcZVit
         baiGE8WWQU0t+caF5wNPQXg9ApEBXY8lj/ygpnfZEaOPNmvSjf5pUajc/VxcSbbjoUim
         ipCGqtTLbBFv/dnm7gSEQAw0w8ewZR+g7UPiCWyE9K3Xf4pUcq/YJsN2mBiA8SzU/Jdm
         74D1ZkOH4h+QkXHYreM5YREL/IKObNBTYUKdoOjeoL4XIjQtZYPULiwNBmDtH8tk8GYy
         ssW6Vk2/TrjXdfgUpEte48t6ckI9qILIJ++joG4bqbJNcqy/WoAokrzw/be0brGcLpXk
         7w9g==
X-Gm-Message-State: AOAM5300QhkiCFENeQPU3M6KlNbDn7K+hZUtsE8PNQOr46RptvUT8f+6
        M8WeIm3xxumEOOKHHrQpDLsC58HYSQ0=
X-Google-Smtp-Source: ABdhPJzSFU3RDunmPPfgs7RXBkRmZ3No6AO2nlcC/nO94kWQb0TYTdt8w/lODiQkGPhvBsOYkeH8xA==
X-Received: by 2002:a17:907:8a19:b0:6e8:a7e:5f50 with SMTP id sc25-20020a1709078a1900b006e80a7e5f50mr3717126ejc.322.1649166002378;
        Tue, 05 Apr 2022 06:40:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-134-094.77.8.pool.telefonica.de. [77.8.134.94])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm5472863ejz.57.2022.04.05.06.40.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:40:01 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] policycoreutils: drop usage of egrep in fixfiles
Date:   Tue,  5 Apr 2022 15:39:58 +0200
Message-Id: <20220405133958.52460-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

egrep(1) is deprecated, use `grep -E`.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/scripts/fixfiles | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 7df4303a..c72ca0eb 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -45,9 +45,9 @@ FS="`cat /proc/self/mounts | sort | uniq | awk '{print $2}'`"
 for i in $FS; do
 	if [ `useseclabel` -ge 0 ]
 	then
-		grep " $i " /proc/self/mounts | awk '{print $4}' | egrep --silent '(^|,)seclabel(,|$)' && echo $i
+		grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --silent '(^|,)seclabel(,|$)' && echo $i
 	else
-		grep " $i " /proc/self/mounts | grep -v "context=" | egrep --silent '(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs )' && echo $i
+		grep " $i " /proc/self/mounts | grep -v "context=" | grep -E --silent '(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs )' && echo $i
 	fi
 done
 }
@@ -55,14 +55,14 @@ done
 get_rw_labeled_mounts() {
 FS=`get_all_labeled_mounts | sort | uniq`
 for i in $FS; do
-	grep " $i " /proc/self/mounts | awk '{print $4}' | egrep --silent '(^|,)rw(,|$)' && echo $i
+	grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --silent '(^|,)rw(,|$)' && echo $i
 done
 }
 
 get_ro_labeled_mounts() {
 FS=`get_all_labeled_mounts | sort | uniq`
 for i in $FS; do
-	grep " $i " /proc/self/mounts | awk '{print $4}' | egrep --silent '(^|,)ro(,|$)' && echo $i
+	grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --silent '(^|,)ro(,|$)' && echo $i
 done
 }
 
@@ -176,7 +176,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 	sed -r -e 's,:s0, ,g' $FC | sort -u | \
 	/usr/bin/diff -b ${PREFCTEMPFILE} - | \
 	    grep '^[<>]'|cut -c3-| grep ^/ | \
-	    egrep -v '(^/home|^/root|^/tmp)' |\
+	    grep -Ev '(^/home|^/root|^/tmp)' |\
 	sed -r -e 's,[[:blank:]].*,,g' \
 	       -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
 	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
-- 
2.35.1

