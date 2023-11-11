Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28872C4332F
	for <selinux@archiver.kernel.org>; Sat, 11 Nov 2023 21:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjKKVxU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Nov 2023 16:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKVxT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Nov 2023 16:53:19 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B681F30CF
        for <selinux@vger.kernel.org>; Sat, 11 Nov 2023 13:53:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9e4675c7a5fso471974866b.0
        for <selinux@vger.kernel.org>; Sat, 11 Nov 2023 13:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699739593; x=1700344393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vPppeRnquzQpV5QvM5Ntw+qjhXUQGMBuaAb5cxGhLoQ=;
        b=N8Gp60rWDDDwDhWPumG16YnuCtnAAMIEbo0UpOU5Ax/o88gXg3SQRtGwYzOkqTKUlS
         GT8SjSMI9iwxxOSLD9vnf8UzQPHYEuSXl+YRTbGi2lF57N6Ifv6nzRTJyvFXBT1arRl0
         GqFRvOeQnKijiLB7rKlzBExFREU2nRSV3j4CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699739593; x=1700344393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPppeRnquzQpV5QvM5Ntw+qjhXUQGMBuaAb5cxGhLoQ=;
        b=ucCJVET9NOLNgCR/+sLGjJeLNMG27MVGzeFSjdH6RHy5u9qhuV5Eg6LmrmgPWqZ5nR
         Z/VsGkOKhNFWhJe3lyUalAFCz5HkhiEXJBxdSwBKc4M6GF6UiwSenONhSekidrIwKVBT
         AGPCm2Jy1qRYfYMOelRYrgfXIQiXkY+p782uh7kesQJ6S3RMK4w7KIw6HZnJyrxmgbu0
         3wuaM7Rcddbi9kozkTHqqnjMg+xJgGVYUprP0woi4xvAmhSmYDdMNaikBDsx4+mgmyj2
         osyotu+YTNtQdV9aH4SF/ll1Yc3gGODsTMdMNtjza8RkGQPv6jy4l8xciyI12qaP+X6j
         Jjqg==
X-Gm-Message-State: AOJu0YzP2yyOPir17qdCe6Jd5pGjoN7HHh4yrp5hlJdyy3xyTYc8qL67
        qKph+8o+5fFTLS1OW4t3Bc1GdTxTKMc6uwbpyyVjnw==
X-Google-Smtp-Source: AGHT+IFoeyjC5YzHKbXmkxKjl49CSrNB469LoZvN8TsxEnd7+jZajXY52WUQ49Lha8jhUH3S2dGwmQ==
X-Received: by 2002:a17:907:2d2b:b0:9e6:4dfb:bc6e with SMTP id gs43-20020a1709072d2b00b009e64dfbbc6emr2567084ejc.29.1699739593378;
        Sat, 11 Nov 2023 13:53:13 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906601500b009e655c77a53sm1613269ejj.132.2023.11.11.13.53.12
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 13:53:12 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so5349155a12.3
        for <selinux@vger.kernel.org>; Sat, 11 Nov 2023 13:53:12 -0800 (PST)
X-Received: by 2002:aa7:d387:0:b0:53d:a1c0:410f with SMTP id
 x7-20020aa7d387000000b0053da1c0410fmr2324921edq.2.1699739591677; Sat, 11 Nov
 2023 13:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20231111160954.45911-2-paul@paul-moore.com>
In-Reply-To: <20231111160954.45911-2-paul@paul-moore.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Nov 2023 13:52:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjg45Pg5qxbio9szL+rMSGT7qm3a466d-zVwZwO96FNdw@mail.gmail.com>
Message-ID: <CAHk-=wjg45Pg5qxbio9szL+rMSGT7qm3a466d-zVwZwO96FNdw@mail.gmail.com>
Subject: Re: [PATCH] selinux: update filenametr_hash() to use full_name_hash()
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000092d38c0609e77643"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--00000000000092d38c0609e77643
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Nov 2023 at 08:10, Paul Moore <paul@paul-moore.com> wrote:
>
> Using full_name_hash() instead of partial_name_hash() should result
> in cleaner and better performing code.

