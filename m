Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795198657;
	b=iGx7Euywd2L/5aLV1p+6njLspvUXnQb18w9/DrSIj1GuUXkR8kIuhMmfmgW8qyEmoXLQ
	 sP+yUXWByD+kQy4Wif5p+x8HBXBFsNAATX2TbGcwQpxYqwB+kvUOTMPH7NXBohCDBz6Ru
	 oc7TkUsC8OsWNdqTRnyrW5XDwjsymh92h4aMu0VqMxCL877Pkb9W75o1XmdKKaPKf9gTX
	 r8MUKU6QLbxkwhnOfz5OiDMHEKMsDlr+cLcVxBIKGiRvCf48OJMvJnx0Fxf9gaFXNszJ7
	 ZnxAtDU3RWDWr8TuZa9C5ABzocsGVWoCEK1fQgtp/GanXfi6HLz9E3S9fgi4CKd/JzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xRnaKYuXJq3EWEQcGbrkE3rcTWW+PCNPpH2/XRTsC7Q=;
	b=1Jl+p3BAIPl5+PXvubiZpwBkuHVLNrCt50pM6EUu6FhyrW8/CEGXrcWy3W/iIJwoLCBR
	 58lTDTg/ZevExB6fyBBXsd3XMy8+uMwKuj4jqBnQg6vI7aTXz/84Hp+ztaS0f2RjPlLts
	 rK29wdQp9aAYHN7C52gqbSLA9uaVY5GBNuNWG8ek5/nR6/nC2uxRRwgbGJYl3Nm7m/wYL
	 /w0HNces3u0od4zqCupah7eeuxc67yJH8vK+1752+oGHu4+sb81VEapaIrL/SFPQfk9ND
	 cojGo5V7l4V6Q8ltbnalSX6Y5riVH9EROTp623p2R8tx59EFFY/wCLdHkgFNSYtGriQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AO/a2gwp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F66607635F
	for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 18:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81F66607635F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AO/a2gwp
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b51389f58cso13091567b3.3
        for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 10:17:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795198652; cv=none;
        d=google.com; s=arc-20260327;
        b=OC3EXoxnLgko/ttroi+5uW9RlG/G9SNOWe7JJ23v1buZoRFxtCEpcMkR5c5uUdtlUU
         JpKhnumwG1FI/DGnBLUou5hDDtCzQdlwNVCbChj1/PaZY4NQGE3XsD48bj64JiNUS+fP
         TfjF8k7plLAOknHVnhzC7M9HIcb3FxsqkEx0MRUtN2p23S6v6LdEzhbAe8tycPhlX+/R
         G1MQgE9C853XBeHB7NeZF+HEs/nb+Z9v+hloL20D1U4Ia7ET6Z6137Vd7HrkDbjCqGva
         kBxqtEsmCJ7U3qfOLxvGxvteDYdgxwjWkNZybFFGYWwmrED5wXinwHEGQvI1Jq+3Udu7
         Y5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xRnaKYuXJq3EWEQcGbrkE3rcTWW+PCNPpH2/XRTsC7Q=;
        fh=3bY8Q6qSUFOwupAktnJ48slZmV8g0SJ1Z5g5jHiCyAU=;
        b=DAOytzEixyGdZhnAMSv+NNL52bpJ69hjPPzqFZIRlLvKdF8pI1olJLYan+LN04HnHR
         g13tJgNHjdaA1I5+YF0szJq6Ak6WUHkwMzfWla6vYB1RIxiBQwOUH0pRbzjLsBSvkdOX
         lRXoR+m2AreiVazlpnB0k/uNGaZ5+3cz1omLRakUxZcF434jIIq4cNVIc3tycRp8OEDr
         NV7Tel3z+Dect1oq2nx9DWQkzgwV38Ik3jsNjazYBjF8kbvfRaTjgD7rby0Gct8SCx6h
         +XcaNRap57fM/Y9btths43mNnYMI2TtrQaBhlN+nvhmVuXJQKEnD/X/4y47g7wnY7v4G
         kkvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198652; x=1795803452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xRnaKYuXJq3EWEQcGbrkE3rcTWW+PCNPpH2/XRTsC7Q=;
        b=AO/a2gwpMpRcQLu+qT//vKIn6K/IPwXAZ+Fhjqcswy3bslC5PjnkM0GGWeGVeuiDGd
         N2GXcMyxdtUj7riEp3LrvOlcjWWzZfGGETYABM745vdFmeotPC+FWEySxdfYXV3EazEN
         HMcVll7PVFc2HisH9Q+t+GuSPUo8hM4hEhgbHM/uLM6SIZ04Evb+/FfJsHP6tHee5ejg
         AIGGZMFba3QWtMwvm6yWdu3q/qBoHB5rcYIBikhhVdij574/bHAiR8RrjTv94XzS6VwF
         z7ny8xrAX1vtbizUhR8++UHjdtRymCGtv2sXa03i2LXasDbg8ap42z4rUG1qj0FiMHnL
         qxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198652; x=1795803452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xRnaKYuXJq3EWEQcGbrkE3rcTWW+PCNPpH2/XRTsC7Q=;
        b=Yq+GEm1ToUKu2sIrfccFbKQk9tECoQt4FVVb/dNYzkAatxk22krjWxAArgpfSgHHtC
         EvzVEELb20xkN2Dew05wMkws0eiztgmXJdaicakXMBaj5fvzofvTBnfFqwQ1UeY7gj8a
         5g47AZOD5yDv7I7M5p6PZqqgPGHJeKxTrbunhDzQJNMNJhchW5QttvkvM43nWjeMQFB9
         MYTX42yZCYf87BUC3YHJyvhxADLfFC8yEKacxjVkRo39hbPs03KBy2vilcvLvPqn65la
         8xCtJpX2AvRtOcZvrifecTlFrvvkjwm/6kEvhssCXxcPpu8kx+2s6VVf79QtcU6CkCbj
         7w2w==
