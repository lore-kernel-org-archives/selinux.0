Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD393B42DE
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676940; cv=pass; b=GKYj38ySEz9dHwJnxYFfUPqgYWxBqwUBYxPtDePjmpxrKmCj00pgBVBpbk19h7yu1iWiPMNgc/IP5o66x9OyM4PR0vyJSWqKFsPjoCnMz464u8UC9RLWE1mfVPLb4VEE3+SRhf/TP4P+5P0RvTkGfa5IbNjsxGRzZL78pN8qxys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676940; c=relaxed/simple;
	bh=/M61cHWwXa8M3lscE9iJQ75Xml/upBI3S27pqg8KKVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SscuvqqL47ioPPy/2MToy+SIXhdPQ3YhSaSJPZGxFizhnTVT9Pueilp58h8DJFu5AVrxELC6B5Qvh5Bj4tVHj6j/LQ+iyYRLgywgyK6Wnk7fGtkzvtIOzHQef7MB4czLRX+rXgVZwkTd/VAUN26HMMNLu0mV1bxislyGhnddFUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stOMfnLk; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stOMfnLk"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8422f395a4aso1346374b3a.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676933; cv=none;
        d=google.com; s=arc-20240605;
        b=Iv9OrlvkrmjCYVpQemLy5CXZDHffw4vKdTO0X8WLa736sWXCLBzKBsFnPnmjOy5Jd4
         WiY/yBe6CU3HAYFHy/gqMxdur34ll5X3Ul8ibySaoGAcHlrQeJEbVIGlcZYz3hR7MLR2
         66E1jvSXnvqfEs6eTBRfh8oyUHMeCMDP4HtyoRx/3pdGlak22wK6sN/aUUu2EeArIfd4
         yLS4CtBclSVPkm5T1F7IUWsAEO3pENi1vBswgSYgJthJNuCHYuRNs/+TrmKmFc03R68v
         wYhr5yZ5naWq2FT80v1xT9Y1ogtIp1qo7DRfaOroir+bKrcM5vqp8ApAEvb4MvST+NQ2
         ksWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w/HdszZ+6+XT89Cy6hpIeXH+we7eQ9vi52iLwiHk3Ws=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=XiI35AgfmJIHdO9WX+FZj/5+gucOe4lh0wE5JSgIvzonRcnpeTq8W4IRTa+F3n71R0
         +Jt0kpQ0aYmf1wcUwYseQMgXdcXjzLE3ifJ4xRvkk+HXV7bZcsBAdvwcuqtK941ZpBbZ
         EFv+q+BF5+K0XRO3HIknrjkjVOdLZfKmVa4kfBABNMAD6JnMXdazpQgHukMxjytWrWcI
         oCv3j0utIuMfi50Ddhu0XGPMMPKZhChJ192yluGj205biVFlNLk3ohvFqWxc5XbOB1Pr
         C6fyGoBAkXDhax/q3v5xFQy3TFHfkepJVnJowAcgTj3gEUMFgvoiDdIsym8QJ+XQazPX
         GE4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676933; x=1781281733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/HdszZ+6+XT89Cy6hpIeXH+we7eQ9vi52iLwiHk3Ws=;
        b=stOMfnLkMegohyrPKeEo7D+wHXcKqnwGcX9OEeJAOreeqMCb4lQFeOsZrMYP8YXgfr
         YXNFi1Hitw/AdbKpzSXBu1nInFwz029kJpUDtxIlfR/IF/8MgGhcXFrdGSTq59t5HLCl
         RZGuPY+TU055d5rN+t3RvVvOsWaso3uOn6gS/Wx7g2AEF3nVbndUvjSKqZ+pnljNEkud
         dNgHMJHhn+/SZMaZ2sqz9hi/3neNP+xs1xb4HUu02L18tl7k3IY84G0KtnFwGrvDNJE0
         ZlIC5wqUDgVQ2crYAyFBLQiLd799jWTXzKu6Ml/mIJVd06yIhyFHPijIgG4Ouc5oj0LZ
         gA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676933; x=1781281733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w/HdszZ+6+XT89Cy6hpIeXH+we7eQ9vi52iLwiHk3Ws=;
        b=oP+59D6AVWjJlO2hZiDoHGJFi4iPLTm+N17kbPqOMxSgIbdpFXv0EFvrzLT8JGPByR
         GFFn1uMInoZoTHztecnd+w0ia7I7GICADP6LI3O+OLrDDHGTDRhe/dy/GTCm0ZC1sbvp
         9mVcyZhTyxtfSZf4oanYo5/6A3iy/KsLc1N7hdO5t5tr3fqSM/ZicguTO7Sagkaq1EAb
         dOOrf2C6ZR9FDRtQF9s8DihsXq5OHHfN/5JGry1jn839WKeSfZc2jAvsR5vrkSRRSd6y
         RAcLh5eb90ZomDK4gYaMF4c1mjNIFJ+dsHjgJSAsSO1/yUF2O4lY04RJzuNGvT45bP44
         TYaQ==
X-Gm-Message-State: AOJu0YyqHJNBzyAIDLLufMzhV+nVtkIDeg0enPTP8JFiJBHhfOo8HDYF
	Hrqe+ozGkluBjhXgHoTfJCsqIuKfiFQDNNmOftapVobx/nzoZeor/HEa0s7EHYmJgPwcBFaHw68
	2UuE6tw82keuzot1JiuopqkM2dgtwSIjyEg==
