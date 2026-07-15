Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195F63C3C01
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148102; cv=pass; b=Swj61gsWuFhDtKku3aBw12ZyPirlCzJZQCB2PqJFOZvYEvDS8NW1PKSRBTOdNWsQ2JhCDlO9BDO2i4a6TkBdAx8xsI6JOxrV6DVV7SQ2FQVoWJbE8Zh0+nOT/KvkCTo5Cyf5Yaq+YJMBT9QTRvNuWxaXnzg4dGrzvxnV5s3A2rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148102; c=relaxed/simple;
	bh=WFUZsI+9mzM5h3Hu8cIqgWqx4bsjN+2caS2Ww8w777g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/v0+zl5Q83qPTRDhdjV8iuaxHj1Nx/3HBdpUWDH9pUnACxcrvKbOZlqqNdAGg3Y+U8mWx/sx2W/pXcoF8AL6GvFctHfpQXoYfe/Ak+6k2LVle9zJqGAxc66qWiHwNDeNqUk/QZSbysCyO2fbJnV/mj110Gyb7Pdz09BsMiA0P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fQL2VAxn; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fQL2VAxn"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-382ef647e20so5570550a91.1
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 13:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784148099; cv=none;
        d=google.com; s=arc-20260327;
        b=SOuF3mIM98IlIXC7ikwgn90kypQTeT4meNkq8To1Vwicx/1j2UWuV6QTZcNIuQVFPX
         sMtoCpQu6W6taAqD2XTYREw9pdf+0u1rr5544DM3Ki3rmIc3YoxqdwGpiAFPZ0TElKaJ
         3tkUiOouKX+WBBfUwhocl7imUFgrib9nYkHfWBoaBJVE0z5oK/9ztIbL+6V3QiI5/xtH
         f0grkuuDP9zAG4Ec+7GaWIz0mJDobCj7JmV6xZAjehN1X8eQQswyOqVxJZI8api5geAG
         sUjn6LHV4hghZVn+Nxeh1cEp7RTJ0Ts9vzdc4rwQTwk2nsIQ7YMSiTb0KR+0wRvdWjJr
         8d+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y4+6tUBvv9kkZdWXGDMO01Jh6FEAjGQaTiyDDZ/AJ9A=;
        fh=BLtD/dFicEbb+rLGmGM19giULO8tWC/SbojQE65ATGY=;
        b=NLVfSx/bMPNujfSNKq85+6o5SW9KRrjwXxDcjYzVkWCY4o+blo/N88IW65XxCZBeUh
         45oleUInmfD5BCqx+saTQwJmDsM9RF39dayl6S2TpXgM2YJs8fSfdZUvbzHksOw0Kt3B
         yqDVVqyG6r0jbr1e8s/0gNUt7GBc/ISAMQp+HeUc2wnH7ykkF9WnPVznLTjNkhpDiyPi
         C+wwndu2R9YXshEJ0LebnaW5AR7X83SD39XE0M/J2Cdta2XI+i4KlqXb+mYs7VG3Dovu
         5sgkQ1j5cAMob09FOatKWQeYWyVDKBnBgRsv2vGHZohJNVeuqmd64mFlThofR2yEMC4i
         YJSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784148099; x=1784752899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y4+6tUBvv9kkZdWXGDMO01Jh6FEAjGQaTiyDDZ/AJ9A=;
        b=fQL2VAxnymU623YvOy/fm+gzOXjRmvV+oJOQ0q5D/1I0oITkZ8+rA7YjnvgQ32R2Gl
         Uzyh7mdGOKFDRt6GLMCT5awLnQTHPZm84tF0ZEz7BBIXHpekePgePIMNp4OVmvmfCwoi
         WdhK3nie2/FdH1+gFnk18zWkPXqb+FVJEyo0umeDv7OKfHMEKDuCbIj9j1i6S6AJiNCq
         Vhbiliy6g/iu/VMAntEyh69tHYdPTSPcsEhSDNUAImr6ERExNXSIPBYu8TPTOhfInp2W
         XdsSB4V0ve+1GZ900/ZOMk07MuWQ8MUM30Koxn+8XdLq++ubDgs7USBktF9IXDikSqUb
         xMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784148099; x=1784752899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y4+6tUBvv9kkZdWXGDMO01Jh6FEAjGQaTiyDDZ/AJ9A=;
        b=DhwDNrzRwdmZLA8w0nHGgsplzFG+m9IqCA2fhWl/mFzdeB92whl9uv9os23PTdZQha
         WdIUWPa4PVCJZ0ymZ8cfp/itOvRNJqKnDe8TPAdvQ1KHs4SF1reXQszHPf2lh2pVx3Lv
         IIQ6mh/xL8pbCaqXjus7lFXWd9Tn4CVRkpwM3a/qvKebEvzlB9+jvQgvN41nsadirbc1
         RwR2Vx8YtVwm6wSh19Xqe8nuC2XZuJ8BIi4NHQjsq7EjgxgDPY3AsFs3vZmFh3hz83OF
         SdH3UqDm+TjugR18esQSRKHQ+QoINRbITY/A21CrqayR5kvvuOloD3Zzu+IvCb/Yt7vk
         c7Zw==
