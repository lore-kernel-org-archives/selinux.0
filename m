Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40CB2DB7B0
	for <selinux@vger.kernel.org>; Fri,  9 Jan 2026 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994164; cv=none; b=qkpU3CP3T2SD5K4oPWnUn40fnvkx5YIxa37BPlCuRtvv3+CBCX+YsUd7dUB4xLBUVQgYLK93VNkmoVlM+A3vAmVdzFHw8rsjKkL2D7/d7zDFA/ggoXO7HdpigqXIF7CiSkit6Hbg9d7EEC0JNHrRR+gJRE9Vfa/UdbDUdbuPtQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994164; c=relaxed/simple;
	bh=iEhp/FjE3Kytf9FEjigPOB+6OGPoKmBFlKdjQguYbEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/OVoe34s3rVJ4lHj81NVX5kkE5NbWF73KpUJ9qmLc3laapc5SdSzY8um+D9awq+n6Ie+vu8pB+sBH3A1sWDSZ0dL1fvu6HPzieByitZWoryAJ8AC6nZI02Yzgi7U81JyGz+7CDk8yK2+O20SgLjsw/MhaJzoU3mNMkrf6Edqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XTMt6fWm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XTMt6fWm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0f3f74587so37536735ad.2
        for <selinux@vger.kernel.org>; Fri, 09 Jan 2026 13:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767994162; x=1768598962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlEDxeOp170V2vmFyTXKPMe76sc40+4HCw82zLM/GzU=;
        b=XTMt6fWm5MyxKy747Y2A3Ayz1vPH3mzI7SYLEitn9JV3P+SaKPCb1Nm+1Up3o10cfI
         RxxGEykzMDj7nwBc1bD7f92dLfaqVjc0cKOoJRmxDhSJeSIuYo+Q+hc6+AbysZ6x8I6I
         njEPaj9ZNacNOioohYc6Vet7gkLuQ/Ypa5V8sHBI3euHjDcGhrtCGTJTo4gmYERJd7tZ
         FJ+6HVK1n1kplBB2n74j1jRxQzay8jw+AD8rOEh6wjGFJghL0myOPQKAMRBjiKCRQRer
         JuPFSyB+7oQSa7Gw1C1ntH+4uVFVqG9GUgIF3yT/SmrZa+doZIIbfUO86NmrsjdpvT7s
         ijqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767994162; x=1768598962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZlEDxeOp170V2vmFyTXKPMe76sc40+4HCw82zLM/GzU=;
        b=K4Z+xtlWw1KB5hLMAPWpYMc1NvM22OAqhOeOd7KZImytn4IEMuRxzpiPeS71pFfcOQ
         345LdPuIqUfTLYvwZ6RRZikO1UTVczJi2U/Z3/t+yJvRFO1c94n3jiASsucE3yQXZmS/
         m51f1StxMuEIRQ8DtZTz6rB3K+01eYOlwIyZ26hWv2KoGlS9zu7ezqo/ReW8c31/z0bK
         yXf4VR87Fh7QinpuJn2REqzqf73ssgKX+K6izkyCG+hJ2bX2ou3TfOpD03J3zqMy2209
         TZkG92OnIVEUsoAHtlO/UaRoAAahhRTBYzT/hnUkfvxX0YJ6/8/A2HWwgaFdwBM1yThP
         VgFw==
X-Gm-Message-State: AOJu0YxkYMTXSj148rNWnpLmQ9ZLeewZsMrERAC/vsl5IikJDaMAEL2x
	lvdS94DH7LDlDMcPy3eBPEQw5Kfr9VHTl0HIoJlD/lxOKOJ7HDXjvyn2+S0Pf7TXcS22KpKuNrI
	DbOz7y/EJ8FSXVtNkU5jSYBRf3NxYMWipFlQlu4MFG42P/12aMwF5Kg==
