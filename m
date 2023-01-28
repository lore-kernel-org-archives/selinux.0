Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D0CC38142
	for <selinux@archiver.kernel.org>; Sat, 28 Jan 2023 21:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjA1VP1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 28 Jan 2023 16:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1VP0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 28 Jan 2023 16:15:26 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA10233F7
        for <selinux@vger.kernel.org>; Sat, 28 Jan 2023 13:15:24 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gs13so11572442ejc.0
        for <selinux@vger.kernel.org>; Sat, 28 Jan 2023 13:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=im+cvRet0di/e1ukAdd1yEZltk52uhFLUNg/ctD2bac=;
        b=G/twm1yFtVoormon9d5G92UdnmSIycMWnq0JDUSIqhUaItvbQEL+4Xq+6rSI3zuJkq
         noLKBNTLem4wHeRg3jSp6HmIos7t5KdO7Jt/aYVubIeawPAPMJzOQrNGOXGK/Kzba91e
         iB2SERuxayGraDedTqyqdxqsnE60ix+RUrbIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=im+cvRet0di/e1ukAdd1yEZltk52uhFLUNg/ctD2bac=;
        b=gXsUD2LnxNCFN85nW+HJm5GnuFaZthP/3MNaoIScFSG+yJxUbxJEqAdf6okLZ1WGRP
         bRon0a4UhaeY8JDeYNw06P5wke0lpn20ybRVFYW7MMoM75LTBZfBqOw1wZR/YGdBoJ47
         FWXnrbdtTvwmF4l9Z4Cw1O7g5upiUp+2hCHrKCw+ly8g8Knh+mUsbGIGQ5Sl9k0eWuzy
         tFkhA85OErip3Ihjx2L9NAheNk7l+5b9H6P2HcP2Irv95H267f/uUIQrxfCVX3RQdqLR
         VCanseQaxodCdHWTxEDV6MNHNSMWUF1Xlz6NtNc69b2pYMpA1mQIMBcNg1OhqPMcxan0
         SqGw==
X-Gm-Message-State: AO0yUKWk2EUA3l0qFC71a/qBc1r12kK0se6dzgF10Nw+bBE0YMX8sa9b
        9chk9umcZ22VH4PDQNP6y2EUIp7FVTttitjKiA8=
X-Google-Smtp-Source: AK7set/+C1ufxhS9ceTnTplAAWDbUcZu2g6KX7fMb+qMAJCXv8mAbIc1LlOoe7C3wMwRjTh9shXhww==
X-Received: by 2002:a17:906:66c2:b0:7c1:2e19:ba3f with SMTP id k2-20020a17090666c200b007c12e19ba3fmr3048480ejp.57.1674940522286;
        Sat, 28 Jan 2023 13:15:22 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906155700b00869f2ca6a87sm4351760ejd.135.2023.01.28.13.15.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 13:15:21 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id m2so21820433ejb.8
        for <selinux@vger.kernel.org>; Sat, 28 Jan 2023 13:15:21 -0800 (PST)
X-Received: by 2002:a17:906:a3c9:b0:879:4f94:41ea with SMTP id
 ca9-20020a170906a3c900b008794f9441eamr2138734ejb.79.1674940521352; Sat, 28
 Jan 2023 13:15:21 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Jan 2023 13:15:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whR4KSGqfEodXMwOMdQBt+V2HHMyz6+CobiydnZE+Vq9Q@mail.gmail.com>
Message-ID: <CAHk-=whR4KSGqfEodXMwOMdQBt+V2HHMyz6+CobiydnZE+Vq9Q@mail.gmail.com>
Subject: Looking at profile data once again - avc lookup
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000cbd86205f3597a86"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--000000000000cbd86205f3597a86
Content-Type: text/plain; charset="UTF-8"

So I happened to do my occasional "let's see what a profile for an
empty kernel build is", which usually highlights some silly thing we
do in pathname lookup (because most of the cost is just 'make' doing
various string handling in user space, and doing variations of
'lstat()' to look at file timestamps).

And, as always, avc_has_perm() and avc_has_perm_noaudit() are pretty
high up there, together with selinux_inode_permission(). It just gets
called a *lot*.

