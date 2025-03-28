Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F3184524
	for <selinux@vger.kernel.org>; Fri, 28 Mar 2025 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183288; cv=none; b=FF+5Yq/w3Tc7P4pfL3C9qYfaQxgLE3j9hPQB1t3grBo//prpzkxtMiNnRFmYgSn1lVCdaJEV8XJoyPsw5Y/Kb1HWH0npMEr0+PPZ9MnyEZiV2WtYFV9JDGftMCPPrndjxnC+M3Relis1rlYata01g2Ffoppv73Fqzd/JnKGaCb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183288; c=relaxed/simple;
	bh=HYM9EqSm0cKVS5kI7KwLn69xBqi5+nyEOoR6i35nJbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGfXeNrEHRIt5FvRTGYqyH/GDiryelI9O32opp0pgxSnfak7dCkURxW6xLyb+7BXOrW/0IGQqNwO0omxQb0vI4/Nn5wKwbAGmP7t3WTj3gFZnBcZ259cUJMtoB17duAoS78G+sI0ZjzN243BaXOg8utG5xjaG+aBpjqZSSC6Tjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DQLGaGh6; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DQLGaGh6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1743183280; bh=HYM9EqSm0cKVS5kI7KwLn69xBqi5+nyEOoR6i35nJbY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DQLGaGh6EU/ccl78LXfFpbRkxLyO8WuPmJWdfiZHW5xSvL6yO6lbi+at5m12iyDlPjOKlxnKaOKqQjy5NiAfZl/co8x86nTmOzpnkMyisTKWx91z34MjdjQQ0g9hsNUoP3PCg7f9eMALymdVtiroDAdvy/Ngx+GgLZKKLeAXQhA4rq3vuKBtKK+Wz7ZZ+BpupnQb7A0QiM09+rsxPppGobd80WjqaGB+00tDMCIf2CohK3lcO/ynXhEVf0mcxMBLQPqbLbKbHuq37tAVfgzLKwQ5gQlwz1D8AN3j8Du7LlXsaBBAYvGIh4d5ZdJAFG+/CqTHNIN/n+ZzjxMmga6qCA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1743183280; bh=QrgPl6uP9imw6wLw5T/Z3drj1nvCOoVdOSjAF3eHLMi=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Tbr1nF0d2IQCJrV0yoyubDTI0DBpNsYm5fsRapJvsEmCSK0wgh615gq9ANWqHT5BCDcFauDrh04z4g2FsDd1i706RSigRZnVxnMXKlX+TG7cENgvQaaTZKtcwbltZgEXb91YcRq70rdbM6C5wqedBhIpK/AS/t/8un+Ovt71u5ybTjlYbD2rWdYI+wEVoGfQrC5SydMDTv4ZDDjIlkHuYLhe5pcINZGMLNch4jUn/UirS0Ztn56fl9d6aOXTxlXA4WfPLiVeaqxmdCAf/P8bnOPMkMYRm5x7X1462dyFbTwk0sotViKPe8WEsYOhGn2CWRCJvK2mbRzrjFCATeW3Bg==
