Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0F1E5724
	for <selinux@vger.kernel.org>; Thu,  9 Jul 2026 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622748; cv=pass; b=rA7LhaQ5pxxUrdvuCDoxZTUvkNK0Mk0baOPzFMQ+8s3FFJALPgCSOsL2hpYJuIHU0yNz1QimIc6is0pmSE7gindhdaVyKVBSPMH2FCAtfi8zCATnuHyO8moY3L/DzKC2Ye4AGHpWac1u/A22CinJqjoJMyU8i5uJIVYteQ0ruHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622748; c=relaxed/simple;
	bh=3u4SByrKRVfS8I4FnJRaJLFnCPrpRec3ttF9McSbocI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=avy82zDgx/vJVlgj125oB3+ePs8SDDYjaGEQU/qd5F8TW/O4c+5ueVF/9Z64vB+pVf8kHc9lW+W2G7nisRUzZNZEEHmyypW8NRjqYKLKiPMryeCjF4XBNGntPDeOJOwsYeEGb6AUQabXjM+fv68ng5Zw1//N7ajv5rLJAbyvBQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucsb.edu; spf=pass smtp.mailfrom=ucsb.edu; dkim=pass (2048-bit key) header.d=ucsb.edu header.i=@ucsb.edu header.b=JJrc2Buv; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucsb.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucsb.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsb.edu header.i=@ucsb.edu header.b="JJrc2Buv"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-667971437d6so152089d50.2
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2026 11:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783622745; cv=none;
        d=google.com; s=arc-20260327;
        b=nJZo6hZGuSppadwvIHNxqMnX1E5ZiwtVrT2ySJBxsSk1x6bFWyq18BbCvIGqPQiYF2
         O1Pd6eofddSADAsK3Ac/M/P3H+6J7ZaqFJw/PDb59BmN12Rul3G29d8EkrBPrVOc985k
         d3u/kU91PKZbD5eq0riBeE8qDJjWC/j2hcw6TeUflR2TMuUKcNGxSOLFElYrplbh6moO
         FSrfHvltvAw1KmZbfzBnTLOV/VKlb1ubrdcU5tquwIfwjDbX+FM3gPi2YjJ+k9tbZn9E
         FYfkzajyEi1UEu0fd9EcE9U/0WimheLQhsTYc8RNmezoI/7jJvrW64EcfBg7J18oyBpb
         nGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qh9Nf+57OBdGJLqCB0Rb8y56HNexw4rc0CiycVo5asQ=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=lJvRfNTHxpZ+7OIljFsy7e01ulLe3ppqAsLYvmAAbbETanolLkL+AiLQif83rqN+Oy
         Zf2o8thFUZCQkqaqYbt+Eg8bp+VwUhbcUmbK9CIOlqEecuZny6n4lykt1+eoH0XUauuB
         UUNtf+KQOKfwgPIPhzKVOytU1fTo5B6BxE1GUI1rXWQCzwPpJq2yypMUsel8RPRMdGGZ
         Bs+utU2iPby2p+jljDv3EjWKKTIKhCP6OTwVp/7UmSML1MSWj+jbGGz2KNZl67UJKiZ4
         2f7M8r2xtODYGzXN2AL33auUD9qZrUO2J7OjdWq31lknDYE9s7dl5O3q7E+T+vJGFqKs
         hVCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsb.edu; s=google; t=1783622745; x=1784227545; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qh9Nf+57OBdGJLqCB0Rb8y56HNexw4rc0CiycVo5asQ=;
        b=JJrc2Buv5SueRYmhsyBIF1dBblitXMtqRFItag/JprYoqCE95Q/lD7U7o8gLgEluKl
         4sviXjEEJttHa8FtYQf4EATdoNkRykE9+NyuPKFSB6VR7ZyYZxmG+F/0kyuClvCmVChv
         LT37626isO3YsNNmpjT3hHN9ROLgLSlUwd+BxloxO/45uIkMOdbuSd3oFRSy9/jU3JxP
         BoeNme2nHoX5S7O5/WKWT2kKYZ2lQ4JLKUVoYWoeLzmZvLM4XAQDdEQ/07H2itVKXFGO
         XoSwJ1nbxox+IftBo0kxQjAcyVWeZ6BHQflrtIlyE52hRMdIrL37XEtPcaBhnchktt0K
         HTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622745; x=1784227545;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qh9Nf+57OBdGJLqCB0Rb8y56HNexw4rc0CiycVo5asQ=;
        b=CfZnOx0Qyrl2MxA+yhyHDMvusXLaoXeypRt0bfEFoz/kbqSg17+iXEONPmVoEQdHVt
         CuASJd4mX273dcnu15iF/hHwElpU7DjqgUV1g2BhokoSgaR7F1tfWFMk6m4Sdriid5Vd
         aAjSwqeiP6Nk33DJ08BRMOZK1SbzwzCzS6ZDqnzc8dDglRJBhiaw9ofd9zKrSQxB+nyF
         ty9vvpRR1qBj0wF217Dt/BC93VtzdvvJkK1ia5nxdPQULt6oYAnpuKzeVoC0HToMskJh
         HXhoq5U5PtF6P+7XDjFPmV1b2SswpDwNp895gZVSU4eh4cDpE9CZ88eaGUaXY6ijgsF0
         FMdg==
