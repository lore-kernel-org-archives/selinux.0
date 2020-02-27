Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381F4C11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 19:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FA724691
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 19:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu+ZGc4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgB0T0W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:26:22 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37223 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgB0T0W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 14:26:22 -0500
Received: by mail-ot1-f47.google.com with SMTP id b3so288156otp.4
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=o2orY3b1gIY6JQAVjqqWiyx/bpScr0B3hVBkPYlfsgE=;
        b=cu+ZGc4gYpVkQHr19KUM9nx8ec0VgTUF+Bv5SKL69jWXuvDCpaNAfE4XmAlbcn0YKT
         sLUxSUZVKgptLoHB0CTQdrlxJG9pYMwBwHhAfQGFujj3HHM0pHB+EcpGm7W5Yn6wmMM9
         wDlyvcAtELiI8sTPUCMpdclkQKefAJsX0VOquLbDq3ZUNVLIvn9ThGz83B/P7296Q18J
         ZkN8myD+tYMENfnadfhmOhpKTUDEJJtu8x14c0223Hd8YDS1UOqse01KcKUTX5e7xAmr
         LcIQxc17pDze1d6/qj0GkmnhhCplqCV9XLamyR6bJoV9hdSqngVeLXUEnj0xRVl7IEej
         jwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=o2orY3b1gIY6JQAVjqqWiyx/bpScr0B3hVBkPYlfsgE=;
        b=OpbaZ8SZ/0qk5Pgz2m6FcUM+0wgaJoS0BLPETSAQxa/MkOeMcHQ+r3OxjPXts5KCG5
         p3J85k68DssAKEJiqlhXoLUjHdA2o01IVZX1c8TrLJwZ97OGAe12GyBsmY4sVg5DexhW
         FYtZAgjK7sJ4SAE2aWIyUJTk+/OB+5SFYZkUwEL5OuArHDNJiUra71+6cfU6+FsPWW3r
         zi/XC463h8RrO9X4sXaQCv+ISRojW0JWiLrEei7h/79NSFEoWI/UtdyAX/UroL5RiJbU
         tMhTR5LMerfoOxlJeSeAutTHlPlzKGR1+pNEv8xzpUwLwltD4ZwwVCByBaAqfyRchTG8
         imGw==
X-Gm-Message-State: APjAAAXveyGeXC18hEeczqtEVjzqplaUIFgrkPulgpT7VHB6AI4NUSE4
        dkHVC6ybGNmlL9XJUsDfdO4x5egQVXOySEK7RyVBmbxt
X-Google-Smtp-Source: APXvYqwoXbxMHAE0YtjjpDR2TOMdKycquQYQabTu+fwjggEZxrV02Hf/IRprs2ymz7673t7IUiZJ4YB4j/2/Pd2R/iI=
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr336945otp.339.1582831581362;
 Thu, 27 Feb 2020 11:26:21 -0800 (PST)
MIME-Version: 1.0
References: <CAB9W1A3-z1YokQUHusrgeuaX2SGyRuh+4X7b_GMEgEo5xe6k_Q@mail.gmail.com>
 <65b5e705-3d42-57c9-6502-973486b3c3c8@tycho.nsa.gov>
In-Reply-To: <65b5e705-3d42-57c9-6502-973486b3c3c8@tycho.nsa.gov>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 27 Feb 2020 14:27:30 -0500
Message-ID: <CAP+JOzSZoUwi8Lfioiu7PRgmexU=0h73p-rkpRConE_jEXboSA@mail.gmail.com>
Subject: Fwd: strange issue with name-base type trans
To:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000025a11a059f93b2ed"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--00000000000025a11a059f93b2ed
Content-Type: text/plain; charset="UTF-8"

Sorry, email problems has made life a bit difficult over the past
week. Steve had to forward this to me.

So far, I am unable to duplicate what you are seeing.

I tried to create policy similar to what you are doing, but I am
getting the correct results. The following is what I tested (the
attached policy is the full policy).

(macro trans_base ((type ARG1)(type ARG2)(type ARG3)(class ARG4)(name ARG5))
    (typetransition ARG1 ARG2 ARG4 ARG5 ARG3)
)

(block b0
       (type t0)
       (macro trans_add1 ((type ARG1)(type ARG2)(class ARG3)(name ARG4))
          (call trans_base (ARG1 t0 ARG2 ARG3 ARG4))
       )
)

(block b1
       (type t1a)
       (type t1b)
       (type t1c)
       (type t1d)
)

(in b1
    (macro trans_parent1a ((type ARG1)(class ARG2))
           (call .b0.trans_add1 (ARG1 t1a ARG2 "thisworks1a"))
    )
    (macro trans_parent2a ((type ARG1)(class ARG2)(name ARG3))
           (call .b0.trans_add1 (ARG1 t1b ARG2 ARG3))
    )
)

