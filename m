Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512F14B7167
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276932; cv=pass; b=QN76nubn24/PHgNjKxfxA9yTFZRxjtSd2sln2L/ALijJKHG7y7WkYp73PZ1Zbt/z9sQWH1NolNCLM3Oxc4MWBtSOa66yIAwjn8M4YwitvzvxRellGrqRFqBux+a6zEl38cC4fKbkt9mDxel/l1bq/q+yJdzFKf46BGvhEiwy3FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276932; c=relaxed/simple;
	bh=Oq3gEmIJZ/Al2x/5mSiU72Ms7DPMqTlsC6Hmo8lOEWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYNJ+If7YSKtkV6RhuRERxkCCgeH30wfwl+h4AlZ1FrXwIrfs1ueUau8xeS4ZG2O0dTyJoNJiPYUKHGnTIhb3VrwQTuS9uVXy4NeRoW0+fvwyPNmDNkMcRH9leYLCg2pbSpfvnLQFzRyT1msVSOUaLjmcIm8pnsE0t+lxj85VcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/qp9zlj; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/qp9zlj"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43f9b119so1804697b3.2
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 12:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790276929; cv=none;
        d=google.com; s=arc-20260327;
        b=gT35VSkAS7bySz5okaV7p9WBSuiO1/8x8TN6kgEXvAM9T3totl+OOCJX3UMLse+Nj/
         FekK0JR8o+XUcYxUbMqrretkySU5Gli6EjeApLAWTuh5j6TbrK6CCzD3sMYc/VBSVqDe
         kJvlv+kuLmRri7P/dHJqljHxYwI/3r1sPrX9xp8swSbI9eDiwZ7uftV7xJZlwA7ScSGp
         G3XfqJo6hUvX/iyI0qQkYSdqGZ/vFRxnv379dbt8rFt7megtMJWYseraxm2cdjpoJgoI
         pvzh9WMHbou05ZdT/qgexpSqtLLTTyXYaS3Oo7jC+8wH7YVv23wr7p+RwubkabFS+dTG
         6X8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S3Ty6jY+1fzDCP7d3tHlgto16211ciFLAZM+wuzbYzk=;
        fh=9CvfyTln6mlGi4sBe9JH0kMBicdx1bffQat4jneQZt8=;
        b=bpS4Qx6Dn9P02l276z0x6XLKtAY+MGyHIky3F+/y1G2w/nU9i2OkCXzFxld/ZRefQU
         5yoZkYHUoife5J8kE1fMVnXZUa+Eg+gxifiQExdJRFGo0oUQth8bdmAVge1xa8dWHzsC
         FRA+AFIqcqK9DUj3eR4X+0fId5yAjR1JgCMRQLzvdjB1HoXD4X/j+ZwRw/LUn2JB3q1K
         APsPjbzcCacPcYL+WanaigLCM+Qpny8LWd7s59iDbBr9YkomAntfpBxXiUL3oVHMioHw
         b5X/BKEmodHOAT96oCPDQXQSsBE63H7XlM3IhQtcxjQl/tdNt0FRAhPtsg14tTjnEVhC
         k0UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790276929; x=1790881729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S3Ty6jY+1fzDCP7d3tHlgto16211ciFLAZM+wuzbYzk=;
        b=l/qp9zljbZZfnhfgAvWF5mPn334+JGstI4V0g+sfeQm7AmKqxtx9K4CMDdMzYpEr/B
         9KcJYWVfnztfEpbSp6HVkRTT7183ln3n+yyHWZkS8ppf/v+bbs8JuzfNC0txt4pt8+u+
         E4yLMOyL3YrsWJzt5krTYZScl+QzS6ZGy+AMfsi13uozCsgV1EvTAuh1qUM3REJuLtck
         qhUb4Bihsc63BI2hFxCwnQ3/tgNf9UYktn7IDxINyNT2dlXg6FOJAS1IAzwSQ40eiWXw
         ltDEJfs2NqHqIHHqS3mfOhVBl4DCMbVoz8QacWTP9xVmnSooPI4GAtunC2w08AFsRlg/
         PWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790276929; x=1790881729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S3Ty6jY+1fzDCP7d3tHlgto16211ciFLAZM+wuzbYzk=;
        b=CpWU20mbDpWoRiJfbK0cVL3MmaIzI1Gz58SOE4PafOIU47Fnf+O7gULZtZWqbuKfym
         8Asu+sws/zx148aSfvFtSESkIHgA+r0Ke1BOHzoB+2ufHDBsBc7Id7B1YioPicor5woC
         dLez9O/i3FChS9kDI6XqP86Q75t1NSHigP1A9v7lFxYZAzJQ2odVBSxD604+wbno/7Mq
         cBUZmbw4+wVfNccviXI/zAd7g5Z7SPqaec0GKQIKtd9C9GssSj9kfRABSnseLz7+c6rp
         yU4PKICY6UVlJr6gRrpEVpdFKVVHnsu1RRd6TVlxBrSNbPdNTNOysP164QTlKWZ5gi11
         0dGQ==
X-Gm-Message-State: AFuF++kHHDKNPXCSizj/3T2kExwRgeC5VOtk1TX8X54C+k/wL75MuHte
	UqVow4rzKSc18GXWE6JCV3wlg80qGUZbnnyXrOL4tuuRjnBaBceJt7cIrhhMj0t0WFMVPmcgG/x
	OKGNqpsqB18wkhQhhyZrQ88rNtjzfQcRXOg==
X-Gm-Gg: AYBFou1ioEuKctznqvCYec9SDzIHHK/wxy9j2h33OVuux3tFwV1KBAgh1jRB14FEfy1
	AkgBysjsZt8IlXMny9a14M2Qown5fhJgJTYEoY80lJi/0JM7JEjvxhwe3hieC9fJU6noVOUwXY6
	afnAllgTTsUumMD1pMz2HRFfbz8Zcxg+TXw+Krv0Wd4ieXqP57uUrVYVMz288Hv7PNS8c8IpOnx
	gBgatwaEkv94mowWB1sgGaqgTfhmuNN0FwlukNywPZo1pB+PagBuYyPRqPz+f+WnyxOo9ennX13
	4IJETZBDzw0Pt5CbEXPmecxIYCE5sd9Lfl4ycuV4b2xveELPoan1Xo4=
X-Received: by 2002:a05:690c:e:b0:853:a9c4:c3eb with SMTP id
 00721157ae682-8a6463b030emr20595567b3.28.1790276928757; Thu, 24 Sep 2026
 12:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924173422.65885-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260924173422.65885-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Sep 2026 15:08:38 -0400
X-Gm-Features: AclHuK8dmTwqV-NeZ_QMsE1rx8imD34_oP9qZYDps3SdUG2PbUePlfi0TK65AyA
Message-ID: <CAEjxPJ6Qs3BENwKDnNX5OAMQfecWsiU9v1LbqC2ZSDpQ+VD72Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: add Python binding for selinux_policy_open()
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 1:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Regenerate selinuxswig_python_exception.i so the SWIG-wrapped
> selinux_policy_open() raises OSError from errno on failure instead of
> returning -1, and add a policy_open(path, mode=3D"r") convenience helper
> to the %pythoncode block that calls selinux_policy_open(path, O_RDONLY|O_=
CLOEXEC)
> and returns an os.fdopen()'d file object. Python callers can then read po=
licy
> configuration files with the same fallback-root search that C users of
> selinux_policy_open()/selinux_policy_fopen() get:
>
>     with selinux.policy_open(selinux.selinux_translations_path()) as f:
>          ...
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
