Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB83672BD
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361879; cv=pass; b=oNOcm1Flygh+LIxjcr3KnDASysweN54hkC9tJC4wL7uscbRxiYWaT6IAtekuk1kWwWVWszXOpNLuqOr3UuJ7RQJRVIo9A08LaHuoWqznuskIGmZY+vIhBkPUfzLXU+2nrXjY9+ySRBLP6vUEXBfS6w4eRvVEDR9tQkCXIFYq1QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361879; c=relaxed/simple;
	bh=ZkSGgaSX0ClSYqiGpD0kof023/0mwEqTAz/5SMUuIUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKGHmYcXq+YE7alqHSgpDnmWVCbo3nTZpdEyYeLTK6MDVUPNy0rspg+CBjoL5MM2u0eRqAjxqhlggjkXKclUUBgsYo5qXvpnwJ0fjEyl/WVMTAIWDlskAHP2wvtaVlQpT+WzeGEAYye2m32n0aXJzfiy2JaZHFGs99ZDMpX1GJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co44Ye0/; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co44Ye0/"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf30817so12901907b3.0
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 11:44:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790361877; cv=none;
        d=google.com; s=arc-20260327;
        b=fvJGJbajS8iqh5+o8z11T+WZT3nMK/AsFN9w6MqWAjPpLxoeUXEkEqqB62Huj0fXPQ
         NDdZ0v17uwoXxmKB8eQOJz0jkx5RTBem/0SIN+uemqKnK6hB11KaarEACWqvHTnaHOKB
         4WfhnHgi2McNK0jgQn54PU7l6l5C/W49N6DhO1MFyTmScDJymxt8L9AiNDc/ZpgYHWGT
         BqKycmrSPbcrGmiv+gPLIjmO15Q0VGce+2lWqPj1epjR+B2jCewn2/DCikE6R3GSdYXH
         PnEKo3fm0Pv2Fgu1SbMPcOa54rhIKdgYGjteVejtD3aAjC5HMrWlFRlUrAqYgUY9Stt8
         t0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D2RcF+9WVD4V02A4UJk/vncjcV9orJ+RSZ015QnqTRc=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=mOJVFDuj0xybmlZOMhvGhfUbmCV+F8taYkxHQmZgd1X5U1CBZyheJWNXyfeKCoNSe5
         XdVfDaySHm2vdKI9uPIsu9TmMqlEtRf6OZmxz9UnrNOyfu/99vEKCPlsuwDTSDpce8lq
         0YjsKkTPx0WtiMpTESmIuKVn50TFZLJmUScorR16WQ/wBQe1N2WVw7vKdGGA1Oyl81FZ
         X4rD1/R92sDca/3XSTutbnP6yT5DzGCRtYp6qglEiAfAB+d9Yh1imnV47w5MWiTDovGf
         //DWmDnVanruOhOks88hoTvg4lwnE9ESvc+sKwddnxsSLlyFpFJm68JeOIHh9HQ0hPA0
         2FyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790361877; x=1790966677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D2RcF+9WVD4V02A4UJk/vncjcV9orJ+RSZ015QnqTRc=;
        b=co44Ye0/28u/oUG6iL1qbNq/S6mcnNugZZyON2T1+XcjA/rlFPOKKtCsE3IuCUBe2z
         I/tv1RUceOi+cSmzMEvTkA7PajWlFaWQadQor3uxhG6rK+yG4TTT6VmHieRtZv7nesp4
         UuceNwgSH5yg3yXcDWks4NhCPG1NxjbPAjrU95L/im4iBnBPTGL1cjkikJOeUWItOVTq
         +6utavgBZKWoaDz5YIDugGRBl56OuHOqSvO6iG7wdbyS+T0rM2ts+6TUwXOkUo6zbeYj
         pLkrXYnH/mICtHGAnKw1dVcSUkKXCgjU1rYNrcR1Qb4P/1/jwSYYnfuPDvkQV+U8Pc9Q
         w5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361877; x=1790966677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D2RcF+9WVD4V02A4UJk/vncjcV9orJ+RSZ015QnqTRc=;
        b=du44gjNc5zEyHiHXS9OcF1ZSSTD4VkmmKBpXcA1x5y8Qt8iqNcQ0CqgetKFLczKW4L
         ZTEsIpqbSVBNkOjoW4bh5elo9iY8M9mM4wIwWhO31ISrNb2PadJsPUbDH/wiT8NJ9mDc
         r+6KzQrvk1QcLigGC+APHcvq2eMED85VVXhC2ZHGmgLRVSkXHBfNOBwWZYrdX0YyLErC
         Wz5qGkQlvKVI/Bft/zRAjOkZGVsErjWzV3ycKyVfsDg0vPv2/9s0b7HPbODmk2LcmtxY
         L+7AcPoqvJklmZISW7+N2MQVVC6Fh6ad0NdbHdDALshvzXFG6ViX3dR+fRFDpFFYoZ0v
         mbUw==
