Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21A4E66AB
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450495; cv=pass; b=dgVirjccLrcVnT5vw/Pb7niYbhaHYtaYBtz3/0DARmSLC5j4WdauTiap2Z87AOmnA75tfhzjEgS6V0o4suTHSii3/OSl1NYXfRILtGfcBR1BhQQiOMtEIaKE4E7nDz0HnLXV0gvKO2apXmxFc0DBiEtjVLpSrHUR48LhRLXZ9Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450495; c=relaxed/simple;
	bh=ysGWC46TVAgt8Kh/5/8QIzyhKkK3xHCTvCSqjeflq74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBVJuYqYXDhMtkbrDLEGoB5cuSTrednBHta6a0dBXZZn3CbLXe/UIiIoDsi7boJ2pOoKqn/eM9NOS/cTYk5VZ17pIcEytalTGH7UFBBJ6MnJ2Mr9wFQwFZLw1MyGJgaKW5joufleZAMZUkW+SLdKmlKk1EbLvCPGVpaM+V6j7FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MTfOo6nK; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MTfOo6nK"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbee846deecso86435a12.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 08:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788450493; cv=none;
        d=google.com; s=arc-20260327;
        b=magYMMqCPMPTmckJMh4FROz+j2D1cmPCi1fuxDvafiJiCkRY7NrPUJ0ySbhmI9KwBD
         bnalh+1RyO1u7xd4vP/l6fKqYAzFn7xUVhtZcKe3tWZVyM2QD8JwA/1SDFLkU+nAJrC4
         1gPgn+RcXlMi0bkMyZh62szHjlEy6qT7n9GzqFxZQDvv3hM6UnDPvIE0YUxWHvvoEDjG
         QIuX4LHRbkGsApROF33NbYqz4PosbfoIWpvrkRRT+23e85RRNlf+TQjaY+YeaG3SFOJr
         2rFclMmUCCutxNxK9EtL4J7KZkEUjgPDnXCegeeChnMEgXiiQVJSKWfzRRC5LOh3z2F5
         YXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zfz+px8BqAfZBHsH8Cz0nrkeyup7coS8NIva+kDPyM4=;
        fh=fOYo6BgII72qJH3IG2TvTPho7MUmjvsMA74jWL2EpTs=;
        b=osjxHQPhGr4mmKcMggCG8uN5O7InWdo3lF3HFfekCPVG78bL40DNpv8IEOq/op4LRQ
         HQqsFhu0PIlTr2Fp+VZWFJv3G2yHt9msS7qHX8UvuorOjiQdyXCTFPmoBKgs+4EcRHUU
         4uARqv31FPjzJkoiQo0vfTvq6j329aRRrj4dUJWEJWIWg5WPZRkEbCXWrn7RfETcqwCw
         4YvFE3IL/cyRzKd3ffVeXkZwV8IG7sHIhu2kIqk8V9VaExe+5u99a76DY4Bm9VBTWho1
         M7hzCgrtYW2LNIZxywCl4mHyScFfdcKVD3glg8bCmbBXS+4S6LZukUpK3xO+3ZPAlKpP
         7N/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788450493; x=1789055293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zfz+px8BqAfZBHsH8Cz0nrkeyup7coS8NIva+kDPyM4=;
        b=MTfOo6nKPb7BfRabUf+KPJxm7CttX/6ZodV+LEtUZ6EcdM1msMddYfILWeUlVUI2xA
         HTyYVlMvF/oh8MT3G8u/yHXatQA+quWaZBJFAcA+Ni5kFPc6ycRcu9TLHAr1yK+8BJuf
         Q8KlLNlLcJNBEOuEKC9zEsg9EhBWAu9+5Fn6lL+5XEjAcDFVj77XFncslhZw7pmt08cL
         kiCdV3MD0rsSfIrH7C7XcRL1mOb61SYkX5GHvGqEXkLfWOBfkoI2eUj5LKhD+Xc4bBje
         dalVYw0QyosuRHi700gizrkoUfIQkNJntiN/VqFdnO93x/13/NlrtX+E7gb4q0JzvD6l
         pnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450493; x=1789055293;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zfz+px8BqAfZBHsH8Cz0nrkeyup7coS8NIva+kDPyM4=;
        b=a9GCr32VcnvIMD+q3mOC7uBo8Jmd5GN4ki7ODCWoqsh7xlY55AGdHVLWdnfg59E+e5
         eHHIc26XPXmWTurAPFsuDDQQgQsJbYM/pgDST2PQXJi80IK1PAAOCRw7yTICri/ActhZ
         enTFPfv5/P42PsBL8LOJVQa55IZxxeoAdqZr+5Q+FxXzgmeFNS0xssN9G7yN8QBwMHam
         1HP7fZ/OigOQuhUCgBBQHSdy8LhrdOTGSiEUhy6sQGyoB0fbJium+GMkefDgKDuwpj9Z
         lNFznXJz+NU6MNjCA6eSNM/XfknEbu3aWORQUUD0X/eJ5LuJyB+ZfzmQwM9Mne2cv0t1
         q2fg==