X-Gm-Message-State: AOJu0Yw2ENFvqUNPROr1T0MIz5Vn8ubhxJY25ymOdSFCpGlSOKGSDuPN
	JNfcjbngcGBHpw28DLplMGJzbra8HPVCryuxFCFS7BhqeIx+XAuEERlM/KfodCdAOjY7vIbfw2B
	Mu6Datbrxn00KWYn+JZQ9iTYAJ/OqsvidvWO1TvfJQCeKUz9Ossfpb5U=
X-Gm-Gg: AfdE7ckAG4KeXaGirz2IToPv2g5X9J99LY/pF+SADbikvVerXIzjGfJ0i3oKPw00623
	4XCvgox3IztgTinv46b+PNnrLlkKsj5vh4Jd4VSuSAitoC2/75UBXXjgFJBoxH0P3k+oJR655g+
	tCffYwcEDB+SDuFNxGedzQ28ZEvYJ9QAilDZ+T6xEgY0TC6IKyt44vQZ0/5XaNUJOscKcnOCLEB
	7ULrzwlYHx0wwsDpqmYqK9l4fPyrGq0tPp2eQ0AZLlJ13PPUf4PoAku7+e7DoYsbvxft7Kz
X-Received: by 2002:a05:690e:1685:b0:667:7633:2b0a with SMTP id
 956f58d0204a3-6679f214d3emr5752695d50.81.1783622744570; Thu, 09 Jul 2026
 11:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: COMS VLAB <coms-vlab@ucsb.edu>
Date: Thu, 9 Jul 2026 11:45:33 -0700
X-Gm-Features: AUfX_mxKglnsEkKqQXvt_hjlEuhEczU5BLQWA4XNldGfmAI_mvlWsg9NRZswgMI
Message-ID: <CA+jXL7=3=+wxXqm42Q_tQaoeusdUCnwzav_6gF6niAttPZ4ijg@mail.gmail.com>
Subject: [Bug] Double free vulnerability at define_genfs_context_helper
To: selinux@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001b1e5f065632089c"

--0000000000001b1e5f065632089c
Content-Type: multipart/alternative; boundary="0000000000001b1e5e065632089a"

--0000000000001b1e5e065632089a
Content-Type: text/plain; charset="UTF-8"

Summary

A double-free vulnerability exists in the checkpolicy source policy
compiler's handling of genfscon statements. When parsing a new (previously
unseen) filesystem type string, define_genfs_context_helper() transfers
ownership of the fstype pointer into a genfs struct that is linked into the
policydb's live genfs list, but fails to clear the local fstype variable
afterward. If any subsequent parsing step in the same function fails,
execution jumps to a shared fail: cleanup block. This cleanup block frees
fstype, which leaves a dangling pointer in the genfs list. When the
policydb is later destroyed via policydb_destroy(), it frees that same
pointer again, causing the double-free.


