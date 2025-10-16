Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A933451AA
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626974; cv=none; b=r53TA6XoR66Qz5ijeSF2G+1CJ5DPyrBGum1N7hdOJ+wFpWl+Ziv6BQ0IBWW+wkRyvqaJY/YekXQUNf7dRt7M8/qpHiMERg/PgGecotT8t/rL2HY276ev8d7yWXQtmXIvo3IFR5DzpDYTfV2wh4w41OxtyKDgNzNqx5mjlrxPjZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626974; c=relaxed/simple;
	bh=Xc7ykTilSR0QjIBYhCP6P27H5PcVxVD5VJ34rH6FIMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlTGeR8bQzH3MK9NH2fheaAMdEOSk1lU7cDUbQ3TTlWh+qNj/Z5INr8ATSIJaGxariORwQa86DAXDyRmWzmuCAL/xJpLChVZEdHymTS4AeEFpjZcQ1YZkgCRDR2yJS41vgXqvWHdZICrHsKxHNchUOZ+jy/FuaVmD7NxiGN53uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ACRbcwwE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ACRbcwwE"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f67ba775aso1274147b3a.3
        for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760626971; x=1761231771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhGFr30axY/WgwfaF9z+hifsh/Fg7t+15krQpfPhwhM=;
        b=ACRbcwwEh5LO0efNDEl/bVqv6cOhVzGNhURL4t8nQorjWplkS88lawTTtOC6L78VRb
         l4AeGBFkTK9Q33LJPiM86v8189HkCC9C23ii49EWOksa9e8E7uZyUHUQ0bvh99bSdM5V
         Euikwn9qDcW/LV2Z5ttaiYTwwGSgugtVhQ7orEeknIxj2VZA58a8biOcg2O5bSgV+uX/
         SZKwqJSpypMBU6/UmAZFN7gxRUDvb2Y9zBBDJqNUqQBrYIO8gEobXaDYGRJIPnTyW01+
         sUa6P1248O37DD4lj+hooP3ZYYoV9o5n8I2niuTcXwzQxFLRvBQ3IeGGDZ87eP+X9KH8
         bT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626971; x=1761231771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhGFr30axY/WgwfaF9z+hifsh/Fg7t+15krQpfPhwhM=;
        b=UacK+CoAcCOwSC6EjoAM0PBzVcvZV/NZrNfkTYxLEehC7z5JvkikN1pGpVyP+PGhz+
         egn6Qz4ik094FjT85fe1TEr/3RmTrA63mpkRI2mg1JV+uBdSOFHmX5uLol6bu55E27Js
         VwqQs4agKkYDiA0kBVQPRrmdcGTgkubcTkckuktClD0DLqGxP0rYf0dgcO8Yh7M0tkIc
         GstT/RGxBIv8OboWXRfS5Cd5x7ZpbtkzG8EbZtX3UdnmWi/fhfakKTwf5OvpfX3twU5r
         jDiFCdwP3wvcU5rzikW6nzdpVHep3A/2xjAfmj1L6UlaFUS6pgsZweFNIJjn6KlkwDgW
         ohzw==
X-Forwarded-Encrypted: i=1; AJvYcCWBCukpd3akd3vryvjsCzntKBXBkxYfplJ2LUFrc+frZJu8RxX5nnKqoJoJWeYmeTeJL7awXd4v@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTT+ldbm4oub2lUpPaZ2V6PB8p1Dl4KMaxjj0Vt9Db8PZQnbw
	Jq65eaCXxYOsgwnMOIIofX/9JFMb5VwyXAmv2jUgKO0jqMXlA8iDFQzj29evz5dzLpbwqr/EWsT
	ezFKhReDyCQHFzvMECTU4twUDMXL3ddTH1Hwy4Jxxd1YK8Ng8AzDigz2E
X-Gm-Gg: ASbGncsPHcykFdPJUvLEvUsMrhTGQZFTBpKgFURVsmNpl3bmHftDtkiHr3Of5SQJBkQ
	uKnk9U3wNoo4GSkzzuZhFm5i1cNw1ckQHaqZ9Wk3eH0XbPrBAonOR1gA7i2dVZiwTV3aKz+BGro
	wwS8jkcFowqBvWAx5hoWnMKixjnL0tlNSAuurvdPHIaj3FgDd1QRRRXtOzYEk3twroLM20p6W0x
	Cku1XyCSuyQpAp5bv2T+dbUckxGk29rFsDlUQA1Cstpl9O866BxXBwEae798IYN9kb+kkc=
