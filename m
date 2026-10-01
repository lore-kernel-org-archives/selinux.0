Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF644A4995
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866136; cv=pass; b=SIhejSQf6ZB42MvdsQ6sUfZWNnAbrJxO8erpIWlzYqnYl3aOfuxZjG83a3ATODVDQ3dpWXmxOJKZNZoYlJL7uNBZo3JpUftdyD+82PkPs2tdE0Vqe3wtLukmDqg/pJCT6nVAmmPZBgiCtpQYUt0jdcRfU0ESwANTpQsk4jjfhyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866136; c=relaxed/simple;
	bh=YQJFOlvxTdD5wMkJMcmHwCr0ZJ1PKkvngCiHvCZ9u0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlGV6ZsKmIzLb2tXZ8l9afEt5c+Y9TJCXx9NZsytSlCWF64tGZAYQFSw/yL6mlNAOhCZ67VSyxzSLMPWWpwEc4wa33L46F+hlYk13un9lZCERZt8kd7OliYwAkt41FgAiDZQbBaHg5A4HGmVRft9CqwXQhtQvj9fucq9VFpSkPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRrxe/Eq; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRrxe/Eq"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66f7a9afe43so5737959d50.1
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2026 07:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790866134; cv=none;
        d=google.com; s=arc-20260327;
        b=OQ2ePj6b/j9x2VoT3rLS8iNNQ1hHveaUZM/bYHnQH1tkUG/73cTqZrffqHldDF76FW
         4WuxR1vtB54BclStfzw3PS+vXl2ufAGTcxd8rihAidtmIEFVdAb1U2a2lgnZDIkWcI4d
         igiMhuCKc1s70bxCT00jzgn9uBjPrq3AR8th/xylWgM80akd5gkeECWxqNO0MyV7zj0K
         G6LmAbaQXeisjGySCe77MPv5tmyAKJHRKDKnRd5ZOpmtLwcEEwcGL1l41LjpthwTdmKa
         dbTGu5x2PlTAV9ns9rIOM2Wx7UMKzZY517o+8eH5Ov06wVACABETHbUmERLnrNfdWYTr
         sDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L83bGQBQ13Am/LWCIHACOZRL8fk6kblH5ZsnlevHkX8=;
        fh=ojsAQng6WAVyh9tkqnwi1au7umpu4zUbCWx9/j22k2E=;
        b=jVQ3Cro83J0R3TfhqDDvsSMeMb4lOlmJydAjD1xB7YzTaX1HaTXLSRmW+WwAcrIHLV
         tRGcYgWSoqJvws8wp4X9QTqGLaCEyax+dPjHr3noh/tM7EsMx+SUfUuZd9TKarfcfGIG
         R3FBCHIXe3M8o9zMz4n7yPdz++x2czc+DXACif40SJmSrbnlAL4e2HxlxXWPCpBQum4o
         5FVEhMdcVHL2xKP4cakxKC+gNUNPu6Tv8HvNjkJ8qJgU9TpSltzu/oDKq0ku5JuI5EjH
         Ji2SVKWfeUM2c6wXJwsNzRBQmfm3mU6cwf3WMov+vGVELVHji7JDUe6ZCSm02Sm55glY
         /QNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790866134; x=1791470934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L83bGQBQ13Am/LWCIHACOZRL8fk6kblH5ZsnlevHkX8=;
        b=bRrxe/EqPSYJlNXyGKGxpMWtB0v65a0DsVjmNEQdjAAaIFgHOey2mOLzv5PJ/u4VZZ
         b/A5oW/hmM9zR/liCB2a3etRwAQIASs7DE95tG3xwGyl4/QzzuIdmjC8cAzAbe58+fh4
         y86NEN9o50IWq0rmAlkTODtlDOvafE48D3mXSCDw02F+zz35m8ik5Tc5WDCGySnAtJQm
         6cXy3Jg02OboSmbDZ0y4XacMbU+YdMJZEie4quIVfyHHz5Uwbf6+b5twplqJm6KmUbfk
         LDxHi7HIhhBngGbFrmSQpncSzsanvfxvnKx6MD3DnakEsX3ztxHFY6EB77U1+d7OcD1l
         v5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790866134; x=1791470934;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L83bGQBQ13Am/LWCIHACOZRL8fk6kblH5ZsnlevHkX8=;
        b=dS3YNrSJ/qM2X4DTQDQMfVKx6Wzz6ySDJP9iPlpC+Y1omoQmk+19C/52CuNMPdbksV
         3HBWfKqg/PywFa0KdpQssCNjJ+l2TfyYxdjUqk0evlVO0Ra7MydZN+Co4BqY7YOOVLhq
         iTbr4XiGRV1BOqZ5NMG7GHKPCx2lVXUJnf5L/pTV0Pmmmvu+LoUb85p/4tlp55ujqejv
         QoxDA+OX4iMI9y0zqFWthn3jZjU6uLtSgJUASXXjIzCAni3VrFMfP0YecVk2t2+i6ZGL
         VxCRlLVQWMPorRcZC9PdoeT3lZUrNU5Pn5OPRijQnXxEoo0R6sWebzqZW5+SnNY74L5J
         EnPQ==
X-Gm-Message-State: AFq9FYLYSvZtyPImW7LfkO3HVgSId7RYqIfAdTcctzxU3RkgQ5vrxDc/
	A8zyMWx9tltf8goJBN0/yHz7tgX43/RtvVqQKLOtXvcQqwAdIzQZmM9fU8qwWnPXKBV5rv1iAl8
	1uyZuGk+Pepd4pVPm6et/hEeTEcg96sI=
