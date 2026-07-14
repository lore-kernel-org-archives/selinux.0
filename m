Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B13CEB8F
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053259; cv=pass; b=BjzVi0pDaLVaG9yv8frcF8WRFjSyuwna0hdozqYCKMTMqAsVKWRJ57BsysH92jU6rLy2l3xygHfNBH0wewZiYdWgU7wpR4/qAhUbittWeV6LJr2Qd8xT99FWnv128XEW+66+o2say0ofajaHTo5wRFLERyvHKdaldmAKZz8yDtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053259; c=relaxed/simple;
	bh=eyZy6tmw/y/uvyziqXobYIoPKaaMSPBA830VuHdiOAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP04CZvLekeIHyUWjoxF4efXPKcF5eg8bziw33+X35kfShHAM7eIXvHUml5tcLRLMlrXmZyQ02joTg5rDneDedOPW1VKDz4zaRXc7Jr1SuAbzaBF1Ix58+7YpJdJwSCSui4wkOJnZRo20eIEPJgpBGOo3njCaF2/ws0NE4rSXos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xxwjrwpw; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xxwjrwpw"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38deea72eebso2579589a91.1
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 11:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784053258; cv=none;
        d=google.com; s=arc-20260327;
        b=Xn0L2L6me/HSAxLyyGTS5d1HMGAiWONrcRaus3F68HGgPeDA4uRQUjxqKQIdfGH2DH
         RtUjCAVlmfWVolZ+VzuHPDP3jm+h2JGgEMhbVYfCmnSB8HiX/ZCz/kPhBxRij3crJDN5
         WXFt0OiBjJ/H+tbqpv4mF1dcGIsLfRz1lK/4BaEE4/egLKE/q5vMGCxBOsaudsum74w1
         +y6e77ELeHv6ZPtwOPYtaCjGhbtJmcRZOojQxRlzTZ6mWDWEFS9PLJmQNeWVI7jOqIic
         m7ICXkG/4EbYg0u31Ox7OQX2g4d63EMH/2KM74yfIYZIePHwg/YO4Hh8TPErmpUux9Bq
         LvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nmo5BFmH0BGw3SSnYVB0DqqeTBkMC36HDpza4IBAqYc=;
        fh=BMH9DHhpHWWXSuUzfDjM7KJvlYXo2dUvrjErgEzp96o=;
        b=X/RoficmuoBx82+Nv/21ckcwTClV8wQ3SLj1T1SFAvuyracDpU/A/4xbT0GivkNhzd
         hKsk9ITytL65Nx6RPkxFRvnGfINfen20pOTSDnt1eUydPZ9Ul0VHXrT0z5lpexUfgTg1
         rdycOCV+YU8l6ds5LhYkO6a5wMCI+qo30EWDABdeTK2ijw8vPJqfToQGnl444G/+1yrm
         jr60Ljmj0kA+ZogYTGiMymT0DDL2Tyyh/mmb2UVvrw7H2hJ9nfEHfvHM74IYEdr2aZSK
         8VaMHvPVIB9/WFrONuw4KMA/nFVkea9Jd9RS7XDd4P8C0hy0t1cBgRvLe8pkojcnjFHR
         VyvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784053258; x=1784658058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nmo5BFmH0BGw3SSnYVB0DqqeTBkMC36HDpza4IBAqYc=;
        b=XxwjrwpwddNtjMiY/N4jN7v7hIiCg8tSyykK1TBcJBDG9Vc6wL3WGkdGPcGmUm/EQN
         vRJgBXpkTbfLChABGIUf4vz1yD6Vb+sZccuEwzF+K8CRyzfmXdY7DcCsy6/kEbqGx60q
         ObkmpJCzyhMhzo5oB/sIL9o7hcDOkgUvS5SKqCQdWA2eZ1uF8UhrbmYrcErSlZhFXT29
         zl931IA7XeCFOzaGtRouf75Tu72PShr3ChV4JUxqYIlg+0kJ6pmpJpIGfyfWYP/SSUDs
         ixaAFzE/sXRVasF+dMD7rTbsKAkEPiSzNR1M+j3ogvKEgi3GIw/WCYzynDoKPFk4zhmH
         vLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053258; x=1784658058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nmo5BFmH0BGw3SSnYVB0DqqeTBkMC36HDpza4IBAqYc=;
        b=F107T3p20Nb7OZ0RF570vuAwhyCn5gxgpW56mCO701m5TjWiw6kVFnetEYO3UXjWjT
         0KQTJgeywuxuqg2iQiym0IZiAiubnRVnfuWRhqLzeGGSas7uq6j2Hz0bUB7K4ztilLmV
         IeR8jf4AcFP4ecAvnD/0VeeoVnIzVcnsBuAKM/qlmn8SZg9asYulg04iyH/g3t7qIYLx
         CBCqvnFt0ziCphLPycZKuhCnWMb4TEZP4WHoJ0aDNftqVPI1iWZZB8w8+dHWBoV0Y+LR
         P1XitKFbIHzTUkYsFNxwI3Gf+HyxHSjFh/dsZGZOGPtasgwoN72592WA0qg6IklNOOmp
         lKPA==