X-Forwarded-Encrypted: i=1; AHgh+RqQ3J5cCJ5ejy37pAEpG0df4JYp22SAlfOsoCl8hHEt5zrkyEUycceWS2nNHOVhzoAF7z5p+4d5@vger.kernel.org
X-Gm-Message-State: AOJu0YyG6SsmuBxBUYZvr4n0ENn8f8rY2tOOjtDAgZ38n9eCTh9iHOjp
	zkcK+dX3gBGPRgjKaxsKJncQYWCGBx5r3oockjWQ+DF4L9SNoKnoHlO9DFbZill/I89Ls38Dd62
	kW3akg07wlqvahNB/dnXuLM2xdW+UGZgeWF2dc+hL
X-Gm-Gg: AfdE7cmLfQJXzb0B4lU+j5MVsmc455cFxQnqLA88yuq2qZQ48Q763mjx8zfpOjk45+D
	wRDs0gJlgCoanzdi6F6RSENMVw1ksu8nheFBjUvUwMSOisc5YgZO2sQ8LVmyX9/EeK4vWI9IflW
	/c4RNp23Q2VQnfr88avFXh6sDSh6CT87WmskJTdOG5eb8sWgp4H58nCwZDNo31/XGk48y9rIJ2x
	N1j6ZjOVYgHV8S/vZdjrF0r8jKB1Wcz+H1T85fXXOf5IXOrEVg9plCmh7eHXaldxmbIG1eB
X-Received: by 2002:a17:90b:1646:b0:38d:c834:24cf with SMTP id
 98e67ed59e1d1-38e2a01d044mr3677818a91.23.1784148099381; Wed, 15 Jul 2026
 13:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com> <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
 <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
 <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
 <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com>
 <CAHC9VhSxpAx+G35fbcMjJ1PfqJxDZYpTEu=qpO+0PQe=nkX5-g@mail.gmail.com>
 <CAHC9VhRq+Vth-4D4OHFAY_6hXqmj=MgTc_2G=3Ehr6bAQzp26Q@mail.gmail.com>
 <CAHC9VhQy4LOgQg0mk+s5sjHOzMe1sxPUgJ2W7vRT8ms4znZp+Q@mail.gmail.com>
 <CAHC9VhR+pWFnt=1pBJTky78br7NsfVcZE=V4UkfkfTbMvBo+mQ@mail.gmail.com> <alaxhbWbFMZyC8VQ@smayhew-thinkpadp1gen4i.remote.csb>
In-Reply-To: <alaxhbWbFMZyC8VQ@smayhew-thinkpadp1gen4i.remote.csb>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Jul 2026 16:41:27 -0400
X-Gm-Features: AUfX_mzsfoszHbfyg2O-Br4gvumLi1bZDkqDuMmCQGdfP1UYUVx-vIZEGp6Qv2I
Message-ID: <CAHC9VhTAa7_tsWOuYELMnC+Zm2gW8PRT3sWvoN7Y=m5Q3UJBUQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>, jlayton@kernel.org, 
	chuck.lever@oracle.com, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Achilles Gaikwad <achillesgaikwad@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 6:00=E2=80=AFPM Scott Mayhew <smayhew@redhat.com> w=
