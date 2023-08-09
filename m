Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE595C001B0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 21:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHIVCN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjHIVCM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 17:02:12 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B781BD9
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 14:02:10 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76c9334baedso20357185a.2
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 14:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691614929; x=1692219729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qG4wpagAZB91EO+10t0+pSRnM+c4bKlRptiyenq8OY8=;
        b=g358QSaTsXZ4hPQWBGeIusFViDWGoYlZdd5FbquRi7c/m9uPkCMm5Gz6oYkmcHsBQ+
         3bgHufBiL0e2t+IUouYx9TI9PC6cRgHiMZkB0dqIANf9VLXoS8jSY7G7TTlkUZkKNRHy
         hIZ5AKmr0KbToxJrNLQz7UuKzMueAmL4Y0mTn2NfsNbc7gyNMsm4mnFKEzYsFNJ/Cdhp
         TlX8sbtLAWee1A5OyTHHqcugsBuI8K1ldeNUMhFpTUf9kJFmqFX2bWNJHcJ+h25h1BLy
         daLrtUMUs4ksJ43/GjHJEDNxeQ5xbITY78UyqZk/JT0lL43vhDAkClBVYHwifAyLXa/f
         Ujew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691614929; x=1692219729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qG4wpagAZB91EO+10t0+pSRnM+c4bKlRptiyenq8OY8=;
        b=bJ9eTG88udM0bINlPzWVZl0FkbAlGNZuJG+ZH/Ou36TyPD8adBXIpsa7bhWK0tpurX
         LIJoikEENl9PJIqoL/IkNbFs6sPB7OJ+xmGaPo8aDP2Ce9/7ibENL0HH+6ZgVFBehGVC
         uzF27tcILEEBCqJCIceMRRtpDTW5MxDuaEsxvAXnrDbr1wwSZm9sUSpcm7gHj/LZAMED
         vZpAi3v0Dntf/5JJS4ikvw1zIT6SyQRcKDMW5tmOEd5dDoak7Bg3uaNT9QeP2KO4ps/T
         h6naRdq9nE0wlNaZlRbUZQWxMFWOqtFcMa/1IagfoU60lpYlKF28gmeXGuZvYIBaiXtu
         yVDw==
X-Gm-Message-State: AOJu0YyIvs2HitpFfXa0IWelHAwQyOw9fPKRbdNmfV+ALRVnbyI2xeK8
        c1c/sUegK6xgHMAfxph3ZkoU749mGTc=
X-Google-Smtp-Source: AGHT+IGE3ls1BkQ252MxiXpT2IL/3YSwQGMGqDWZWitXhujkjmQDglylIqe/Cjyb8FLXWKsyZ4+gnw==
X-Received: by 2002:a05:620a:25d1:b0:767:3cfc:32aa with SMTP id y17-20020a05620a25d100b007673cfc32aamr198208qko.21.1691614928779;
        Wed, 09 Aug 2023 14:02:08 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a10b400b00766fbeb3e7csm4208287qkk.132.2023.08.09.14.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:02:08 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 8/9 v4] secilc/test: Add deny rule tests
Date:   Wed,  9 Aug 2023 17:01:56 -0400
Message-ID: <20230809210157.112275-9-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809210157.112275-1-jwcart2@gmail.com>
References: <20230809210157.112275-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/test/deny_rule_test1.cil | 580 ++++++++++++++++++++++++++++++++
 secilc/test/deny_rule_test2.cil | 418 +++++++++++++++++++++++
 2 files changed, 998 insertions(+)
 create mode 100644 secilc/test/deny_rule_test1.cil
 create mode 100644 secilc/test/deny_rule_test2.cil

