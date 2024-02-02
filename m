Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE81FAB
	for <selinux@vger.kernel.org>; Fri,  2 Feb 2024 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832667; cv=none; b=pXZJIRthPLpMbxn4WP4HNnP9tXhV3JIm93vCvhVzf/LZrZTOxleBdSTtaGDeVKVixcfy9sRl4EzklC00NowKXPTMPHwYd48t+EFcrCxPww83YvbZ5cDOtpCcGFhkUoSlJdnRWF0ZYc3eOhr1q0wGh0djd9t1C8chlqy/i8Cs9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832667; c=relaxed/simple;
	bh=dNvlRUYZVWGGUxt9L0+r6HQwqybJCid6fp45/p+iV1I=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=SLwgoNpIEL+/oBrD+3cuRbGjDgVsMFUKepUXwSYGe0Q2GUL33HB0rqV1inzblpeLWPTDuCWc+/ox+2Rh1b59Ua6JEBFrNqPGSN0OlSnd47Z7rfAdP3+sarFhl7yuJUme5+Z+56SzU1osGSIWG9XdQSOKj8PeCsfw12nJZi+5xjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VfHVLQHa; arc=none smtp.client-ip=66.163.189.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VfHVLQHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706832664; bh=3ilMtLoOE4tvHvaa7uRLvxlf7wxLomjhxt02Vr4duNU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VfHVLQHaQGRUKkDIuO4RDmem+i4E6HDLstgp0X2Xe+YnSF5hZvgny6QcSe2YFkomePaMKBLAnEKRuJvf0mkrqhhy1pxGd0Z+uKrRR0iAxcii80B70HwSjt5bKopW6IwZ44UgGW0vuWmk4mUvvHVkKhKy6xE3SDXGt1d/jS7OUuNcPW0rsV/OzmazfEwcbJgruVYKCdeV3l6UYEu2BihoCYLghKujrkmtREefEsHP1o/rsGRCvLcvzn9Bz4D5e3cjWcLC9ERBzfRjUOO+Tt+aJCh4f+tboIy8YyRwFl5hQ2Y6pv2cNStB5H88yu0SskFzDDVPwROIBPE/ACt0axqcTw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706832664; bh=mtAUtVNQ/5O9LambxSy7AIrdLXVhYf0cgEcpyZtBYq/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=KvP6+hd5+m9dF11hOuVKej5ZmX3B/x0YV9po9TSqfynX+wNySK65UI4In8DpptpQ+WgE9aj1Zg52qxKChoZUm51RZRH/s53ZmIGiZ06DYmgOOfw5mjNGwnmQMllWvQdw59/1EEVujLWflboYsNs8RpRwH+lJhkWoP84UfR4ffGPY/wTwtI7czdDO2lQz4KGkwwxTVrZYtno196XLtTKEapKUkyfk50oo4FspyjB9uKoiPBenIKciZYgRWNIWndmFkNhQAWU2bKcPV71jBC70giTSHqU2UiCgbd2SRsfkXcq6w2HIfdlpq+DspU71CPuq7CPNl8G9zSQNZSBsUCPL6A==