X-Forwarded-Encrypted: i=1; AHgh+RpCeJESzI3LxSEnV9cbQifFJMogS/7M2eUmYC5Qh742aXiQSKCUMbDYTwVLpEGyDm/qv9hlCR+v@vger.kernel.org
X-Gm-Message-State: AOJu0YxPV8p+P+EpwtaciKiRrDpj3wqhbTeomFwW77oqOdZcABWmpBEL
	mplmQoqv4wmfUNahsfD1VcO+UT9XBix2qrqPC1LviC6m0alFHmRodVnpeaRzMuATPqT2MDMhvec
	xQiHhHfSoeWVh+nR6exOa6ughcm6hCHLEMmPZSi1V
X-Gm-Gg: AfdE7cl275CN7Nmt86dV62tNZcIWxr5bwCLIygLZ325mCdmLz8NCbVKE4GzCKK7cRj2
	gQQ+lDDvWWLVvyQZn83iQK+zmJIAz8dA6W3vqY4FQDeqBP95P28IHImA37HZQTH+jTHFyDN6s0R
	r1RJWTuF+FBm0ZSJg4hI8bCIwnt+brlmvTyDXygs4nRs9s+o5ryxPGHD84+F+r8X4SVLfd1qO4I
	6Il2MjE9tpQAYyaBGk9YumbFTToC5f9X4pYxP5VLShnOCaFvTJXKG2aezt9D/sD9S2d3u5u
X-Received: by 2002:a17:90b:2f0f:b0:38d:f710:63f0 with SMTP id
 98e67ed59e1d1-38df7106443mr8092118a91.43.1784053257798; Tue, 14 Jul 2026
 11:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com> <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
 <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
 <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
 <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com>
 <CAHC9VhSxpAx+G35fbcMjJ1PfqJxDZYpTEu=qpO+0PQe=nkX5-g@mail.gmail.com>
 <CAHC9VhRq+Vth-4D4OHFAY_6hXqmj=MgTc_2G=3Ehr6bAQzp26Q@mail.gmail.com> <CAHC9VhQy4LOgQg0mk+s5sjHOzMe1sxPUgJ2W7vRT8ms4znZp+Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQy4LOgQg0mk+s5sjHOzMe1sxPUgJ2W7vRT8ms4znZp+Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Jul 2026 14:20:44 -0400
X-Gm-Features: AUfX_myy9lHcOpd_cDyjYmBWTe6s3i0pZ8Os5e9WcvXk9QQAvyVGAEYp6ElR_c8
Message-ID: <CAHC9VhR+pWFnt=1pBJTky78br7NsfVcZE=V4UkfkfTbMvBo+mQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>, jlayton@kernel.org, 
	chuck.lever@oracle.com
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Achilles Gaikwad <achillesgaikwad@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 6:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> ... and scratch that, the offending commit was that one.
>
>    commit 01c2305795a3b6b164df48e72b12022a68fd60c1
>    Author: Jeff Layton <jlayton@kernel.org>
>    Date:   Wed Mar 25 10:40:32 2026 -0400
>
>    nfsd: add netlink upcall for the nfsd.fh cache
>
>    Add netlink-based cache upcall support for the expkey (nfsd.fh) cache,
>    following the same pattern as the existing svc_export netlink support.
>
>    Add expkey to the cache-type enum, a new expkey attribute-set with
>    client, fsidtype, fsid, negative, expiry, and path fields, and the
>    expkey-get-reqs / expkey-set-reqs operations to the nfsd YAML spec
>    and generated headers.
>
>    Implement nfsd_nl_expkey_get_reqs_dumpit() which snapshots pending
>    expkey cache requests and sends each entry's seqno, client name,
>    fsidtype, and fsid over netlink.
>
>    Implement nfsd_nl_expkey_set_reqs_doit() which parses expkey cache
>    responses from userspace (client, fsidtype, fsid, expiry, and path
>    or negative flag) and updates the cache via svc_expkey_lookup() /
>    svc_expkey_update().
>
>    Wire up the expkey_notify() callback in svc_expkey_cache_template
>    so cache misses trigger NFSD_CMD_CACHE_NOTIFY multicast events with
>    NFSD_CACHE_TYPE_EXPKEY.
>
>    Signed-off-by: Jeff Layton <jlayton@kernel.org>
>    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Playing around with it some this morning on a current Fedora Rawhide
system, I can reproduce the problem with a simple command line:

 %  mount -t nfs localhost:/mnt/test /mnt/nfs_test
 mount.nfs: Connection refused for localhost:/mnt/test on /mnt/nfs_test

... adding an explicit "vers=3D{4,4.1,4.2}" has no effect; versions 2
and 3 are no supported on my kernel builds.  There is nothing obvious
in dmesg.  I've run with SELinux both in permissive mode and disabled
and encountered the same problem.  This doesn't appear to be related
to SELinux, it may simply be that we are the first ones to hit this.

As there was some earlier discussion about this being a wonky
interaction with userspace, here are some of the relevant packages on
my system:

nfs-common-utils-2.9.1-4.rc4.fc45.x86_64
nfs-client-utils-2.9.1-4.rc4.fc45.x86_64
nfsv4-client-utils-2.9.1-4.rc4.fc45.x86_64
nfs-utils-2.9.1-4.rc4.fc45.x86_64

My next step is to try disabling portions of the NFS file handle cache
upcall to see if that is the issue, but it would be nice if the NFS
devs could take a look at this too.  I'm happy to test things out or
answer any questions about my test system.

--=20
paul-moore.com