(call .b1.trans_parent1a (.b1.t1c CLASS))
(call .b1.trans_parent2a (.b1.t1d CLASS "thisdoesntwork2a"))

I then compiled and decompiled the policy:
  secilc -v -v -v -o test3.bin typetransition_problem_3.cil
  checkpolicy -b -C -o test3.cil test3.bin

In test3.cil, there is the following typetransition rules (which are
as they should be):
  (typetransition b1.t1c b0.t0 CLASS thisworks1a b1.t1a)
  (typetransition b1.t1d b0.t0 CLASS thisdoesntwork2a b1.t1b)

I must be doing something slightly different from what your policy is
doing and I could use help in figuring out what that might be.

Jim

---------- Forwarded message ---------
From: Dominick Grift <dominick.grift@defensec.nl>
Date: Mon, Feb 24, 2020 at 12:07 PM
Subject: strange issue with name-base type trans
To: <selinux@vger.kernel.org>


The scenario:

(in user
(macro obj_type_transition_mytmp1 ((type ARG1)(class ARG2))
(call .file.tmp_obj_type_transition (ARG1 tmp ARG2 "thisworks")))
(macro obj_type_transition_mytmp2 ((type ARG1)(class ARG2)(name ARG3))
(call .file.tmp_obj_type_transition (ARG1 tmp ARG2 ARG3))))

(call .user.obj_type_transition_mytmp1 (user.subj chr_file))
(call .user.obj_type_transition_mytmp2 (user.subj chr_file "thisdoesntwork"))

The outcome:

[root@myguest ~]# sesearch -T -s user.subj -c chr_file,blk_file | grep tmp
type_transition user.subj file.tmp:chr_file user.tmp ARG3;
type_transition user.subj file.tmp:chr_file user.tmp thisworks;

[root@myguest ~]# uname -a
Linux myguest 5.5.5-200.fc31.x86_64 #1 SMP Wed Feb 19 23:28:07 UTC
2020 x86_64 x86_64 x86_64 GNU/Linux
[root@myguest ~]# rpm -qa libsepol
libsepol-3.0-3.fc32.x86_64
[root@myguest ~]# rpm -qa libselinux
libselinux-3.0-3.fc32.x86_64

--
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--00000000000025a11a059f93b2ed
Content-Type: application/octet-stream; name="typetransition_problem_3.cil"
Content-Disposition: attachment; filename="typetransition_problem_3.cil"
Content-Transfer-Encoding: base64
Content-ID: <170881838c722ff52bb1>
X-Attachment-Id: 170881838c722ff52bb1

