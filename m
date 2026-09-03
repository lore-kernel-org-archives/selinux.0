Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC604A484B
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438748; cv=pass; b=G6RPl6Tshnolx4OFQjJECMQNjSVDZqF6Q78nhtf4Lq5xu83Cofe/zXqRQ/LNnnvX4HhRlJlJi1O6OEyNAMm2I6xur5iNK/FFmQsvd1J9m/mElz7odbcHCGZVcj9DWcS4iLxpYOyfNYhRbGMjmDGDcUN3JIscive2jipi+3xIY10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438748; c=relaxed/simple;
	bh=K5kiV1pGpE/oIFL9kGCW0HX9tRAcBztC6D1QkspHn8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OB26oCvGv+XfXfG28v3uE2O+t6wbbDhurE5htQLD/7OMkEcvxLAHTUqrCwwQ4/Mpgn7LnLWuNSdDRAz0/17TKHK3IYGlsQ3ABxr04sPLiZ1Nr2HvZ9TWKXXOD3ZNUDSetDOXWdiL3LjwRAQwOpj+Spo34WbJZq2Q4KJwOV6lz6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5JROE2p; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5JROE2p"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4650773fa99so1046402fac.2
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 05:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788438746; cv=none;
        d=google.com; s=arc-20260327;
        b=DaGEDR9HLOMFF6Cb7WqEDpGHKgunhoWKSwzDwk1w1dvLPg6aOimqr2K/IEo539Hx0f
         CpM1XNKJCHcw3HPY6MYgVpDr/CUmHswfAsGPUmyhSksf6bbEMnQ19BKq0FQQqgBIqUJT
         xvuaeZg48K1fROIx2wJTnk1w0gdtqWECsLdr7E9CcHQOgIXeS1IMudRvwxkTtbdZ+B1O
         7mfCtfURTGuYdBevBrNnjKW2w1K14FwfCYO21TP7PJspjtvFIHWN1ceIjOb5CJHRJFqq
         JzKPdxhHJi7URqTQXW0aese7GIwA350hZsfp8mlkGW97EzX8Hh3XG1tghCnslhkgnAdK
         u2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XokyMpC2uz3u3fmnMRd3git/TgidI+/M4SWX22okfiM=;
        fh=GFKFKlx6i1p3pkQyCFPTic0fvNb+4AvtzlWd+ja3fAA=;
        b=KPewPH8mKkAKmpdPQzisnqknte8rpFth3VckWGSsszUAilF8rxAVQ5jlxN/vUvYlO+
         DGZFb9e81V5dOt2nJ2IXQdOq2uGR+LD08qFe3eEThxbX2fyq+gr7+bi+oJv40amc3c09
         fGgTsu8anmafmSPHVdHVtCCUboouJXQlia0i98JjthGGslTkftIp31ZRfuOLFtfnN4II
         MqZoZ2t6pyhHQ4Jj67YD/c94ZVgkWG95wDumaUKaQmubvsmNYF3eDf9uYBA8/617JCqp
         X07asGtpxTvSgkfMqa6RN9y+vHGi8iyoH7Uj3yfS/FQfrghLl1lMy7zgL5xDFERIz/on
         zk9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788438746; x=1789043546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XokyMpC2uz3u3fmnMRd3git/TgidI+/M4SWX22okfiM=;
        b=Y5JROE2p5yD4TVVLjTQ8evVV/NC9mmCpODVkSDWtkr152laUtc4Gk3uWGqBngOmC9U
         /rrLPOAgHfaw8HbV3tH+d6DPEshI/3HUScCKSyHpsReEc11eFuEY2NTHN09OuosoLnu3
         cop2nuTtlpNZPVUnyO84r1pRvedAJ0lPfxvqlczcsym+Q8s5ZK3szk7tKUfjjQ9vNWe9
         /QhKnRkDhyKYnrJI4vq1gIvRtpqPKZwCnqSy1bQSRX0XJpWg/PAmf+y+O29t0gz20zdT
         9GPgQdcT/GS/ti/LKkGpALCnBtWcOZmsPxn6HKHcPEztToj8tSvy6V5miLCwQoguyah6
         ExOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788438746; x=1789043546;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XokyMpC2uz3u3fmnMRd3git/TgidI+/M4SWX22okfiM=;
        b=RFZ215/QKn18fzScJvtImRqHF1Uugc8/DClrBA/kBBSslnM5Z0CdFt86+IF7ylBuzC
         gkUet28Z7wmiyoeLRmvZYxzdSL3T9x9tuOjUO0YUBGuExqbcS1wenzRRGkPlLyvPGrMt
         pTPLeE7wQ3JAqH+kiLglavBD8BzmQQ054tDt7yrR91YV5bLjTaiPZa627yGSBcVwKh7g
         XG2id2lXIUPkl+eg1AQNKDb1plQK4DKjri48w89yhNXqwHiFT0R8+NrDK8uWHynBUS9x
         S+qvNdMT7FxzMrDeYhrIvSiuIeaga+JJJPNMxLqLk+0PV/r4jtYKiEL6LZADHz54dOaK
         twzQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+uIMas2GNL24SzmmEAy2LigCVcY2M9KSaEz+BuPUfsqOpb/IHajoKDVimria51ToO8H6xvyN5@vger.kernel.org
X-Gm-Message-State: AFuF++nPn/HJ1bN1neQEpI96WFDBenzDZchzl/MZ94sE7iXcdHuefCeo
	vaGPsdVLPu0Ap9RBHPJPVTD3cyJnBSF7LfclbjcfZqXTiVgkaDQGNAYYnEFMxqtv0g3lbgfTBsM
	DhXDHzgRc0w9rdChmqLFHcNZA6QoNPSs=
