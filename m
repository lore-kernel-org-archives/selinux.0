Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76925757
	for <selinux@vger.kernel.org>; Fri,  1 Nov 2024 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730423311; cv=none; b=Js+2/T1Nj6zjqj25gkoeJmHRyRXHWZ1s+TlXBeJOKQf8sbYAKah5nt0VhY7/IMJi3z6gip7LxMP9xnmqfI5YuI+tCfUJdfbCW5ZIevvA53affpJX0zDwxleisuJn8Lq3K/qOZeeWmopiVQl3nAFWv/yXgqXEBTsElmiES9n93JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730423311; c=relaxed/simple;
	bh=JR0ujweQvlyTW0MKVy9vjmPtUd3fnDFmZowQSLuGxao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUkeSrI71ZnQmgO6mjHw6l3edmqhIzIyEN996/S4xsK436ttI3lRTj9bcBfvl5AmGT1EhGKoxG7JTWLgXSCM758yuHdSMZIen5EfybVGmo+jl6GcgaHpD5isb9xprg1nDQyOck5GLIzMWK5QvltfW+dwi3OauRjVC1+TvOIkBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2DyDPwAV; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2DyDPwAV"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e19d8c41so7172e87.0
        for <selinux@vger.kernel.org>; Thu, 31 Oct 2024 18:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730423303; x=1731028103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EIbYSSxRf0VPJE8mwzNclBUFssw93pIDsmmJXDng+0=;
        b=2DyDPwAV7OwVHLNXgCYhNui6r9kI++qgw4c/oUuIlPA90F1Ge3EluJZQcRTzTTE6Je
         z6TBbb5OrthM0PNwIfFFEwAcwZCKFJrsVTT9S0Fvagaeq1ZFZPq/VstLjf58EzbcHmWF
         35tpiHwkI5GQ+YsQaN6bbb21Yn9+ou5NlYpeNAUgiwxEVluF1ynyaqMdY8BpQoJ6wUBq
         aN1ihM9BgWFZDqGkqFv0zekXox0KUI7KQ7aR1GWwksrc7waS71rMLp6Mx8hHN4CawOGR
         1cGlUd5+lNcJvYNvwCARgMsdGMq0z1bicjCwvpwfCC37Qb7t0Q5i1hmECz2a84cridsQ
         ipdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730423303; x=1731028103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EIbYSSxRf0VPJE8mwzNclBUFssw93pIDsmmJXDng+0=;
        b=AWKl1TL0zBOjqg6RkHtjS+J1AvSzC4H2z+fR0JzYsHCXHCs2AhIiXIL/XQmVVAVWPT
         q3GPodKQe89hwDfSdGwsLxa02FQ783iNg43rNvRyFoBLSt3N808PKZjEGpeyRamYkbJ8
         4LXdtEtIbxyKcWGOPkoRppiM5KNY0STmkkCjc/4kjRPTz6VXU1YLcOemnuMPh8OL6ESF
         Ya+RMfkYHoawgB9A1mGqClNeSOi/WaaR6D3iHXakPk9qiPSyLmSP+VrPbNiDAozd1/vF
         e8bqJFlMUXLasSQYk0aIafbqqA9/oHfhM5TPyGcE6yf2u169wdqHHElotKYMqjzBG8rh
         2hbA==
X-Forwarded-Encrypted: i=1; AJvYcCX7TLtH8G0P0/tf9RXL5v9gJsCNC+1uLji6dLELeWLya5WHZo1XzcfGHxQ2Jq1qxta40ill3zZz@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3OnAdl+RgFRSNI+jUzDMxuZwyzTYN1y2Aoa/SyEwlzS/u2OT
	gaF8btYVkywNpBZIkMIQHJgI65wQUhmgwb8P8/zBvbuhWzZE+ti8fwFsho1d9rVy1VteT4OnUCg
	TyGvIersKfEke4n3CvD6mvTMKvOhLsl6yIkMg
X-Gm-Gg: ASbGncvK6cJKQWjvVUA+zaylho/ss/e54s9Uvz8YI5CFLeJkTv1jFB5WPug+JiwkIZ1
	YaKF4ZfO/dLpu9sDI8Er7j7LSRPhudPE=
X-Google-Smtp-Source: AGHT+IESVL1zK9jjjoT6Ir6QfikZ2f1cGXwNz5Q1Y1YwaXp29gtaTqWJAbhimfWkzATgYZyk8LiqRZcAfe8oxBGmBV4=
X-Received: by 2002:a05:6512:3b9d:b0:52c:dd42:cf57 with SMTP id
 2adb3069b0e04-53c7a903992mr482713e87.0.1730423302958; Thu, 31 Oct 2024
 18:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022223711.3066190-1-tweek@google.com> <0aa16dcb5d0708fb926d8e8128217205@paul-moore.com>
In-Reply-To: <0aa16dcb5d0708fb926d8e8128217205@paul-moore.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Fri, 1 Nov 2024 12:08:02 +1100
Message-ID: <CA+zpnLd_TjPxXFz8Ek80-udQzx7xhEWxxryxFpXAD2hdw4wRkg@mail.gmail.com>
Subject: Re: [PATCH] selinux: add netlink nlmsg_type audit message
To: Paul Moore <paul@paul-moore.com>
Cc: brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Oct 22, 2024 "=3D?UTF-8?q?Thi=3DC3=3DA9baud=3D20Weksteen?=3D" <tweek@g=
oogle.com> wrote:
> >
> > Add a new audit message type to capture nlmsg-related information. This
> > is similar to LSM_AUDIT_DATA_IOCTL_OP which was added for the other
> > SELinux extended permission (ioctl).
> >
> > Adding a new type is preferred to adding to the existing
> > lsm_network_audit structure which contains irrelevant information for
> > the netlink sockets (i.e., dport, sport).
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > ---
> >  include/linux/lsm_audit.h | 2 ++
> >  security/lsm_audit.c      | 3 +++
> >  security/selinux/hooks.c  | 4 ++--
> >  3 files changed, 7 insertions(+), 2 deletions(-)
>
> ...
>
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index 849e832719e2..b6544024f688 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -425,6 +425,9 @@ static void dump_common_audit_data(struct audit_buf=
fer *ab,
> >       case LSM_AUDIT_DATA_ANONINODE:
> >               audit_log_format(ab, " anonclass=3D%s", a->u.anonclass);
> >               break;
> > +     case LSM_AUDIT_DATA_NLMSGTYPE:
> > +             audit_log_format(ab, " nlmsg_type=3D%hu", a->u.nlmsg_type=
);
> > +             break;
>
> Based on the audit field dictionary, link below, it appears that netlink
> related fields follow the "nlnk-XXX" pattern, and while I don't recall
> any current users in the kernel, it seems like sticking with that pattern
> is probably a good idea.  With that in mind, what do you think about
> changing "nlmsg_type" into "nlnk-msgtype"?
>

Thanks Paul, I wasn't aware of this list. I found one example of a
netlink field in kernel/audit.c (function audit_log_multicast), which
was added in commit 9d2161bed4e39. The field is 'nl-mcgrp'. The name
was changed from nlnk-grp between v4 and v5 of the patch, but I can't
seem to find the reasoning.

Do you know if 'nlnk-fam' and 'nlnk-pid' were deprecated/removed at some po=
int?

I don't mind either way. If you think 'nlnk-msgtype' (or 'nl-msgtype')
is more consistent with the other audit fields, I'm happy to send an
updated version.