X-YMail-OSG: ql7uyZUVM1lqjiW3aJVTpGK9mS8lRVHg9d4XaoCegKZ8Bv2ayvLmGtUK_CyZ3n2
 CjRrXpkjT4Pxu1ig54Txu7f1FnZtK6mBEU5CY3jcGzD83QKSw7v7VcJOWoTM8O57hkY0EzCSOU2l
 YiU0RmTqhDPbWe00c.RvWs_UD8jiA72Ej4T.mmzuOqelTu3Sco5Vf9uX8vF16Mt.hOD_KU9GZlE4
 6u9goW28Qwn956QGk998ez0.wM6NXcVbrvHaWxh7vu2L0F1.7iwkR6KB3lG9BhSDmMt2p6IqANIo
 tDdcyCPC.CrvJuULeNpzF37o5SSSHcYA3iVkX.Mg4hTaGVj7GGvbCdV0bmtjpBNwrl1SR.wnMiXJ
 RuhONEJGUf6MSXyWukeEWdNuw.AAFEg9t4a1EIcL6xiVfg9bLJKHELrQvBhLNV7OO_UKwMlp4MwW
 iDpaKQsHF.d.MjyD27RXwYS3zkWdo0NqCIe4VvsVS4zj59qcQQ_AIJ3EpowuZvsCMBTqHnkBDRGb
 8zUQoLS067EdgIO6CqNyRymj6PvqcD7_tjiLiT66O2hisLS4O21laVKFsMuXc7RhrdnTLQlUcT0e
 8Ksk3_0NBSBQzKHfn1iycVu5l6jHv5P2ZVVCex5wos5Pi1os1QtQLsMTU2s.NjadGtJFbDAjXBvl
 rBR_Pr6jePLOxLJrcKs6FheiKMMZKE522.kW7UhhRi_XhPLmt0LebAAXfm0iAe_91zK3BwJQAX4D
 Xi4swplZT72UyB2tIRlXEqFshS.LkeAtJkzgXHwHnG_BALRArkL3OSnJUCKMHnHKrJ5Fyf.TS.2e
 39eVeGUmlqP_RDkREM_yHPl6f8iQ7fyG1Gc1jR4gWPPDCo8EdR3QcOqBm1UMRFofvtoxOnCOqZKQ
 U91bqZJ2bsaui8b0_Ki6BfOpOlJwkk5LBX2Te0E.4xJ7Zjf1YtaWOQP7Jy0cE6J6w9We3XcmWhUj
 xu8RAN_OmcU1w4ddgL6uSKh60cJkdgTrTgDegXswjW8aJLeZJyYrABt9CW.7rLWZfh86VmMWTuI4
 iR2J5Ywoe6igmKp87_bCKHwCuXhyr2AFMePXy9HlUFNc2AiKTbEpKZ.PBEIxUJKImBhwLGXCqsKB
 m8pEymMQCDAaUVkQMzBK5p8uc6Gtk3eGnQYuG7Ir_26J0N0jCBLhvX2iwxHqRhH6Wa2wFVgy0nhF
 ApcAUwoB.FeFtis_FDPMAK3cYcTDBT.njQNf2zre5C03Aj8FURDDLNS8yjPQQoI2zfOLb8Q2u8OP
 FMt6QcLwTtdbNLS6CewJrE2clJRS4ZUfSf_3oolqMiBo6gBPmjRf1x1BHQJGU1d_rEOI6ZKFJJIg
 JHwK_ivGiMHCrFaptZgTTji1VSEMcp22EW8lNUyBgJhQr.9qVtpldSpAsdpLU43LLVy6lNk0OeBJ
 yrioGhs9nDHwnH4p3Nvj8IsvFbIM6SnXdOPU7LZPNTVFrpWAtdPyKEJ_mhXjd4SxjVao4wBVTalu
 iCsjO7nMKMh57CyaYOkri9v7jVZjMluvnw4yWmRvgHg2w9vcPcEUss5R2B9fF0C.20u6oTDw6LkU
 VV96PnoN10QnV0BceiZcZ5Ip0Ikg8gYVmNUAxVpajkOJ5G0lJPvpKUACN6SXKL12vMe80Z771YOu
 QC2DXbghioolaQ3QqMPxYJxikbWdBap5R9Z1uKQ6OQzFm_bpq_XvY9FIBKrF_3tFpqumaImLPX35
 KNVyK3Pt248L2zD8yI0SlhVuPGleXESxKcroFBQ6lqlATt4hSNjRenbshRb9ZG0kuk5MMMvRYO9l
 fjErvtdx9uVSGofVlWdtIbWPkBugOGGRlPt6z7WNtwyrbr6P52JXlDD63tw.91pB8QAfSLBam.gB
 09SYqrjmd9e74VQhEYJvMXt3t6MWoHBLhKUF.Dyq6Pl9ReRoUafsPVcLshqPxn0MY_xg4aqC.tAr
 pntf.5kRNmZz3dnT1TrV9IKfpAfpxBTtTXCUox7uQIEU6BgHdIg.Wd0M4ms3PNvYd_GYWlz02qfj
 x.ZjOQir2UN8JxBsSVwk2GlbyCCp0Lfb2gLhrr0PE2kP69RARwpW6Wa4FLaWhsYha4_TFTjjJVvz
 jp.ANZdLgxqLcYDRp5qCPDMCIGw7yL6EO10wlTleheD0_k7e1Lz8npFwRryBL_l5JUyLWYYS0a69
 Kz3eaPK7qHoJfFeYel62oChEtgwQB6lfRrNV0boJxYRfUwb7dxKbj8tBZNixu8HYqZnDOvF0DHQh
 cE.IBSjq4SR0Nym4NPBIc40sFKWK8O519wVgQLJRu1m6Oua7t4seaf9m0.OemRSnT90m_U2UT705
 82aYeDQUTX1LLPzEtMGyF0Prl3gIDEQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b1d68e80-0919-4882-930a-c32d13455c2d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Mar 2025 17:34:40 +0000
Received: by hermes--production-gq1-5c477bf655-f7xj6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9e9b4313e0a857085e64680bd3846c5e;
          Fri, 28 Mar 2025 17:24:32 +0000 (UTC)