X-Forwarded-Encrypted: i=1; AKwUvBw5hqUyoZQHfhI4unU5RQ825nNNunzqoBGFr7x8+0/CbmVhZA7WPqXG+BegOLZTmDVajOiPHTt3@vger.kernel.org
X-Gm-Message-State: AFuF++niRV5GqxahkfAq/UNPkWBLBsw4o8J6A8EHeoIG35zT5/qqJnUQ
	bfjfNlSHsnyNwugUgq+42ZiCSas/7lM2xDH5+XBLG9KertWhAyDuvStDO+3nsql4JR3Nue5RwR2
	ieXJUukhXCR4P6jVyW7LExFq4VR4J4aD6ok5YLYUU
X-Gm-Gg: AYBFou0cMF49aK2jgWWs8ZCVnrpVcInjPnDoF1t9FpgV8OW47fMrimRJU4HFmh3F3u2
	s0pBlQJBTUGIvnDpXFEweX5TKyxh0A7YWsi6Fb7zl/zCEpcZq+ixyrDWXRl6HTGZrgxKb8ce7rs
	Nhlc0CDKxUO1mKrbTYxRmxuJA8OLZa9f6pDal0BBGQns1WHahw7sfl7XMQGQ9G5BixZGmQZHTRu
	U4MV17GE8hDYy84GlnC4kDfhTl+HMZta/Agmw++ZyrK5M8WwLAwigjEaZv/ym+nb0zeA8LL8rGH
	TqkIPj4gdCMZD6nPv1RdTiUYspWMGIoNSpQWmg9txyAC
X-Received: by 2002:a05:6a20:938e:b0:3d3:ae50:97cd with SMTP id
 adf61e73a8af0-3da35fcdbe3mr1075867637.26.1788450493217; Thu, 03 Sep 2026
 08:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830201157.2084730-1-tristmd@gmail.com> <5be8f666e660371dbc964c2348422a25@paul-moore.com>
 <CAEjxPJ7b4nd7ak7HJ+AdZKyuE-kwfV_hpyx0r8Umz7ECAYVVEQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7b4nd7ak7HJ+AdZKyuE-kwfV_hpyx0r8Umz7ECAYVVEQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 3 Sep 2026 11:47:59 -0400