X-Gm-Gg: AYBFou2b3oo1MEKtgHWWaYrDYXzk3kNyr1DXzKYdmtKrYn5E8hAQ8rEL2Qt1IRFVM0b
	7cJPI/Qmrkl5TbMVqXl2TIwgwrw4x5FeLiJ5g17/8bqxv6kl99CNamsGD0/3195Y7oDrQJG3kLb
	nnQhMT3lwXJFFPUaZwJ7tVWQRjx70ssUiUIW8nTCigwJZ9W0tJSOXFRUoUZoVQgzmSpVGgFJKH4
	Stro9ooUZ1LZ7I/mn52bl64flkqb+HZO06P2PD7ysZjNZASTFotyLZYcUeKgm8SnVP4yMJ64J91
	QALfv7UHc4tGmyfZ3HAmhjNYeh0NWVcvxYhL2l39WSIF
X-Received: by 2002:a05:6870:46aa:b0:451:b3ae:e444 with SMTP id
 586e51a60fabf-46f858a7dc3mr10636349fac.1.1788438743135; Thu, 03 Sep 2026
 05:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830201157.2084730-1-tristmd@gmail.com> <5be8f666e660371dbc964c2348422a25@paul-moore.com>
In-Reply-To: <5be8f666e660371dbc964c2348422a25@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 3 Sep 2026 08:32:11 -0400
X-Gm-Features: AcwNN1V5N92UiGFZ-i9pCIWxt79RhFNzFeD5m_A-JclL3TKEK35sC70WcAPuReg
Message-ID: <CAEjxPJ7b4nd7ak7HJ+AdZKyuE-kwfV_hpyx0r8Umz7ECAYVVEQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission checks
To: Paul Moore <paul@paul-moore.com>
Cc: Tristan Madani <tristmd@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 10:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Aug 30, 2026 Tristan Madani <tristmd@gmail.com> wrote:
> >
> > __selinux_socket_bind() and selinux_socket_connect_helper() call
> > sock_has_perm() which uses current_sid() as the AVC subject.  When
> > selinux_sctp_bind_connect() is invoked from the ASCONF processing
> > path (sctp_process_asconf), current refers to whichever task was
> > interrupted, so the permission check evaluates an unrelated subject.
> >
> > Fix by extracting the sock_has_perm() call out of
> > __selinux_socket_bind() and selinux_socket_connect_helper() into
> > their callers.  The process-context wrappers (selinux_socket_bind,
> > selinux_socket_connect) call sock_has_perm() directly.
> >
> > For selinux_sctp_bind_connect(), determine the caller SID based on
> > the optname: SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF
> > chunk parameter types only passed from the softirq processing path,
> > so use the socket own SID (sksec->sid), consistent with other
> > softirq-context hooks such as selinux_socket_sock_rcv_skb() and
> > selinux_sctp_assoc_request().  All other optnames originate from
> > process-context syscalls and use current_sid().
> >
> > Factor out __sock_has_perm() with an explicit subject SID parameter
> > so that sock_has_perm() remains unchanged for all other callers.
> >
> > Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > Changes in v2:
> >   - Do not use sksec->sid unconditionally; determine the caller SID
> >     based on the optname so that process-context callers (bind, connect=
,
> >     connectx, sendmsg) still use current_sid()  [Paul Moore, Sashiko]
> >   - Factor out __sock_has_perm() with an explicit SID parameter and kee=
p
> >     sock_has_perm() as a thin wrapper for all other callers
> >   - Move the sock_has_perm() call out of __selinux_socket_bind() and
> >     selinux_socket_connect_helper() into their respective callers
> >     (selinux_socket_bind, selinux_socket_connect, selinux_sctp_bind_con=
nect)
> >  security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++----------
> >  1 file changed, 35 insertions(+), 12 deletions(-)
>
> Hi Tristan, this looks much better thank you for putting together this
> revised patch.  Unfortunately, while looking at it I did notice one thing
> (below) which I think we need to change ...
>
> > @@ -5731,13 +5737,25 @@ static int selinux_sctp_bind_connect(struct soc=
k *sk, int optname,
> >                                    struct sockaddr *address,
> >                                    int addrlen)
> >  {
> > +     struct sk_security_struct *sksec =3D selinux_sock(sk);
> >       int len, err =3D 0, walk_size =3D 0;
> >       void *addr_buf;
> >       struct sockaddr *addr;
> > +     u32 caller_sid;
> >
> >       if (!selinux_policycap_extsockclass())
> >               return 0;
> >
> > +     /* SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF chunk
> > +      * parameter types passed from sctp_process_asconf() in softirq
> > +      * context where current is not meaningful. Use the socket own
> > +      * SID for permission checks in that case; all other optnames
> > +      * originate from process-context syscalls.
> > +      */
> > +     caller_sid =3D (optname =3D=3D SCTP_PARAM_SET_PRIMARY ||
> > +                   optname =3D=3D SCTP_PARAM_ADD_IP) ?
> > +                  sksec->sid : current_sid();
>
> This should have caught my eye in the previous iteration, I'm sorry about
> that, but now that I'm looking at this it occurs to me that the sock's
> label isn't the subject in the ASCONF case, it's the label of the remote
> node (sksec->peer_sid).  After all, the ASCONF operation doesn't originat=
e
> with the local socket, as would be implied by sksec->sid, it comes from t=
he
> remote endpoint which is represented by sksec->peer_sid.

Are you sure that's the behavior you want? I don't think there is
precedent for performing the socket layer checks with the peer SID as
the subject rather than the local socket SID, and if using NetLabel,
that peer SID will be limited to the peer's MLS label and whatever
type was assigned via netlabelctl.