X-YMail-OSG: zM7lbfYVM1lAootPzfNIEiTmJfNd4PqaN8h9a6AOEr_Qqwpn.9hKTtE9N1fvCmq
 k33Os1k7w0jtf8dxnx0QARQRENP9yAnQFqsKMtSa_T00tE8i2GwuRyY36Cz0FE0cPeZY8jgsGHo8
 C8l1I4MJjtUBU3b6uussuu0IZV_lJfYVJOnu28NinWiogDAy6LmJDn0IuYyiMNSDmmKRVvbq8oqK
 hn6beMtdHHQSSoSvpn8qiQlVLGHKCXYRNSCyx0PBUn4BKcF7LrSDX9i34l8jwhPzIRNZ5HcZ5ub7
 aAHAucE2oslCFskpt9AYs5.MmIpQo6zi_mEvKXSRgFH.7hFc74S_6tXnj9DRzyHOirReaHURQd9p
 CLzoItJQEYhxJgpmcNAZpm7H2xraWx8nkCZCpZvM56nvKZ5wJ5iuG744Vhd7DkCmNPiRIssH04kT
 dRXAuBqBB4F326wezOwGTZOPkF997iMR2Kqh5pjuKeTCv3cjITl3DlTTf30bwufP4QHKFfLtqdm3
 hudhDwhWEAxu.soME111g0ip8DW_UoXSoPZpWvMVpO6qRg9lygmGsVA0Acf1R7RaoKSpAsGH1V29
 LknQSTWDBr5y3vbQAY7NOAWROS..CRhfpwQnNmuyalLnyjmjlhpg8A_0hOnGp7NTd2dIgJgdVJ0_
 s0KQcor8MsX361l_XDOX_8DHqfvJanYHBP_yKLs3faZyGIX.WNkI.stBYCkQtR2waZxFu9jh7fKx
 rVnMI3kJ70gzrMhqixui.BjH3uYVquP06LO0Hz7cYAe9MwG5HP0MR6GiFBa381M5XGhAeCuHOaFj
 BcFZ5LflVSNC5NZ_9xwFQjC.KIfa.fTB5.VXetnhmQRJZpFaXCWxIbmqnkicOFBN6gTiJlSftVMz
 L1a.o7jt33QocOxcqZt2SuWkMyb673C0XSDv8pggh13SpjRTdXsRUPMmpGiXaHF1WcXeSE0PuOxE
 7lpxSfdyrBTdoZ0nThesB.7RDGvt3V.ZAcmAizokPW7240Y9xVIaZSSMYHFkWcBH45Edl1bNRPCv
 GmBXMjLcGMj5VwoXfOo75JMXja2u1euG0fSkTVeDCks5mWTd01AV9VeLagAXzc0lwSSbbvVumTFA
 gHvN7E40qxP1y8jkI7DOUmlCFnPTyxZBjmk31uAQbTERSEueylMg5j49xg_7V8ns5eQKqUuTJNv9
 eKuP7QroFzmXnx3LmjaRS8MEndUM_Miy.OHnCJcQ9CAGocmZHB4jvdOudSH9Zcv8doBPzBFLM.3Z
 RHob8cioth2qFg36NEXgB2o8WL.N8tFDdg._amSU6En7rRcFxQtX8KTF2csXUQkFxFuUp51ihLkO
 lx2a0s02O3OPkmbgMhF_JUaHYDEwIbYZmFQ1jdX94HAgucMVC820Dv77pkKpdu7h9TQ4FNhtMGPn
 aMcIsb_pvyWcSaMFfRlsehVsz1.rhkvGUe1HCmamCneOTK5fxvJIdBWKR1nHvEJ_cm.54JYCl0lN
 ysgkl3OPyOAHTSNzRjIxgrpF3NbBjuv18aK9aea8B0Z52_Y9Oc6duphcvjSxaeYgZg2KiDmlx0Ql
 9AYiInY5lNBvJLzV5TIsRzdebFakUQwkFAaxqDSrcFQ6GNMG4IiFxbG1X29sUeXQ3rEl.rN2xLnz
 2C9nTfaJIRErQaGSgbKpLeYuN9awYtblaPb1kGLwD6gp0r.cbNp5x_BvX.oc34DPPQuQxfBZsn.X
 sZS0tzW6ft.ECY9OpzzEyaSRs2J2Dc1UrcASQn_dIjyQ3u6MfhOQW5JHjqQX2P5KnAvOWW9K8T5X
 s4lN13YzeEl3I.o0n2UAhLFb1w.q_NKg2e9v7SPG266WyQI5_60HoIuJ4wt6xb95QcuGO0XJ.y2l
 YfWtO3d15iIAvjnQH1vw440MmOseQ1W_SSOZHIEAC.7yf8NB5FGdc0uFAnETzLBXWuCgxDmTlw.T
 xIytqTXSG8ioV_7sIvj3WXwVHyo46Zv4LJ18hLr9x78U34kAraP20sJpqrRXFoaeJ00A2aVuTVfn
 mu_cY5ujcF.QG8cGz6jdSrulTvaJF5Eo.kYHECweea3RtuuWBBDGUs1eaQUK6w59F6d0nFs6asiQ
 kFcOj45Xy90Ok1p2oBHTVoDSOs1WDd3mOxzVaObceIVn_VeMz9ukhQ2zgM3wu2mHfRFB8B1c76A0
 AvFZg4iz_MFvDhMCr1Rd3OiYlIehc72lSTtts7dtEAEMvUTfCNa6r02hLUAo44Wx6fIC1dzCRJpg
 6.Iqm7O_LjA6HxcSwwKyHU5CKR9PDrC76j5uj4kBh_pw.J4EDpDosfIjS6Fvb.ed0KEX88eHoTx3
 PsnaNW2mYVH4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ceaa6283-9a6f-476c-8ce3-f9324bb63ea8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 2 Feb 2024 00:11:04 +0000