X-Gm-Features: AcwNN1WRh6bIzS_5E7FQAMT0lE88uQHSPbMJnb8bd6pclmcyXC-IOtQe9nhwqy4
Message-ID: <CAHC9VhTiBGMJWQ7JSn1yP97XcQQUvwjZG1LKAHjQRiQ+AG792Q@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Tristan Madani <tristmd@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:32=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Sep 2, 2026 at 10:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Aug 30, 2026 Tristan Madani <tristmd@gmail.com> wrote:
> > >
> > > __selinux_socket_bind() and selinux_socket_connect_helper() call
> > > sock_has_perm() which uses current_sid() as the AVC subject.  When
> > > selinux_sctp_bind_connect() is invoked from the ASCONF processing
> > > path (sctp_process_asconf), current refers to whichever task was
> > > interrupted, so the permission check evaluates an unrelated subject.
> > >
> > > Fix by extracting the sock_has_perm() call out of
> > > __selinux_socket_bind() and selinux_socket_connect_helper() into
> > > their callers.  The process-context wrappers (selinux_socket_bind,
> > > selinux_socket_connect) call sock_has_perm() directly.
> > >
> > > For selinux_sctp_bind_connect(), determine the caller SID based on
> > > the optname: SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF
> > > chunk parameter types only passed from the softirq processing path,
> > > so use the socket own SID (sksec->sid), consistent with other
> > > softirq-context hooks such as selinux_socket_sock_rcv_skb() and
> > > selinux_sctp_assoc_request().  All other optnames originate from
> > > process-context syscalls and use current_sid().
> > >
> > > Factor out __sock_has_perm() with an explicit subject SID parameter
> > > so that sock_has_perm() remains unchanged for all other callers.
> > >
> > > Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Paul Moore <paul@paul-moore.com>
> > > Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> > > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > > Changes in v2:
> > >   - Do not use sksec->sid unconditionally; determine the caller SID
> > >     based on the optname so that process-context callers (bind, conne=
ct,
> > >     connectx, sendmsg) still use current_sid()  [Paul Moore, Sashiko]
> > >   - Factor out __sock_has_perm() with an explicit SID parameter and k=
eep
> > >     sock_has_perm() as a thin wrapper for all other callers
> > >   - Move the sock_has_perm() call out of __selinux_socket_bind() and
> > >     selinux_socket_connect_helper() into their respective callers
> > >     (selinux_socket_bind, selinux_socket_connect, selinux_sctp_bind_c=
onnect)
> > >  security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++--------=
--
> > >  1 file changed, 35 insertions(+), 12 deletions(-)
> >
> > Hi Tristan, this looks much better thank you for putting together this
> > revised patch.  Unfortunately, while looking at it I did notice one thi=
ng
> > (below) which I think we need to change ...
> >
> > > @@ -5731,13 +5737,25 @@ static int selinux_sctp_bind_connect(struct s=
ock *sk, int optname,
> > >                                    struct sockaddr *address,
> > >                                    int addrlen)
> > >  {
> > > +     struct sk_security_struct *sksec =3D selinux_sock(sk);
> > >       int len, err =3D 0, walk_size =3D 0;
> > >       void *addr_buf;
> > >       struct sockaddr *addr;
> > > +     u32 caller_sid;
> > >
> > >       if (!selinux_policycap_extsockclass())
> > >               return 0;
> > >
> > > +     /* SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF chun=
k
> > > +      * parameter types passed from sctp_process_asconf() in softirq
> > > +      * context where current is not meaningful. Use the socket own
> > > +      * SID for permission checks in that case; all other optnames
> > > +      * originate from process-context syscalls.
> > > +      */
> > > +     caller_sid =3D (optname =3D=3D SCTP_PARAM_SET_PRIMARY ||
> > > +                   optname =3D=3D SCTP_PARAM_ADD_IP) ?
> > > +                  sksec->sid : current_sid();
> >
> > This should have caught my eye in the previous iteration, I'm sorry abo=
ut
> > that, but now that I'm looking at this it occurs to me that the sock's
> > label isn't the subject in the ASCONF case, it's the label of the remot=
e
> > node (sksec->peer_sid).  After all, the ASCONF operation doesn't origin=
ate
> > with the local socket, as would be implied by sksec->sid, it comes from=
 the
> > remote endpoint which is represented by sksec->peer_sid.
>
> Are you sure that's the behavior you want?

Think about how the socket/connect check works for local operations:
the task requesting the socket/connect operation is the subject and
the socket is the object.  In the currently proposed patch, when an
ASCONF socket/connect operation is requested, the subject is treated
completely differently as the socket is used to represent both the
subject and object.  Even if we consider the socket's label a proxy
for the creating task, using the socket's label as the subject of an
ASCONF permission check makes little sense as it is the remote
endpoint that triggers the ASCONF operation, not a local entity.

> I don't think there is
> precedent for performing the socket layer checks with the peer SID as
> the subject rather than the local socket SID ...

I think that is because all (?) of the other socket layer checks are
initiated by the local system.  The ASCONF operations are unique
because a remote node initiates them, which is why the network peer
label is used as the subject as that best represents the remote
endpoint.

Please feel free to put forth your own reasoning on this, a discussion
would be good, but I think we do need to recognize that ASCONF
operations are different from local socket operations.

> ... and if using NetLabel,
> that peer SID will be limited to the peer's MLS label and whatever
> type was assigned via netlabelctl.

Limitations in the peer label don't change that it is the remote note
triggering the operation and not a local task.

--=20
paul-moore.com