Now, avc_has_perm_noaudit() should be inlined, but it turns out that
it isn't because of some bad behavior of the unlikely path. That part
looks fairly easy to massage away. I'm attaching a largely untested
patch that makes the generated code look a bit better, in case anybody
wants to look at it.

But the real reason for this email is to query about 'selinux_state'.

We pass that around as a pointer quite a bit, to the point where
several function calls have to use stack space for arguments just
because they have more than six arguments. And from what I can tell,
it is *always* just a pointer to 'selinux_state', and never anything
else.

Some cases are obvious:

    git grep -w avc_has_perm |
        grep -v 'avc_has_perm(&selinux_state,'

ie every _single_ callers of 'avc_has_perm()' just passes in a pointer
to that single selinux_state thing.

Some cases are a bit less obvious, like security_get_user_sids(),
which has sel_write_user() do

        struct selinux_state *state = fsi->state;
        ..
                rc = security_sid_to_context(state, sids[i], &newcon, &len);

and then in turn it passes that to avc_has_perm_noaudit(), so it looks
like we might actually have multiple states.

The emphasis here being on "looks like", because it turns out that the
only thing that assigns 'fsi->state' is selinux_fs_info_create(),
which does

        fsi->state = &selinux_state;

oh, look, it's that same &selinux_state again!

In general, I really think there is just one single

        struct selinux_state selinux_state;

declared in security/selinux/hooks.c, and everybody just pointlessly
passes in a pointer to that single thing.