KGNsYXNzIENMQVNTIChQRVJNKSkKKGNsYXNzb3JkZXIgKENMQVNTKSkKKHNpZCBTSUQpCihzaWRv
cmRlciAoU0lEKSkKKHVzZXIgVVNFUikKKHJvbGUgUk9MRSkKKHR5cGUgVFlQRSkKKGNhdGVnb3J5
IENBVCkKKGNhdGVnb3J5b3JkZXIgKENBVCkpCihzZW5zaXRpdml0eSBTRU5TKQooc2Vuc2l0aXZp
dHlvcmRlciAoU0VOUykpCihzZW5zaXRpdml0eWNhdGVnb3J5IFNFTlMgKENBVCkpCihhbGxvdyBU
WVBFIHNlbGYgKENMQVNTIChQRVJNKSkpCihyb2xldHlwZSBST0xFIFRZUEUpCih1c2Vycm9sZSBV
U0VSIFJPTEUpCih1c2VybGV2ZWwgVVNFUiAoU0VOUykpCih1c2VycmFuZ2UgVVNFUiAoKFNFTlMp
KFNFTlMgKENBVCkpKSkKKHNpZGNvbnRleHQgU0lEIChVU0VSIFJPTEUgVFlQRSAoKFNFTlMpKFNF
TlMpKSkpCgo7Owo7OyBSZXBvcnQgYnkgRG9taW5pY2sgR3JpZnQgPGRvbWluaWNrLmdyaWZ0QGRl
ZmVuc2VjLm5sPgo7Owo7O2luIHVzZXIKOzsobWFjcm8gb2JqX3R5cGVfdHJhbnNpdGlvbl9teXRt
cDEgKCh0eXBlIEFSRzEpKGNsYXNzIEFSRzIpKQo7OyhjYWxsIC5maWxlLnRtcF9vYmpfdHlwZV90
cmFuc2l0aW9uIChBUkcxIHRtcCBBUkcyICJ0aGlzd29ya3MiKSkpCjs7KG1hY3JvIG9ial90eXBl
X3RyYW5zaXRpb25fbXl0bXAyICgodHlwZSBBUkcxKShjbGFzcyBBUkcyKShuYW1lIEFSRzMpKQo7
OyhjYWxsIC5maWxlLnRtcF9vYmpfdHlwZV90cmFuc2l0aW9uIChBUkcxIHRtcCBBUkcyIEFSRzMp
KSkpCjs7Cjs7KGNhbGwgLnVzZXIub2JqX3R5cGVfdHJhbnNpdGlvbl9teXRtcDEgKHVzZXIuc3Vi
aiBjaHJfZmlsZSkpCjs7KGNhbGwgLnVzZXIub2JqX3R5cGVfdHJhbnNpdGlvbl9teXRtcDIgKHVz
ZXIuc3ViaiBjaHJfZmlsZSAidGhpc2RvZXNudHdvcmsiKSkKOzsKOztUaGUgb3V0Y29tZToKOzsK
Oztbcm9vdEBteWd1ZXN0IH5dIyBzZXNlYXJjaCAtVCAtcyB1c2VyLnN1YmogLWMgY2hyX2ZpbGUs
YmxrX2ZpbGUgfCBncmVwIHRtcAo7O3R5cGVfdHJhbnNpdGlvbiB1c2VyLnN1YmogZmlsZS50bXA6
Y2hyX2ZpbGUgdXNlci50bXAgQVJHMzsKOzt0eXBlX3RyYW5zaXRpb24gdXNlci5zdWJqIGZpbGUu
dG1wOmNocl9maWxlIHVzZXIudG1wIHRoaXN3b3JrczsKOzsKCihtYWNybyB0cmFuc19iYXNlICgo
dHlwZSBBUkcxKSh0eXBlIEFSRzIpKHR5cGUgQVJHMykoY2xhc3MgQVJHNCkobmFtZSBBUkc1KSkK
CSh0eXBldHJhbnNpdGlvbiBBUkcxIEFSRzIgQVJHNCBBUkc1IEFSRzMpCikKCihibG9jayBiMAog
ICAgICAgKHR5cGUgdDApCiAgICAgICAobWFjcm8gdHJhbnNfYWRkMSAoKHR5cGUgQVJHMSkodHlw
ZSBBUkcyKShjbGFzcyBBUkczKShuYW1lIEFSRzQpKQoJICAgICAgKGNhbGwgdHJhbnNfYmFzZSAo
QVJHMSB0MCBBUkcyIEFSRzMgQVJHNCkpCiAgICAgICApCikKCihibG9jayBiMQogICAgICAgKHR5
cGUgdDFhKQogICAgICAgKHR5cGUgdDFiKQogICAgICAgKHR5cGUgdDFjKQogICAgICAgKHR5cGUg
dDFkKQopCgooaW4gYjEKICAgIChtYWNybyB0cmFuc19wYXJlbnQxYSAoKHR5cGUgQVJHMSkoY2xh
c3MgQVJHMikpCiAgICAJICAgKGNhbGwgLmIwLnRyYW5zX2FkZDEgKEFSRzEgdDFhIEFSRzIgInRo
aXN3b3JrczFhIikpCiAgICApCiAgICAobWFjcm8gdHJhbnNfcGFyZW50MmEgKCh0eXBlIEFSRzEp
KGNsYXNzIEFSRzIpKG5hbWUgQVJHMykpCiAgICAJICAgKGNhbGwgLmIwLnRyYW5zX2FkZDEgKEFS
RzEgdDFiIEFSRzIgQVJHMykpCiAgICApCikKCihjYWxsIC5iMS50cmFuc19wYXJlbnQxYSAoLmIx
LnQxYyBDTEFTUykpCihjYWxsIC5iMS50cmFuc19wYXJlbnQyYSAoLmIxLnQxZCBDTEFTUyAidGhp
c2RvZXNudHdvcmsyYSIpKQoKOzsgQ29tcGlsZSBhbmQgZGVjb21waWxlOgo7OyAgIHNlY2lsYyAt
diAtdiAtdiAtbyB0ZXN0My5iaW4gdHlwZXRyYW5zaXRpb25fcHJvYmxlbV8zLmNpbAo7OyAgIGNo
ZWNrcG9saWN5IC1iIC1DIC1vIHRlc3QzLmNpbCB0ZXN0My5iaW4KOzsgSW4gdGVzdDMuY2lsLCB3
ZSBoYXZlIHRoZSBmb2xsb3dpbmc6Cjs7ICAgKHR5cGV0cmFuc2l0aW9uIGIxLnQxYyBiMC50MCBD
TEFTUyB0aGlzd29ya3MxYSBiMS50MWEpCjs7ICAgKHR5cGV0cmFuc2l0aW9uIGIxLnQxZCBiMC50
MCBDTEFTUyB0aGlzZG9lc250d29yazJhIGIxLnQxYikK
--00000000000025a11a059f93b2ed--
