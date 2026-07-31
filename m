Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1536F8E7
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529460; cv=pass; b=XrvDE3WWofZLJb8GYD9CpWhL4JQUZf20uxMw2ffotXfw3/bEfYU0hxVPPH/t12WGxRCL4rSL3AXWSbO9JMSEq5Z1gk0sncSAKGEhbJvi1W03U/hO68mFcFtV66/gLGCKm3a4916JgINZYLbwcTlLdj6VhrRSw8dCTMJS0nt/Xew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529460; c=relaxed/simple;
	bh=Rk7oo7lnkRtvOGIsTANDyDqMivFVxyPzc8I194ixEdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5is7ekNPIlHJRtRKGVETaBtXYvnEUpQftwv8/mErsSW1gF7yXXbZbqS4SEZ9NYTnp3IuXkE485JesqLIpwkZpjoCkFy1TE4AH8R4yFpUZSLIl86sqL2LAERswytmEPUYeXAwoIOtkdiZOV1sKekFB1xqSpFGf9CHO/khol7aas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bcmjXypw; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bcmjXypw"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1437017a91.0
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 13:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785529459; cv=none;
        d=google.com; s=arc-20260327;
        b=HR74pp0SVHCw1IqFDG/+loA6Mu01vwwuZvmPMHBerFw6bFwPdu34yCeZs6vgP+hXsr
         hllaXmGM356C55b5b3/0pyDMKIxkbu7hRWW/JwJvGvQ2SgYDAm9w0OF0md+0kZAM0djf
         obaGHoGOSR7QeGDwLKGjRXdTfZwR416C1sDA63oTlZsyHxNiplagFu3Vu6BaGgmYI8ZE
         TEMo563goDJSm6USP0QNdYYgaV/T/ojMe3ZyUuz/PpTusZisk2CQot4de+q+/amp+n+f
         G6MA9UxecnrLJADPHEiBmJuL1VwGPnukSFFp1+JlpOS+/9Hb7M7Ua1QnL8KvGBb8TkFT
         IxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rk7oo7lnkRtvOGIsTANDyDqMivFVxyPzc8I194ixEdo=;
        fh=T4kylB5r/IyxrWqIH0613CeG9t79gBa0MzSKyvHp5FY=;
        b=pDVnOQ+Q/TID3X7DaLik8Mq6ugTZi/Mh8MOiF61cjUdlt/hfS1NodMjG3gZvjH6GXY
         xCQIF06t7sFZAUBbDt2EROKomVH2bhGZLPZQNzXvfxczP4w/ocjmN9O2v+VJVQjVxFSa
         L+jdZS2otBmKJUFkpJev477HAG+T3RS+8v51fM3nqu/s3ONmr93AvjBTUGMHZSdEq92W
         XNwqTG82+M7cs2Ap0SyvLddgJSpcPFP+Tn9ZpYXFx7+bE9HUKrAL0vyua/R83L80EN+W
         a6bGz50X0a987oj2+ZZYMB2Vq/Fo579y3qBTJ9tDd9pv8/QvgSHoFXiiV8SQLess2CBG
         gaGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785529459; x=1786134259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rk7oo7lnkRtvOGIsTANDyDqMivFVxyPzc8I194ixEdo=;
        b=bcmjXypwzyHOE/x+M5GCdL+anwsAcYTJ1KUWko2Jf4ZRIuy0HHGn3X1uxM8+7n7FyU
         rlKUZSP8HC26gEXMdrwMPgbFHO22aGCv5NXsKt+ZIRGpGvSnf7UXMM1lwXiBcANJlAoh
         LU8hKTF6/s5lFum3U0n+csUmQKsO/5y40z/ixr5GKTUMLAoyj3v7herhmK1G5S7EL/2F
         CbHz9v3cj0bQKY40TRfjJ0zUbDtUm0bzvhGfn/tHGUU1zbEKE34eeQqAWUwNS9qVMLWv
         V6ysu58Bw6M4zZsQJCJUqSIX3dVMnpfbiT8SqKiUTFRBjAAKWerz1FrAvxLHqq4AFCwT
         0+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785529459; x=1786134259;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rk7oo7lnkRtvOGIsTANDyDqMivFVxyPzc8I194ixEdo=;
        b=p6HjpiStIT7PGnxovmDBHsBDqt6rd2ot/Lsi97AbaNx42sfA7PYX+YCbYblUi2HQXD
         BOXOi2DJPoa74Xm7Qc1B6dzhA1lP4AAK0T8IqKoDY5G8/pWmrTwW8zH0z/QdX+hrBenK
         5h5pCQPvwTedm19h6Tr67JKCWElnjFJehcx/bLfXzRis92vAMq2O6Aa6RBhr6tQx7w0/
         gzbq1ae5S0xTCTlqP4G/SBqOB+XsmtdmDhLFwctLcYea+iLcvjoYsjLdfKpe0R4/jhl1
         3rr5Zi8ErbZmBORKK1prZmUkJCRm5ZM0MHzMjCM/mV+PAwNOXVyiI4jqb/M+jH7IRBoK
         u76Q==