Received: by hermes--production-gq1-5c57879fdf-hjdnf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3d278314b840ddbcb974878f2218861a;
          Fri, 02 Feb 2024 00:11:01 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------l1CAGVWvAFQZ8ajuoLk9jElg"
Message-ID: <0e5dd86d-bdc4-4ef0-a9bd-d883227102ca@schaufler-ca.com>
Date: Thu, 1 Feb 2024 16:10:59 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: fix no-op hook logic in
 security_inode_{set,remove}xattr()
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240129133058.1627971-1-omosnace@redhat.com>
 <CAHC9VhSzdvJ2DAgV75Tdxk+tOLuhY-vM+BTT--Mfn6xoxVKbxQ@mail.gmail.com>
 <CAHC9VhQRSWMRAg=y5cUx9+XLG4A2_+WSqJN1RgQQ8bF=VDwnWw@mail.gmail.com>
 <CAHC9VhRa5q3fvWUD-Dh-d5Udq18XqFwR4AGUzSow6Ur+_TmFrQ@mail.gmail.com>
 <CAHC9VhSyNPd4rK+oZE6cDwZTCb3Km_eu-+K8s+X73BJwt8ynuA@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSyNPd4rK+oZE6cDwZTCb3Km_eu-+K8s+X73BJwt8ynuA@mail.gmail.com>
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This is a multi-part message in MIME format.
--------------l1CAGVWvAFQZ8ajuoLk9jElg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/1/2024 3:52 PM, Paul Moore wrote:
> On Tue, Jan 30, 2024 at 9:19 PM Paul Moore <paul@paul-moore.com> wrote:
>> I'll come back to this tomorrow with some fresh eyes.
> My apologies, "tomorrow" turned into "the day after tomorrow" (as it
> often does) ...
>
> I've been struggling with the idea that there are individual LSMs
> still calling into the capability hooks instead of leveraging the LSM
> stacking infrastructure, and the "magic" involved to make it all work.
> While your patch looks like it should restore proper behavior - that's
> good! - I keep thinking that we can, and should, do better.

Apology for attaching a patch rather than inlining it.
I've attached patch #38 from the current stacking set.
It addresses the issue.

>
> The only thing that I coming up with is to create two new LSM hooks,
> in addition to the existing 'inode_setxattr' hook.  The new LSM hooks
> would be 'inode_setxattr_owned' and 'inode_setxattr_cap'.  The _owned
> hook would simply check the xattr name and return a positive value if
> the LSM "owned" the xattr, e.g. XATTR_NAME_SELINUX for SELinux, and
> zero otherwise.  The _cap hook would only be used by the capabilities
> code (or something similar), and would match up with
> cap_inode_setxattr().  With these two new hooks I think we could do
> something like this:
>
> int security_inode_setxattr(...)
> {
>   owned = false
>   hook_loop(inode_setxattr_owned) {
>     trc = hook->inode_setxattr_owned(name);
>     if (trc > 0) {
>       owned = true;
>       break;
>     }
>   }
>   if (owned) {
>     hook_loop(inode_setxattr) {
>       /* run the existing inode_setxattr hooks, e.g. SELinux and Smack */
>     }
>   } else {
>     hook_loop(inode_setxattr_cap) {
>       /* run the capability setxattr hooks, e.g. commoncap.c */
>     }
>   }
> }
>
> .. with security_inode_removexattr() following a similar pattern.
>
> I will admit that there is some duplication in having to check the
> xattr twice (once in _owned, again in inode_setxattr), and the
> multiple hook approach is less than ideal, but this seems much less
> fragile to me.
>
> Thoughts?
>
--------------l1CAGVWvAFQZ8ajuoLk9jElg
Content-Type: text/plain; charset=UTF-8;
 name="v39-0038-LSM-Correct-handling-of-ENOSYS-in-inode_setxattr.patch"