Version

06159ee35d6b4c968c1f942c9361c111644de826 - current version
<https://github.com/SELinuxProject/selinux>


PoC: Please see attachment



ASAN Report

==2502==ERROR: AddressSanitizer: attempting double-free on 0xfc1f82fe1330
in thread T0:

    #0 0xaaaac9f6d518 in free (/selinux/repro+0xed518) (BuildId:
ea3a1d5343a0633f08393e738125b8f44be83f66)

    #1 0xaaaac9ffd49c in policydb_destroy
selinux/libsepol/src/policydb.c:1596:3

    #2 0xaaaac9faf758 in main selinux/../repro.c:11:5

    #3 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18)
(BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)

    #4 0xffff83c63058 in __libc_start_main
(/usr/lib/aarch64-linux-gnu/libc.so.6+0x23058) (BuildId:
b50ceafbd17dc6bceee344a66671c7eaa152bef4)

    #5 0xaaaac9ec7c6c in _start (selinux/repro+0x47c6c) (BuildId:
ea3a1d5343a0633f08393e738125b8f44be83f66)

0xfc1f82fe1330 is located 0 bytes inside of 2-byte region
[0xfc1f82fe1330,0xfc1f82fe1332)

freed by thread T0 here:

    #0 0xaaaac9f6d518 in free (/selinux/repro+0xed518) (BuildId:
ea3a1d5343a0633f08393e738125b8f44be83f66)

    #1 0xaaaac9fc8a60 in define_genfs_context_helper
/selinux/checkpolicy/policy_define.c:6163:2

    #2 0xaaaac9fc8a60 in define_genfs_context
/selinux/checkpolicy/policy_define.c:6171:9

    #3 0xaaaac9fcbc1c in yyparse /selinux/checkpolicy/policy_parse.y:787:30

    #4 0xaaaac9fb95b4 in read_source_policy
/selinux/checkpolicy/parse_util.c:70:6

    #5 0xaaaac9faf750 in main /selinux/../repro.c:10:5

    #6 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18)
(BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)

    #7 0xffff83c63058 in __libc_start_main
(/usr/lib/aarch64-linux-gnu/libc.so.6+0x23058) (BuildId:
b50ceafbd17dc6bceee344a66671c7eaa152bef4)

    #8 0xaaaac9ec7c6c in _start (/selinux/repro+0x47c6c) (BuildId:
ea3a1d5343a0633f08393e738125b8f44be83f66)

previously allocated by thread T0 here:

    #0 0xaaaac9f53a4c in strdup (/selinux/repro+0xd3a4c) (BuildId:
ea3a1d5343a0633f08393e738125b8f44be83f66)

    #1 0xaaaac9fb9aa0 in insert_id
/selinux/checkpolicy/policy_define.c:131:10

    #2 0xaaaac9fcc744 in yyparse /selinux/checkpolicy/policy_parse.y

    #3 0xaaaac9fb95b4 in read_source_policy
/selinux/checkpolicy/parse_util.c:70:6

    #4 0xaaaac9faf750 in main /selinux/../repro.c:10:5

    #5 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18)
(BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)

    #6 0xffff83c63058 in __libc_start_main
(/usr/lib/aarch64-linux-gnu/libc.so.6+0x23058) (BuildId:
b50ceafbd17dc6bceee344a66671c7eaa152bef4)

    #7 0xaaaac9ec7c6c in _start (/selinux/repro+0x47c6c) (BuildId:
ea3a1d5343a0633f08393e738125b8f44be83f66)

SUMMARY: AddressSanitizer: double-free (/selinux/repro+0xed518) (BuildId:
ea3a1d5343a0633f08393e738125b8f44be83f66) in free

==2502==ABORTING