Message-ID: <e8106dbb-7044-4ae0-9554-6eae857ba7d0@schaufler-ca.com>
Date: Fri, 28 Mar 2025 10:24:30 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jeffrey Vander Stoep <jeffv@google.com>,
 =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Paul Moore <paul@paul-moore.com>,
 "Cameron K. Williams" <ckwilliams.work@gmail.com>,
 "Kipp N. Davis" <kippndavis.work@gmx.com>, selinux@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nick Kralevich <nnk@google.com>, Kees Cook <kees@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
 <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
 <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
 <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
 <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
 <CAEjxPJ6XnBmbzH44YVQxxv8WOyPN7N81fpj7OYonEOTB=rn6wg@mail.gmail.com>
 <CAHk-=wguzgJu4p_khuEXKHmh-6abSN7xLJdCTuyVEfjsopY7iQ@mail.gmail.com>
 <CAHk-=wh4H3j3TYWn6KSgznUsOXz8vfHMOfTNmFvjGr=hwULWsw@mail.gmail.com>
 <CAEjxPJ4fzoONpiy3z8QOZ55w35=WfWQ+hiTg24LMEHPpnaC87Q@mail.gmail.com>
 <CAHk-=wjbSRL7LM7CvckB+goQdUokMa_6G-iirdbtxrFSFe3mfA@mail.gmail.com>
 <CAEjxPJ4Np-_LeSQOPxRQggZjWxpJRhZm++XuEwNbMyUkZCvYjw@mail.gmail.com>
 <CAHk-=whoXr5GCHZsarzUKELLMAtcw0Qpmz_i+nenCVtBY1iBig@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHk-=whoXr5GCHZsarzUKELLMAtcw0Qpmz_i+nenCVtBY1iBig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23533 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/28/2025 9:36 AM, Linus Torvalds wrote:
> On Fri, 28 Mar 2025 at 06:23, Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> Yes, thank you. I think it would be easy enough to make that change to
>> selinux_inode_permission() and to clear that inode flag on file
>> relabels (e.g. in selinux_inode_post_setxattr() and
>> inode_invalidate_secctx()).
> So the thing that *really* made me go "I don't know how to do this in
> the security layer" is not so much the relabeling - that should be
> easy to handle by just clearing the bit, as you say.
>
> And I wasn't even so much worried about policy changes that would
> globally change meaning of existing labels:
>
>> Not as sure about handling policy reloads
>> / boolean changes at runtime without also caching the policy sequence
>> number in the inode too so that can be compared.
> Yeah, a sequence number seems like an obvious solution, even if it
> might be a bit awkward to find a place to store it that doesn't
> pollute the cache. The reason it would be _so_ nice to not call the
> security hooks at all in this path is that I think we otherwise can do
> all the inode security lookups by just looking at the very beginning
> of the inode (that's why we do that IOP_FASTPERM thing - just to avoid
> touching other cachelines). But if it avoids the
> security_inode_permission() call, it would definitely be a win even
> with a cache miss.
>
>> Further, I'm unclear
>> on how to implement this in a manner that works with the LSM stacking
>> support,
> So *this* was what made me go "I don't know how to to this AT ALL",
> along with the fact that the rule for the bit would have to be that it
> would be true for *all* execution contexts.
>
> IOW, it's a very different thing from the usual security hook calls,
> in that instead of saying "is this access ok for the current context",
> the bit setting would have to say "this lookup is ok for _all_ calling
> contexts for this inode for _all_ of the nested security things".

That is correct. But the LSMs we currently have don't do frequent
attribute changes on objects and generally constrain process attribute
changes to exec() and administrative actions. Invalidating the lookup ok
flag when any LSM changes attributes is most likely to occur at a time
when all LSMs could be expected to change attributes.

> The sequence number approach should take care of any races, so that
> part isn't a huge problem: just set the inode sequence number early,
> before doing any of the checks. And then only set the bit at the end
> if every stacked security layer says "yeah, this inode doesn't have
> extra lookup rules as far as I'm concerned". So if any of the rules
> changed in the meantime, the sequence number means that the bit won't
> take effect. So that part should be fine.
>
> But the "this inode doesn't have extra lookup rules" part is what
> needs low-level knowledge about how all the security models work. And
> it really would have to be true in all contexts - ie across different
> namespaces etc.

It would be nice if changing the rules for one LSM (e.g. adding a
Smack access rule: # echo Snap Pop rw > /sys/fs/smackfs/load2) didn't
affect the lookup ok flag for other LSMs, but I don't see how the
overhead would be justified. I'm also concerned about how detecting
and clearing the flag on a single LSM case on policy change is going
to be anything but brutal.