Content-Disposition: attachment;
 filename*0="v39-0038-LSM-Correct-handling-of-ENOSYS-in-inode_setxattr.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2NDRhYzIzOWNiYmRlZTNkNGZjM2JhMDE3M2M4NWIzNDM4MjY3MGM2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDYXNleSBTY2hhdWZsZXIgPGNhc2V5QHNjaGF1Zmxl
ci1jYS5jb20+CkRhdGU6IFRodSwgMjYgT2N0IDIwMjMgMTI6NTI6NTUgLTA3MDAKU3ViamVj
dDogW1BBVENIIHYzOSAzOC80Ml0gTFNNOiBDb3JyZWN0IGhhbmRsaW5nIG9mIEVOT1NZUyBp
biBpbm9kZV9zZXR4YXR0cgoKVGhlIHVzdWFsICJiYWlsIG9uIGZhaWwiIGJlaGF2aW9yIG9m
IExTTSBob29rcyBkb2Vzbid0CndvcmsgZm9yIHNlY3VyaXR5X2lub2RlX3NldHhhdHRyKCku
IE1vZHVsZXMgYXJlIGFsbG93ZWQKdG8gcmV0dXJuIC1FTk9TWVMgaWYgdGhlIGF0dHJpYnV0
ZSBzcGVjaWZpZWQgaXNuJ3Qgb25lCnRoZXkgbWFuYWdlLiBGaXggdGhlIGNvZGUgdG8gYWNj
b21tb2RhdGUgdGhpcyB1bnVzYWwgY2FzZS4KVGhpcyByZXF1aXJlcyBjaGFuZ2VzIHRvIHRo
ZSBob29rcyBpbiBTRUxpbnV4IGFuZCBTbWFjay4KClNpZ25lZC1vZmYtYnk6IENhc2V5IFNj
aGF1ZmxlciA8Y2FzZXlAc2NoYXVmbGVyLWNhLmNvbT4KLS0tCiBzZWN1cml0eS9zZWN1cml0
eS5jICAgICAgICB8IDI5ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiBzZWN1cml0
eS9zZWxpbnV4L2hvb2tzLmMgICB8ICA3ICsrLS0tLS0KIHNlY3VyaXR5L3NtYWNrL3NtYWNr
X2xzbS5jIHwgMTAgKysrKystLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25z
KCspLCAyNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zZWN1cml0eS9zZWN1cml0eS5j
IGIvc2VjdXJpdHkvc2VjdXJpdHkuYwppbmRleCA2NGNkZjBlMDk4MzIuLmIxYTg0OWU4NTg5
YyAxMDA2NDQKLS0tIGEvc2VjdXJpdHkvc2VjdXJpdHkuYworKysgYi9zZWN1cml0eS9zZWN1
cml0eS5jCkBAIC0yMzQ2LDI0ICsyMzQ2LDI1IEBAIGludCBzZWN1cml0eV9pbm9kZV9zZXR4
YXR0cihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwKIAkJCSAgICBzdHJ1Y3QgZGVudHJ5ICpk
ZW50cnksIGNvbnN0IGNoYXIgKm5hbWUsCiAJCQkgICAgY29uc3Qgdm9pZCAqdmFsdWUsIHNp
emVfdCBzaXplLCBpbnQgZmxhZ3MpCiB7Ci0JaW50IHJldDsKKwlzdHJ1Y3Qgc2VjdXJpdHlf
aG9va19saXN0ICpocDsKKwlpbnQgcmMgPSAtRU5PU1lTOwogCiAJaWYgKHVubGlrZWx5KElT
X1BSSVZBVEUoZF9iYWNraW5nX2lub2RlKGRlbnRyeSkpKSkKIAkJcmV0dXJuIDA7Ci0JLyoK
LQkgKiBTRUxpbnV4IGFuZCBTbWFjayBpbnRlZ3JhdGUgdGhlIGNhcCBjYWxsLAotCSAqIHNv
IGFzc3VtZSB0aGF0IGFsbCBMU01zIHN1cHBseWluZyB0aGlzIGNhbGwgZG8gc28uCi0JICov
Ci0JcmV0ID0gY2FsbF9pbnRfaG9vayhpbm9kZV9zZXR4YXR0ciwgMSwgaWRtYXAsIGRlbnRy
eSwgbmFtZSwgdmFsdWUsCi0JCQkgICAgc2l6ZSwgZmxhZ3MpOwogCi0JaWYgKHJldCA9PSAx
KQotCQlyZXQgPSBjYXBfaW5vZGVfc2V0eGF0dHIoZGVudHJ5LCBuYW1lLCB2YWx1ZSwgc2l6
ZSwgZmxhZ3MpOwotCWlmIChyZXQpCi0JCXJldHVybiByZXQ7Ci0JcmV0ID0gaW1hX2lub2Rl
X3NldHhhdHRyKGRlbnRyeSwgbmFtZSwgdmFsdWUsIHNpemUpOwotCWlmIChyZXQpCi0JCXJl
dHVybiByZXQ7CisJaGxpc3RfZm9yX2VhY2hfZW50cnkoaHAsICZzZWN1cml0eV9ob29rX2hl
YWRzLmlub2RlX3NldHhhdHRyLCBsaXN0KSB7CisJCXJjID0gaHAtPmhvb2suaW5vZGVfc2V0
eGF0dHIoaWRtYXAsIGRlbnRyeSwgbmFtZSwgdmFsdWUsIHNpemUsCisJCQkJCSAgICAgZmxh
Z3MpOworCQlpZiAocmMgIT0gLUVOT1NZUykKKwkJCWJyZWFrOworCX0KKwlpZiAocmMgPT0g
LUVOT1NZUykKKwkJcmMgPSBjYXBfaW5vZGVfc2V0eGF0dHIoZGVudHJ5LCBuYW1lLCB2YWx1
ZSwgc2l6ZSwgZmxhZ3MpOworCWlmIChyYykKKwkJcmV0dXJuIHJjOworCXJjID0gaW1hX2lu
b2RlX3NldHhhdHRyKGRlbnRyeSwgbmFtZSwgdmFsdWUsIHNpemUpOworCWlmIChyYykKKwkJ
cmV0dXJuIHJjOwogCXJldHVybiBldm1faW5vZGVfc2V0eGF0dHIoaWRtYXAsIGRlbnRyeSwg
bmFtZSwgdmFsdWUsIHNpemUpOwogfQogCmRpZmYgLS1naXQgYS9zZWN1cml0eS9zZWxpbnV4
L2hvb2tzLmMgYi9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMKaW5kZXggNDZkZWU2M2VlYzEy
Li40YWM0YjUzNmM1NjggMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYwor
KysgYi9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMKQEAgLTMyMDcsMTMgKzMyMDcsMTAgQEAg
c3RhdGljIGludCBzZWxpbnV4X2lub2RlX3NldHhhdHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlk
bWFwLAogCWludCByYyA9IDA7CiAKIAlpZiAoc3RyY21wKG5hbWUsIFhBVFRSX05BTUVfU0VM
SU5VWCkpIHsKLQkJcmMgPSBjYXBfaW5vZGVfc2V0eGF0dHIoZGVudHJ5LCBuYW1lLCB2YWx1
ZSwgc2l6ZSwgZmxhZ3MpOwotCQlpZiAocmMpCi0JCQlyZXR1cm4gcmM7Ci0KIAkJLyogTm90
IGFuIGF0dHJpYnV0ZSB3ZSByZWNvZ25pemUsIHNvIGp1c3QgY2hlY2sgdGhlCiAJCSAgIG9y
ZGluYXJ5IHNldGF0dHIgcGVybWlzc2lvbi4gKi8KLQkJcmV0dXJuIGRlbnRyeV9oYXNfcGVy
bShjdXJyZW50X2NyZWQoKSwgZGVudHJ5LCBGSUxFX19TRVRBVFRSKTsKKwkJcmMgPSBkZW50
cnlfaGFzX3Blcm0oY3VycmVudF9jcmVkKCksIGRlbnRyeSwgRklMRV9fU0VUQVRUUik7CisJ
CXJldHVybiByYyA/IHJjIDogLUVOT1NZUzsKIAl9CiAKIAlpZiAoIXNlbGludXhfaW5pdGlh
bGl6ZWQoKSkKZGlmZiAtLWdpdCBhL3NlY3VyaXR5L3NtYWNrL3NtYWNrX2xzbS5jIGIvc2Vj
dXJpdHkvc21hY2svc21hY2tfbHNtLmMKaW5kZXggNjFiZDNmNjI2ZTdkLi4wMmI5YWEyMDBh
ZDQgMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L3NtYWNrL3NtYWNrX2xzbS5jCisrKyBiL3NlY3Vy
aXR5L3NtYWNrL3NtYWNrX2xzbS5jCkBAIC0xMzQwLDcgKzEzNDAsNyBAQCBzdGF0aWMgaW50
IHNtYWNrX2lub2RlX3NldHhhdHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLAogCQkgICAg
c3RybmNtcCh2YWx1ZSwgVFJBTlNfVFJVRSwgVFJBTlNfVFJVRV9TSVpFKSAhPSAwKQogCQkJ
cmMgPSAtRUlOVkFMOwogCX0gZWxzZQotCQlyYyA9IGNhcF9pbm9kZV9zZXR4YXR0cihkZW50
cnksIG5hbWUsIHZhbHVlLCBzaXplLCBmbGFncyk7CisJCXJjID0gLUVOT1NZUzsKIAogCWlm
IChjaGVja19wcml2ICYmICFzbWFja19wcml2aWxlZ2VkKENBUF9NQUNfQURNSU4pKQogCQly
YyA9IC1FUEVSTTsKQEAgLTEzNTQsMTEgKzEzNTQsMTEgQEAgc3RhdGljIGludCBzbWFja19p
bm9kZV9zZXR4YXR0cihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwKIAkJCXJjID0gLUVJTlZB
TDsKIAl9CiAKLQlzbWtfYWRfaW5pdCgmYWQsIF9fZnVuY19fLCBMU01fQVVESVRfREFUQV9E
RU5UUlkpOwotCXNta19hZF9zZXRmaWVsZF91X2ZzX3BhdGhfZGVudHJ5KCZhZCwgZGVudHJ5
KTsKLQogCWlmIChyYyA9PSAwKSB7Ci0JCXJjID0gc21rX2N1cmFjYyhzbWtfb2ZfaW5vZGUo
ZF9iYWNraW5nX2lub2RlKGRlbnRyeSkpLCBNQVlfV1JJVEUsICZhZCk7CisJCXNta19hZF9p
bml0KCZhZCwgX19mdW5jX18sIExTTV9BVURJVF9EQVRBX0RFTlRSWSk7CisJCXNta19hZF9z
ZXRmaWVsZF91X2ZzX3BhdGhfZGVudHJ5KCZhZCwgZGVudHJ5KTsKKwkJcmMgPSBzbWtfY3Vy
YWNjKHNta19vZl9pbm9kZShkX2JhY2tpbmdfaW5vZGUoZGVudHJ5KSksCisJCQkJTUFZX1dS
SVRFLCAmYWQpOwogCQlyYyA9IHNta19idV9pbm9kZShkX2JhY2tpbmdfaW5vZGUoZGVudHJ5
KSwgTUFZX1dSSVRFLCByYyk7CiAJfQogCi0tIAoyLjQxLjAKCg==

--------------l1CAGVWvAFQZ8ajuoLk9jElg--
