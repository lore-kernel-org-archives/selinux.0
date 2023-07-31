Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D296EC41513
	for <selinux@archiver.kernel.org>; Mon, 31 Jul 2023 14:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjGaO1F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jul 2023 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjGaO0i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jul 2023 10:26:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A229C9
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 07:26:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6874d1c8610so173063b3a.0
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690813597; x=1691418397;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpL2j81fN635u6TrQn9FMkHTOEzcm6uzxL+im6W4Yhg=;
        b=Yjd4tKGRJaJQG9Xl2g0mrwT1jPwpa6qHu7IrvnDjx/Ra/SCqj3q/i1wXobWBjyDUe1
         KEdpeqpdy4AJJtPVCLWHpLw0M1mE7V3fsETwVBZdvb8UercrME5+RRhGhoGRL/Pr90oC
         s5v3kf0RhkhK21Me2+a/3i4zNHJOt2RyPVRwGjHDLYL/vHK/zUNulx0gyyXQU8rs/6tT
         lgJnpzFWV9nZeKQpwri2RxUeYf5L+xqfonP6uQY6BjRscFVnEje5Jgk92VfRd6Q4Mixr
         x5zchCQD0WF/lDIAvBRTqWMQyAZB0ad46wz1NHQYaTOSwpQRFxKt9gj7rTNwNuK2Lzei
         i5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690813597; x=1691418397;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpL2j81fN635u6TrQn9FMkHTOEzcm6uzxL+im6W4Yhg=;
        b=YBvHJga4NbMRw1V8pzPFfHUmJTXHrUuw2mRQF95TeeR62My+ERrEze8G4efkqBRRqY
         fZ1TzBrub4Lb/k+RoVY1KLTtk8T7wBd6+8DlrEiKuV0hg++Ri6zu0IaLL39fGn86A1cj
         JP7H7LvToH0wu09XH29cjwd7Z4ggA2VEz4SuF+AaZmSjMOS4SmGes8HOiO3lKnDHJHmG
         kLpHVNBy7rXLWBcx2Ft3e6JY8qDpd7rTn02gT0XQHG4MRFq/fnn29Nm+Jns+m2LQD1dp
         nS0u9UsRAsCK+iQGIRGHo1xjv53Se2gk/q+OXQk3l8x/NabEazT5Fj+oAM3JMoXHrZKn
         +8gw==
X-Gm-Message-State: ABy/qLbSLFQ9ongi5m26T40ThmS/yF3jC/lGI1vbAjQ8mX2mTZJX+w9E
        Wd1+2ENLBDOz/bjQHU7QcByCpqL8g9eFQjXvsHIAkDhTAZ0=
X-Google-Smtp-Source: APBJJlHX8AObUNx4eF/rJmEkhMhNVh6X8mxvFEgNRstXxfgtF67sonnuVKpRRLZlu+1WQzihqTLsuhEENwlsWFaO+jE=
X-Received: by 2002:a17:90a:86c7:b0:268:2b5c:14c with SMTP id
 y7-20020a17090a86c700b002682b5c014cmr8165481pjv.13.1690813596786; Mon, 31 Jul
 2023 07:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230728050043.59880-1-wangkefeng.wang@huawei.com> <20230728050043.59880-4-wangkefeng.wang@huawei.com>
In-Reply-To: <20230728050043.59880-4-wangkefeng.wang@huawei.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 31 Jul 2023 10:26:25 -0400
Message-ID: <CAEjxPJ5ZuBGVDah0f3g0-7t2v1uSXTmp_cTT3g_MSP3J9QtoeA@mail.gmail.com>
Subject: Fwd: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and vma_is_initial_heap()
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I believe this patch yields a semantic change in the SELinux execheap
permission check. That said, I think the change is for the better. For
ease of comparison, is_initial_heap() is defined in patch 1 of the
series as:
+/*
+ * Indicate if the VMA is a heap for the given task; for
+ * /proc/PID/maps that is the heap of the main task.
+ */
+static inline bool vma_is_initial_heap(const struct vm_area_struct *vma)
+{
+       return vma->vm_start <=3D vma->vm_mm->brk &&
+               vma->vm_end >=3D vma->vm_mm->start_brk;
+}
+

This is a check for whether the mapping has a non-empty intersection
with the heap range.
Whereas the existing test in the SELinux code only appears to check
whether the mapping is _within_ the heap range.

---------- Forwarded message ---------
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Fri, Jul 28, 2023 at 12:48=E2=80=AFAM
Subject: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and
vma_is_initial_heap()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <amd-gfx@lists.freedesktop.org>,
<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
<linux-perf-users@vger.kernel.org>, <selinux@vger.kernel.org>,
Christian G=C3=B6ttsche <cgzones@googlemail.com>, David Hildenbrand
<david@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Alex
Deucher <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
<Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
<paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
<eparis@parisplace.org>, <peterz@infradead.org>, <acme@kernel.org>,
Kefeng Wang <wangkefeng.wang@huawei.com>


Use the helpers to simplify code.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 security/selinux/hooks.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c87b79a29fad..ac582c046c51 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3800,13 +3800,10 @@ static int selinux_file_mprotect(struct
vm_area_struct *vma,
        if (default_noexec &&
            (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
                int rc =3D 0;
-               if (vma->vm_start >=3D vma->vm_mm->start_brk &&
-                   vma->vm_end <=3D vma->vm_mm->brk) {
+               if (vma_is_initial_heap(vma)) {
                        rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
                                          PROCESS__EXECHEAP, NULL);
-               } else if (!vma->vm_file &&
-                          ((vma->vm_start <=3D vma->vm_mm->start_stack &&
-                            vma->vm_end >=3D vma->vm_mm->start_stack) ||
+               } else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
                            vma_is_stack_for_current(vma))) {
                        rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
                                          PROCESS__EXECSTACK, NULL);
--
2.41.0