rote:
> On Tue, 14 Jul 2026, Paul Moore wrote:
> > On Fri, Jul 10, 2026 at 6:20=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > ... and scratch that, the offending commit was that one.
> > >
> > >    commit 01c2305795a3b6b164df48e72b12022a68fd60c1
> > >    Author: Jeff Layton <jlayton@kernel.org>
> > >    Date:   Wed Mar 25 10:40:32 2026 -0400
> > >
> > >    nfsd: add netlink upcall for the nfsd.fh cache
> > >
> > >    Add netlink-based cache upcall support for the expkey (nfsd.fh) ca=
che,
> > >    following the same pattern as the existing svc_export netlink supp=
ort.
> > >
> > >    Add expkey to the cache-type enum, a new expkey attribute-set with
> > >    client, fsidtype, fsid, negative, expiry, and path fields, and the
> > >    expkey-get-reqs / expkey-set-reqs operations to the nfsd YAML spec
> > >    and generated headers.
> > >
> > >    Implement nfsd_nl_expkey_get_reqs_dumpit() which snapshots pending
> > >    expkey cache requests and sends each entry's seqno, client name,
> > >    fsidtype, and fsid over netlink.
> > >
> > >    Implement nfsd_nl_expkey_set_reqs_doit() which parses expkey cache
> > >    responses from userspace (client, fsidtype, fsid, expiry, and path
> > >    or negative flag) and updates the cache via svc_expkey_lookup() /
> > >    svc_expkey_update().
> > >
> > >    Wire up the expkey_notify() callback in svc_expkey_cache_template
> > >    so cache misses trigger NFSD_CMD_CACHE_NOTIFY multicast events wit=
h
> > >    NFSD_CACHE_TYPE_EXPKEY.
> > >
> > >    Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > >    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >
> > Playing around with it some this morning on a current Fedora Rawhide
> > system, I can reproduce the problem with a simple command line:
> >
> >  %  mount -t nfs localhost:/mnt/test /mnt/nfs_test
> >  mount.nfs: Connection refused for localhost:/mnt/test on /mnt/nfs_test
> >
> > ... adding an explicit "vers=3D{4,4.1,4.2}" has no effect; versions 2
> > and 3 are no supported on my kernel builds.  There is nothing obvious
> > in dmesg.  I've run with SELinux both in permissive mode and disabled
> > and encountered the same problem.  This doesn't appear to be related
> > to SELinux, it may simply be that we are the first ones to hit this.
> >
> > As there was some earlier discussion about this being a wonky
> > interaction with userspace, here are some of the relevant packages on
> > my system:
> >
> > nfs-common-utils-2.9.1-4.rc4.fc45.x86_64
> > nfs-client-utils-2.9.1-4.rc4.fc45.x86_64
> > nfsv4-client-utils-2.9.1-4.rc4.fc45.x86_64
> > nfs-utils-2.9.1-4.rc4.fc45.x86_64
> >
> > My next step is to try disabling portions of the NFS file handle cache
> > upcall to see if that is the issue, but it would be nice if the NFS
> > devs could take a look at this too.  I'm happy to test things out or
> > answer any questions about my test system.
>
> Pardon the dumb question, but are you positive your NFS server is
> running?

I'm slightly embarrassed to admit that your question wasn't as dumb as
one might have thought :)

While my bisection testing used the selinux-testsuite which ensures
the NFS server starts, when I tried to create a simple reproducer to
share with the non-SELinux crowd I neglected to verify that the NFS
server was running, the directory, was exported, etc.  My apologies
for the confusion.  However, the problem was real, even if my
reproducer and error message were junk.

> FWIW the netlink upcall requires CAP_NET_ADMIN, which is blocked by the
> current selinux-policy on rawhide (and I think it's a dontaudit rule)...

As a quick test I added a quick hack to my policy (allow rule below)
and everything appears to be working again.  Thanks for the pointer!

 allow nfsd_t nfsd_t:capability { net_admin };

--=20
paul-moore.com
