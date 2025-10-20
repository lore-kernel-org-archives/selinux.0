Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45EC2741B6
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980769; cv=none; b=B3klQ7eIvxcefu+S2DM8GHnSh3bO3KNjVINriJgzXsLoCjcGQy483J+Wq3il7d2Wkc1tcLIGEjq0q0jwrwqsUl+dKf+zX7PlvyPKW0EtPLjtF1z+2jLC9vtTtverHSS79dIOv8oP0a/oUI9uuyLGNDyB5gqpUw6TvH8gkcpx+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980769; c=relaxed/simple;
	bh=dIctKXyot4unP9TfIstkrdXnT2xOfBmJKUgRzgWr/s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dP20OTTI1AcPKEsdJAgCjMjg7c/R5yWu/VORIJAg0n1jiDCxFdP+80n3idz7LPM9qhmYpk2vD9HYKgk5LHY4MdMSCnjdtY3ikj1p5sU+K544DHkMBqZt3JiQtV1cSD1AtzDJMZbYGyKiZwIqdw4Z7UKi2pWJf+seV64TLOBMIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECaJdhU3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECaJdhU3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33bc2178d6aso3109144a91.0
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760980766; x=1761585566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sylcjcPaxI1rfP8bUnZQeCbE/T2B8Qlbla9DLthnHIA=;
        b=ECaJdhU3IxKtfIerZ8LaDuBVj7Xr2mJ85tD9ERQqAnaVsvgt92p81wsBl5UcjhkMvJ
         5cQxjttii9K23qVOzZ/y8eBUzvmbybHvmIlrM4T94cYqS1QeSZHgeczAzej1jZK7qc90
         ipl/pCdwfscsLC86v6FgMs17Pni/plts8xqmbuXHBWYaxFgDfyLgwrak1Ld+0J/6u1rr
         CF4KN9WSsOdxUrw4mqjndfJoONIoauskrR38V0pHeTwAm0wKJ6oS9USV616pVLnoFBXX
         y5YqY9AT6gsUGIyIT6xZdTm1A0BY8ODw7RutjdxicHWA+TRbZtgtdfZyUh5+gH/p5nXX
         71AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760980766; x=1761585566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sylcjcPaxI1rfP8bUnZQeCbE/T2B8Qlbla9DLthnHIA=;
        b=YWmk0kSeKPeR0j38U5FCGepp3iEgF/AF/6bogBNgOqPDOoaesRkDzYVxN0eEvnuAYt
         95J2kUjnCHg/iG8z3j87G9YlVFtyar1zWLrqokyXVHjAat/IGwxdXOMnhncg0jVmUErG
         PmXN7a5Azmt4jZxUv1S3Uf+qDK8hysbOJpb9fk/8HgUJQz0Z43tOHePXxGUSVGNgNsk/
         w6zpO1y639cYufKhoM0kmFONWYgTkq+YH5HIWj9hkuRxX4IooOF7GliV0y8dY0vAEF/J
         8PShZKM9V294stnwhybDjqr9iBdZgA02fyXhSB6bkA1+UkikhPaZlB+P9qLhIC+xtIQx
         vSfQ==
X-Gm-Message-State: AOJu0Yzvw7MD/K3hWL5hEJBLv3kDac0qrRwSqsMe8emwZU/6cGo+J5XY
	pf84S+Wcf0vsGNTAl30k5ZbdOmKvKqftGfFQ/FVJR0EwAQxYd3bG4Ph2RtkE8BbbPzN2VLPOJvT
	/Pz7cdQ7Aq/mpuFuzt15m8uTBNsgcpQ0=
X-Gm-Gg: ASbGncuRY0dRXIjj1g5ScVGDX+7EoGllG+wnBu4uHn28/oqlmWQG1VSM36GbXHBVxw/
	Bgf7uJtelHRBdJDmrPMb7DyjRgHa/sz4RlFcBHVtFV7RtCZiYp/xCYzv6286Kh67fBs7+bCzrPX
	fnrNMx9FAjkyQqRy/1OqOoCcc+RMpIMxpHvIHujRsq36EGC9/YWrmni2eaP9GkrCP4jAx0NFI29
	mfQWYc5JXpdlKI3Zq4MAVeZEj+sZxXoFbacLJAWi00qsPavZ5/ykTP6PWCWd5mINSDdmqA=
X-Google-Smtp-Source: AGHT+IE+7L0PQd5ha/h78pmrKHiCbQGc8TwFrT0tMcDTbtNhnhYavhlYPTsm9aLztkZfOOWzdbWF9poA5SNlI6T8gBw=
X-Received: by 2002:a17:90b:5623:b0:33b:d371:1131 with SMTP id
 98e67ed59e1d1-33bd3711391mr17073293a91.34.1760980766280; Mon, 20 Oct 2025
 10:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018051945.51425-1-nvraxn@gmail.com> <CAEjxPJ6dzwny-82pHpEHf6ugMDpXb_atFe5Q-EZBzte=NYy7_g@mail.gmail.com>
 <DDN73GJRM4FD.64O8R1T8XR3M@gmail.com> <CAEjxPJ6FTYB6B3qn3cCGE-16h4kUT-mjGzxxCP9JFDAA-k99hA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6FTYB6B3qn3cCGE-16h4kUT-mjGzxxCP9JFDAA-k99hA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Oct 2025 13:19:15 -0400