--0000000000001b1e5e065632089a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><span id=3D"m_3491866375=
012644840m_3447522423952227765gmail-docs-internal-guid-c75bbc50-7fff-714a-a=
a56-2b165f380f34"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;m=
argin-bottom:0pt"><span style=3D"font-size:12pt;font-family:&quot;Times New=
 Roman&quot;,serif;color:rgb(0,0,0);background-color:transparent;font-weigh=
t:700;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">Sum=
mary</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;marg=
in-bottom:0pt"><span style=3D"font-size:12pt;font-family:&quot;Times New Ro=
man&quot;,serif;color:rgb(0,0,0);background-color:transparent;font-variant:=
normal;vertical-align:baseline;white-space:pre-wrap">A double-free vulnerab=
ility exists in the <span aria-invalid=3D"spelling" style=3D"border-style:n=
one;background:none"><span aria-invalid=3D"spelling" style=3D"border-style:=
none;background:none"><span aria-invalid=3D"spelling" class=3D"LI ng" style=
=3D"border-style:none;background:none">checkpolicy</span></span></span> sou=
rce policy compiler&#39;s handling of genfscon statements. When parsing a n=
ew (previously unseen) filesystem type string, </span><span style=3D"font-s=
ize:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);bac=
kground-color:transparent;font-style:italic;font-variant:normal;vertical-al=
ign:baseline;white-space:pre-wrap">define_genfs_context_helper()</span><spa=
n style=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;col=
or:rgb(0,0,0);background-color:transparent;font-variant:normal;vertical-ali=
gn:baseline;white-space:pre-wrap"> transfers ownership of the </span><span =
style=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color=
:rgb(0,0,0);background-color:transparent;font-style:italic;font-variant:nor=
mal;vertical-align:baseline;white-space:pre-wrap">fstype</span><span style=
=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(=
0,0,0);background-color:transparent;font-variant:normal;vertical-align:base=
line;white-space:pre-wrap"> pointer into a </span><span style=3D"font-size:=
12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);backgro=
und-color:transparent;font-style:italic;font-variant:normal;vertical-align:=
baseline;white-space:pre-wrap">genfs</span><span style=3D"font-size:12pt;fo=
nt-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);background-col=
or:transparent;font-variant:normal;vertical-align:baseline;white-space:pre-=
wrap"> struct that is linked into the policydb&#39;s live </span><span styl=
e=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb=
(0,0,0);background-color:transparent;font-style:italic;font-variant:normal;=
vertical-align:baseline;white-space:pre-wrap">genfs</span><span style=3D"fo=
nt-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0)=
;background-color:transparent;font-variant:normal;vertical-align:baseline;w=
hite-space:pre-wrap"> list, but fails to clear the local </span><span style=
=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(=
0,0,0);background-color:transparent;font-style:italic;font-variant:normal;v=
ertical-align:baseline;white-space:pre-wrap">fstype</span><span style=3D"fo=
nt-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0)=
;background-color:transparent;font-variant:normal;vertical-align:baseline;w=
hite-space:pre-wrap"> variable afterward. If any subsequent parsing step in=
 the same function fails, execution jumps to a shared fail: cleanup block. =
This cleanup block frees </span><span style=3D"font-size:12pt;font-family:&=
quot;Times New Roman&quot;,serif;color:rgb(0,0,0);background-color:transpar=
ent;font-style:italic;font-variant:normal;vertical-align:baseline;white-spa=
ce:pre-wrap">fstype</span><span style=3D"font-size:12pt;font-family:&quot;T=
imes New Roman&quot;,serif;color:rgb(0,0,0);background-color:transparent;fo=
nt-variant:normal;vertical-align:baseline;white-space:pre-wrap">, which lea=
ves a dangling pointer in the genfs list. When the policydb is later destro=
yed via </span><span style=3D"font-size:12pt;font-family:&quot;Times New Ro=
man&quot;,serif;color:rgb(0,0,0);background-color:transparent;font-style:it=
alic;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">poli=
cydb_destroy</span><span style=3D"font-size:12pt;font-family:&quot;Times Ne=
w Roman&quot;,serif;color:rgb(0,0,0);background-color:transparent;font-vari=
ant:normal;vertical-align:baseline;white-space:pre-wrap">(), it frees that =
same pointer again, causing the double-free.</span></p><br><br><p dir=3D"lt=
r" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(=
0,0,0);background-color:transparent;font-weight:700;font-variant:normal;ver=
tical-align:baseline;white-space:pre-wrap">Version</span></p><p dir=3D"ltr"=
 style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><a href=3D"htt=
