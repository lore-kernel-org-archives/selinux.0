Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B0481641
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523916; cv=pass; b=YWcM7k5WUIJxMY32s12HA91689dvgiX8jDilH9WKufFEBDJ5oMr/HJcOqwkajEsZa2oNH/CWP+EGub8oBFXbGoOCNVbUPd7B7Xh+ys/ua+5mGCVhPKF5SaHwPXvSN+uWPlniECEKajwwTfT9ONpLEUxA7MUzueTZah6SmejVXM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523916; c=relaxed/simple;
	bh=3XOzfiTaTl8nssaYUzhNxyvEpsxLzFFqpUF+v1dzuRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGn+onaB6tAzQhVTt5EdjFxi27pwoyjY1oGruTvh2V9pb0brnMzpk6lQSIuNp4FB2+qz/xDpBrwmG9gsQ2GFdQ9Q4I6U9ywKREtM/Gfnmcz5sa7vZBU8kkKBb76g2oAvAOCIYy+CY8VuUA+BV4MYbF4Y9bnvWp6uUMR7AXfbQhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1JgrpZP; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1JgrpZP"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-48a0ca07c38so855646b6e.2
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 05:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788523913; cv=none;
        d=google.com; s=arc-20260327;
        b=BHN5zPOhVYxYzvD5tKxoYPIr2u251FUI/v2wf7b12nxTiPtoF6ydM9zw9Ufq1MdREg
         PR5DYnTRRZZV6w4+10fkyPUWP6n2dvPTKgNj0DyXoYxEIuhpugG7fV5gqWCNYCIKaY6A
         mDtI/01naCruMK4BFdBTgilRxBtDTCB8gI1uFKHVkE4Or8/DJY5REmacEe0fXLvFyzMo
         xrzz8LY8lQFxCyzMH+3+qhYat8MPDjjqRiWkws4fo8QGcUea76w2GJzgcwJ/2KF/hne7
         brlBQkBTvZbK/PLszweVEF5XnfEsqqMjP+ULDXV/6IFxUhTCbUjh8uIB7vqLY2o9lot1
         dZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NOZ+/s7O1II+LBybpAWTVkJ4Q4aeE/04aKXYIBgsGyA=;
        fh=ECB1nU8VcQ1qaN8Gy2XppVrMK4BUd156Hr0y/bpCcrs=;
        b=k2sYergYGrSFJw/7QWBeoXjGW4Vdp5mMb72F5JPW7B4+LzHZcv++yOhg92qHlmaTrW
         /61c2SQErDP1YW4Qf4q5X+GMv17t1xVyHTb+cnKLAVE3rLqfZmNqoc9G/ctNJNbQPqdX
         V35rT7T27jhkigon+kk/+Pn/66KClTPoArukrxHZx4MVQnXUI3ftSwuQ3zt19oYeJ18d
         XRIWgZpCx/KSShM+y6g3X3ZFPvph6ebaOC1ZUzoVNLNFjRqFmpRELAeBQEGc8oetNbo5
         7IwZKml0TrXmkHqYAJLySChvU6BufElPS9kd+E6a0jfNBvrFFHvRqVxpK6kP6yuyrWt6
         SReg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788523913; x=1789128713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NOZ+/s7O1II+LBybpAWTVkJ4Q4aeE/04aKXYIBgsGyA=;
        b=V1JgrpZPRDJA72Ll7RrPY2BejpIHUpjk3iV333p4apWdy+kM71sujO2eSBhdxwikgx
         qHPARe3WUscX03Bhc2HcNvIMb8fWyEHSLqlXc9oDPgHVSk4mt1C83HnjF7rfhw2J3qDl
         G2qMIqj0WMgGTSVdyWbTz0bAYMzE+5oX+dv0J/oZFFB2IPcrroF/zcYW7Y2V+vGQRAIJ
         tOv2zmpUxWsS0vMAtlkLw4T/e9B2RlmU+gLSieMq75P8Gn/4mfhv0QwVoWcJOUiKHLsM
         XAa9ECSeA4mGSXZWzfRmP06KBgS3g6gjIRWCwYJPtXmxL7GXamQ8ESOQIq/nqOJiUbv+
         M50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788523913; x=1789128713;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NOZ+/s7O1II+LBybpAWTVkJ4Q4aeE/04aKXYIBgsGyA=;
        b=IhGrvcq5ukI/UO0wyEUBf41enzdJln02XGrSMNH3YKWpJa6gl2yKKzi+s2o5j9o7Lf
         42tGVod9yGdfL/j5Nh3fq1EuWDrf+1ohiCKl/gbv1lsmXo03rJbWJlD6IvzB1y1Xvjj9
         oKPfY7x1EdJh5qKDJJpvP9Z9eYwy+MV1NJgRQD5B7IQikjE/aRctD45SDEy9qEAxYrex
         GR/UTX7YCSGamhkakDkM+3kItEs+3yCP8blvrj2bwdE3vOzG7aICOkhV06HW1zYv7yvD
         7jyXSs+FCXMey1UWVzPj5+9+eiiP2p5INNK4Qpz2j0Ch1WL0iAAoA+j4+8DblMbs00nY
         ga0g==
