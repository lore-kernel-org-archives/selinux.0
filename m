Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E4129951C
	for <selinux@vger.kernel.org>; Wed, 30 Apr 2025 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046743; cv=none; b=g+nVTld9U+6bkqD+Izt+N1TX23j+zzR0x0pBvsXe4mRiuMcFlHxDnCMZWRBbOItgHTO0H+BnGNECIhZP4q56MLYlbcTlWuly0pvLxWEhycqZczTrKZlnoV7p+ptjCicHetPuWkm2YApvp1VZYQEQGaFkTa5eiDqHSL9Jd/mRv9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046743; c=relaxed/simple;
	bh=X3V2lY6xt3KmbTiZ4jeylhjURL3PNT00MwS5+CYXf/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpIrNhAPbW1VhLtbkIaHkRZswUWcyGSELCIn+XBTFh9R5rCFdoaqQ4EEmhiF8TAsZVxX5vgIBPk5nj0KQ55d52NfnFVSdyl/zDMJM0RkBw1d2HGPHmtB9lID7hQf3lx/DK0pwi6Sdr8Ep8HUOXKy4Vj219zeQRFzrJJz98v8q8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bDOXR/To; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bDOXR/To"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746046740; bh=+gC+d7moRSAaJPJZhwxmGK5/40fNgFBiFFeRuG5b1KM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bDOXR/ToO3dTpbH4gZaidk7BW+4tLB2pAmjEwba4KBzQEkFzaz0OkA11HuOqQPje/u1waSWSwt/fPFU7ou1iIpsD3Lm9kxBw2PJp1AdJKUsZznIBanWy3cETGwl1h+7E0Nm5hyc2uNjvwFGK3abAIY7blk37pOnp2fSYX3H233YZKz//hBckOa1CdOan+9/OOAo6ARpStOnNpgm4LAzfmDYdK9KEyGTkGb0srWXxm2ORx4zHosBXuahxa+P+wJTqQepdwCvgKPZKciZmcAaZTU6adSmGA5YMGFNVZys1i8lMdPq9cCxvarMc/SxwwQXEU/aXExobKWZcwC2wq878/w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746046740; bh=FFQBjUHjq5nksePFYBQEx8CtEkXMwSakpkhyCyXMEmq=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WcyYsEZ+bJuhWCI7gB+beaoB7oEUlvq04U6xqvKZnO08WSComVcU7LEs0aUY8ngs4HAnPxe58rjMGGFHTo+RHFfukPO1GBcI3qjKdaamv5gsrBsPOp73yWvPS6B/X6iDJ0wcOfQbPOxTYgd5OQzdZ+so1nGyPKsCGZsQwoK4teHDRb7cjCOsvbI7z8euSIKNtqezpxwcD4CwLpdfkY0rjEeKCn74dlRRsUj4HMvmoKZrbyv8y+ujIZyDujANmev+FjQTyvs/FnlXJo6G/NyBciCWCQtUyMhYtEwiC7ro+gm2/0CC3fQpjybCNtK0vwuoloML+GYhIg9o1fdcG/7vgg==