ps://github.com/SELinuxProject/selinux" style=3D"text-decoration:none" targ=
et=3D"_blank"><span style=3D"font-size:12pt;font-family:&quot;Times New Rom=
an&quot;,serif;background-color:transparent;font-variant:normal;text-decora=
tion:underline;vertical-align:baseline;white-space:pre-wrap">06159ee35d6b4c=
968c1f942c9361c111644de826 - current version</span></a></p><br><br><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color=
:rgb(0,0,0);background-color:transparent;font-weight:700;font-variant:norma=
l;vertical-align:baseline;white-space:pre-wrap">PoC: </span><span style=3D"=
font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,=
0);background-color:transparent;font-variant:normal;vertical-align:baseline=
;white-space:pre-wrap">Please see attachment</span></p><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><br></p><br><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color=
:rgb(0,0,0);background-color:transparent;font-weight:700;font-variant:norma=
l;vertical-align:baseline;white-space:pre-wrap">ASAN Report</span></p><p di=
r=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span=
 style=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;colo=
r:rgb(0,0,0);background-color:transparent;font-weight:700;font-variant:norm=
al;vertical-align:baseline;white-space:pre-wrap">=3D=3D2502=3D=3DERROR: Add=
ressSanitizer: attempting double-free on 0xfc1f82fe1330 in thread T0:</span=
></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:=
0pt"><span style=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,=
serif;color:rgb(0,0,0);background-color:transparent;font-variant:normal;ver=
tical-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#0 0xaaa=
ac9f6d518 in free (/selinux/repro+0xed518) (BuildId: ea3a1d5343a0633f08393e=
738125b8f44be83f66)</span></p><p dir=3D"ltr" style=3D"line-height:1.38;marg=
in-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12pt;font-family:&qu=
ot;Times New Roman&quot;,serif;color:rgb(0,0,0);background-color:transparen=
t;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">=C2=A0=
=C2=A0=C2=A0=C2=A0#1 0xaaaac9ffd49c in policydb_destroy selinux/libsepol/sr=
c/policydb.c:1596:3</span></p><p dir=3D"ltr" style=3D"line-height:1.38;marg=
in-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12pt;font-family:&qu=
ot;Times New Roman&quot;,serif;color:rgb(0,0,0);background-color:transparen=
t;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">=C2=A0=
=C2=A0=C2=A0=C2=A0#2 0xaaaac9faf758 in main selinux/../repro.c:11:5</span><=
/p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0p=
t"><span style=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,se=
rif;color:rgb(0,0,0);background-color:transparent;font-variant:normal;verti=
cal-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#3 0xffff8=
3c62f18=C2=A0 (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18) (BuildId: b50c=
eafbd17dc6bceee344a66671c7eaa152bef4)</span></p><p dir=3D"ltr" style=3D"lin=
e-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12=
pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);backgroun=
d-color:transparent;font-variant:normal;vertical-align:baseline;white-space=
:pre-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#4 0xffff83c63058 in __libc_start_main (=
/usr/lib/aarch64-linux-gnu/libc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee=
344a66671c7eaa152bef4)</span></p><p dir=3D"ltr" style=3D"line-height:1.38;m=
argin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12pt;font-family:=
&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);background-color:transpa=
rent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">=C2=
=A0=C2=A0=C2=A0=C2=A0#5 0xaaaac9ec7c6c in _start (selinux/repro+0x47c6c) (B=
uildId: ea3a1d5343a0633f08393e738125b8f44be83f66)</span></p><p dir=3D"ltr" =
style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"=
font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,=
0);background-color:transparent;font-weight:700;font-variant:normal;vertica=
l-align:baseline;white-space:pre-wrap">0xfc1f82fe1330 is located 0 bytes in=
side of 2-byte region [0xfc1f82fe1330,0xfc1f82fe1332)</span></p><p dir=3D"l=
tr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(=
0,0,0);background-color:transparent;font-weight:700;font-variant:normal;ver=
tical-align:baseline;white-space:pre-wrap">freed by thread T0 here:</span><=
/p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0p=
t"><span style=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,se=
rif;color:rgb(0,0,0);background-color:transparent;font-variant:normal;verti=
cal-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#0 0xaaaac=
9f6d518 in free (/selinux/repro+0xed518) (BuildId: ea3a1d5343a0633f08393e73=
8125b8f44be83f66)</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin=
-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12pt;font-family:&quot=
;Times New Roman&quot;,serif;color:rgb(0,0,0);background-color:transparent;=
font-variant:normal;vertical-align:baseline;white-space:pre-wrap">=C2=A0=C2=
=A0=C2=A0=C2=A0#1 0xaaaac9fc8a60 in define_genfs_context_helper /selinux/ch=
eckpolicy/policy_define.c:6163:2</span></p><p dir=3D"ltr" style=3D"line-hei=
ght:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12pt;fo=
nt-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);background-col=
or:transparent;font-variant:normal;vertical-align:baseline;white-space:pre-=
wrap">=C2=A0=C2=A0=C2=A0=C2=A0#2 0xaaaac9fc8a60 in define_genfs_context /se=
linux/checkpolicy/policy_define.c:6171:9</span></p><p dir=3D"ltr" style=3D"=
line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size=
:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);backgr=
ound-color:transparent;font-variant:normal;vertical-align:baseline;white-sp=
ace:pre-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#3 0xaaaac9fcbc1c in yyparse /selinux=
/checkpolicy/policy_parse.y:787:30</span></p><p dir=3D"ltr" style=3D"line-h=
eight:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12pt;=
font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);background-c=
olor:transparent;font-variant:normal;vertical-align:baseline;white-space:pr=
e-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#4 0xaaaac9fb95b4 in read_source_policy /se=
linux/checkpolicy/parse_util.c:70:6</span></p><p dir=3D"ltr" style=3D"line-=
height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12pt=
;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);background-=
color:transparent;font-variant:normal;vertical-align:baseline;white-space:p=
re-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#5 0xaaaac9faf750 in main /selinux/../repr=
o.c:10:5</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;=
margin-bottom:0pt"><span style=3D"font-size:12pt;font-family:&quot;Times Ne=
w Roman&quot;,serif;color:rgb(0,0,0);background-color:transparent;font-vari=
ant:normal;vertical-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0=C2=A0=
=C2=A0#6 0xffff83c62f18=C2=A0 (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18=
) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)</span></p><p dir=3D"l=
tr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(=
0,0,0);background-color:transparent;font-variant:normal;vertical-align:base=
line;white-space:pre-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#7 0xffff83c63058 in __l=
ibc_start_main (/usr/lib/aarch64-linux-gnu/libc.so.6+0x23058) (BuildId: b50=
ceafbd17dc6bceee344a66671c7eaa152bef4)</span></p><p dir=3D"ltr" style=3D"li=
ne-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:1=
2pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);backgrou=
nd-color:transparent;font-variant:normal;vertical-align:baseline;white-spac=
e:pre-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#8 0xaaaac9ec7c6c in _start (/selinux/r=
epro+0x47c6c) (BuildId: ea3a1d5343a0633f08393e738125b8f44be83f66)</span></p=
><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><span style=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,seri=
f;color:rgb(0,0,0);background-color:transparent;font-weight:700;font-varian=
t:normal;vertical-align:baseline;white-space:pre-wrap">previously allocated=
 by thread T0 here:</span></p><p dir=3D"ltr" style=3D"line-height:1.38;marg=