X-Google-Smtp-Source: AGHT+IFqc5ie2mNylwJg5E3qdaOqEzTyuedsVS0GcuS2gogOS8n12mxffYYtv6c42j10+ZDO5sIDE2LEHDrW5c415YE=
X-Received: by 2002:a17:902:f647:b0:273:1516:3ed2 with SMTP id
 d9443c01a7336-290cb756abemr3256425ad.50.1760626969424; Thu, 16 Oct 2025
 08:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008234613.2150-1-ericsu@linux.microsoft.com>
 <9f91729c4030890ebd10a6faa1009589@paul-moore.com> <CAEjxPJ4SdB1xEM2zNwAW9hgdh7QqbCEOewjaR0t61QnKNKyw3Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4SdB1xEM2zNwAW9hgdh7QqbCEOewjaR0t61QnKNKyw3Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Oct 2025 11:02:37 -0400
X-Gm-Features: AS18NWA-wye4fUasrYO1mWoGwHClF59N49x5kX8uiLxt88MxSVcy1pKWWAPMh0U
Message-ID: <CAHC9VhSAiAbW_-f0BRGXPSDKMesPj=2-wyEbrtDouYpYrq7j2w@mail.gmail.com>
Subject: Re: [PATCH v5] SELinux: Add support for BPF token access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 10:05=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Oct 15, 2025 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Oct  8, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
> > >
> > > BPF token support was introduced to allow a privileged process to del=
egate
> > > limited BPF functionality=E2=80=94such as map creation and program lo=
ading=E2=80=94to
> > > an unprivileged process ...

...

> > > +static int selinux_bpf_token_capable(const struct bpf_token *token, =
int cap)
> > > +{
> > > +     u16 sclass;
> > > +     struct bpf_security_struct *bpfsec =3D token->security;
> > > +     u32 sid =3D bpfsec->sid;
> > > +     u32 av =3D CAP_TO_MASK(cap);
> > > +
> > > +     switch (CAP_TO_INDEX(cap)) {
> > > +     case 0:
> > > +             sclass =3D SECCLASS_CAP_USERNS;
> > > +             break;
> > > +     case 1:
> > > +             sclass =3D SECCLASS_CAP2_USERNS;
> > > +             break;
> >
> > This assumes that this call will always be made in a non-init userns,
> > I'd rather see us handle arbitrary user namespaces, see
> > bpf_token_capable() for hints.
>
> Is that possible? bpf_token_create() explicitly disallows creating a
> BPF token in the init_user_ns.

Yes, you are correct, bpf_token_create() blocks creating a token in
the init userns, but based on the return codes and comments in the
function I worry that this is simply because the BPF devs can't think
of a good reason to allow it at the moment, and not because it is
something that they want to intentionally block.  If we don't have
code to handle both the init and non-init cases we might miss a change
in bpf_token_create() that could cause us to use the wrong object
class in the future.

The change to support both types of user namespaces is relatively
small so I'd rather us include it now and have one less bug waiting
for us in the future.

> > For a normal capability permission check, it makes sense for the subjec=
t
> > and object to be the same as the process/subject isn't operating on
> > anything other than itself, it's simply attempting to assert a capabili=
ty
> > that it has been assigned.
> >
> > However, I don't believe it is quite as simple for the BPF token
> > capability check.  In this case the current process isn't asking if it
> > can assert a capability assigned to itself, it is asking if it can asse=
rt
> > a capability assigned to the token.  Due to this I'm wondering if we
> > should change the subject to the current task, leaving the object
> > as the token:
> >
> >   selinux_bpf_token_capable(...)
> >   {
> >     struct bpf_security_struct *bpfsec =3D token->security
> >     bool initns =3D (token->userns =3D=3D &init_user_ns);
> >     u32 av =3D CAP_TO_MASK(cap);
> >     u16 sclass;
> >
> >     switch (CAP_TO_INDEX(cap)) {
> >     case 0:
> >         sclass =3D initns ? SECCLASS_CAPABILITY : SECCCLASS_CAP_USERNS;
> >         break;
> >     ...
> >     }
> >
> >     return avc_has_perm(current_sid(), bpfsec->sid, sclass, av, NULL);
>
> My understanding, which could be wrong, is that this hook is called
> outside of process context (or at least outside of the context of
> either process involved - token creator or token user) since it can be
> called during any eBPF program and hence we can only use information
> from the token, not the current process, for our permission checks. We
> could perhaps pre-compute the capability access vectors at token
> creation time and cache them for later checking instead.

If you take a close look at bpf_token_capable() and you follow the
bpf_ns_capable() call down to ns_capable_common() you will see that it
calls into security_capable() with the current task's creds.  I
haven't chased all of the callers of bpf_token_capable(), but if there
is a case where bpf_token_capable() is being called outside of the
current task's process context we have a larger problem that needs to
be addressed.

Aside from the calling context, does the subj/obj change sound
reasonable?  While I think it makes sense, I like getting a sanity
check from others on things like this as the impact is significant.

--=20
paul-moore.com