X-YMail-OSG: EmGTxl4VM1nm95CdTEC7vPAhmhB5PTVR6.8wsREeMwE7cxFAOFPFq1jRuHcUdmy
 eSzdbFra9.4qi5XG88xks2C_dSCQfx_5yJ2aK4zEejYkdsfsiYnCFVQ3tpIwmxLa0A5UfsAJx9Vn
 _IkUFjR2V.DVmdK2bRSeOTw8jP3OaFd486YtWjtYnHanumwMPyH5YQv.jmKGU7xWvWV8CrYT5O7G
 vP4FyE0p2iKy_TWQKZXUdcw1Vha5n6VAwkhD32JCUvTHRNl3h6EY6NraHvuacFSSdIyt4vgQUK19
 4MgJRqf1rlZpcH8unuwJOHlp4.ikdr9ORfBphpd7CZXpVoPvJ0uPU1x5591FFCWXRZy4SQ0IzkTJ
 wldTX8zUjZhi3Wo2AVBqU_IyQJgoDkM9amvU8tHpkdABiYvC71GC0AzkPoZaSIw_oTsXOzH7VBFn
 rBZRZr5rTwus.Xuz.BNjkU39lb8u_znco_H1Iem5bTj4UVOENnIRpK1YNkXqiw0gH.RmAeC7pYEn
 dBqxb8Z7P_XlZzrEuKIXNpyGtP7Xc4uTGHanxc_aPY7EQgc0BChc0bhU_1ofDxkhmedNqtFOxgug
 boSsOu0YRRtXVAfxI28NUcWraTtJrCg3QnAW.pvYJFavRsI6gUjZaUnEXJ3ZIg3D1MCJqgOaJ.KH
 y0BVSDIQU1pFGZeIGLiIwnemevVincewipfw_uygh84mvItBOERbEbQrTS7QEYdiW1iy7_NPqLuP
 Zu8vv6kITXmhs.rDIWMkzcvXF9boHKUKHZ8Q84c1VtY7b8koJ8TCJMviSUfirDojgh6fFpKgUEnK
 _UpQeOTnzvQrGKCW8O7LAG2IKlvlUvMEfRGevSD3ItlIWIHMI3XbP_SEZATDx2YJmZJq1tOnGmSk
 o15pajfmJmGI7IRtkC37s49iEzaKLq8wBmtE5FKcQLGtRoGtyFKS2AEsX1VsLdTon8T_ZrF4hbMy
 KQyAKN8.ox.qFZi.8poHmiudXF89CJ7D.U35GbrTCuibNzgyAUMN9DzjkBvwMYf6XYCInQkEMGZx
 zTCs2dmr8gR8EeAfU6pOaRF6VwNodByOu5HWO0508.EBWuGxBxC_8yJbqlkqjnu.DMWCW9iODPam
 c0mHvT5VW6fgQfLiQ6KvG7szUcGfyWwGxx52Z70CT65DfyIaKBcML3NwKH4Nphmo3kIlFXwGn.OA
 qNRCOJ9dVueQku2MCiQh.q8wVb7ynPwW2kBv5jqzvraIYpJ5_pplWEWVhK1nl2m0EqkUD6lTAiy9
 nlr8STwx3bFLWc8a.DVm4VDyjwhBzw1ES7.AgKDCjUDj1Q0SnWM7yNskFQrMIegBRUA5KBl1HbZf
 LkdnPTc5aaQksn3J5azvLNj19VE86XLqNRvwpAwXMGRrnpmgjsJG_9D.EmY2bBwy4zOmgOpuBSmF
 eiLkbTbGQhnwLF6EwsPPCKUpECn64lPxtQFxn3w1bFkXf9C1iTJ8wspGBJNzxl6ks9y0ZAte.kYR
 Ba26DmyzshiuT7OtGUoos7w_CYzk7WPBRSrlqfw6Yq785e.Cc2q.qBWOTtpcB4AZvv5LaiGFKPFm
 lTmXT8n0y1JH_OS9Rwfyo98eIeiVgSYImD2CkU28VEDW5l5oj.WJ6rxsTN2VAXGSQB5hYUp52mcQ
 S7S6PSUu0.PMTLSIKnsGuPgwelfK2Vlj1i_.IByiAIHqwhF31IcVhJ8Cuna40PtT3HbZ2zyt2D9v
 Ktd2DSjPSGw_lxDYcNgx7h7XXLfsLs8C209.yRpmG18G6WC4QSiBu8F8is2q3HP6cFQRpnroUXqb
 eNDPfv70WV8szPH1DbxBJ8OJbl0RIp0rqAffwcNt8WR2y2GH3C5665T9n4pZuqAyHOeht3YsatR9
 h7Vi4dYo7.4QoPGStzq_7dLJPCzMq.4tMHM2zMjMJwxy62xe3e.8ktK1jICcnqEemVBwJ0JupQSM
 kz4Wp4iAM4Wf4nxZT62Qlpmjkoy8t_NxPxHZ1ZuJym9rdBdifjWFzTUz63I_NqxrBjVIanfNVg33
 .gLUyBPv7QRSHvoUeEgTeC9q5E.t.YyztGnUTj6D1c2KzQHApEY0TXzpMiLwVCAlbWOSgbd1z78T
 3xWfJjZTSPUOBPymBFl5zEAd60bGTmQyt.xA73eAhpqajMwVmF8FSsmeC7vFqrVFwiZ_CIgzho4u
 aoHpuRZEA8sS2vx3G4Fk3euK3xK5I9pc0URf5N025_hwBXI78n43lTKp04I2Q0H6lBdSKwjXbANs
 tpiXeDBA8qR69MNKhifX9_5P89MlSnS3v89M1YjgHQ5OQjhuIC_2SOP9y3k5Y46COE5iTPppa673
 iRjkXLQGu2I4tgTgBHskKWQ0-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 27ad3a78-a3a6-4fd0-a5b1-c54b774af32a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 30 Apr 2025 20:59:00 +0000