X-Gm-Message-State: APuU4Z+Y4sy2REU+dC9P+LgIOMkz2vtPIAWiUKetHiiv2UNLbftt8y9K
	4YLOWkbsM5x9e9WWkN7c/skUyHmOE2w712dNrotRtRDCkGXihCq1VPvCcy8KZkfHAYlpfBstgRq
	/dYcabebNbQ2me/g3qGbC3sEB6EQaoYBY1D6+
X-Gm-Gg: AZFdTZcrOBVWUXytVLuJBztjkoPNlyWdnYf/l4H6Qg7qMcoR6xpVAlVgoVHy0xS8mvP
	G9+vyoawlOWJF97ipPZU9tkVAD8lQCppas1YBfFz/e0EtRSpbsOuseOXtUsiKVAbjl3XYoLcjKi
	PdX4kkWp1ggqN3g3nT1S6wDNsOrqwkNXI1Uh9Co0y315OFIFmqp10ur22tf9rTjfn/TY3x4laU0
	yZjycU8rSMjybjj1TQHDB6c6QJNrlQCnuDYWfeBSDvk0Ymu5qXgSYIwvWoOkfb52IsGAz+ZnYE3
	M+1go3HfrergTSuYcy4uXkF2Uezk43tcz2T0PRafQE+AMJFCVNYafZldiAMcjj/Pr8bUVjFmeIy
	6kZe20Jl5f5AWRt7j3u9c0Vl/ks0LRFT6641peldDXAUlR4soUPKuYKqf9ixzrKBoM2HU56PI6E
	/0lbnG7Pthkhm1PR3sfHosqqgkxTAi2VryQRzcU8j6Rcs2ICqvM5f7hdLY+Pg=
X-Received: by 2002:a05:690c:3505:b0:8b4:d8f1:cc92 with SMTP id
 00721157ae682-8b5204bb88bmr15637757b3.60.1795198652509; Fri, 20 Nov 2026
 10:17:32 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119195022.1554-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20261119195022.1554-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 20 Nov 2026 13:17:21 -0500
X-Gm-Features: AclHuK9VdJY8HrqeV3TxrTyECCuOLzcD1iU-oUgSDzqfxRZ9N7mRQY_E3_o4jP8
Message-ID: <CAEjxPJ4FSryeXGvjPkjBzfcJ4Egzbq2-PnZ+GiCMTSNg+40Luw@mail.gmail.com>
Subject: Re: [PATCH 1/2] .github/workflows: pin run_tests to ubuntu 24.04
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jwcart2@gmail.com, 
	paul@paul-moore.com, jason@perfinion.com, cahu@suse.de, jsegitz@suse.de, 
	tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 2:51=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> ubuntu-latest has been updated to 26.04
> but this breaks the CI test matrix. Pin
> to 24.04 until we can resolve the
> breakage.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series was merged and restored the CI to green but I have a new
series coming up to restore support on ubuntu-latest.