X-Forwarded-Encrypted: i=1; AKwUvBxbj+pU+/P19kdh6kSGKpni4iu+7zII2gTHsqMQcruGESnwzGfELVXATWpX5ZmjBXsAYTU2mR+T@vger.kernel.org
X-Gm-Message-State: AFuF++kmMEW+HgX4yN+XpuyXBT4+SAdcbGHzPWpQUtlzKQJ+Mb/tPznK
	I5+295+VoN3QuG6B7M0gTqsZW27bM2CQBGY4WZCN2MA6znfV8TXrNIWnRe1wSxtdXrWvjC/SrR3
	nOoyNhYs3wRda+yP/knwei98IAQAHFb4=
X-Gm-Gg: AYBFou3hz+6lGFAadc7RHcEYkNOVYU9A+kGgrvP97rCoF1uS9Lcvoonu9rCyHub3Zih
	zBfxJawv/ld4WNR3UwSK08xO/gqd8R0Gxs2HyexCFeQvEl4FW5f1IABB6eEkA3CFvr4ufe0VMGR
	ZbDpmHwcQSahBNrQjyaJKpIoUkMveSHkXy85VUYhtgtXi64zuYJ47RCnLk/isSjW7HgPGzT5CbN
	DIHTrddEv9S5LmGtCgqY7Y+z8MP1Ey8zpQiALqzDZorBITCLzmb9aErXRZiMmQwLr2aAxS4dWdk
	tC9lqoLpS3HBnfiD5cGQug/dU9YJBArOVsyfNMi7zzdr
X-Received: by 2002:a05:6820:f014:b0:6b1:61b8:7ed5 with SMTP id
 006d021491bc7-6b6fabe1074mr4366051eaf.1.1788523913399; Fri, 04 Sep 2026
 05:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830201157.2084730-1-tristmd@gmail.com> <5be8f666e660371dbc964c2348422a25@paul-moore.com>
 <CAEjxPJ7b4nd7ak7HJ+AdZKyuE-kwfV_hpyx0r8Umz7ECAYVVEQ@mail.gmail.com> <CAHC9VhTiBGMJWQ7JSn1yP97XcQQUvwjZG1LKAHjQRiQ+AG792Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTiBGMJWQ7JSn1yP97XcQQUvwjZG1LKAHjQRiQ+AG792Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 08:11:42 -0400
X-Gm-Features: AcwNN1VbUdbEej1BLIUfSISJ6S7hp4UQ4qRAN1vcXaQB0HJToelq_ptidxZSstc
Message-ID: <CAEjxPJ5Q7ABrw6Df0m7Ru+7M5t4duCG1X-ogGc3+eGOXcAiuqg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission checks
To: Paul Moore <paul@paul-moore.com>
Cc: Tristan Madani <tristmd@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 11:48=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Sep 3, 2026 at 8:32=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > Are you sure that's the behavior you want?
>
> Think about how the socket/connect check works for local operations:
> the task requesting the socket/connect operation is the subject and
> the socket is the object.  In the currently proposed patch, when an
> ASCONF socket/connect operation is requested, the subject is treated
> completely differently as the socket is used to represent both the
> subject and object.  Even if we consider the socket's label a proxy
> for the creating task, using the socket's label as the subject of an
> ASCONF permission check makes little sense as it is the remote
> endpoint that triggers the ASCONF operation, not a local entity.
>
> > I don't think there is
> > precedent for performing the socket layer checks with the peer SID as
> > the subject rather than the local socket SID ...
>
> I think that is because all (?) of the other socket layer checks are
> initiated by the local system.  The ASCONF operations are unique
> because a remote node initiates them, which is why the network peer
> label is used as the subject as that best represents the remote
> endpoint.
>
> Please feel free to put forth your own reasoning on this, a discussion
> would be good, but I think we do need to recognize that ASCONF
> operations are different from local socket operations.

That seems reasonable. Wondering if this change will then require
updates to the selinux-testsuite (or if not, we ought to test this
behavior too).