X-Gm-Gg: Acq92OEjOGYfWES/SUID7zT+a+H+CplerHMTYZdZBosuOJjBJKpI1D9dfgYwCSQpiP8
	eron0tBytClFm9To8NCzw43qRH+69WN744W+mwMl4sJJVErFbWYibJjeNzSZnp6SnW/97xHlxZn
	vHVMrwP0EK2IqPSHDqz324jCIKgHFpz/DZ9ckuZ3CtTF6G4V8su7WoTMQUZ6vGcvgu1/leuEKzC
	DoQe+QSXGetbd1Sc/XhVuF8UdxxxgR9wCtaBGlCBxMwRa44xMHE/Ghn1J4nAUx/Y0wa7wXRaNd6
	YfIRTkmkJ6mY92Oasw==
X-Received: by 2002:a05:6a00:1ad4:b0:837:f111:b70 with SMTP id
 d2e1a72fcca58-842b665ff89mr2808565b3a.4.1780676932544; Fri, 05 Jun 2026
 09:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605140203.76848-1-cgoettsche@seltendoof.de>
 <20260605140203.76848-3-cgoettsche@seltendoof.de> <CAEjxPJ5FRx3-TpkEqiBEU6+bpWSOfeWETosm8XNPfLYCWUiEKA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5FRx3-TpkEqiBEU6+bpWSOfeWETosm8XNPfLYCWUiEKA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:28:41 -0400
X-Gm-Features: AVHnY4ID_dPxrtbX5ETVSyIk2URl4_YUXNgiFs6FIqKmcLtvpwhrqNmoIRqMHao
Message-ID: <CAEjxPJ5-RXgU+APGE67aiHy-0W1jZxM-Qh_RCsVMO-+FTpoRYw@mail.gmail.com>
Subject: Re: [PATCH 4/4] libselinux: validate netlink message length before
 accessing payload
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:55=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 5, 2026 at 10:11=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > avc_netlink_process() cast NLMSG_DATA(nlh) to selnl_msg_setenforce,
> > selnl_msg_policyload or nlmsgerr and dereferenced it without checking
> > that nlmsg_len was large enough to contain that payload.  A short
> > message would lead to reading past the received data (into the
> > uninitialized remainder of the stack receive buffer).
> >
> > The SELinux netlink socket only accepts messages from the kernel
> > (avc_netlink_receive() rejects packets whose source pid is non-zero),
> > so this is not a reachable vulnerability, but the payload size should
> > be validated as defense in depth before being trusted.
> >
> > Assisted-by: Claude:claude-4.7-opus
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

All 4 patches merged.

>
> > ---
> >  libselinux/src/avc_internal.c | 30 +++++++++++++++++++++++++++---
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_interna=
l.c
> > index 41257ee6..ec19010a 100644
> > --- a/libselinux/src/avc_internal.c
> > +++ b/libselinux/src/avc_internal.c
> > @@ -204,7 +204,15 @@ static int avc_netlink_process(void *buf)
> >
> >         switch (nlh->nlmsg_type) {
> >         case NLMSG_ERROR: {
> > -               struct nlmsgerr *err =3D NLMSG_DATA(nlh);
> > +               struct nlmsgerr *err;
> > +
> > +               if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*err))) {
> > +                       avc_log(SELINUX_WARNING,
> > +                               "%s:  warning: truncated netlink messag=
e\n",
> > +                               avc_prefix);
> > +                       return -1;
> > +               }
> > +               err =3D NLMSG_DATA(nlh);
> >
> >                 /* Netlink ack */
> >                 if (err->error =3D=3D 0)
> > @@ -217,7 +225,15 @@ static int avc_netlink_process(void *buf)
> >         }
> >
> >         case SELNL_MSG_SETENFORCE: {
> > -               struct selnl_msg_setenforce *msg =3D NLMSG_DATA(nlh);
> > +               struct selnl_msg_setenforce *msg;
> > +
> > +               if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*msg))) {
> > +                       avc_log(SELINUX_WARNING,
> > +                               "%s:  warning: truncated netlink messag=
e\n",
> > +                               avc_prefix);
> > +                       return -1;
> > +               }
> > +               msg =3D NLMSG_DATA(nlh);
> >                 rc =3D avc_process_setenforce(!!msg->val);
> >                 if (rc < 0)
> >                         return rc;
> > @@ -225,7 +241,15 @@ static int avc_netlink_process(void *buf)
> >         }
> >
> >         case SELNL_MSG_POLICYLOAD: {
> > -               struct selnl_msg_policyload *msg =3D NLMSG_DATA(nlh);
> > +               struct selnl_msg_policyload *msg;
> > +
> > +               if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*msg))) {
> > +                       avc_log(SELINUX_WARNING,
> > +                               "%s:  warning: truncated netlink messag=
e\n",
> > +                               avc_prefix);
> > +                       return -1;
> > +               }
> > +               msg =3D NLMSG_DATA(nlh);
> >                 rc =3D avc_process_policyload(msg->seqno);
> >                 if (rc < 0)
> >                         return rc;
> > --
> > 2.53.0
> >
> >