in-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12pt;font-family:&qu=
ot;Times New Roman&quot;,serif;color:rgb(0,0,0);background-color:transparen=
t;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">=C2=A0=
=C2=A0=C2=A0=C2=A0#0 0xaaaac9f53a4c in strdup (/selinux/repro+0xd3a4c) (Bui=
ldId: ea3a1d5343a0633f08393e738125b8f44be83f66)</span></p><p dir=3D"ltr" st=
yle=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"fo=
nt-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0)=
;background-color:transparent;font-variant:normal;vertical-align:baseline;w=
hite-space:pre-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#1 0xaaaac9fb9aa0 in insert_id=
 /selinux/checkpolicy/policy_define.c:131:10</span></p><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);ba=
ckground-color:transparent;font-variant:normal;vertical-align:baseline;whit=
e-space:pre-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#2 0xaaaac9fcc744 in yyparse /sel=
inux/checkpolicy/policy_parse.y</span></p><p dir=3D"ltr" style=3D"line-heig=
ht:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12pt;fon=
t-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);background-colo=
r:transparent;font-variant:normal;vertical-align:baseline;white-space:pre-w=
rap">=C2=A0=C2=A0=C2=A0=C2=A0#3 0xaaaac9fb95b4 in read_source_policy /selin=
ux/checkpolicy/parse_util.c:70:6</span></p><p dir=3D"ltr" style=3D"line-hei=
ght:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12pt;fo=
nt-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);background-col=
or:transparent;font-variant:normal;vertical-align:baseline;white-space:pre-=
wrap">=C2=A0=C2=A0=C2=A0=C2=A0#4 0xaaaac9faf750 in main /selinux/../repro.c=
:10:5</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;mar=
gin-bottom:0pt"><span style=3D"font-size:12pt;font-family:&quot;Times New R=
oman&quot;,serif;color:rgb(0,0,0);background-color:transparent;font-variant=
:normal;vertical-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0=C2=A0=C2=
=A0#5 0xffff83c62f18=C2=A0 (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18) (=
BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)</span></p><p dir=3D"ltr"=
 style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D=
