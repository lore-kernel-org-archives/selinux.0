Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0810C433E0
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 14:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B355120829
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 14:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgG3ObW convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:31:22 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:7628 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729356AbgG3ObV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 10:31:21 -0400
Subject: [PATCH] RFC: selinux avc trace
To:     Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>
CC:     Paul Moore <paul@paul-moore.com>, Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <selinux@vger.kernel.org>
References: <20200724091520.880211-1-tweek@google.com>
 <20200724095232.5f9d3f17@oasis.local.home>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <80a23580-5067-93b0-53fa-3bd53253c056@sony.com>
Date:   Thu, 30 Jul 2020 16:29:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724095232.5f9d3f17@oasis.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=DrAoB13+ c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=_RQrkK6FrEwA:10 a=z6gsHLkEAAAA:8 a=0l5Oc7AxwvPC4nGLvrwA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I did manage to rebase it but this is about my approach.

Compared to Thiébaud Weksteen patch this adds:

1 Filtering. Types goes to trace so we can put up a filter for contexts or type etc.

2 It tries also to cover non denies.  And upon that you should be able to do coverage tools.
I think many systems have a lot more rules that what is needed, but there is good way
to find out what.  A other way us to make a stat page for the rules, but this way connect to
userspace and can be used for test cases.

This code need a lot more work, but it shows how the filter should work (extra info is not right)
and there are  memory leaks, extra debug info and nonsense variable etc.

From: Peter Enderborg <peter.enderborg@sony.com>
Date: Thu, 30 Jul 2020 14:44:53 +0200
Subject: [PATCH] RFC: selinux avc trace

This is not done yet. But it shows a trace for selinux avc.
---
 include/trace/events/avc.h |  92 +++++++++++++++++++++++++++++
 security/selinux/avc.c     | 115 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 205 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/avc.h

diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
new file mode 100644
index 000000000000..28c1044e918b
--- /dev/null
+++ b/include/trace/events/avc.h
@@ -0,0 +1,92 @@
+/*
+ * License terms: GNU General Public License (GPL) version 2
+ *
+ * Author: Peter Enderborg <Peter.Enderborg@sony.com>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM avc
+
+#if !defined(_TRACE_AVC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_AVC_H
+
+#include <linux/tracepoint.h>
+TRACE_EVENT(avc_data,
+        TP_PROTO(u32 requested,
+             u32 denied,
+             u32 audited,
+             int result,
+             const char *msg
+             ),
+
+        TP_ARGS(requested, denied, audited, result,msg),
+
+        TP_STRUCT__entry(
+             __field(u32, requested)
+             __field(u32, denied)
+             __field(u32, audited)
+             __field(int, result)
+             __array(char, msg, 255)
+                 ),
+
+        TP_fast_assign(
+               __entry->requested    = requested;
+               __entry->denied    = denied;
+               __entry->audited    = audited;
+               __entry->result    = result;
+               memcpy(__entry->msg, msg, 255);
+    ),
+
+        TP_printk("requested=0x%x denied=%d audited=%d result=%d msg=%s",
+              __entry->requested, __entry->denied, __entry->audited, __entry->result, __entry->msg
+              )
+);
+TRACE_EVENT(avc_req,
+        TP_PROTO(u32 requested,
+             u32 denied,
+             u32 audited,
+             int result,
+             const char *msg,
+             u32 ssid,
+             struct selinux_state *state
+             ),
+
+        TP_ARGS(requested, denied, audited, result,msg, ssid, state),
+
+        TP_STRUCT__entry(
+            __field(u32, requested)
+            __field(u32, denied)
+            __field(u32, audited)
+            __field(int, result)
+            __array(char, msg, 255)
+            __field(u32, ssid)
+            __field(struct selinux_state *, state)
+            __field(char*, scontext)
+            __field(u32, ssid_len)
+            __field(u32, ssid_res)
+                 ),
+
+        TP_fast_assign(
+            __entry->requested    = requested;
+            __entry->denied    = denied;
+            __entry->audited    = audited;
+             __entry->result    = result;
+            memcpy(__entry->msg, msg, 255);
+            __entry->ssid    = ssid;
+            __entry->state    = state;
+            __entry->ssid_res = security_sid_to_context(
+                           state,
+                           ssid,
+                           &__entry->scontext,
+                           &__entry->ssid_len);
+    ),
+
+        TP_printk("requested=0x%x denied=%d audited=%d result=%d msg=%s ssid=%d state=%p scontext=%s slen=%d s=%d",
+              __entry->requested, __entry->denied, __entry->audited, __entry->result, __entry->msg, __entry->ssid, __entry->state,__entry->scontext,__entry->ssid_len, __entry->ssid_res
+              )
+);
+
+#endif /* _TRACE_AVC_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index d18cb32a242a..d8cb9a23d669 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -30,6 +30,8 @@
 #include "avc.h"
 #include "avc_ss.h"
 #include "classmap.h"
+#define CREATE_TRACE_POINTS
+#include <trace/events/avc.h>
 
 #define AVC_CACHE_SLOTS            512
 #define AVC_DEF_CACHE_THRESHOLD        512
@@ -126,6 +128,41 @@ static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
     return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
 }
 
+static int avc_dump_avs(char *ab, u16 tclass, u32 av)
+{
+    const char **perms;
+    int i, perm;
+    int rp;
+
+    if (av == 0) {
+        rp = sprintf(ab, " null");
+        return rp;
+    }
+
+    BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
+    perms = secclass_map[tclass-1].perms;
+
+    rp = sprintf(ab, " {");
+    i = 0;
+    perm = 1;
+    while (i < (sizeof(av) * 8)) {
+        if ((perm & av) && perms[i]) {
+            rp +=sprintf(ab+rp, " %s", perms[i]);
+            av &= ~perm;
+        }
+        i++;
+        perm <<= 1;
+    }
+
+    if (av)
+        rp += sprintf(ab+rp, " 0x%x", av);
+
+    rp +=sprintf(ab+rp, " }");
+    return rp;
+}
+
+
+
 /**
  * avc_init - Initialize the AVC.
  *
@@ -421,8 +458,12 @@ static inline int avc_xperms_audit(struct selinux_state *state,
 
     audited = avc_xperms_audit_required(
             requested, avd, xpd, perm, result, &denied);
-    if (likely(!audited))
+    if (likely(!audited)) {
+        trace_avc_data(requested, denied, audited, -1,"foo");
         return 0;
+    }
+
+    trace_avc_data(requested, denied, audited, -1,"bar");
     return slow_avc_audit(state, ssid, tsid, tclass, requested,
             audited, denied, result, ad);
 }
@@ -541,6 +582,34 @@ static inline struct avc_node *avc_search_node(struct selinux_avc *avc,
     return ret;
 }
 
+static int avc_dump_querys(struct selinux_state *state, char *ab, u32 ssid, u32 tsid, u16 tclass)
+{
+    int rc;
+    char *scontext;
+    u32 scontext_len;
+    int rp;
+
+    rc = security_sid_to_context(state,ssid, &scontext, &scontext_len);
+    if (rc)
+        rp = sprintf(ab, "ssid=%d", ssid);
+    else {
+        rp = sprintf(ab, "scontext=%s", scontext);
+        kfree(scontext);
+    }
+
+    rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
+    if (rc)
+        rp +=sprintf(ab+rp, " tsid=%d", tsid);
+    else {
+        rp +=sprintf(ab+rp, " tcontext=%s", scontext);
+        kfree(scontext);
+    }
+
+    BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
+    rp += sprintf(ab+rp, " tclass=%s", secclass_map[tclass-1].name);
+    return rp;
+}
+
 /**
  * avc_lookup - Look up an AVC entry.
  * @ssid: source security identifier
@@ -690,6 +759,7 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
         audit_log_format(ab, " 0x%x", av);
 
     audit_log_format(ab, " } for ");
+
 }
 
 /**
@@ -780,6 +850,7 @@ noinline int slow_avc_audit(struct selinux_state *state,
     a->selinux_audit_data = &sad;
 
     common_lsm_audit(a, avc_audit_pre_callback, avc_audit_post_callback);
+    pr_info("done lsm");
     return 0;
 }
 
@@ -1105,6 +1176,34 @@ int avc_has_extended_perms(struct selinux_state *state,
         return rc2;
     return rc;
 }
+static int avc_dump_extra_info_s(char *ab,
+        struct common_audit_data *ad)
+{
+    struct task_struct *tsk = current;
+    int rp;
+
+    if (tsk && tsk->pid) {
+        rp = sprintf(ab, " ppid=%d pcomm=", tsk->parent->pid);
+        rp += sprintf(ab+rp, tsk->parent->comm);
+
+        if (tsk->group_leader->pid != tsk->pid) {
+            rp +=sprintf(ab+rp, " pgid=%d pgcomm=",
+                    tsk->group_leader->pid);
+            rp += sprintf(ab+rp,
+                    tsk->group_leader->comm);
+        } else if (tsk->parent->group_leader->pid) {
+            rp += sprintf(ab+rp, " pgid=%d pgcomm=",
+                    tsk->parent->group_leader->pid);
+            rp += sprintf(ab+rp,
+                    tsk->parent->group_leader->comm);
+        }
+    } else {
+        rp = sprintf(ab," no task %p", tsk);
+    }
+    return rp;
+}
+
+
 
 /**
  * avc_has_perm_noaudit - Check permissions but perform no auditing.
@@ -1178,14 +1277,26 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
 {
     struct av_decision avd;
     int rc, rc2;
+    char *lb;
+    int x;
+
+    lb = kmalloc(1024, GFP_KERNEL);
 
     rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, 0,
                   &avd);
 
     rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
             auditdata, 0);
-    if (rc2)
+    if (rc2)  {
+        kfree(lb);
         return rc2;
+    }
+
+    x = avc_dump_avs(lb, tclass, 42);
+    x += avc_dump_querys(state, lb+x,ssid, tsid, tclass);
+        if(1)    x += avc_dump_extra_info_s(lb+x, auditdata);
+    trace_avc_data(requested, rc, 0, rc2,lb);
+    kfree(lb);
     return rc;
 }
 
-- 
2.17.1