X-Gm-Features: AS18NWDbbb-pfEQr95GizGayMOCRkrr068jx8ZGubpYaeoWspDdV5zjE7heRJ1I
Message-ID: <CAEjxPJ7VktYWYreg4PMUSTeoxRvBBoD0HVb1bsXdsach+j7PyA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: semanage_store: recursively create SEMANAGE_ROOT
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 12:27=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Oct 20, 2025 at 9:48=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > On Mon Oct 20, 2025 at 2:15 PM BST, Stephen Smalley wrote:
> > > On Sat, Oct 18, 2025 at 1:20=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.co=
m> wrote:
> > >>
> > >> In package build/install environments, when semodule(8) is passed th=
e
> > >> `--path` option, it is expected that it creates the entire directory
> > >> tree for the policy root.
> > >>
> > >> Some package managers warn or error if permissions do not align betw=
een
> > >> the tree on the existing system and the build environment about to b=
e
> > >> merged. To make sure this is a non-issue, create the tree of the pol=
icy
> > >> root with 0755 permissions (in line with standards for `/var/lib`) a=
nd
> > >> then chmod the final path to the more restrictive 0700 permissions. =
As
> > >> the contents being placed in the policy root are security sensitive,
> > >> erorr instead of warning if we fail to chown the policy root to 0700=
.
> > >
> > > error
> > >
> > >>
> > >> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> > >> ---
> > >>  libsemanage/src/semanage_store.c | 58 ++++++++++++++++++++++++++++-=
---
> > >>  1 file changed, 52 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/sema=
nage_store.c
> > >> index 1731c5e8..c1425f15 100644
> > >> --- a/libsemanage/src/semanage_store.c
> > >> +++ b/libsemanage/src/semanage_store.c
> > >> @@ -491,6 +491,44 @@ char *semanage_conf_path(void)
> > >>         return semanage_conf;
> > >>  }
> > >>
> > >> +/* Recursively create a directory from a path string.
> > >> + * Returns 0 on success, -errno on failure.
> > >> + */
> > >> +static int mkdir_recursive(const char *path, mode_t mode)
> > >> +{
> > >> +       if (!path || !*path) {
> > >> +               return -EINVAL;
> > >> +       }
> > >> +
> > >> +       char path_buffer[PATH_MAX] =3D {0};
> > >> +       size_t len =3D strlen(path);
> > >> +       /* + 1 for nullterm.  */
> > >> +       if (len + 1 >=3D sizeof(path_buffer)) {
> > >
> > > if len =3D=3D sizeof(path_buffer) - 1, then len + 1 =3D=3D sizeof(pat=
h_buffer)
> > > and this condition will evaluate to true even though the path + NUL
> > > terminator will fit into the buffer, right?
> > >
> >
> > Yea, forgot to change the check from `>=3D` to `>` when I added the +1 =
to
> > make the nullterm more clear. Will update.
> >
> > >> +               return -ENAMETOOLONG;
> > >> +       }
> > >> +
> > >> +       strncpy(path_buffer, path, sizeof(path_buffer) - 1);
> > >
> > > Not sure why "sizeof(path_buffer) - 1" is used as "n" here or why we
> > > even need to use strncpy() at this point. We already know that path
> > > has length len and that len < sizeof(path_buffer), right?
> > >
> >
> > Should be fine as I initalise with `=3D {0}`, but it isn't great agreed=
,
> > will change this.
> >
> > >> +
> > >> +       /* trim possible trailing slashes, except if '/' is the enti=
re path.  */
> > >> +       while (len > 1 && path_buffer[len - 1] =3D=3D '/') {
> > >> +               path_buffer[--len] =3D '\0';
> > >> +       }
> > >> +
> > >> +       for (char *pos =3D path_buffer + 1, *slash; (slash =3D strch=
r(pos, '/')); pos =3D slash + 1) {
> > >
> > > Assumes that path_buffer originally starts with a "/"? Likely always
> > > true but noting it.
> > >
> >
> > I don't think this is the case, there are two cases here:
> >
> > 1. We start with a /, so `/foo/bar`. In this case, we have the + 1, so
> >    the `/` is skipped over and we start searching from the `f` characte=
r
> >    and find the next `/` before `bar`. In this case, we set that to '\0=
'
> >    so mkdir doesn't read past that, only creating `/foo` (because we di=
d
> >    not actually modify the first slash in `path_buffer`. We modify pos,
> >    which is how we calculate where '/' is to set it to '\0'.
> >
> > 2. We don't start with a /, so `foo/bar`. in this case, we have the + 1
> >    again, but this doesn't actually matter! Sure, pos advances, but we
> >    never remove or change the initial character in the `path_buffer`, w=
e
> >    only advance past it when searching for the `/`, which then continue=
s
> >    the case like we did above, setting the `/` to '\0'.
> >
> > I might have had some oversight though, please do correct me if I have
> > missed something.
>
> I assumed incorrectly that you are calling mkdir() with pos to create
> each directory component in turn. On 2nd look though I see you are
> just passing path_buffer each time. But that won't work if you have a
> multi-component pathname with more than one directory level, yes?

Oh, never mind - I just misread the code again.

>
> >
> > >> @@ -529,6 +573,8 @@ int semanage_create_store(semanage_handle_t * sh=
, int create)
> > >>                         return -1;
> > >>                 }
> > >>         }
> > >> +       /* We no longer need to use mkdir_recursive at this point: t=
he toplevel
> > >> +          directory heirachy has been created by now.  */
> > >
> > > hierarchy
> >
> > Will fix - whoops.
> >
> > Regards,
> > Rahul