Received: by hermes--production-gq1-74d64bb7d7-mh87r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2fa6c2ffd89e3e47aa75eb5dbe1c77c5;
          Wed, 30 Apr 2025 20:48:48 +0000 (UTC)
Message-ID: <5a220cb2-17ef-4bc6-813b-5ae5c7818d97@schaufler-ca.com>
Date: Wed, 30 Apr 2025 13:48:48 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] Audit: multiple subject lsm values for netlabel
To: Paul Moore <paul@paul-moore.com>
Cc: eparis@redhat.com, linux-security-module@vger.kernel.org,
 audit@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
 keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250319222744.17576-5-casey@schaufler-ca.com>
 <0211e4c6561bf2eabbad2bf75a760e03@paul-moore.com>
 <c53cf38a-f159-48b8-922a-550bd21b5951@schaufler-ca.com>
 <CAHC9VhTbrk_XovghLTtqPUv3br9aJbn2YcnFyn3uugTUKAHNFw@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTbrk_XovghLTtqPUv3br9aJbn2YcnFyn3uugTUKAHNFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23737 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/30/2025 11:51 AM, Paul Moore wrote:
> On Wed, Apr 30, 2025 at 12:25 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/24/2025 3:18 PM, Paul Moore wrote:
>>> On Mar 19, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
>>>> This is used in netlabel auditing to provide multiple subject security
>>>> contexts as necessary.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>>>  include/linux/audit.h        |  7 +++++++
>>>>  kernel/audit.c               | 28 +++++++++++++++++++++-------
>>>>  net/netlabel/netlabel_user.c |  9 +--------
>>>>  3 files changed, 29 insertions(+), 15 deletions(-)
>>> Other than moving to the subject count supplied by the LSM
>>> initialization patchset previously mentioned, this looks fine to me.
>> I'm perfectly willing to switch once the LSM initialization patch set
>> moves past RFC.
> It's obviously your choice as to if/when you switch, but I'm trying to
> let you know that acceptance into the LSM tree is going to be
> dependent on that switch happening.

Not a problem. Obviously, I'd prefer this patch going in before the
LSM initialization work, but it is your call.

> The initialization patchset is still very much alive, and the next
> revision will not be an RFC.  I'm simply waiting on some additional
> LSM specific reviews before posting the next revision so as to not
> burn out people from looking at multiple iterations.  I've been told
> privately by at least one LSM maintainer that reviewing the changes in
> their code is on their todo list, but they have been slammed with
> other work at their job and haven't had the time to look at that
> patchset yet.  I realize you don't have those issues anymore, but I
> suspect you are still sympathetic to those problems.

Of course. Waiting on reviews can be frustrating.

> If you're really anxious to continue work on this RIGHT NOW, you can
> simply base your patchset on top of the initialization patchset.  Just
> make sure you mention in the cover letter what you are using as a base
> for the patchset.

As I don't anticipate serious changes to your patch set this makes sense.

> If that still doesn't offer any satisfaction, you can always
> incorporate the feedback that I made in v2 that was ignored in your v3
> posting :-P

Yeah, oops on that.