"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0=
,0);background-color:transparent;font-variant:normal;vertical-align:baselin=
e;white-space:pre-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#6 0xffff83c63058 in __libc=
_start_main (/usr/lib/aarch64-linux-gnu/libc.so.6+0x23058) (BuildId: b50cea=
fbd17dc6bceee344a66671c7eaa152bef4)</span></p><p dir=3D"ltr" style=3D"line-=
height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:12pt=
;font-family:&quot;Times New Roman&quot;,serif;color:rgb(0,0,0);background-=
color:transparent;font-variant:normal;vertical-align:baseline;white-space:p=
re-wrap">=C2=A0=C2=A0=C2=A0=C2=A0#7 0xaaaac9ec7c6c in _start (/selinux/repr=
o+0x47c6c) (BuildId: ea3a1d5343a0633f08393e738125b8f44be83f66)</span></p><p=
 dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><s=
pan style=3D"font-size:12pt;font-family:&quot;Times New Roman&quot;,serif;c=
olor:rgb(0,0,0);background-color:transparent;font-variant:normal;vertical-a=
lign:baseline;white-space:pre-wrap">SUMMARY: AddressSanitizer: double-free =
(/selinux/repro+0xed518) (BuildId: ea3a1d5343a0633f08393e738125b8f44be83f66=
) in free</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt=
;margin-bottom:0pt"><span style=3D"font-size:12pt;font-family:&quot;Times N=
ew Roman&quot;,serif;color:rgb(0,0,0);background-color:transparent;font-var=
iant:normal;vertical-align:baseline;white-space:pre-wrap">=3D=3D2502=3D=3DA=
BORTING</span></p><br></span></div>
</div>
</div>

--0000000000001b1e5e065632089a--
--0000000000001b1e5f065632089c
Content-Type: application/zip; name="poc.zip"
Content-Disposition: attachment; filename="poc.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_mrduqzto0>
X-Attachment-Id: f_mrduqzto0

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
--0000000000001b1e5f065632089c--
