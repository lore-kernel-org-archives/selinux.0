Return-Path: <SRS0=PQdl=EJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D129C2D0A3
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85C120870
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 17:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DwXqc1Qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgKCRLW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCRLW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Nov 2020 12:11:22 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1990C0613D1
        for <selinux@vger.kernel.org>; Tue,  3 Nov 2020 09:11:21 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id cw8so11719851ejb.8
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2020 09:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yln6e9DFCtRBB1nDEWcn7mUWxZv67NRC0F96HEo+Zw=;
        b=DwXqc1QpXw2rUq7o6JvtvkMFIrS4uQZ7x6fKJ9xgSWfwLbf+6atqGKZUX2veV5kTBw
         pLlaILsCc42btrTJPRGYAf1eBi81bNG2Db1zpdHAcT7FQXJhM7dcxrgN817WqrvQuvDy
         3m0ZSOB6xOa6veC4CmttFDqxAYfsT33eFfn6tSJhkQVcQL5zxG6XXZ8MYDLwBH2UhCEr
         4DNIZYl4IcuzHP/gh0RpJZQrwm3pRI5tWiqYwkfjXcEots+4lgJsSWKrZ1z1PFWViZ7p
         s2J+hi7+ovz9Hf9K+lJ2Xrd8U8ijmB7HVlSZve49sMBJjLTTFHI1xXAtYAcBcmo16/Dc
         EEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yln6e9DFCtRBB1nDEWcn7mUWxZv67NRC0F96HEo+Zw=;
        b=pdhhSqsMs+7p/8RBQf16yLQ3sV3rNS16mDL4VwZLBTxKezPtqoLaB+61yBPbhXWoHO
         cCLkCT9V4qb41JOpS+RGiIJKkV9JgTMPRFpEmh0CXEpzmWR/kDRJ7IVPctfPC247jYmX
         fXmIcmmteBL4IegEwVe4Ccfi+EiQkUYMtkp/XGYfEzUAPtvYcyrQImoqnaWd697Ry40r
         Yc2ZcLgMqxmfmFaOXbxyoZ7BR967++topHBUdutdqgE1FmxsuryW/YzHkfhOb/lBZJnu
         AfquNGNCf4zjIyHXh+RJCFSGO7AfkPnr7eKRpJ2q33CZwo6USAN6UbNiTrQWj6jCJ/or
         ZhTw==
X-Gm-Message-State: AOAM532Pe6riMPT6Z39q9gKMXRNO0p53k5zSDwKDVtZTQlqO6C70ImXI
        2AZxPJp5uEmnw4xcynO1+M12mmciwAc7HFu717BA
X-Google-Smtp-Source: ABdhPJwEbU22jukM38VVa2SZOwS/mkl4pv+xf1F4osP6iZpkNzvWk5OhnwJ0cY+eRV4I015HHYgLZdyAye25HDa9NRo=
X-Received: by 2002:a17:906:1159:: with SMTP id i25mr1270779eja.398.1604423480232;
 Tue, 03 Nov 2020 09:11:20 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhQTp3Rc_7zM661Rzur0XSuWRWKJJg=CwLPAQo5ABRpS-w@mail.gmail.com>
 <20201009013630.6777-1-rentianyue@tj.kylinos.cn> <20201009013630.6777-2-rentianyue@tj.kylinos.cn>
 <CAHC9VhR2KPKN8ot9WrkjZQ08X-VPDGkXro18C5jhDEwcFH6wog@mail.gmail.com> <yt9dh7q64m8a.fsf@linux.ibm.com>
In-Reply-To: <yt9dh7q64m8a.fsf@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 Nov 2020 12:11:08 -0500
Message-ID: <CAHC9VhT-dgT8pP7ZfPu+Ssw4RAYUpcwhTWfXXeciVPz0mRcP3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     rentianyue@tj.kylinos.cn,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andreas Gruenbacher <agruenba@redhat.com>, yangzhao@kylinos.cn,
        selinux@vger.kernel.org, Tianyue Ren <rentianyue@kylinos.cn>,
        linux-s390@vger.kernel.org, hca@linux.ibm.com,
        borntraeger@de.ibm.com