X-Forwarded-Encrypted: i=1; AHgh+RrKl1wlbPB+mj+k4+dv7CKRUV0wY97kayQ0v891YCGFGGDa5peq9/Cv0pO4wNIUbh4t+YqVvZM2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp1ak7dOHQP7DjJkNDrn/0h0tgwR77FjPBKiC6BU3nNpm0PbN3
	khrHIAC8oWG/qqAssAOcl/WgEzeLQizre6oJm5m/Gw8EaFI8KO6t48tc2jqsI6L7/kcbPLJy6Yi
	Ru/mcok7BB/C4V8Pd3Zhg6p7AE/HtK2kR90IdD8CgrSDRiKN1ew0=
X-Gm-Gg: AR+sD11bxAbu2cpyr7Ulfl/NBnaMcHFvieqP98ohCt1EILRZzIt0xCAR3StGx0Nv0vr
	YxUVo1lLlxtvlegHIJK2sv8L86RBYEMBC+Htrtm1bX2qAJbXsJyd6XgkGTszXdjauPcnfYxsx53
	E7D8JCS0HH5PW9eyyJDxjj4H0ThHl/HKBV8YBZJkUUj03DT6rFgsAeKdfBDxJlzrRft5FZ4U0dg
	ijNOTIx8jaX0ZrceHq5OPG9ErLuXRHdyPuynP+26ZJZ0DoQ433v6/vXITgD8A+H6VOor8NuOhgH
	gSxXvOFEhAoZLf2xNi5MT8OrCXvpkjReIu+0LihP+Mq0TRdI06TFJBw=
X-Received: by 2002:a17:90b:2248:b0:38e:8050:e63a with SMTP id
 98e67ed59e1d1-38fbc40941bmr912838a91.6.1785529458966; Fri, 31 Jul 2026
 13:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <20260725200958.4471-1-cel@kernel.org> <CAHC9VhSGn6UQ1__HtqjKWD1KgyMOhHYYKny5HnVuPAuvqZR9aw@mail.gmail.com>
 <CAHC9VhS6B1yW+8G9Biqit5CAmcg4CwCaWbq1B+Qpo2n6a=yqnw@mail.gmail.com>
 <8df686c5-f1cd-4298-97de-14c2c4638496@app.fastmail.com> <33ba1c27-27cf-4b83-9c69-1ec40023a5d2@app.fastmail.com>
In-Reply-To: <33ba1c27-27cf-4b83-9c69-1ec40023a5d2@app.fastmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 16:24:06 -0400
X-Gm-Features: AUfX_mwMO6Jjth8dKZRaqKSi6vQy__VpnKWqSL55ru0Ew4-Pu1uuDWVesrbZjVE
Message-ID: <CAHC9VhQh5D_Py4c0JCzRWrcHbE5QSnencD7-mzzaZNyZGGE_NA@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Achilles Gaikwad <achillesgaikwad@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 1:28=E2=80=AFPM Anna Schumaker <anna@kernel.org> wr=
ote:
>
> Looks like I did have it in a branch with other commits for testing, but =
I
> never pushed it out. I've moved it over to my public linux-next and will
> pass it along to Linus in the next few days.

Perfect, thanks Anna!

--=20
paul-moore.com