X-Gm-Gg: AY/fxX7fHj9rsbmL9TIvkb7Ry26gMawE8qWksl1001HClP9rMfXmPsdQ+tpG/wpBKpw
	ujR+NQBJfr/sxQhcFyvcaMpIYzxWM3lYbx99kRE3ZNCBRnlIHpyoZU2i9gAUjca09U05RaKMfTg
	0Dr9Yk/2HPQ1GUhbLh7XpQoJ9L93X96K+daXshfYyOsIxJ19Dv9V3FSnHCmM+Q6+6a09a8KF62c
	62/OqFUPUA0mpnC8dj0EHDa0GLA7uGv8sAeRsoCHeSR394n5nyQllXh4wXzQFjXDxIBAhc=
X-Google-Smtp-Source: AGHT+IG4wEcux6h0h9zaQ3vheXWXkkPCo0EPVW/i0RKQhFasGA4iFCuK2qM8WRrDBWshQjdoMQA1LVHJV0QrCbcyVOs=
X-Received: by 2002:a17:903:3884:b0:295:290d:4afa with SMTP id
 d9443c01a7336-2a3ee46179fmr100852375ad.23.1767994161941; Fri, 09 Jan 2026
 13:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105174020.887724-1-lautrbach@redhat.com> <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
 <87h5sxvd52.fsf@redhat.com> <CAHC9VhQmYLMqFzytgauijn_C6TXksBVsptEdNb2ZcyKFT8fsCg@mail.gmail.com>
 <87cy3kv5w2.fsf@redhat.com>
In-Reply-To: <87cy3kv5w2.fsf@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 9 Jan 2026 16:29:09 -0500
X-Gm-Features: AQt7F2q6QiVvdS128AJ6-WBTud-jzcQhvyj7LKT_BDzb-x1upFWe7OOfambHvDE
Message-ID: <CAHC9VhTcEFHNJcTSbvWFU4gKpAUBg-8cLAfushX8CrhnT41SbQ@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:57=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Wed, Jan 7, 2026 at 7:08=E2=80=AFAM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
> >> Paul Moore <paul@paul-moore.com> writes:
> >> > On Mon, Jan 5, 2026 at 12:46=E2=80=AFPM Petr Lautrbach <lautrbach@re=
dhat.com> wrote:

...

> >> >> diff --git a/SECURITY.md b/SECURITY.md
> >> >> index 2a7ce5b317a7..faa060ccff03 100644
> >> >> --- a/SECURITY.md
> >> >> +++ b/SECURITY.md
> >> >> @@ -24,7 +24,8 @@ list is below. We typically request at most a 90 =
day time period to address
> >> >>  the issue before it is made public, but we will make every effort =
to address
> >> >>  the issue as quickly as possible and shorten the disclosure window=
.
> >> >>
> >> >> -* Petr Lautrbach, plautrba@redhat.com
> >> >> +* Petr Lautrbach, lautrbach@redhat.com
> >> >> +  *  (GPG fingerprint) 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5D=
C1 C13E
> >> >
> >> > I think you may want to list the fingerprint of your primary key and
> >> > not a subkey, as the primary key is what carries the signatures and
> >> > helps verify trust.
> >> >
> >>
> >> I guess I need help then:
> >>
> >> $ gpg --show-keys --fingerprint lautrbach@redhat.com.gpg
> >
> > You want to use the key fingerprint which displays when you run 'gpg
> > --fingerprint <email>'.  Assuming you have the keys for the other devs
> > in your keyring, you'll notice that command can be used to reproduce
> > the other fingerprints in the file.
> >
> > %  gpg --fingerprint plautrba@redhat.com
> > pub   rsa4096 2012-04-03 [SC]
> >      E853 C184 8B01 85CF 4286  4DF3 63A8 AD4B 982C 4373
> > uid           [  full  ] Petr Lautrbach <plautrba@redhat.com>
> > sub   rsa4096 2012-04-03 [E]
> > sub   rsa4096 2017-12-05 [S]
> > sub   rsa4096 2017-12-05 [A]
>
> I've also changed my email contact address to lautrbach@redhat.com which =
I
> use for some time already:
>
> > From: Petr Lautrbach <lautrbach@redhat.com>
>
> > -* Petr Lautrbach, plautrba@redhat.com
> > +* Petr Lautrbach, lautrbach@redhat.com

There are mechanisms to add a new identity to an existing GPG key:

https://docs.github.com/en/authentication/managing-commit-signature-verific=
ation/associating-an-email-with-your-gpg-key

--
paul-moore.com