X-Gm-Message-State: AFuF++nwZ4cjI5v78fC++omsGpF7EDwmYAyIpP8ayAAgd3xR1kyCj/qU
	FyAzM6ATC7al97NxQLbRyRWloFy8FwaLXxqF3eIXkkKC8KH77o56ckgXChVr6Ij6gtrTp7UrME3
	5VHEh8NDDCJa8mQxdQ2mfpN/j8dJPM7A=
X-Gm-Gg: AYBFou15C0tcxkg6bRcOHNX5XrQKbNrERsxYTzdyR5hDdryRfoirtKfoSIA4eFSHxfG
	BaytLD4POMQYc4KsS+G9EmGtjHEddfYLK8LmGTP20x9fNpv8yplcOqewQwPE5ht2E5hWlnub8Nh
	VsVgKp6eStryGu3O0gUAvnDs3ZrPgk/gyodiNVbtMjk08oHefYEHZH8iU6yGjcBghVkF281VVpY
	uu/U9JhqnthkhGdzLtZt6NhQ3wsHHxOwpnhInfTlS3Ry1l/zmGlCdNuaw3SyBkiAy2INb4NHvQ8
	NM38YDFqL6YshNwx0CloanGccxIxvm9sAzYpuF/jIIghvGo/Sw0QrgfUAj5MuGXvxA==
X-Received: by 2002:a53:a984:0:b0:672:99e1:11cb with SMTP id
 956f58d0204a3-672ed48ebb8mr2052009d50.104.1790361876791; Fri, 25 Sep 2026
 11:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 14:44:25 -0400
X-Gm-Features: AclHuK_dgR2IOZ3NugWhYlZxvnc_Fy67V0BlaAXJWdhG8T6xNY83tfUStPdMgm8
Message-ID: <CAEjxPJ7PxnmQoD9vzg4DH2vhxtOvG9pjERpiRHMH9m+CCL_5Eg@mail.gmail.com>
Subject: Re: [PATCH 02/21] policy: fix build with Reference Policy
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:20=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> test_file_load.te and test_bpf_token.te call interfaces that only exist
> in the Fedora policy: files_rw_generic_tmp_dir(),
> fs_rw_inherited_tmpfs_files(), userdom_read_inherited_user_tmp_files()
> and fs_list_bpf_dirs().  With Reference Policy, e.g. Debian's
> selinux-policy-dev, the unexpanded calls end up in the module source
> and the test policy fails to build.
>
> Fall back to the Reference Policy equivalents, as already done for other
> interfaces in test_global.te.  files_rw_generic_tmp_dir() needs no
> replacement, since Reference Policy's files_tmp_filetrans() already
> allows writing to /tmp.  test_bpf_token.te also uses bpf_t directly,
> which only got required via fs_list_bpf_dirs(), so require it explicitly.
>
> Fixes: 011a106 ("policy,tests: add tests for new permissions for loading =
files/data")
> Fixes: 16ac3af ("tests/bpf: Add tests for SELinux BPF token access contro=
l")

It doesn't strongly matter to me but I think kernel patches generally
use 12 or more characters of the hash when referencing git commits.

> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

I would suggest that maybe refpolicy should have these interfaces
added to it, or if they truly aren't necessary, switch
selinux-testsuite to always use the refpolicy interfaces that do
exist, but regardless:
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