diff --git a/secilc/test/deny_rule_test1.cil b/secilc/test/deny_rule_test1.cil
new file mode 100644
index 00000000..4a01921a
--- /dev/null
+++ b/secilc/test/deny_rule_test1.cil
@@ -0,0 +1,580 @@
+(class CLASS (PERM))
+(class ca (pa1 pa2 pa3 pa4 pa5 pa6 pa7 pa8 pa9))
+(class cb (pb1 pb2 pb3 pb4 pb5 pb6 pb7 pb8 pb9))
+(class cc (pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9))
+(class cd (pd1 pd2 pd3 pd4 pd5 pd6 pd7 pd8 pd9))
+(class ce (pe1 pe2 pe3 pe4 pe5 pe6 pe7 pe8 pe9))
+(class cf (pf1 pf2 pf3 pf4 pf5 pf6 pf7 pf8 pf9))
+(class cg (pg1 pg2 pg3 pg4 pg5 pg6 pg7 pg8 pg9))
+(class ch (ph1 ph2 ph3 ph4 ph5 ph6 ph7 ph8 ph9))
+(class ci (pi1 pi2 pi3 pi4 pi5 pi6 pi7 pi8 pi9))
+(class cj (pj1 pj2 pj3 pj4 pj5 pj6 pj7 pj8 pj9))
+(classorder (CLASS ca cb cc cd ce cf cg ch ci cj))
+(sid SID)
+(sidorder (SID))
+(user USER)
+(role ROLE)
+(type TYPE)
+(category CAT)
+(categoryorder (CAT))
+(sensitivity SENS)
+(sensitivityorder (SENS))
+(sensitivitycategory SENS (CAT))
+(allow TYPE self (CLASS (PERM)))
+(roletype ROLE TYPE)
+(userrole USER ROLE)
+(userlevel USER (SENS))
+(userrange USER ((SENS)(SENS (CAT))))
+(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
+
+(classmap cma (mpa1 mpa2))
+(classmapping cma mpa1
+	      (cc (pc1 pc2)))
+(classmapping cma mpa2
+	      (cc (pc3 pc4)))
+
+(classmap cmb (mpb1 mpb2))
+(classmapping cmb mpb1
+	      (cd (pd1 pd2)))
+(classmapping cmb mpb2
+	      (cd (pd3 pd4)))
+
+(classpermission cpsa)
+(classpermissionset cpsa (cd (pd5 pd6)))
+(classpermissionset cpsa (cd (pd7 pd8)))
+
+(classpermission cpsb)
+(classpermissionset cpsb (cd (pd1 pd2)))
+(classpermissionset cpsb (cd (pd3 pd4)))
+
+(type ta)
+(type tb)
+(type tc)
+(type td)
+(type te)
+(type tf)
+(type tg)
+(type th)
+(type ti)
+(type tj)
+(type tk)
+(type tl)
+(type tm)
+(type tn)
+(type to)
+(type tp)
+(type tq)
+(type tr)
+(type ts)
+(type tt)
+(type tu)
+(type tv)
+(type tw)
+(type tx)
+(type ty)
+(type tz)
+
+(typeattribute a_s1)
+(typeattributeset a_s1 (ta tb tc td te tf tg th tk tl tm tn ts tt))
+(typeattribute a_t1)
+(typeattributeset a_t1 (ta tb tc td te tf ti tj tk tl to tp tu tv))
+(typeattribute a_s2)
+(typeattributeset a_s2 (ta tb tc td tg th ti tj tm tn tq tr tw tx))
+(typeattribute a_t2)
+(typeattributeset a_t2 (ta tb te tf tg th ti tj to tp tq tr ty tz))
+(typeattribute a_s3)
+(typeattributeset a_s3 (and a_s1 (not a_s2)))
+(typeattribute a_s4)
+(typeattributeset a_s4 (and a_s1 a_s2))
+(typeattribute a_t3)
+(typeattributeset a_t3 (and a_t1 (not a_t2)))
+
+
+(typeattribute aab)
+(typeattributeset aab (ta tb))
+
+(typeattribute aNab)
+(typeattributeset aNab (and (all) (not (ta tb))))
+
+(typeattribute aNac)
+(typeattributeset aNac (and (all) (not (ta tc))))
+
+(typeattribute aNbc)
+(typeattributeset aNbc (and (all) (not (tb tc))))
+
+(typeattribute acd)
+(typeattributeset acd (tc td))
+
+(typeattribute aNacd)
+(typeattributeset aNacd (and (all) (not (ta tc td))))
+
+(typeattribute aabc)
+(typeattributeset aabc (ta tb tc))
+
+
+; Test 01
+(allow ta tb (ca (pa1)))
+(deny ta tb (ca (pa1)))
+(neverallow ta tb (ca (pa1)))
+
+; Test 02
+(allow ta tb (ca (pa2 pa3)))
+(deny ta tb (ca (pa2)))
+(neverallow ta tb (ca (pa2)))
+; (neverallow ta tb (ca (pa3))) ; This check should fail
+
+; Test 03
+(allow tc td (ca (pa2)))
+(deny tc td (ca (pa2 pa3)))
+(neverallow tc td (ca (pa2 pa3)))
+
+; Test 04
+(allow aab acd (ca (pa4)))
+(deny aab acd (ca (pa4)))
+(neverallow aab acd (ca (pa4)))
+
+; Test 05
+(allow ta tc (ca (pa5)))
+(deny aab acd (ca (pa5)))
+(neverallow aab acd (ca (pa5)))
+
+; Test 06
+(allow aab acd (ca (pa6)))
+(deny ta tc (ca (pa6)))
+(neverallow ta tc (ca (pa6)))
+; (neverallow tb td (ca (pa6))) ; This check should fail
+
+; Test 07
+(allow ta self (ca (pa7)))
+(deny ta self (ca (pa7)))
+(neverallow ta self (ca (pa7)))
+
+; Test 08
+(allow ta self (ca (pa8)))
+(deny ta ta (ca (pa8)))
+(neverallow ta ta (ca (pa8)))
+
+; Test 09
+(allow ta ta (ca (pa9)))
+(deny ta self (ca (pa9)))
+(neverallow ta self (ca (pa9)))
+
+; Test 11
+(allow aab self (cb (pb1)))
+(deny aab self (cb (pb1)))
+(neverallow aab self (cb (pb1)))
+
+; Test 12
+(allow ta self (cb (pb2)))
+(deny aab self (cb (pb2)))
+(neverallow aab self (cb (pb2)))
+
+; Test 13
+(allow aab self (cb (pb3)))
+(deny ta self (cb (pb3)))
+(neverallow ta self (cb (pb3)))
+; (neverallow tb self (cb (pb3))) ; This check should fail
+
+; Test 14
+(allow aab self (cb (pb4)))
+(deny aab aab (cb (pb4)))
+(neverallow aab aab (cb (pb4)))
+
+; Test 15
+(allow aab aab (cb (pb5)))
+(deny aab self (cb (pb5)))
+(neverallow aab self (cb (pb5)))
+; (neverallow ta tb (cb (pb5))) ; This check should fail
+; (neverallow tb ta (cb (pb5))) ; This check should fail
+
+; Test 16
+(allow aab self (cb (pb6)))
+(deny ta ta (cb (pb6)))
+(neverallow ta ta (cb (pb6)))
+; (neverallow tb tb (cb (pb6))) ; This check should fail
+
+; Test 17
+(allow ta ta (cb (pb7)))
+(deny aab self (cb (pb7)))
+(neverallow aab self (cb (pb7)))
+
+; Test 18
+(allow ta self (cb (pb8)))
+(deny aab aab (cb (pb8)))
+(neverallow aab aab (cb (pb8)))
+
+; Test 19
+(allow aab aab (cb (pb9)))
+(deny ta self (cb (pb9)))
+(neverallow ta self (cb (pb9)))
+; (neverallow ta tb (cb (pb9))) ; This check should fail
+; (neverallow tb ta (cb (pb9))) ; This check should fail
+
+; Test 21
+(allow ta tb (cma (mpa1)))
+(deny ta tb (cma (mpa1)))
+(neverallow ta tb (cma (mpa1)))
+
+; Test 22
+(allow tc td (cma (mpa1 mpa2)))
+(deny tc td (cma (mpa1)))
+(neverallow tc td (cma (mpa1)))
+; (neverallow tc td (cma (mpa2))) ; This check should fail
+
+; Test 23
+(allow te tf (cma (mpa1)))
+(deny te tf (cma (mpa1 mpa2)))
+(neverallow te tf (cma (mpa1 mpa2)))
+
+; Test 24
+(allow tg th (cc (pc1)))
+(deny tg th (cma (mpa1)))
+(neverallow tg th (cma (mpa1)))
+
+; Test 25
+(allow ti tj (cma (mpa1)))
+(deny ti tj (cc (pc1)))
+(neverallow ti tj (cc (pc1)))
+; (neverallow ti tj (cc (pc2))) ; This check should fail
+
+; Test 31
+(allow ta tb cpsa)
+(deny ta tb cpsa)
+(neverallow ta tb cpsa)
+
+; Test 32
+(allow tc td cpsa)
+(deny tc td (cd (pd5 pd6)))
+(neverallow tc td (cd (pd5 pd6)))
+; (neverallow tc td (cd (pd7 pd8))) ; This check should fail
+
+; Test 33
+(allow te tf (cd (pd5 pd6)))
+(deny te tf cpsa)
+(neverallow te tf cpsa)
+
+; Test 34
+(allow tg th cpsb)
+(deny tg th (cmb (mpb1 mpb2)))
+(neverallow tg th (cmb (mpb1 mpb2)))
+
+; Test 35
+(allow ti tj (cmb (mpb1 mpb2)))
+(deny ti tj cpsb)
+(neverallow ti tj cpsb)
+
+; Test 36
+(allow tk tl cpsb)
+(deny tk tl (cmb (mpb1)))
+(neverallow tk tl (cmb (mpb1)))
+; (neverallow tk tl (cmb (mpb2))) ; This check should fail
+
+; Test 37
+(allow tm tn (cmb (mpb1)))
+(deny tm tn cpsb)
+(neverallow tm tn cpsb)
+
+; Test 41
+(block b41
+  (allow ta tb (ce (pe1)))
+  (deny ta tb (ce (pe1)))
+  (neverallow ta tb (ce (pe1)))
+)
+
+; Test 42
+(block b42
+  (type ta)
+  (type tb)
+  (type tc)
+  (type td)
+  (type te)
+  (type tf)
+  (type tg)
+  (typeattribute aa)
+  (typeattribute ab)
+  (typeattribute ac)
+  (typeattribute ad)
+  (typeattribute s3)
+  (typeattribute s4)
+  (typeattribute t3)
+  (typeattributeset aa (ta tb td))
+  (typeattributeset ab (ta tc te))
+  (typeattributeset ac (ta tb tf))
+  (typeattributeset ad (ta tc tg))
+  (typeattributeset s3 (and aa (not ac)))
+  (typeattributeset s4 (and aa ac))
+  (typeattributeset t3 (and ab (not ad)))
+  (allow aa ab (ce (pe2)))
+  (deny ac ad (ce (pe2)))
+  (neverallow ac ad (ce (pe2)))
+  ;(neverallow s3 ab (ce (pe2))) ; This check should fail
+  ;(neverallow s4 t3 (ce (pe2))) ; This check should fail
+)
+
+; Test 43
+(block b43
+  (type ta)
+  (type tb)
+  (allow ta tb (ce (pe3)))
+)
+(deny b43.ta b43.tb (ce (pe3)))
+(neverallow b43.ta b43.tb (ce (pe3)))
+
+; Test 44
+(block b44
+  (type ta)
+  (type tb)
+  (allow ta tb (ce (pe4)))
+)
+
+(block b44a
+  (blockinherit b44)
+  (deny ta tb (ce (pe4)))
+  (neverallow ta tb (ce (pe4)))
+)
+
+(block b44b
+  (blockinherit b44)
+)
+(deny b44b.ta b44b.tb (ce (pe4)))
+(neverallow b44b.ta b44b.tb (ce (pe4)))
+
+
+; Test 45
+(optional opt45
+  (allow aab acd (ce (pe5)))
+  (deny aab acd (ce (pe5)))
+  (neverallow aab acd (ce (pe5)))
+)
+
+; Test 46
+(allow ta tc (ce (pe6)))
+(optional opt46
+  (deny aab acd (ce (pe6)))
+  (neverallow aab acd (ce (pe6)))
+)
+
+; Test 47
+(optional opt47
+  (allow aab acd (ce (pe7)))
+)
+(deny ta tc (ce (pe7)))
+(neverallow ta tc (ce (pe7)))
+
+; Test 51
+(boolean b51 true)
+(booleanif b51
+  (true
+    (allow ta tb (cf (pf1)))
+  )
+)
+(deny ta tb (cf (pf1)))
+(neverallow ta tb (cf (pf1)))
+
+; Test 52
+(boolean b52 true)
+(booleanif b52
+  (false
+    (allow ta tb (cf (pf2)))
+  )
+)
+(deny ta tb (cf (pf2)))
+(neverallow ta tb (cf (pf2)))
+
+; Test 53
+(boolean b53 false)
+(booleanif b53
+  (true
+    (allow ta tb (cf (pf3)))
+  )
+)
+(deny ta tb (cf (pf3)))
+(neverallow ta tb (cf (pf3)))
+
+; Test 54
+(boolean b54 false)
+(booleanif b54
+  (true
+    (allow ta tb (cf (pf4)))
+  )
+)
+(deny ta tb (cf (pf4)))
+(neverallow ta tb (cf (pf4)))
+
+; Test 55
+(tunable b55 true)
+(tunableif b55
+  (true
+    (allow ta tb (cf (pf5)))
+  )
+)
+(deny ta tb (cf (pf5)))
+(neverallow ta tb (cf (pf5)))
+
+; Test 56
+(tunable b56 true)
+(tunableif b56
+  (false
+    (allow ta tb (cf (pf6)))
+  )
+)
+(deny ta tb (cf (pf6)))
+(neverallow ta tb (cf (pf6)))
+
+; Test 57
+(tunable b57 false)
+(tunableif b57
+  (true
+    (allow ta tb (cf (pf7)))
+  )
+)
+(deny ta tb (cf (pf7)))
+(neverallow ta tb (cf (pf7)))
+
+; Test 58
+(tunable b58 false)
+(tunableif b58
+  (true
+    (allow ta tb (cf (pf8)))
+  )
+)
+(deny ta tb (cf (pf8)))
+(neverallow ta tb (cf (pf8)))
+
+; Test 61
+(allow a_s1 a_t1 (cg (pg1)))
+(deny a_s2 a_t2 (cg (pg1)))
+(neverallow a_s2 a_t2 (cg (pg1)))
+; (neverallow a_s3 a_t1 (cg (pg1))) ; This check should fail
+; (neverallow a_s4 a_t3 (cg (pg1))) ; This check should fail
+
+; Test 62
+(allow tm a_t1 (cg (pg2)))
+(deny a_s2 a_t2 (cg (pg2)))
+(neverallow a_s2 a_t2 (cg (pg2)))
+; (neverallow tm a_t3 (cg (pg2))) ; This check should fail
+
+; Test 63
+(allow a_s1 to (cg (pg3)))
+(deny a_s2 a_t2 (cg (pg3)))
+(neverallow a_s2 a_t2 (cg (pg3)))
+; (neverallow a_s3 to (cg (pg3))) ; This check should fail
+
+; Test 64
+(allow a_s1 a_t1 (cg (pg4)))
+(deny tm a_t2 (cg (pg4)))
+(neverallow tm a_t2 (cg (pg4)))
+; (neverallow a_s3 a_t1 (cg (pg4))) ; This check should fail
+; (neverallow tm a_t3 (cg (pg4)))   ; This check should fail
+
+; Test 65
+(allow a_s1 a_t1 (cg (pg5)))
+(deny a_s2 to (cg (pg5)))
+(neverallow a_s2 to (cg (pg5)))
+; (neverallow a_s3 a_t1 (cg (pg5))) ; This check should fail
+; (neverallow a_s4 a_t3 (cg (pg5))) ; This check should fail
+
+; Test 71
+(allow a_s1 self (ch (ph1)))
+(deny a_s2 a_t2 (ch (ph1)))
+(neverallow a_s2 a_t2 (ch (ph1)))
+; Below should fail
+(typeattribute a71)
+(typeattributeset a71 (and a_s4 (not a_t2)))
+; (neverallow a_s3 self (ch (ph1))) ; This check should fail
+; (neverallow a71 self (ch (ph1)))  ; This check should fail
+
+; Test 72
+(allow tg self (ch (ph2)))
+(deny a_s2 a_t2 (ch (ph2)))
+(neverallow a_s2 a_t2 (ch (ph2)))
+
+; Test 73
+(allow a_s1 self (ch (ph3)))
+(deny tg a_t2 (ch (ph3)))
+(neverallow tg a_t2 (ch (ph3)))
+; (neverallow a_s3 self (ch (ph3))) ; This check should fail
+
+; Test 74
+(allow a_s1 self (ch (ph4)))
+(deny a_s2 tg (ch (ph4)))
+(neverallow a_s2 tg (ch (ph4)))
+; Below should fail
+(typeattribute a74)
+(typeattributeset a74 (and a_s4 (not tg)))
+; (neverallow a_s3 self (ch (ph4))) ; This check should fail
+; (neverallow a74 self (ch (ph4)))  ; This check should fail
+
+; Test 81
+(allow a_s1 a_t1 (ci (pi1)))
+(deny a_s2 self (ci (pi1)))
+(neverallow a_s2 self (ci (pi1)))
+; Below should fail
+(typeattribute a81a)
+(typeattribute a81b)
+(typeattribute a81c)
+(typeattribute a81b01)
+(typeattribute a81b02)
+(typeattribute a81b03)
+(typeattribute a81b04)
+(typeattributeset a81a (and a_s4 (not a_t1)))
+(typeattributeset a81b (and a_s4 a_t1))
+(typeattributeset a81c (and a_t1 (not a_s4)))
+(typeattributeset a81b01 (and a81b (not ta)))
+(typeattributeset a81b02 (and a81b (not tb)))
+(typeattributeset a81b03 (and a81b (not tc)))
+(typeattributeset a81b04 (and a81b (not td)))
+; (neverallow a_s3 a_t1 (ci (pi1))) ; This check should fail
+; (neverallow a81a a_t1 (ci (pi1))) ; This check should fail
+; (neverallow a81b a81c (ci (pi1))) ; This check should fail
+; (neverallow ta a81b01 (ci (pi1))) ; This check should fail
+; (neverallow tb a81b02 (ci (pi1))) ; This check should fail
+; (neverallow tc a81b03 (ci (pi1))) ; This check should fail
+; (neverallow td a81b04 (ci (pi1))) ; This check should fail
+
+; Test 82
+(allow tc a_t1 (ci (pi2)))
+(deny a_s2 self (ci (pi2)))
+(neverallow a_s2 self (ci (pi2)))
+; Below should fail
+(typeattribute a82)
+(typeattributeset a82 (and a_t1 (not a_s4)))
+; (neverallow tc a82 (ci (pi2))) ; This check should fail
+
+; Test 83
+(allow a_s1 tc (ci (pi3)))
+(deny a_s2 self (ci (pi3)))
+(neverallow a_s2 self (ci (pi3)))
+; Below should fail
+(typeattribute a83)
+(typeattributeset a83 (and a_s4 (not tc)))
+; (neverallow a_s3 tc (ci (pi3))) ; This check should fail
+; (neverallow a83 tc (ci (pi3)))  ; This check should fail
+
+
+; Test 84
+(allow a_s1 a_t1 (ci (pi4)))
+(deny tc self (ci (pi4)))
+(neverallow tc self (ci (pi4)))
+; Below should fail
+(typeattribute a84)
+(typeattributeset a84 (and a_t1 (not a_s4)))
+; (neverallow a_s3 a_t1 (ci (pi4))) ; This check should fail
+; (neverallow tc a84 (ci (pi4)))    ; This check should fail
+
+; Test 91
+(allow a_s1 self (cj (pj1)))
+(deny a_s2 self (cj (pj1)))
+(neverallow a_s2 self (cj (pj1)))
+; (neverallow a_s3 self (cj (pj1))) ; This check should fail
+
+; Test 92
+(allow tm self (cj (pj2)))
+(deny a_s2 self (cj (pj2)))
+(neverallow a_s2 self (cj (pj2)))
+
+; Test 93
+(allow a_s1 self (cj (pj3)))
+(deny tm self (cj (pj3)))
+(neverallow tm self (cj (pj3)))
+; (neverallow a_s3 self (cj (pj3))) ; This check should fail
diff --git a/secilc/test/deny_rule_test2.cil b/secilc/test/deny_rule_test2.cil
new file mode 100644
index 00000000..7750db73
--- /dev/null
+++ b/secilc/test/deny_rule_test2.cil
@@ -0,0 +1,418 @@
+(class CLASS (PERM))
+(class ca (pa1 pa2 pa3 pa4 pa5 pa6 pa7 pa8 pa9))
+(class cb (pb1 pb2 pb3 pb4 pb5 pb6 pb7 pb8 pb9))
+(class cc (pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9))
+(class cd (pd1 pd2 pd3 pd4 pd5 pd6 pd7 pd8 pd9))
+(class ce (pe1 pe2 pe3 pe4 pe5 pe6 pe7 pe8 pe9))
+(class cf (pf1 pf2 pf3 pf4 pf5 pf6 pf7 pf8 pf9))
+(class cg (pg1 pg2 pg3 pg4 pg5 pg6 pg7 pg8 pg9))
+(class ch (ph1 ph2 ph3 ph4 ph5 ph6 ph7 ph8 ph9))
+(class ci (pi1 pi2 pi3 pi4 pi5 pi6 pi7 pi8 pi9))
+(class cj (pj1 pj2 pj3 pj4 pj5 pj6 pj7 pj8 pj9))
+(classorder (CLASS ca cb cc cd ce cf cg ch ci cj))
+(sid SID)
+(sidorder (SID))
+(user USER)
+(role ROLE)
+(type TYPE)
+(category CAT)
+(categoryorder (CAT))
+(sensitivity SENS)
+(sensitivityorder (SENS))
+(sensitivitycategory SENS (CAT))
+(allow TYPE self (CLASS (PERM)))
+(roletype ROLE TYPE)
+(userrole USER ROLE)
+(userlevel USER (SENS))
+(userrange USER ((SENS)(SENS (CAT))))
+(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
+
+(type ta)
+(type tb)
+(type tc)
+(type td)
+(type te)
+(type tf)
+(type tg)
+(type th)
+(type ti)
+(type tj)
+(type tk)
+(type tl)
+(type tm)
+(type tn)
+(type to)
+(type tp)
+(type tq)
+(type tr)
+(type ts)
+(type tt)
+(type tu)
+(type tv)
+(type tw)
+(type tx)
+(type ty)
+(type tz)
+
+(typeattribute a_s1)
+(typeattributeset a_s1 (ta tb tc td te tf tg th tk tl tm tn ts tt))
+(typeattribute a_t1)
+(typeattributeset a_t1 (ta tb tc td te tf ti tj tk tl to tp tu tv))
+(typeattribute a_s2)
+(typeattributeset a_s2 (ta tb tc td tg th ti tj tm tn tq tr tw tx))
+(typeattribute a_t2)
+(typeattributeset a_t2 (ta tb te tf tg th ti tj to tp tq tr ty tz))
+(typeattribute a_s3)
+(typeattributeset a_s3 (and a_s1 (not a_s2)))
+(typeattribute a_s4)
+(typeattributeset a_s4 (and a_s1 a_s2))
+
+
+(typeattribute aab)
+(typeattributeset aab (ta tb))
+
+(typeattribute aNab)
+(typeattributeset aNab (and (all) (not (ta tb))))
+
+(typeattribute aNac)
+(typeattributeset aNac (and (all) (not (ta tc))))
+
+(typeattribute aNbc)
+(typeattributeset aNbc (and (all) (not (tb tc))))
+
+(typeattribute acd)
+(typeattributeset aab (tc td))
+
+(typeattribute aNacd)
+(typeattributeset aNacd (and (all) (not (ta tc td))))
+
+(typeattribute aabc)
+(typeattributeset aabc (ta tb tc))
+
+
+; Test 01
+(allow ta notself (ca (pa1)))
+(deny ta notself (ca (pa1)))
+(neverallow ta notself (ca (pa1)))
+
+; Test 02
+(allow aab notself (ca (pa2)))
+(deny aab notself (ca (pa2)))
+(neverallow aab notself (ca (pa2)))
+
+; Test 03
+(allow ta notself (ca (pa3)))
+(deny aab notself (ca (pa3)))
+(neverallow aab notself (ca (pa3)))
+
+; Test 04
+(allow aab notself (ca (pa4)))
+(deny ta notself (ca (pa4)))
+(neverallow ta notself (ca (pa4)))
+; (neverallow tb notself (ca (pa4))) ; This check should fail
+
+; Test 11
+(allow ta notself (cb (pb1)))
+(deny ta tb (cb (pb1)))
+(neverallow ta tb (cb (pb1)))
+; (neverallow ta aNab (cb (pb1))) ; This check should fail
+
+; Test 12
+(allow ta tb (cb (pb2)))
+(deny ta notself (cb (pb2)))
+(neverallow ta notself (cb (pb2)))
+
+; Test 13
+(allow aab notself (cb (pb3)))
+(deny ta tb (cb (pb3)))
+(neverallow ta tb (cb (pb3)))
+; (neverallow ta aNab (cb (pb3)))    ; This check should fail
+; (neverallow tb notself (cb (pb3))) ; This check should fail
+
+; Test 14
+(allow ta tb (cb (pb4)))
+(deny aab notself (cb (pb4)))
+(neverallow aab notself (cb (pb4)))
+
+; Test 15
+(allow aab notself (cb (pb5)))
+(deny aab tc (cb (pb5)))
+(neverallow aab tc (cb (pb5)))
+; (neverallow ta aNac (cb (pb5)))    ; This check should fail
+; (neverallow tb aNbc (cb (pb5)))    ; This check should fail
+
+; Test 16
+(allow aab tc (cb (pb6)))
+(deny aab notself (cb (pb6)))
+(neverallow aab notself (cb (pb6)))
+
+; Test 17
+(allow aab notself (cb (pb7)))
+(deny aab acd (cb (pb7)))
+(neverallow aab acd (cb (pb7)))
+; (neverallow aab aNacd (cb (pb7)))    ; This check should fail
+
+; Test 18
+(allow aab acd (cb (pb7)))
+(deny aab notself (cb (pb7)))
+(neverallow aab notself (cb (pb7)))
+
+; Test 21
+(allow aab other (cc (pc1)))
+(deny aab other (cc (pc1)))
+(neverallow aab other (cc (pc1)))
+
+; Test 22
+(allow aabc other (cc (pc2)))
+(deny aab other (cc (pc2)))
+(neverallow aab other (cc (pc2)))
+; (neverallow tc aab (cc (pc2))) ; This check should fail
+
+; Test 23
+(allow aab other (cc (pc3)))
+(deny aabc other (cc (pc3)))
+(neverallow aabc other (cc (pc3)))
+
+; Test 31
+(allow aab other (cd (pd1)))
+(deny aab aab (cd (pd1)))
+(neverallow aab aab (cd (pd1)))
+
+; Test 32
+(allow aab aab (cd (pd2)))
+(deny aab other (cd (pd2)))
+(neverallow aab other (cd (pd2)))
+; (neverallow aab self (cd (pd2))) ; This check should fail
+
+; Test 33
+(allow ta tb (cd (pd3)))
+(deny aab other (cd (pd3)))
+(neverallow aab other (cd (pd3)))
+
+; Test 34
+(allow aab other (cd (pd4)))
+(deny ta tb (cd (pd4)))
+(neverallow ta tb (cd (pd4)))
+; (neverallow tb ta (cd (pd4))) ; This check should fail
+
+
+; Test 61
+(allow a_s1 notself (ce (pe1)))
+(deny a_s2 a_t2 (ce (pe1)))
+(neverallow a_s2 a_t2 (ce (pe1)))
+; Below should fail
+(typeattribute a61a)
+(typeattributeset a61a (and a_s4 (not a_t2)))
+(typeattribute a61b)
+(typeattributeset a61b (and a_s4 a_t2))
+(typeattribute a61c)
+(typeattributeset a61c (and (all) (not a_t2)))
+(typeattribute a61d)
+(typeattributeset a61d (and a61c (not a_s4)))
+; (neverallow a_s3 notself (ce (pe1))) ; This check should fail
+; (neverallow a61a other (ce (pe1)))   ; This check should fail
+; (neverallow a61a a61d (ce (pe1)))    ; This check should fail
+; (neverallow a61b a61c (ce (pe1)))    ; This check should fail
+
+; Test 62
+(allow tg notself (ce (pe2)))
+(deny a_s2 a_t2 (ce (pe2)))
+(neverallow a_s2 a_t2 (ce (pe2)))
+
+; Test 63
+(allow tm notself (ce (pe3)))
+(deny a_s2 a_t2 (ce (pe3)))
+(neverallow a_s2 a_t2 (ce (pe3)))
+
+; Test 64
+(allow a_s1 notself (ce (pe4)))
+(deny tg a_t2 (ce (pe4)))
+(neverallow tg a_t2 (ce (pe4)))
+
+; Test 65
+(allow a_s1 notself (ce (pe5)))
+(deny tm a_t2 (ce (pe5)))
+(neverallow tm a_t2 (ce (pe5)))
+
+; Test 66
+(allow a_s1 notself (ce (pe6)))
+(deny a_s2 tg (ce (pe6)))
+(neverallow a_s2 tg (ce (pe6)))
+; (neverallow a_s3 notself (ce (pe6))) ; This check should fail
+
+; Test 67
+(allow a_s1 notself (ce (pe7)))
+(deny a_s2 ty (ce (pe7)))
+(neverallow a_s2 ty (ce (pe7)))
+; (neverallow a_s3 notself (ce (pe7))) ; This check should fail
+
+; Test 68
+(typeattribute a68)
+(typeattributeset a68 (tg tm))
+(allow a68 notself (ce (pe8)))
+(deny a_s2 a_t2 (ce (pe8)))
+(neverallow a_s2 a_t2 (ce (pe8)))
+
+; Test 71
+(allow a_s1 a_t1 (cf (pf1)))
+(deny a_s2 notself (cf (pf1)))
+(neverallow a_s2 notself (cf (pf1)))
+; Below should fail
+(typeattribute a71a)
+(typeattributeset a71a (and a_s4 a_t1))
+; (neverallow a_s3 a_t1 (cf (pf1))) ; This check should fail
+; (neverallow a71a self (cf (pf1))) ; This check should fail
+
+; Test 72
+(allow tc a_t1 (cf (pf2)))
+(deny a_s2 notself (cf (pf2)))
+(neverallow a_s2 notself (cf (pf2)))
+
+; Test 73
+(allow tm a_t1 (cf (pf3)))
+(deny a_s2 notself (cf (pf3)))
+(neverallow a_s2 notself (cf (pf3)))
+
+; Test 74
+(allow a_s1 a_t1 (cf (pf4)))
+(deny tc notself (cf (pf4)))
+(neverallow tc notself (cf (pf4)))
+
+; Test 75
+(allow a_s1 a_t1 (cf (pf5)))
+(deny tm notself (cf (pf5)))
+(neverallow tm notself (cf (pf5)))
+
+; Test 76
+(allow a_s1 tc (cf (pf6)))
+(deny a_s2 notself (cf (pf6)))
+(neverallow a_s2 notself (cf (pf6)))
+; (neverallow a_s3 tc (cf (pf6))) ; This check should fail
+
+; Test 77
+(allow a_s1 tu (cf (pf7)))
+(deny a_s2 notself (cf (pf7)))
+(neverallow a_s2 notself (cf (pf7)))
+; (neverallow a_s3 tu (cf (pf7))) ; This check should fail
+
+; Test 78
+(typeattribute a78)
+(typeattributeset a78 (tc tm))
+(allow a_s1 a_t1 (cf (pf8)))
+(deny a78 notself (cf (pf8)))
+(neverallow a78 notself (cf (pf8)))
+
+; Test 81
+(allow a_s1 other (cg (pg1)))
+(deny a_s2 a_t2 (cg (pg1)))
+(neverallow a_s2 a_t2 (cg (pg1)))
+; Below should fail
+(typeattribute a81a)
+(typeattributeset a81a (and a_s4 (not a_t2)))
+(typeattribute a81b)
+(typeattributeset a81b (and a_s4 a_t2))
+(typeattribute a81c)
+(typeattributeset a81c (and a_s1 (not a_t2)))
+(typeattribute a81d)
+(typeattributeset a81d (and a_s3 (not a_t2)))
+; (neverallow a_s3 other (cg (pg1))) ; This check should fail
+; (neverallow a81a other (cg (pg1))) ; This check should fail
+; (neverallow a81a a81d (cg (pg1)))  ; This check should fail
+; (neverallow a81b a81c (cg (pg1)))  ; This check should fail
+
+; Test 82
+(allow a_s1 other (cg (pg2)))
+(deny tg a_t2 (cg (pg2)))
+(neverallow tg a_t2 (cg (pg2)))
+
+; Test 83
+(allow a_s1 other (cg (pg3)))
+(deny tm a_t2 (cg (pg3)))
+(neverallow tm a_t2 (cg (pg3)))
+
+; Test 84
+(allow a_s1 other (cg (pg4)))
+(deny a_s2 tg (cg (pg4)))
+(neverallow a_s2 tg (cg (pg4)))
+; (neverallow a_s3 other (cg (pg4))) ; This check should fail
+
+; Test 85
+(allow a_s1 other (cg (pg5)))
+(deny a_s2 ty (cg (pg5)))
+(neverallow a_s2 ty (cg (pg5)))
+; (neverallow a_s3 other (cg (pg5))) ; This check should fail
+
+; Test 86
+(typeattribute a86)
+(typeattributeset a86 (tg tm ts))
+(allow a86 other (cg (pg6)))
+(deny a_s2 a_t2 (cg (pg6)))
+(neverallow a_s2 a_t2 (cg (pg6)))
+
+; Test 91
+(allow a_s1 a_t1 (ch (ph1)))
+(deny a_s2 other (ch (ph1)))
+(neverallow a_s2 other (ch (ph1)))
+; Below should fail
+(typeattribute a91a)
+(typeattributeset a91a (and a_s4 a_t1))
+(typeattribute a91b)
+(typeattributeset a91b (and a_t1 a_s2))
+; (neverallow a_s3 a_t1 (ch (ph1))) ; This check should fail
+; (neverallow a_s4 a91b (ch (ph1))) ; This check should fail
+; (neverallow a91a self (ch (ph1))) ; This check should fail
+
+; Test 92
+(allow tc a_t1 (ch (ph2)))
+(deny a_s2 other (ch (ph2)))
+(neverallow a_s2 other (ch (ph2)))
+
+; Test 93
+(allow tm a_t1 (ch (ph3)))
+(deny a_s2 other (ch (ph3)))
+(neverallow a_s2 other (ch (ph3)))
+
+; Test 94
+(allow a_s1 tc (ch (ph4)))
+(deny a_s2 other (ch (ph4)))
+(neverallow a_s2 other (ch (ph4)))
+; (neverallow a_s3 tc (ch (ph4))) ; This check should fail
+
+; Test 95
+(allow a_s1 tu (ch (ph5)))
+(deny a_s2 other (ch (ph5)))
+(neverallow a_s2 other (ch (ph5)))
+; (neverallow a_s3 tu (ch (ph5))) ; This check should fail
+
+; Test 96
+(typeattribute a96)
+(typeattributeset a96 (tc tm tw))
+(allow a_s1 a_t1 (ch (ph6)))
+(deny a96 other (ch (ph6)))
+(neverallow a96 other (ch (ph6)))
+
+; Test 101
+(allow a_s1 other (ci (pi1)))
+(deny a_s2 other (ci (pi1)))
+(neverallow a_s2 other (ci (pi1)))
+; (neverallow a_s3 other (ci (pi1))) ; This check should fail
+; (neverallow a_s4 a_s3 (ci (pi1)))  ; This check should fail
+
+; Test 102
+(allow a_s1 notself (ci (pi2)))
+(deny a_s2 other (ci (pi2)))
+(neverallow a_s2 other (ci (pi2)))
+; (neverallow a_s3 notself (ci (pi2))) ; This check should fail
+; (neverallow a_s4 a_s3 (ci (pi2)))    ; This check should fail
+
+; Test 103
+(allow a_s1 other (ci (pi3)))
+(deny a_s2 notself (ci (pi3)))
+(neverallow a_s2 notself (ci (pi3)))
+; (neverallow a_s3 other (ci (pi3))) ; This check should fail
+
+; Test 104
+(allow a_s1 notself (ci (pi4)))
+(deny a_s2 notself (ci (pi4)))
+(neverallow a_s2 notself (ci (pi4)))
+; (neverallow a_s3 notself (ci (pi4))) ; This check should fail
-- 
2.41.0