This looks obviously good to me, but I don't actually know what that
hash is used for and whether it all matters.

Also, looking at the actual use of this all, I suspect the *real*
issue that started this all is that in hashtab_search(), we have

        hvalue = key_params.hash(key) & (h->size - 1);
        cur = h->htable[hvalue];

and it's that "& (h->size - 1)" thing in that hash search function
that caused problems in the first place, and that made Christian then
do that commit 37b7ea3ca306 ("selinux: improve role transition
hashing") that in turn made me look at it all.

That "just use the low bits of the hash" really ends up being the
simplest model, but it's also the worst possible thing if the hash
itself isn't spreading out all bits optimally.

We have a much better function for this, so instead of doing "x &
(size-1)" to get a hash value, you do "hash_32(x, bits)".

But that requires 'bits' instead of 'size'.

So here's a *TOTALLY UNTESTED* patch that tries to remove the use of
"h->size' for the hash table size, and replace it with an
almost-equivalent 'h->hbits' for the size of the table in bits.

I say _almost_ equivalent, because I kept the "zero means no table"
behavior, so it turns out that you cannot have a hash table of just
one entry (h->hbits would be zero). So the minimal hash table size is
2 (hbits = 1).

Honestly, I doubt that matters.

Now, that actually makes this patch somewhat intrusive, because there
were quite a bit of places that used h->size, for obvious reasons.

Also, while at it, I removed the pattern that I absolutely *detest*
that the list handling in the hashing code used, which was that
disgusting "what is the previous pointer to be filled in" pattern.

The trivial - and *horrible* - way to do it is

        prev = NULL;
        cur = h->htable[hvalue];
        ... walk the list ...
                prev = cur;
        ...
        prev ? &prev->next : &h->htable[hvalue],

which shows that people don't understand the power of pointers.

The *proper* way to do this with pointers is:

        pprev = hashtab_entry(h, key, key_params);
        .. walk the list with (cur = *pprev) != NULL) ...
                pprev = &cur->next;
        ...
        pprev

which doesn't have that unnecessary conditional for "is this the first
entry". It not only generates better code, it shows that you
understand pointers.

Yes, this is the smallest hill I'll die on. It's literally a pet peeve of mine.

I also moved variable declarations into the blocks where they are
used, rather than at the top level.

Now, I want to state this very clearly once again: this attached patch
is ENTIRELY UNTESTED.  It might have some completely stupid thinko in
it, and may be entirely broken.

I test-compiled it, and I've looked through it a couple of times for
sanity, and I do think it's better to keep "hbits" around instead of
"size", but I'm not going to force this on you.

Anyway, I guess I should test this, but here is that untested patch if
you want to consider it.

               Linus

--00000000000092d38c0609e77643
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_loul15sz0>
X-Attachment-Id: f_loul15sz0