Content-Type: multipart/mixed; boundary="0000000000009c59a805b336f33d"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--0000000000009c59a805b336f33d
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 3, 2020 at 8:14 AM Sven Schnelle <svens@linux.ibm.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Thu, Oct 8, 2020 at 9:37 PM <rentianyue@tj.kylinos.cn> wrote:
> >> From: Tianyue Ren <rentianyue@kylinos.cn>
> >>
> >> Mark the inode security label as invalid if we cannot find
> >> a dentry so that we will retry later rather than marking it
> >> initialized with the unlabeled SID.
> >>
> >> Fixes: 9287aed2ad1f ("selinux: Convert isec->lock into a spinlock")
> >> Signed-off-by: Tianyue Ren <rentianyue@kylinos.cn>
> >> ---
> >>  security/selinux/hooks.c | 19 ++++++++++++++++---
> >>  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > Merged into selinux/next with some minor tweaks to the comments.
> > Thanks for your help!
>
> This seems to break booting on s390:
>
> Welcome to Fedora 32 (Thirty Two)!
>
> [    1.434571] systemd[1]: Set hostname to <xxx.xxx>
> [    1.436839] audit: type=1400 audit(1604408868.681:4): avc:  denied  { write } for  pid=1 comm="systemd" dev="cgroup2" ino=2 scontext=system_u:sys
> tem_r:init_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=file permissive=0
> [    1.436840] systemd[1]: Failed to create /init.scope control group: Permission denied
> [    1.438039] systemd[1]: Failed to allocate manager object: Permission denied
> [ [0;1;31m!!!!!! [0m] Failed to allocate manager object.
> [    1.438281] systemd[1]: Freezing execution.
>
> Any ideas? If i revert 83370b31a915493231e5b9addc72e4bef69f8d31 from
> linux-next-20201103 it works fine...

Thanks for the report.

Looking at this again, I'm thinking that setting the isec->initialized
field outside of the spinlock is probably a bad idea.  My guess is
that your system is racing on inode_doinit_with_dentry() and the
initialized field is getting messed up.

Any chance you could try the attached (completely untested) patch?

-- 
paul moore
www.paul-moore.com

--0000000000009c59a805b336f33d
Content-Type: text/x-patch; charset="US-ASCII"; name="01-selinux-inode_dentry_init_fix.patch"
Content-Disposition: attachment; 
	filename="01-selinux-inode_dentry_init_fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kh2864py0>
X-Attachment-Id: f_kh2864py0

c2VsaW51eDogZml4IGlub2RlX2RvaW5pdF93aXRoX2RlbnRyeSgpIGVycm9yIGNhc2UgbG9ja2lu
ZwoKRnJvbTogUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4KClhYWCAtIHRlc3Rpbmcg
b25seSBwYXRjaCwgd29yayBpbiBwcm9ncmVzcwoKRml4ZXM6IDgzMzcwYjMxYTkxNSAoInNlbGlu
dXg6IGZpeCBlcnJvciBpbml0aWFsaXphdGlvbiBpbiBpbm9kZV9kb2luaXRfd2l0aF9kZW50cnko
KSIpClJlcG9ydGVkLWJ5OiBTdmVuIFNjaG5lbGxlIDxzdmVuc0BsaW51eC5pYm0uY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPgotLS0KIHNlY3VyaXR5
L3NlbGludXgvaG9va3MuYyB8ICAgMjkgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMgYi9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMK
aW5kZXggMTU4ZmM0N2Q4NjIwLi4wMjk0ZGEyYWFhY2QgMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L3Nl
bGludXgvaG9va3MuYworKysgYi9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMKQEAgLTE0NTEsMTMg
KzE0NTEsNyBAQCBzdGF0aWMgaW50IGlub2RlX2RvaW5pdF93aXRoX2RlbnRyeShzdHJ1Y3QgaW5v
ZGUgKmlub2RlLCBzdHJ1Y3QgZGVudHJ5ICpvcHRfZGVudAogCQkJICogaW5vZGVfZG9pbml0IHdp
dGggYSBkZW50cnksIGJlZm9yZSB0aGVzZSBpbm9kZXMgY291bGQKIAkJCSAqIGJlIHVzZWQgYWdh
aW4gYnkgdXNlcnNwYWNlLgogCQkJICovCi0JCQlpc2VjLT5pbml0aWFsaXplZCA9IExBQkVMX0lO
VkFMSUQ7Ci0JCQkvKgotCQkJICogVGhlcmUgaXMgbm90aGluZyB1c2VmdWwgdG8ganVtcCB0byB0
aGUgIm91dCIKLQkJCSAqIGxhYmVsLCBleGNlcHQgYSBuZWVkbGVzcyBzcGluIGxvY2svdW5sb2Nr
Ci0JCQkgKiBjeWNsZS4KLQkJCSAqLwotCQkJcmV0dXJuIDA7CisJCQlnb3RvIG91dF9pbnZhbGlk
OwogCQl9CiAKIAkJcmMgPSBpbm9kZV9kb2luaXRfdXNlX3hhdHRyKGlub2RlLCBkZW50cnksIHNi
c2VjLT5kZWZfc2lkLApAQCAtMTUxMywxNSArMTUwNyw4IEBAIHN0YXRpYyBpbnQgaW5vZGVfZG9p
bml0X3dpdGhfZGVudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBkZW50cnkgKm9wdF9k
ZW50CiAJCQkgKiBpbm9kZV9kb2luaXQoKSB3aXRoIGEgZGVudHJ5LCBiZWZvcmUgdGhlc2UgaW5v
ZGVzCiAJCQkgKiBjb3VsZCBiZSB1c2VkIGFnYWluIGJ5IHVzZXJzcGFjZS4KIAkJCSAqLwotCQkJ
aWYgKCFkZW50cnkpIHsKLQkJCQlpc2VjLT5pbml0aWFsaXplZCA9IExBQkVMX0lOVkFMSUQ7Ci0J
CQkJLyoKLQkJCQkgKiBUaGVyZSBpcyBub3RoaW5nIHVzZWZ1bCB0byBqdW1wIHRvIHRoZSAib3V0
IgotCQkJCSAqIGxhYmVsLCBleGNlcHQgYSBuZWVkbGVzcyBzcGluIGxvY2svdW5sb2NrCi0JCQkJ
ICogY3ljbGUuCi0JCQkJICovCi0JCQkJcmV0dXJuIDA7Ci0JCQl9CisJCQlpZiAoIWRlbnRyeSkK
KwkJCQlnb3RvIG91dF9pbnZhbGlkOwogCQkJcmMgPSBzZWxpbnV4X2dlbmZzX2dldF9zaWQoZGVu
dHJ5LCBzY2xhc3MsCiAJCQkJCQkgICBzYnNlYy0+ZmxhZ3MsICZzaWQpOwogCQkJaWYgKHJjKSB7
CkBAIC0xNTQ2LDExICsxNTMzLDEwIEBAIHN0YXRpYyBpbnQgaW5vZGVfZG9pbml0X3dpdGhfZGVu
dHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBkZW50cnkgKm9wdF9kZW50CiBvdXQ6CiAJ
c3Bpbl9sb2NrKCZpc2VjLT5sb2NrKTsKIAlpZiAoaXNlYy0+aW5pdGlhbGl6ZWQgPT0gTEFCRUxf
UEVORElORykgewotCQlpZiAoIXNpZCB8fCByYykgeworCQlpZiAocmMpIHsKIAkJCWlzZWMtPmlu
aXRpYWxpemVkID0gTEFCRUxfSU5WQUxJRDsKIAkJCWdvdG8gb3V0X3VubG9jazsKIAkJfQotCiAJ
CWlzZWMtPmluaXRpYWxpemVkID0gTEFCRUxfSU5JVElBTElaRUQ7CiAJCWlzZWMtPnNpZCA9IHNp
ZDsKIAl9CkBAIC0xNTU4LDYgKzE1NDQsMTMgQEAgc3RhdGljIGludCBpbm9kZV9kb2luaXRfd2l0
aF9kZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGRlbnRyeSAqb3B0X2RlbnQKIG91
dF91bmxvY2s6CiAJc3Bpbl91bmxvY2soJmlzZWMtPmxvY2spOwogCXJldHVybiByYzsKKworb3V0
X2ludmFsaWQ6CisJc3Bpbl9sb2NrKCZpc2VjLT5sb2NrKTsKKwlpZiAoaXNlYy0+aW5pdGlhbGl6
ZWQgPT0gTEFCRUxfUEVORElORykKKwkJaXNlYy0+aW5pdGlhbGl6ZWQgPSBMQUJFTF9JTlZBTElE
OworCXNwaW5fdW5sb2NrKCZpc2VjLT5sb2NrKTsKKwlyZXR1cm4gMDsKIH0KIAogLyogQ29udmVy
dCBhIExpbnV4IHNpZ25hbCB0byBhbiBhY2Nlc3MgdmVjdG9yLiAqLwo=
--0000000000009c59a805b336f33d--