X-Gm-Gg: AYBFou0ijDs5Y3AX/oaMzbp/IWJ3si61dZWScA2bdKlQBibnFCV34WIOyhf/U6cmUiL
	QurktLudVs+3AjNMTuJy5YHWzwKAuEwvd+WvAVcbmXQuYgWLJoK6aq6W3zD6hjutyXikQfH59RT
	7+zy/iKmVhhYOAvI/Gm1h7hi/j+Z+7oz61rU3XXYkOgZDs3Iwj7S8yaKQ9bcs7CwqRcSo1swlva
	3x0tJbbzfple198RBoi0+RsVxxBiAJYSyn6FPuqEIdBhjAv46Rv99p9foXQET7tU7zWFWy5FhaO
	QlUI3WTDb+T+1nwNDnccnPV2JJC2F/uCiXiMsszzH/jf/yVIJjTB0p0=
X-Received: by 2002:a05:690c:dd6:b0:8ac:e42d:35a with SMTP id
 00721157ae682-8ace42d0a11mr6644087b3.49.1790866133680; Thu, 01 Oct 2026
 07:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930111444.192037-2-lautrbach@redhat.com> <CAEjxPJ4a9r0Um3ufA16spvB6raYSQhaJbzwyWCvz4zkZeigjRg@mail.gmail.com>
 <CAEjxPJ7Ktrj4Vv-HeQyop_JJoHDE1sc76YW0t5Dz1_Z9iwkC7Q@mail.gmail.com> <pjda4ox8pw0.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
In-Reply-To: <pjda4ox8pw0.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Oct 2026 10:48:42 -0400
X-Gm-Features: AclHuK9eJX4WtcDDC9t4e_K3H_ljGj7fydLBTaEiZgcxxeJOMdOb6ZAYJko-nkI
Message-ID: <CAEjxPJ7cYLBYypzCzOKcZGUe8KYpYEW9Si46=SNDjHFRQY0isA@mail.gmail.com>
Subject: Re: [PATCH] Replace SHA-1 with SHA-256
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Jason Zaman <jason@perfinion.com>, 
	Russell Coker <russell@coker.com.au>, Cathy Hu <cahu@suse.de>, Johannes Segitz <jsegitz@suse.de>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:19=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Wed, Sep 30, 2026 at 9:44=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >>
> >> On Wed, Sep 30, 2026 at 7:18=E2=80=AFAM Petr Lautrbach <lautrbach@redh=
at.com> wrote:
> >> >
> >> > From: Petr Lautrbach <plautrba@redhat.com>
> >> >
> >> > SHA-1 is considered obsolete so move to SHA-256 as the default diges=
t algorithm.
> >> >
> >> > Import the public-domain SHA-256 implementation from WjCryptLib and =
use it for
> >> > label digest handling.
> >> >
> >> > The original source of sha256.c is
> >> > https://github.com/WaterJuice/WjCryptLib/releases/tag/Version_3.0.0
> >> >
> >> > Ignore sha256.{c,h} in make-format and check-format targets in order=
 to adopt
> >> > possible future changes in WaterJuice/WjCryptLib simpler.
> >> >
> >> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> >> > ---
> >>
> >> A few comments below regarding compatibility / versioning and code
> >> formatting inconsistency, but otherwise
> >> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >>
> >> 1. selabel_hash_all_partial_matches() output size grows from 20 to 32
> >> bytes. selabel_hash_all_partial_matches() is a public exported symbol
> >> (libselinux.map, LIBSELINUX_2.9) whose prototype is uint8_t *digest
> >> with no length parameter and no man page. Any external caller sized
> >> for the old SHA-1 output gets a 12-byte OOB write from
> >> hash_all_partial_matches(). This interface/functionality was based on
> >> Android-specific functionality and I don't see any distro users, so
> >> this is probably fine to break, but it should be a stated decision and
> >> called out in the commit message and the 3.12 release notes. I will
> >> defer to the distros on whether it requires a libselinux.so version
> >> bump; I am fine either way.
> >
> > Actually, if someone cares, we could just use symbol versioning for
> > this and fallback on the old symbol to only write the first 20-bytes
> > of the SHA256 hash to the output buffer to avoid a compatibility
> > break. That said, the only user of this function that I see is in
> > Android's libselinux and that wouldn't be helped by that.
> >
>
> I guess it's related to
> https://android.googlesource.com/platform/external/selinux/+/refs/heads/m=
ain/libselinux/src/android/android_device.c#394
>
> It seems to me that symbol versioning would not help if android just
> pulled new libselinux and left other code intact.
>
> What if we drop selabel_hash_all_partial_matches(), add new
> selabel_hash_all_partial_matches_with_len(struct selabel_handle *handle,
>                                              const char *key, uint8_t *di=
gest, size_t
>                          digest_len)   or ..._sha256,
> bump libselinux.so version and also document the change.
>
> This way 3rd party projects using selabel_hash_all_partial_matches()
> would not even build and it would highlight the change.

Bumping the .so version should be avoided if at all possible since it
will mean some/all distros will have to ship both going forward. Using
symbol versioning (already used elsewhere in libselinux) as I
suggested would be better for the distros but as you note would not
fix Android. libselinux already has #ifdef ANDROID blocks however so
we could also just use that to have selabel_hash_all_partial_matches()
truncate the SHA-256 hash at 20-bytes if that's acceptable for
Android, or to do whatever they want done there.