IHNlY3VyaXR5L3NlbGludXgvc3MvaGFzaHRhYi5jICB8IDc4ICsrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLQogc2VjdXJpdHkvc2VsaW51eC9zcy9oYXNodGFiLmggIHwg
NDEgKysrKysrKysrKysrLS0tLS0tLS0tLQogc2VjdXJpdHkvc2VsaW51eC9zcy9wb2xpY3lkYi5j
IHwgIDIgKy0KIDMgZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKSwgNTcgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvc2VsaW51eC9zcy9oYXNodGFiLmMgYi9zZWN1cml0
eS9zZWxpbnV4L3NzL2hhc2h0YWIuYwppbmRleCBjMDVkODM0NmE5NGEuLmI0YmMxYWViZWJlNiAx
MDA2NDQKLS0tIGEvc2VjdXJpdHkvc2VsaW51eC9zcy9oYXNodGFiLmMKKysrIGIvc2VjdXJpdHkv
c2VsaW51eC9zcy9oYXNodGFiLmMKQEAgLTI0LDI1ICsyNCwyNyBAQCBzdGF0aWMgc3RydWN0IGtt
ZW1fY2FjaGUgKmhhc2h0YWJfbm9kZV9jYWNoZXAgX19yb19hZnRlcl9pbml0OwogICogVGhlIHRv
dGFsIG1lbW9yeSB1c2VkIGJ5IHRoZSBodGFibGUgYXJyYXlzIChvbmx5KSB3aXRoIEZlZG9yYSBw
b2xpY3kgbG9hZGVkCiAgKiBpcyBhcHByb3hpbWF0ZWx5IDE2MyBLQiBhdCB0aGUgdGltZSBvZiB3
cml0aW5nLgogICovCi1zdGF0aWMgdTMyIGhhc2h0YWJfY29tcHV0ZV9zaXplKHUzMiBuZWwpCitz
dGF0aWMgdTMyIGhhc2h0YWJfY29tcHV0ZV9oYml0cyh1MzIgbmVsKQogewotCXJldHVybiBuZWwg
PT0gMCA/IDAgOiByb3VuZHVwX3Bvd19vZl90d28obmVsKTsKKwlpZiAobmVsIDw9IDEpCisJCXJl
dHVybiBuZWw7CisJcmV0dXJuIGlsb2cyKG5lbCAtIDEpICsgMTsKIH0KIAogaW50IGhhc2h0YWJf
aW5pdChzdHJ1Y3QgaGFzaHRhYiAqaCwgdTMyIG5lbF9oaW50KQogewotCXUzMiBzaXplID0gaGFz
aHRhYl9jb21wdXRlX3NpemUobmVsX2hpbnQpOworCXUzMiBoYml0cyA9IGhhc2h0YWJfY29tcHV0
ZV9oYml0cyhuZWxfaGludCk7CiAKIAkvKiBzaG91bGQgYWxyZWFkeSBiZSB6ZXJvZWQsIGJ1dCBi
ZXR0ZXIgYmUgc2FmZSAqLwogCWgtPm5lbCA9IDA7Ci0JaC0+c2l6ZSA9IDA7CisJaC0+aGJpdHMg
PSAwOwogCWgtPmh0YWJsZSA9IE5VTEw7CiAKLQlpZiAoc2l6ZSkgewotCQloLT5odGFibGUgPSBr
Y2FsbG9jKHNpemUsIHNpemVvZigqaC0+aHRhYmxlKSwgR0ZQX0tFUk5FTCk7CisJaWYgKGhiaXRz
KSB7CisJCWgtPmh0YWJsZSA9IGtjYWxsb2MoMSA8PCBoYml0cywgc2l6ZW9mKCpoLT5odGFibGUp
LCBHRlBfS0VSTkVMKTsKIAkJaWYgKCFoLT5odGFibGUpCiAJCQlyZXR1cm4gLUVOT01FTTsKLQkJ
aC0+c2l6ZSA9IHNpemU7CisJCWgtPmhiaXRzID0gaGJpdHM7CiAJfQogCXJldHVybiAwOwogfQpA
QCAtNjYsMTAgKzY4LDExIEBAIGludCBfX2hhc2h0YWJfaW5zZXJ0KHN0cnVjdCBoYXNodGFiICpo
LCBzdHJ1Y3QgaGFzaHRhYl9ub2RlICoqZHN0LAogCiB2b2lkIGhhc2h0YWJfZGVzdHJveShzdHJ1
Y3QgaGFzaHRhYiAqaCkKIHsKLQl1MzIgaTsKLQlzdHJ1Y3QgaGFzaHRhYl9ub2RlICpjdXIsICp0
ZW1wOworCXUzMiBzaXplID0gaGFzaHRhYl9zaXplKGgpOworCisJZm9yICh1MzIgaSA9IDA7IGkg
PCBzaXplOyBpKyspIHsKKwkJc3RydWN0IGhhc2h0YWJfbm9kZSAqY3VyLCAqdGVtcDsKIAotCWZv
ciAoaSA9IDA7IGkgPCBoLT5zaXplOyBpKyspIHsKIAkJY3VyID0gaC0+aHRhYmxlW2ldOwogCQl3
aGlsZSAoY3VyKSB7CiAJCQl0ZW1wID0gY3VyOwpAQCAtODEsMjAgKzg0LDE5IEBAIHZvaWQgaGFz
aHRhYl9kZXN0cm95KHN0cnVjdCBoYXNodGFiICpoKQogCiAJa2ZyZWUoaC0+aHRhYmxlKTsKIAlo
LT5odGFibGUgPSBOVUxMOworCWgtPmhiaXRzID0gMDsKIH0KIAogaW50IGhhc2h0YWJfbWFwKHN0
cnVjdCBoYXNodGFiICpoLAogCQlpbnQgKCphcHBseSkodm9pZCAqaywgdm9pZCAqZCwgdm9pZCAq
YXJncyksCiAJCXZvaWQgKmFyZ3MpCiB7Ci0JdTMyIGk7Ci0JaW50IHJldDsKLQlzdHJ1Y3QgaGFz
aHRhYl9ub2RlICpjdXI7CisJdTMyIHNpemUgPSBoYXNodGFiX3NpemUoaCk7CiAKLQlmb3IgKGkg
PSAwOyBpIDwgaC0+c2l6ZTsgaSsrKSB7Ci0JCWN1ciA9IGgtPmh0YWJsZVtpXTsKKwlmb3IgKHUz
MiBpID0gMDsgaSA8IHNpemU7IGkrKykgeworCQlzdHJ1Y3QgaGFzaHRhYl9ub2RlICpjdXIgPSBj
dXIgPSBoLT5odGFibGVbaV07CiAJCXdoaWxlIChjdXIpIHsKLQkJCXJldCA9IGFwcGx5KGN1ci0+
a2V5LCBjdXItPmRhdHVtLCBhcmdzKTsKKwkJCWludCByZXQgPSBhcHBseShjdXItPmtleSwgY3Vy
LT5kYXR1bSwgYXJncyk7CiAJCQlpZiAocmV0KQogCQkJCXJldHVybiByZXQ7CiAJCQljdXIgPSBj
dXItPm5leHQ7CkBAIC0xMDYsMTggKzEwOCwxOCBAQCBpbnQgaGFzaHRhYl9tYXAoc3RydWN0IGhh
c2h0YWIgKmgsCiAjaWZkZWYgQ09ORklHX1NFQ1VSSVRZX1NFTElOVVhfREVCVUcKIHZvaWQgaGFz
aHRhYl9zdGF0KHN0cnVjdCBoYXNodGFiICpoLCBzdHJ1Y3QgaGFzaHRhYl9pbmZvICppbmZvKQog
ewotCXUzMiBpLCBjaGFpbl9sZW4sIHNsb3RzX3VzZWQsIG1heF9jaGFpbl9sZW47CisJdTMyIHNp
emUgPSBoYXNodGFiX3NpemUoaCk7CisJdTMyIHNsb3RzX3VzZWQsIG1heF9jaGFpbl9sZW47CiAJ
dTY0IGNoYWluMl9sZW5fc3VtOwotCXN0cnVjdCBoYXNodGFiX25vZGUgKmN1cjsKIAogCXNsb3Rz
X3VzZWQgPSAwOwogCW1heF9jaGFpbl9sZW4gPSAwOwogCWNoYWluMl9sZW5fc3VtID0gMDsKLQlm
b3IgKGkgPSAwOyBpIDwgaC0+c2l6ZTsgaSsrKSB7Ci0JCWN1ciA9IGgtPmh0YWJsZVtpXTsKKwlm
b3IgKHUzMiBpID0gMDsgaSA8IHNpemU7IGkrKykgeworCQlzdHJ1Y3QgaGFzaHRhYl9ub2RlICpj
dXIgPSBoLT5odGFibGVbaV07CiAJCWlmIChjdXIpIHsKKwkJCXUzMiBjaGFpbl9sZW4gPSAwOwog
CQkJc2xvdHNfdXNlZCsrOwotCQkJY2hhaW5fbGVuID0gMDsKIAkJCXdoaWxlIChjdXIpIHsKIAkJ
CQljaGFpbl9sZW4rKzsKIAkJCQljdXIgPSBjdXItPm5leHQ7CkBAIC0xNDIsMzYgKzE0NCwzNSBA
QCBpbnQgaGFzaHRhYl9kdXBsaWNhdGUoc3RydWN0IGhhc2h0YWIgKm5ldywgc3RydWN0IGhhc2h0
YWIgKm9yaWcsCiAJCWludCAoKmRlc3Ryb3kpKHZvaWQgKmssIHZvaWQgKmQsIHZvaWQgKmFyZ3Mp
LAogCQl2b2lkICphcmdzKQogewotCXN0cnVjdCBoYXNodGFiX25vZGUgKmN1ciwgKnRtcCwgKnRh
aWw7Ci0JdTMyIGk7Ci0JaW50IHJjOworCXUzMiBzaXplID0gaGFzaHRhYl9zaXplKG9yaWcpOwog
CiAJbWVtc2V0KG5ldywgMCwgc2l6ZW9mKCpuZXcpKTsKIAotCW5ldy0+aHRhYmxlID0ga2NhbGxv
YyhvcmlnLT5zaXplLCBzaXplb2YoKm5ldy0+aHRhYmxlKSwgR0ZQX0tFUk5FTCk7Ci0JaWYgKCFu
ZXctPmh0YWJsZSkKLQkJcmV0dXJuIC1FTk9NRU07CisJaWYgKHNpemUpIHsKKwkJbmV3LT5odGFi
bGUgPSBrY2FsbG9jKHNpemUsIHNpemVvZigqbmV3LT5odGFibGUpLCBHRlBfS0VSTkVMKTsKKwkJ
aWYgKCFuZXctPmh0YWJsZSkKKwkJCXJldHVybiAtRU5PTUVNOworCQluZXctPmhiaXRzID0gb3Jp
Zy0+aGJpdHM7CisJfQogCi0JbmV3LT5zaXplID0gb3JpZy0+c2l6ZTsKKwlmb3IgKHUzMiBpID0g
MDsgaSA8IHNpemU7IGkrKykgeworCQlzdHJ1Y3QgaGFzaHRhYl9ub2RlICpjdXIsICoqdGFpbHA7
CisJCXRhaWxwID0gbmV3LT5odGFibGUgKyBpOwogCi0JZm9yIChpID0gMDsgaSA8IG9yaWctPnNp
emU7IGkrKykgewotCQl0YWlsID0gTlVMTDsKIAkJZm9yIChjdXIgPSBvcmlnLT5odGFibGVbaV07
IGN1cjsgY3VyID0gY3VyLT5uZXh0KSB7CisJCQlzdHJ1Y3QgaGFzaHRhYl9ub2RlICp0bXA7CisK
IAkJCXRtcCA9IGttZW1fY2FjaGVfemFsbG9jKGhhc2h0YWJfbm9kZV9jYWNoZXAsCiAJCQkJCQlH
RlBfS0VSTkVMKTsKIAkJCWlmICghdG1wKQogCQkJCWdvdG8gZXJyb3I7Ci0JCQlyYyA9IGNvcHko
dG1wLCBjdXIsIGFyZ3MpOwotCQkJaWYgKHJjKSB7CisJCQlpZiAoY29weSh0bXAsIGN1ciwgYXJn
cykpIHsKIAkJCQlrbWVtX2NhY2hlX2ZyZWUoaGFzaHRhYl9ub2RlX2NhY2hlcCwgdG1wKTsKIAkJ
CQlnb3RvIGVycm9yOwogCQkJfQogCQkJdG1wLT5uZXh0ID0gTlVMTDsKLQkJCWlmICghdGFpbCkK
LQkJCQluZXctPmh0YWJsZVtpXSA9IHRtcDsKLQkJCWVsc2UKLQkJCQl0YWlsLT5uZXh0ID0gdG1w
OwotCQkJdGFpbCA9IHRtcDsKKwkJCSp0YWlscCA9IHRtcDsKKwkJCXRhaWxwID0gJnRtcC0+bmV4
dDsKIAkJCW5ldy0+bmVsKys7CiAJCX0KIAl9CkBAIC0xNzksNyArMTgwLDggQEAgaW50IGhhc2h0
YWJfZHVwbGljYXRlKHN0cnVjdCBoYXNodGFiICpuZXcsIHN0cnVjdCBoYXNodGFiICpvcmlnLAog
CXJldHVybiAwOwogCiAgZXJyb3I6Ci0JZm9yIChpID0gMDsgaSA8IG5ldy0+c2l6ZTsgaSsrKSB7
CisJZm9yICh1MzIgaSA9IDA7IGkgPCBzaXplOyBpKyspIHsKKwkJc3RydWN0IGhhc2h0YWJfbm9k
ZSAqY3VyLCAqdG1wOwogCQlmb3IgKGN1ciA9IG5ldy0+aHRhYmxlW2ldOyBjdXI7IGN1ciA9IHRt
cCkgewogCQkJdG1wID0gY3VyLT5uZXh0OwogCQkJZGVzdHJveShjdXItPmtleSwgY3VyLT5kYXR1
bSwgYXJncyk7CmRpZmYgLS1naXQgYS9zZWN1cml0eS9zZWxpbnV4L3NzL2hhc2h0YWIuaCBiL3Nl
Y3VyaXR5L3NlbGludXgvc3MvaGFzaHRhYi5oCmluZGV4IDA5YjBhMzc0NDkzNy4uNmI2NWM5YTUy
NTU5IDEwMDY0NAotLS0gYS9zZWN1cml0eS9zZWxpbnV4L3NzL2hhc2h0YWIuaAorKysgYi9zZWN1
cml0eS9zZWxpbnV4L3NzL2hhc2h0YWIuaApAQCAtMTQsNiArMTQsNyBAQAogI2luY2x1ZGUgPGxp
bnV4L3R5cGVzLmg+CiAjaW5jbHVkZSA8bGludXgvZXJybm8uaD4KICNpbmNsdWRlIDxsaW51eC9z
Y2hlZC5oPgorI2luY2x1ZGUgPGxpbnV4L2hhc2guaD4KIAogI2RlZmluZSBIQVNIVEFCX01BWF9O
T0RFUwlVMzJfTUFYCiAKQEAgLTMxLDcgKzMyLDcgQEAgc3RydWN0IGhhc2h0YWJfbm9kZSB7CiAK
IHN0cnVjdCBoYXNodGFiIHsKIAlzdHJ1Y3QgaGFzaHRhYl9ub2RlICoqaHRhYmxlOwkvKiBoYXNo
IHRhYmxlICovCi0JdTMyIHNpemU7CQkJLyogbnVtYmVyIG9mIHNsb3RzIGluIGhhc2ggdGFibGUg
Ki8KKwl1MzIgaGJpdHM7CQkJLyogbnVtYmVyIG9mIHNsb3RzIGluIGhhc2ggdGFibGUgKi8KIAl1
MzIgbmVsOwkJCS8qIG51bWJlciBvZiBlbGVtZW50cyBpbiBoYXNoIHRhYmxlICovCiB9OwogCkBA
IC00MSw2ICs0MiwxMSBAQCBzdHJ1Y3QgaGFzaHRhYl9pbmZvIHsKIAl1NjQgY2hhaW4yX2xlbl9z
dW07CiB9OwogCitzdGF0aWMgaW5saW5lIHUzMiBoYXNodGFiX3NpemUoY29uc3Qgc3RydWN0IGhh
c2h0YWIgKmgpCit7CisJcmV0dXJuIGgtPmhiaXRzID8gMSA8PCBoLT5oYml0cyA6IDA7Cit9CisK
IC8qCiAgKiBJbml0aWFsaXplcyBhIG5ldyBoYXNoIHRhYmxlIHdpdGggdGhlIHNwZWNpZmllZCBj
aGFyYWN0ZXJpc3RpY3MuCiAgKgpAQCAtNTEsNiArNTcsMTIgQEAgaW50IGhhc2h0YWJfaW5pdChz
dHJ1Y3QgaGFzaHRhYiAqaCwgdTMyIG5lbF9oaW50KTsKIGludCBfX2hhc2h0YWJfaW5zZXJ0KHN0
cnVjdCBoYXNodGFiICpoLCBzdHJ1Y3QgaGFzaHRhYl9ub2RlICoqZHN0LAogCQkgICAgIHZvaWQg
KmtleSwgdm9pZCAqZGF0dW0pOwogCitzdGF0aWMgaW5saW5lIHN0cnVjdCBoYXNodGFiX25vZGUg
KipoYXNodGFiX2VudHJ5KHN0cnVjdCBoYXNodGFiICpoLAorCWNvbnN0IHZvaWQgKmtleSwgY29u
c3Qgc3RydWN0IGhhc2h0YWJfa2V5X3BhcmFtcyBrZXlfcGFyYW1zKQoreworCXJldHVybiBoLT5o
dGFibGUgKyBoYXNoXzMyKGtleV9wYXJhbXMuaGFzaChrZXkpLCBoLT5oYml0cyk7Cit9CisKIC8q
CiAgKiBJbnNlcnRzIHRoZSBzcGVjaWZpZWQgKGtleSwgZGF0dW0pIHBhaXIgaW50byB0aGUgc3Bl
Y2lmaWVkIGhhc2ggdGFibGUuCiAgKgpAQCAtNjAsMzIgKzcyLDI3IEBAIGludCBfX2hhc2h0YWJf
aW5zZXJ0KHN0cnVjdCBoYXNodGFiICpoLCBzdHJ1Y3QgaGFzaHRhYl9ub2RlICoqZHN0LAogICAw
IG90aGVyd2lzZS4KICAqLwogc3RhdGljIGlubGluZSBpbnQgaGFzaHRhYl9pbnNlcnQoc3RydWN0
IGhhc2h0YWIgKmgsIHZvaWQgKmtleSwgdm9pZCAqZGF0dW0sCi0JCQkJIHN0cnVjdCBoYXNodGFi
X2tleV9wYXJhbXMga2V5X3BhcmFtcykKKwkJCQkgY29uc3Qgc3RydWN0IGhhc2h0YWJfa2V5X3Bh
cmFtcyBrZXlfcGFyYW1zKQogewotCXUzMiBodmFsdWU7Ci0Jc3RydWN0IGhhc2h0YWJfbm9kZSAq
cHJldiwgKmN1cjsKKwlzdHJ1Y3QgaGFzaHRhYl9ub2RlICoqcHByZXY7CiAKIAljb25kX3Jlc2No
ZWQoKTsKIAotCWlmICghaC0+c2l6ZSB8fCBoLT5uZWwgPT0gSEFTSFRBQl9NQVhfTk9ERVMpCisJ
aWYgKCFoLT5oYml0cyB8fCBoLT5uZWwgPT0gSEFTSFRBQl9NQVhfTk9ERVMpCiAJCXJldHVybiAt
RUlOVkFMOwogCi0JaHZhbHVlID0ga2V5X3BhcmFtcy5oYXNoKGtleSkgJiAoaC0+c2l6ZSAtIDEp
OwotCXByZXYgPSBOVUxMOwotCWN1ciA9IGgtPmh0YWJsZVtodmFsdWVdOwotCXdoaWxlIChjdXIp
IHsKKwlwcHJldiA9IGhhc2h0YWJfZW50cnkoaCwga2V5LCBrZXlfcGFyYW1zKTsKKwlmb3IgKHN0
cnVjdCBoYXNodGFiX25vZGUgKmN1cjsgKGN1ciA9ICpwcHJldikgIT0gTlVMTDsgKSB7CiAJCWlu
dCBjbXAgPSBrZXlfcGFyYW1zLmNtcChrZXksIGN1ci0+a2V5KTsKIAogCQlpZiAoY21wID09IDAp
CiAJCQlyZXR1cm4gLUVFWElTVDsKIAkJaWYgKGNtcCA8IDApCiAJCQlicmVhazsKLQkJcHJldiA9
IGN1cjsKLQkJY3VyID0gY3VyLT5uZXh0OworCQlwcHJldiA9ICZjdXItPm5leHQ7CiAJfQogCi0J
cmV0dXJuIF9faGFzaHRhYl9pbnNlcnQoaCwgcHJldiA/ICZwcmV2LT5uZXh0IDogJmgtPmh0YWJs
ZVtodmFsdWVdLAotCQkJCWtleSwgZGF0dW0pOworCXJldHVybiBfX2hhc2h0YWJfaW5zZXJ0KGgs
IHBwcmV2LCBrZXksIGRhdHVtKTsKIH0KIAogLyoKQEAgLTk1LDE2ICsxMDIsMTQgQEAgc3RhdGlj
IGlubGluZSBpbnQgaGFzaHRhYl9pbnNlcnQoc3RydWN0IGhhc2h0YWIgKmgsIHZvaWQgKmtleSwg
dm9pZCAqZGF0dW0sCiAgKiB0aGUgZGF0dW0gb2YgdGhlIGVudHJ5IG90aGVyd2lzZS4KICAqLwog
c3RhdGljIGlubGluZSB2b2lkICpoYXNodGFiX3NlYXJjaChzdHJ1Y3QgaGFzaHRhYiAqaCwgY29u
c3Qgdm9pZCAqa2V5LAotCQkJCSAgIHN0cnVjdCBoYXNodGFiX2tleV9wYXJhbXMga2V5X3BhcmFt
cykKKwkJCQkgICBjb25zdCBzdHJ1Y3QgaGFzaHRhYl9rZXlfcGFyYW1zIGtleV9wYXJhbXMpCiB7
Ci0JdTMyIGh2YWx1ZTsKIAlzdHJ1Y3QgaGFzaHRhYl9ub2RlICpjdXI7CiAKLQlpZiAoIWgtPnNp
emUpCisJaWYgKCFoLT5oYml0cykKIAkJcmV0dXJuIE5VTEw7CiAKLQlodmFsdWUgPSBrZXlfcGFy
YW1zLmhhc2goa2V5KSAmIChoLT5zaXplIC0gMSk7Ci0JY3VyID0gaC0+aHRhYmxlW2h2YWx1ZV07
CisJY3VyID0gKmhhc2h0YWJfZW50cnkoaCwga2V5LCBrZXlfcGFyYW1zKTsKIAl3aGlsZSAoY3Vy
KSB7CiAJCWludCBjbXAgPSBrZXlfcGFyYW1zLmNtcChrZXksIGN1ci0+a2V5KTsKIApkaWZmIC0t
Z2l0IGEvc2VjdXJpdHkvc2VsaW51eC9zcy9wb2xpY3lkYi5jIGIvc2VjdXJpdHkvc2VsaW51eC9z
cy9wb2xpY3lkYi5jCmluZGV4IDU5NWE0MzVlYTljOC4uNjFiYzgyYjJjZWE2IDEwMDY0NAotLS0g
YS9zZWN1cml0eS9zZWxpbnV4L3NzL3BvbGljeWRiLmMKKysrIGIvc2VjdXJpdHkvc2VsaW51eC9z
cy9wb2xpY3lkYi5jCkBAIC02ODUsNyArNjg1LDcgQEAgc3RhdGljIHZvaWQgaGFzaF9ldmFsKHN0
cnVjdCBoYXNodGFiICpoLCBjb25zdCBjaGFyICpoYXNoX25hbWUpCiAKIAloYXNodGFiX3N0YXQo
aCwgJmluZm8pOwogCXByX2RlYnVnKCJTRUxpbnV4OiAlczogICVkIGVudHJpZXMgYW5kICVkLyVk
IGJ1Y2tldHMgdXNlZCwgbG9uZ2VzdCBjaGFpbiBsZW5ndGggJWQsIHN1bSBvZiBjaGFpbiBsZW5n
dGheMiAlbGx1XG4iLAotCQkgaGFzaF9uYW1lLCBoLT5uZWwsIGluZm8uc2xvdHNfdXNlZCwgaC0+
c2l6ZSwKKwkJIGhhc2hfbmFtZSwgaC0+bmVsLCBpbmZvLnNsb3RzX3VzZWQsIGhhc2h0YWJfc2l6
ZShoKSwKIAkJIGluZm8ubWF4X2NoYWluX2xlbiwgaW5mby5jaGFpbjJfbGVuX3N1bSk7CiB9CiAK
--00000000000092d38c0609e77643--
