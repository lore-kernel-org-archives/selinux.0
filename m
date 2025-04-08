Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F981263C84
	for <selinux@vger.kernel.org>; Tue,  8 Apr 2025 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099959; cv=none; b=NUtjTJMfVoKm5nbef9yU4ZHl033TpnKqYv8WBxy5Sf1E+4qNpTXT8rxgCDBlXrPUrij+eH7u5HuUNv9W8WIvhd2F7Vr90fA2frpUaWNN6hoPS37Pjj9FHb1W1+7hqJWS3udLyRCZ1qaC6Bye4D8IqLbBqgl+AJhpc0vpzDaUIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099959; c=relaxed/simple;
	bh=61xtwFIb5wptqbNmXz3zvzG3JN9+GREgW8jot8W/KRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVi8gmaxAk2FwAH6/saUgC4Gz8gFFwxnHRCSY88RDjWDS/HDUnJhpIS6YIEc8m+PDecZRhoQO6g5thuM2q2IrLVX4Zly0v4bwSrAqFNtnwpGifzWw64uT8UWSEpYndRu7zeHWLKAJoJtt3+3FptHWAkSyGWxJaLmqAsWBcI4Ajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MArZ9EuW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MArZ9EuW"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6feb229b716so53379557b3.3
        for <selinux@vger.kernel.org>; Tue, 08 Apr 2025 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744099956; x=1744704756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dr8oyZQMPFVJkSi7/HiJ1yWQXUgwYWLqcCGtSaSYV9g=;
        b=MArZ9EuWfKmaX/y9pwTRIt+EzwDeltm8IcSjhSNlR5iVepvfRMyMCrA0gTNXgti6U2
         ln47I3HQAh7pZ0zS634j1s+BDEr30rRIuxmUD6uLxZFTSMcn90Mk5MoKghT5umunmUu2
         yQYlFYD17O5nE8323wyZF/bbbe+ElqbuX7yIZLrEY7301R59aE5Hpo/wdcNcYA2j6QIW
         bkpQt6azEhVBiGyHt6yGkZAeRhaUaoHD8HsTMiYeFDY36P8hGmJa2D7Weg6s9o6PYvDW
         Q8Hx4y9I2ry6gcer+33fBoJJ3E4oN1Za5izG/oUiVhAWn5YOprvFJM2XZ+Q5EH0dfYXU
         pcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744099956; x=1744704756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr8oyZQMPFVJkSi7/HiJ1yWQXUgwYWLqcCGtSaSYV9g=;
        b=MvDiKp9cnp/r+iTqwhicl8USfOY76vX8BtN5dHgDG7V90lmfzdX+5S+g7dT17cWdg3
         5DSkLXcDEAAh+Y5U6UbAU2DEr1zdPF+s+/Qey+SjZCY+pBZwqa3+RaKM8ecWmX/O407P
         b44X/LnrRtc+hpt9FXieIcZBC4xCULkEYqoZg/ARLF2rJ7yJYw2gry0j7kkRrimjHTz7
         PBvZ9GylhybdmUMOE40u4wxh0AXHjIMrE9JTAbVKVud77DO5dX1ryUu4eaaOl3Jwot9Q
         HMbFobcb+KnB79T43CW6fFjNgx+eI9axkdKJ3oettPDF4pI7o/jQbOv16+DGk2GdPVAs
         XVtw==
X-Forwarded-Encrypted: i=1; AJvYcCX4szOOaHfYQ/v02JY90Amw/Pbuk7LHNDKYv1ZfLHr+vFmL8GY7yXsBVFfYNIJqz4csL2viBvS1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2w2TNZjC2FWQuiIGpPGJIyWmFLI9BRYRFtexOh5wPfpNKgrCr
	41y0d8W2N5KFsm3rdOhv/I5A/gPAwvB1jon9ilMO8HfOTJ8op5ALZZx6f7EUR+0wTX8i6gHEz0x
	BKGsWqk3DuSadmY6YyooPWaPvSbBVO5YK9aIA
X-Gm-Gg: ASbGncttPjNLz0vDuSDenrXK8w/aoEXErhfnPbAIRHhu0dGRIWMhnYOkyzb3whE9uoW
	8jeEmPkryzSetfXsZG2xz0yIvX7NR4MSETiFDv7tjZQsRzyAyKZ84K4mvIY7TVV6aZYLr4fYeVp
	Rq7oNyfCsr2PxRBXOT5uxFKY4OLA==
X-Google-Smtp-Source: AGHT+IELMpKtZhcecUs8JWexH/Kqjt1EKVHKIyu9bGTk/DheARK6jQXpug7N9exoBuWvQU0b09RaeXutHWJnMX1ZMC8=
X-Received: by 2002:a05:690c:6106:b0:700:b007:a33e with SMTP id
 00721157ae682-703e154f99emr272898897b3.16.1744099956540; Tue, 08 Apr 2025
 01:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407231823.95927-1-kuniyu@amazon.com> <20250407231823.95927-3-kuniyu@amazon.com>
 <CAHC9VhQCS-TfSL4cMfBu2GszHS8DVE05Z6FH-zPXV=EiH4ZHdg@mail.gmail.com> <cd8c8f91-336d-4dd2-b997-4f7581202e64@googlemail.com>