This was all done five years ago by commit aa8e712cee93 ("selinux:
wrap global selinux state") and I don't see the point. It never seems
to have gone anywhere, there's no other state that I can find, and all
it does is add overhead and complexity.

So I'd like to undo that, and go back to the good old days when we
didn't waste time and effort on passing a pointer that always has the
same value as an argument.

Comments? Is there some case I've missed?

               Linus

--000000000000cbd86205f3597a86
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-selinux-uninline-unlikely-parts-of-avc_has_perm_noau.patch"
Content-Disposition: attachment; 
	filename="0001-selinux-uninline-unlikely-parts-of-avc_has_perm_noau.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ldggb7em0>
X-Attachment-Id: f_ldggb7em0

RnJvbSA1MGQzMmVjYjA2NmE4MjAxNDZmNWRjNDQxMTg1YzBlMDNjMTFiM2U1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgMjggSmFuIDIwMjMgMTI6NTM6MjYgLTA4MDAKU3ViamVjdDog
W1BBVENIXSBzZWxpbnV4OiB1bmlubGluZSB1bmxpa2VseSBwYXJ0cyBvZiBhdmNfaGFzX3Blcm1f
bm9hdWRpdCgpCgphdmNfaGFzX3Blcm1fbm9hdWRpdCgpaXMgb25lIG9mIHRob3NlIGhvdCBmdW5j
dGlvbnMgdGhhdCBlbmQgdXAgYmVpbmcKdXNlZCBieSBhbG1vc3QgYWxsIGZpbGVzeXN0ZW0gb3Bl
cmF0aW9ucyAodGhyb3VnaCAiYXZjX2hhc19wZXJtKCkiKSBhbmQKaXQncyBpbnRlbmRlZCB0byBi
ZSBjaGVhcCBlbm91Z2ggdG8gaW5saW5lLgoKSG93ZXZlciwgaXQgdHVybnMgb3V0IHRoYXQgdGhl
IHVubGlrZWx5IHBhcnRzIG9mIGl0ICh3aGVyZSBpdCBkb2Vzbid0CmZpbmQgYW4gZXhpc3Rpbmcg
YXZjIG5vZGUpIG5lZWQgYSBmYWlyIGFtb3VudCBvZiBzdGFjayBzcGFjZSBmb3IgdGhlCmF1dG9t
YXRpYyByZXBsYWNlbWVudCBub2RlLCBzbyBpZiBpdCB3ZXJlIHRvIGJlIGlubGluZWQgKGF0IGxl
YXN0IGNsYW5nCmRvZXMgbm90KSBpdCB3b3VsZCBqdXN0IHVzZSBzdGFjayBzcGFjZSB1bm5lY2Vz
c2FyaWx5LgoKU28gc3BsaXQgdGhlIHVubGlrZWx5IHBhcnQgb3V0IG9mIGl0LCBhbmQgbWFyayB0
aGF0IHBhcnQgbm9pbmxpbmUuICBUaGF0CmltcHJvdmVzIHRoZSBhY3R1YWwgbGlrZWx5IHBhcnQu
CgpTaWduZWQtb2ZmLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlv
bi5vcmc+Ci0tLQogc2VjdXJpdHkvc2VsaW51eC9hdmMuYyB8IDUyICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQxIGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NlY3VyaXR5L3NlbGludXgvYXZjLmMg
Yi9zZWN1cml0eS9zZWxpbnV4L2F2Yy5jCmluZGV4IDlhNDNhZjBlYmQ3ZC4uODVlNWFmN2Y4NTZl
IDEwMDY0NAotLS0gYS9zZWN1cml0eS9zZWxpbnV4L2F2Yy5jCisrKyBiL3NlY3VyaXR5L3NlbGlu
dXgvYXZjLmMKQEAgLTExMTIsNiArMTExMiwzOCBAQCBpbnQgYXZjX2hhc19leHRlbmRlZF9wZXJt
cyhzdHJ1Y3Qgc2VsaW51eF9zdGF0ZSAqc3RhdGUsCiAJcmV0dXJuIHJjOwogfQogCisvKgorICog
VGhpcyBpcyB0aGUgIndlIGhhdmUgbm8gbm9kZSIgcGFydCBvZiBhdmNfaGFzX3Blcm1fbm9hdWRp
dCgpLAorICogd2hpY2ggaXMgdW5saWtlbHkgYW5kIG5lZWRzIGV4dHJhIHN0YWNrIHNwYWNlIGZv
ciB0aGUgbmV3CisgKiBub2RlIHRoYXQgd2UgZ2VuZXJhdGUuIFNvIGRvbid0IGlubGluZSBpdC4K
KyAqCisgKiBOT1RFISBDYWxsZWQgd2l0aCBSQ1UgbG9jayBoZWxkIGZvciByZWFkaW5nLCBhbmQg
bmVlZHMgdG8KKyAqIGRyb3AgaXQuIEFuZCBzaW5jZSB0aGUgUkNVIGxvY2sgd2FzIGZvciB0aGUg
bm9kZSBsaWZldGltZQorICogKHdoaWNoIHdlIGRvbid0IGhhdmUpLCB3ZSBjb3VsZCBqdXN0IGRy
b3AgaXQgZWFybHkuIEV4Y2VwdAorICogYXZjX2NvbXB1dGVfYXYoKSBrbm93cyBpdCdzIGNhbGxl
ZCB1bmRlciB0aGUgcmN1IGxvY2ssIGFuZAorICogZHJvcHMgYW5kIHJlLXRha2VzIGl0LiBXaGF0
IGEgY3JvY2suCisgKgorICogU28gd2UgZHJvcCBpdCBhZnRlciBjYWxsaW5nIGF2Y19jb21wdXRl
X2F2KCkgKGFuZCAqaW5zaWRlKgorICogYXZjX2NvbXB1dGVfYXYoKSkuCisgKi8KK3N0YXRpYyBu
b2lubGluZSBpbnQgYXZjX3Blcm1fbm9ub2RlKHN0cnVjdCBzZWxpbnV4X3N0YXRlICpzdGF0ZSwK
KwkJCQl1MzIgc3NpZCwgdTMyIHRzaWQsCisJCQkJdTE2IHRjbGFzcywgdTMyIHJlcXVlc3RlZCwK
KwkJCQl1bnNpZ25lZCBpbnQgZmxhZ3MsCisJCQkJc3RydWN0IGF2X2RlY2lzaW9uICphdmQpCit7
CisJCXUzMiBkZW5pZWQ7CisJCXN0cnVjdCBhdmNfeHBlcm1zX25vZGUgeHBfbm9kZTsKKworCQlh
dmNfY29tcHV0ZV9hdihzdGF0ZSwgc3NpZCwgdHNpZCwgdGNsYXNzLCBhdmQsICZ4cF9ub2RlKTsK
KwkJcmN1X3JlYWRfdW5sb2NrKCk7CisJCWRlbmllZCA9IHJlcXVlc3RlZCAmIH4oYXZkLT5hbGxv
d2VkKTsKKwkJaWYgKHVubGlrZWx5KGRlbmllZCkpCisJCQlyZXR1cm4gYXZjX2RlbmllZChzdGF0
ZSwgc3NpZCwgdHNpZCwgdGNsYXNzLCByZXF1ZXN0ZWQsIDAsIDAsCisJCQkJCWZsYWdzLCBhdmQp
OworCQlyZXR1cm4gMDsKK30KKwogLyoqCiAgKiBhdmNfaGFzX3Blcm1fbm9hdWRpdCAtIENoZWNr
IHBlcm1pc3Npb25zIGJ1dCBwZXJmb3JtIG5vIGF1ZGl0aW5nLgogICogQHN0YXRlOiBTRUxpbnV4
IHN0YXRlCkBAIC0xMTM5LDEwICsxMTcxLDggQEAgaW5saW5lIGludCBhdmNfaGFzX3Blcm1fbm9h
dWRpdChzdHJ1Y3Qgc2VsaW51eF9zdGF0ZSAqc3RhdGUsCiAJCQkJdW5zaWduZWQgaW50IGZsYWdz
LAogCQkJCXN0cnVjdCBhdl9kZWNpc2lvbiAqYXZkKQogewotCXN0cnVjdCBhdmNfbm9kZSAqbm9k
ZTsKLQlzdHJ1Y3QgYXZjX3hwZXJtc19ub2RlIHhwX25vZGU7Ci0JaW50IHJjID0gMDsKIAl1MzIg
ZGVuaWVkOworCXN0cnVjdCBhdmNfbm9kZSAqbm9kZTsKIAogCWlmIChXQVJOX09OKCFyZXF1ZXN0
ZWQpKQogCQlyZXR1cm4gLUVBQ0NFUzsKQEAgLTExNTEsMTcgKzExODEsMTcgQEAgaW5saW5lIGlu
dCBhdmNfaGFzX3Blcm1fbm9hdWRpdChzdHJ1Y3Qgc2VsaW51eF9zdGF0ZSAqc3RhdGUsCiAKIAlu
b2RlID0gYXZjX2xvb2t1cChzdGF0ZS0+YXZjLCBzc2lkLCB0c2lkLCB0Y2xhc3MpOwogCWlmICh1
bmxpa2VseSghbm9kZSkpCi0JCWF2Y19jb21wdXRlX2F2KHN0YXRlLCBzc2lkLCB0c2lkLCB0Y2xh
c3MsIGF2ZCwgJnhwX25vZGUpOwotCWVsc2UKLQkJbWVtY3B5KGF2ZCwgJm5vZGUtPmFlLmF2ZCwg
c2l6ZW9mKCphdmQpKTsKKwkJcmV0dXJuIGF2Y19wZXJtX25vbm9kZShzdGF0ZSwgc3NpZCwgdHNp
ZCwgdGNsYXNzLCByZXF1ZXN0ZWQsIGZsYWdzLCBhdmQpOworCisJZGVuaWVkID0gcmVxdWVzdGVk
ICYgfm5vZGUtPmFlLmF2ZC5hbGxvd2VkOworCW1lbWNweShhdmQsICZub2RlLT5hZS5hdmQsIHNp
emVvZigqYXZkKSk7CisJcmN1X3JlYWRfdW5sb2NrKCk7CiAKLQlkZW5pZWQgPSByZXF1ZXN0ZWQg
JiB+KGF2ZC0+YWxsb3dlZCk7CiAJaWYgKHVubGlrZWx5KGRlbmllZCkpCi0JCXJjID0gYXZjX2Rl
bmllZChzdGF0ZSwgc3NpZCwgdHNpZCwgdGNsYXNzLCByZXF1ZXN0ZWQsIDAsIDAsCi0JCQkJZmxh
Z3MsIGF2ZCk7CisJCXJldHVybiBhdmNfZGVuaWVkKHN0YXRlLCBzc2lkLCB0c2lkLCB0Y2xhc3Ms
IHJlcXVlc3RlZCwgMCwgMCwKKwkJCQkJZmxhZ3MsIGF2ZCk7CiAKLQlyY3VfcmVhZF91bmxvY2so
KTsKLQlyZXR1cm4gcmM7CisJcmV0dXJuIDA7CiB9CiAKIC8qKgotLSAKMi4zOS4wLnJjMi40Lmcx
NDM1OTMxZTQzCgo=
--000000000000cbd86205f3597a86--
