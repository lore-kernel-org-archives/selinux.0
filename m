Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C3CC35E01
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 19:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B182082F
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 19:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZZWuVl85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgBYTUy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:20:54 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44206 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBYTUy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 14:20:54 -0500
Received: by mail-vk1-f194.google.com with SMTP id y184so62085vkc.11
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 11:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/jjy6jiYXtX1LjRixPl7iH3X4idWtpaEvBjf0TWMp7E=;
        b=ZZWuVl85Y/swdZhYvz8Y1I4DwiJRk8goTTPZngUQaQGs8yOVOzYGAtPiuUj4CaSmZy
         CDRSa0Tbkf+9XJE6rVw+zZRB9qJWRgmshTG3rOMqB2vTfoYKzpF/54NCPyjfLqroYdsC
         KSH7j5BzI7Z73Wk/mL+9FBTFoqwpv3tnL80r/Iw1n9CSfBnoCp55e+n6VE7WqlqZp4wc
         CNegJf4mXowEfntbcTMXjz10L16seEBsBDAW81ZezHTehdekfjal4k9QLw+VDIhcY/pz
         TH3Bzz5VCVPRe+RZjsNrEvhiEbZrHJNOoiWoZLEBZxyhf2+tqekh90lBrfZ02++HjRVu
         HNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=/jjy6jiYXtX1LjRixPl7iH3X4idWtpaEvBjf0TWMp7E=;
        b=ZQU67wL7LxT0KeVYv6ZsWsSflhwFKaTPEKd7HWTSVt4wP6LjP2HSIR24AJjoNOUPOi
         wWHOKW0nT5bLbaIAQsQdBqLW57cCW01Keu52KxNNrJ91I4tlhOt8LMAR76htJs3m0ArR
         nnzdhXdEc4PXfEMPJJIXSNe8vzhN5f5NF6DYhND+7TPFAwOG00vErucUoWkuDKgkRMOy
         tXw6WG6+RFETMcEcyyOFmxn9YmmqKZX1/bbBfhiZk1mQGx20k+9m5u/tUlo0NOK3WXj2
         Dd8OZCRzFF1JiVDalT6kOCgcXkM/GOIpYV9mdjYFU/TEqvLH/Hfa/gg15swJnFFF57nU
         R+vQ==
X-Gm-Message-State: APjAAAVr67Or4L+WXNeyfIR7ThDG5lkz+ns/JsaU510uqdAOyjeqVGni
        AH8lRWKo3UxfcOKY3QFY+isnl35YWpn+/Ri+GWwSu+ZTjYc=
X-Google-Smtp-Source: APXvYqwH+AvPyLISGPNAhzwwaVcF8YsJN5TCA06hBQn1NOlGVakIV92VgIEUHwQrywKTAt+0Pt2sHg2DlFyOPedmOuo=
X-Received: by 2002:a1f:7d43:: with SMTP id y64mr369165vkc.15.1582658452609;
 Tue, 25 Feb 2020 11:20:52 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_DdN4koR+9+5UvYSp8U0KGA8Gq_ND9qTdAu6b8yQYmy82A@mail.gmail.com>
 <069d698d-9067-fc90-e666-b35d919df2ee@tycho.nsa.gov> <c2dea4c1-d67b-d872-284f-acde6e9ba58a@tycho.nsa.gov>
 <CAHC9VhTp0CesJurTf3y8VbwnWTpVTTZJAYEs2Mun+F6MCjvUsQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTp0CesJurTf3y8VbwnWTpVTTZJAYEs2Mun+F6MCjvUsQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 25 Feb 2020 20:20:41 +0100
Message-ID: <CAJ2a_DfjV5ZWtnHfbOHYm0NrZcFy5MTTH2D79bJoMFFVyM=J6A@mail.gmail.com>
Subject: Re: How to see SELinux denials late at shutdown
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> On 11/12/19 8:08 AM, Christian G=C3=B6ttsche wrote:
> While trying to confine systemd-shutdown, I am unable to see any
> SELinux denials late at shutdown.
> I tested on Debian sid with systemd 242/243 and Linux 4.19.67-2/5.3.9-1.
> The command line is: `BOOT_IMAGE=3D/boot/vmlinuz-5.3.0-2-amd64
> root=3DUUID=3D0a22bd66-a082-4b76-b96b-ca5cff3ffdf6 ro security=3Dselinux
> console=3DttyS0 console=3Dtty0 log_buf_len=3D1M printk.devkmsg=3Don`.
> When running poweroff or reboot, systemd-shutdown stalls but no denial
> is printed.
> With a script like [1] dmesg does not print any information.
> In permissive mode the system powers off/reboots, but no denials are
> printed.
> Trying to stop auditd/systemd-journald beforehand does not help.
>
> Does the kernel itself shuts down the ring buffer, or can systemd
> interfere somehow?

For the record:

With a custom kernel I was able to retrieve the denials and confine
systemd-shutdown.

---
 security/selinux/avc.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index d18cb32a242a..26c440f022ce 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -751,6 +751,62 @@ static void avc_audit_post_callback(struct
audit_buffer *ab, void *a)
     }
 }

+static void dump_avc_to_console(const struct selinux_audit_data *sad)
+{
+    u32 av =3D sad->audited;
+    char perm_str[128];
+    const char **perms;
+    int i, perm;
+    char *scontext =3D NULL, *tcontext =3D NULL;
+    u32 context_len;
+
+    if (av =3D=3D 0) {
+        snprintf(perm_str, sizeof(perm_str), " null");
+    } else {
+        perms =3D secclass_map[sad->tclass-1].perms;
+
+        snprintf(perm_str, sizeof(perm_str), " {");
+
+        i =3D 0;
+        perm =3D 1;
+
+        while (i < (sizeof(av) * 8)) {
+            if ((perm & av) && perms[i]) {
+                strncat(perm_str, " ",
+                    sizeof(perm_str) - strlen(perm_str)
+                             - 1);
+                strncat(perm_str, perms[i],
+                    sizeof(perm_str) - strlen(perm_str)
+                             - 1);
+                av &=3D ~perm;
+            }
+            i++;
+            perm <<=3D 1;
+        }
+
+        if (av)
+            strncat(perm_str, " UNKNOWN",
+                sizeof(perm_str) - strlen(perm_str) - 1);
+
+        strncat(perm_str, " }", sizeof(perm_str) - strlen(perm_str)
+                             - 1);
+    }
+
+    security_sid_to_context(sad->state, sad->ssid, &scontext, &context_len=
);
+    security_sid_to_context(sad->state, sad->tsid, &tcontext, &context_len=
);
+
+    pr_warn("SELinux avc: %s %s for scontext=3D%s tcontext=3D%s tclass=3D%=
s
permissive=3D%d\n",
+        sad->denied ? "denied" : "granted",
+        perm_str,
+        scontext ? scontext : "KERNEL SID",
+        tcontext ? tcontext : "KERNEL SID",
+        secclass_map[sad->tclass-1].name,
+        sad->denied ? (sad->result ? 0 : 1) : -1);
+
+    kfree(scontext);
+    kfree(tcontext);
+}
+
 /* This is the slow part of avc audit with big stack footprint */
 noinline int slow_avc_audit(struct selinux_state *state,
                 u32 ssid, u32 tsid, u16 tclass,
@@ -779,6 +835,8 @@ noinline int slow_avc_audit(struct selinux_state *state=
,

     a->selinux_audit_data =3D &sad;

+    dump_avc_to_console(&sad);
+
     common_lsm_audit(a, avc_audit_pre_callback, avc_audit_post_callback);
     return 0;
 }
--=20
2.25.1