In-Reply-To: <cd8c8f91-336d-4dd2-b997-4f7581202e64@googlemail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 8 Apr 2025 04:12:25 -0400
X-Gm-Features: ATxdqUEOtPZ9bXkkZInYIGVexxRT64LXSEfkUWmNZGLrCXqEODt-AG9ggi-X7zs
Message-ID: <CAHC9VhQeq6RjukUUnoyoCopEOfR5VJ85yPZ1CUfTAA7LeiWJTA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/4] net: Retire DCCP.
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 1:22=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> Apr 8, 2025 03:35:15 Paul Moore <paul@paul-moore.com>:
> > On Mon, Apr 7, 2025 at 7:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> >>
> >> DCCP was orphaned in 2021 by commit 054c4610bd05 ("MAINTAINERS: dccp:
> >> move Gerrit Renker to CREDITS"), which noted that the last maintainer
> >> had been inactive for five years.
> >>
> >> In recent years, it has become a playground for syzbot, and most chang=
es
> >> to DCCP have been odd bug fixes triggered by syzbot.  Apart from that,
> >> the only changes have been driven by treewide or networking API update=
s
> >> or adjustments related to TCP.
> >>
> >> Thus, in 2023, we announced we would remove DCCP in 2025 via commit
> >> b144fcaf46d4 ("dccp: Print deprecation notice.").
> >>
> >> Since then, only one individual has contacted the netdev mailing list.=
 [0]
> >>
> >> There is ongoing research for Multipath DCCP.  The repository is hoste=
d
> >> on GitHub [1], and development is not taking place through the upstrea=
m
> >> community.  While the repository is published under the GPLv2 license,
> >> the scheduling part remains proprietary, with a LICENSE file [2] stati=
ng:
> >>
> >>   "This is not Open Source software."
> >>
> >> The researcher mentioned a plan to address the licensing issue, upstre=
am
> >> the patches, and step up as a maintainer, but there has been no furthe=
r
> >> communication since then.
> >>
> >> Maintaining DCCP for a decade without any real users has become a burd=
en.
> >>
> >> Therefore, it's time to remove it.
> >>
> >> Removing DCCP will also provide significant benefits to TCP.  It allow=
s
> >> us to freely reorganize the layout of struct inet_connection_sock, whi=
ch
> >> is currently shared with DCCP, and optimize it to reduce the number of
> >> cachelines accessed in the TCP fast path.
> >>
> >> Note that we leave uAPI headers alone for userspace programs.
> >>
> >> Link: https://lore.kernel.org/netdev/20230710182253.81446-1-kuniyu@ama=
zon.com/T/#u #[0]
> >> Link: https://github.com/telekom/mp-dccp #[1]
> >> Link: https://github.com/telekom/mp-dccp/blob/mpdccp_v03_k5.10/net/dcc=
p/non_gpl_scheduler/LICENSE #[2]
> >> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> >
> > Adding the LSM and SELinux lists for obvious reasons, as well as Casey
> > directly since he maintains Smack and I don't see him on the To/CC
> > line.
> >
> > For those that weren't on the original posting, the lore link is below:
> > https://lore.kernel.org/all/20250407231823.95927-1-kuniyu@amazon.com
> >
> >> diff --git a/security/selinux/include/classmap.h b/security/selinux/in=
clude/classmap.h
> >> index 04a9b480885e..5665aa5e7853 100644
> >> --- a/security/selinux/include/classmap.h
> >> +++ b/security/selinux/include/classmap.h
> >> @@ -127,8 +127,6 @@ const struct security_class_mapping secclass_map[]=
 =3D {
> >>         { "key",
> >>           { "view", "read", "write", "search", "link", "setattr", "cre=
ate",
> >>             NULL } },
> >> -       { "dccp_socket",
> >> -         { COMMON_SOCK_PERMS, "node_bind", "name_connect", NULL } },
> >>         { "memprotect", { "mmap_zero", NULL } },
> >>         { "peer", { "recv", NULL } },
> >>         { "capability2", { COMMON_CAP2_PERMS, NULL } },
> >
> > A quick question for the rest of the SELinux folks: the DCCP code is
> > going away, so we won't be performing any of the access checks listed
> > above, and there will be no way to get a "dccp_socket" object, but do
> > we want to preserve the class/perms simply to quiet the warning when
> > loading existing policies?
>
> Isn't the kernel just warning about missing clssses/permissions? If polic=
ies still define dccp_socket I think the kernel treats it as user space cla=
ss, like dbus.

Ah yes, my apologies, I mixed up the "... not defined in policy"
warning in my mind.  Thanks for setting me straight :)

Anyway, this looks fine to me.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM and SELinux)

--=20
paul-moore.com
