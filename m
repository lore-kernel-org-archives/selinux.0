Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E51E5B97
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747302774; cv=none; b=ApAO94wt5NPAyvtV5kfQfvjvC2JvG/jdOxw8JeEK8VBxI953VlmGaWSSDIajkuxf2Fx7owEvYrDdcjz+D/fommLFbzeCXaGNUXtxuxQM+H8nfmNLSJhUsPSaIODJnsXdOjKLfRmdI6YZyK4WMh9MMdD8+ONIG5OxvzG6OoUSyHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747302774; c=relaxed/simple;
	bh=pey3VqEeP7QTEM641qzijWlW/30xwFA7ZLkznPpMriI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EHzR6WPWB5pIEbnZsq6ObsrdpgreS2HxLoh4D3ikXnM8nr2nzpWz3d2aRRiZ0Z4vrXkpJWXm/0Jr9Q5qoWmArcm8n9QS+iwBbyKfcnSDx6Ht9CsySbcEi/cqqjITNkToZ1Kul2IFUZ/k0WTaOtr9DLebC/aUxSuqPQzrvto6tHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=APIz+eUa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APIz+eUa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747302771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd4sSToeoKVNWMcMgGweKWZx5c0T3q/oRAUdQWR0gVk=;
	b=APIz+eUam+wiBfydY1IEwY06RiXYVZlBAUaL9ORMlCQSwdAf1H+3GzNgYuoT6c3a3Gt6G/
	FqT1X3dtAj+hYUO6nKlSM58aXxdEHpE1vd23OMu6she9Q0gK78pBpR23Jjw7zhOOzLcaZG
	f7SHsI+ZzNfKL5sngwoJ3jgYTRFvllc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-NaH5DCC5NOW1H6Xs3cf7Fg-1; Thu,
 15 May 2025 05:52:48 -0400
X-MC-Unique: NaH5DCC5NOW1H6Xs3cf7Fg-1
X-Mimecast-MFC-AGG-ID: NaH5DCC5NOW1H6Xs3cf7Fg_1747302767
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67B9E195608F;
	Thu, 15 May 2025 09:52:47 +0000 (UTC)
Received: from localhost (unknown [10.45.224.64])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D41D8180087A;
	Thu, 15 May 2025 09:52:46 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, Christian =?utf-8?Q?G=C3=B6ttsche?=
 <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: prioritize local literal fcontext definitions
In-Reply-To: <CAP+JOzT+KRj2GvLa1g3z6YqKPEM4e72+oPKjUQ=XLKssHnZ8ew@mail.gmail.com>
References: <20250417190812.41263-1-cgoettsche@seltendoof.de>
 <CAP+JOzQT6z8osFtrK9PTfG8dXnuwwo7vNyMxT_83OBUEwERKtg@mail.gmail.com>
 <CAJ2a_DdRZXWnjnmJMmxZspUJn4hUgMBF=vVfsqY9EL3L8gpRoA@mail.gmail.com>
 <CAP+JOzT+KRj2GvLa1g3z6YqKPEM4e72+oPKjUQ=XLKssHnZ8ew@mail.gmail.com>
Date: Thu, 15 May 2025 11:52:45 +0200
Message-ID: <87wmai42vm.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

James Carter <jwcart2@gmail.com> writes:

> On Fri, Apr 25, 2025 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
>>
>> On Fri, 18 Apr 2025 at 21:13, James Carter <jwcart2@gmail.com> wrote:
>> >
>> > On Thu, Apr 17, 2025 at 3:18=E2=80=AFPM Christian G=C3=B6ttsche
>> > <cgoettsche@seltendoof.de> wrote:
>> > >
>> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>> > >
>> > > For literal file context definitions respect overrides from homedirs=
 or
>> > > local configurations by ordering them first.
>> > >
>> > > Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
>> > > Reported-by: Paul Holzinger
>> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2360183
>> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>> > > ---
>> > >  libselinux/src/label_file.c       |  5 +++--
>> > >  libselinux/src/label_file.h       | 10 +++++++++-
>> > >  libselinux/src/selinux_internal.h |  2 ++
>> > >  3 files changed, 14 insertions(+), 3 deletions(-)
>> > >
>> > > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file=
.c
>> > > index 5d73fb84..61a9ddb6 100644
>> > > --- a/libselinux/src/label_file.c
>> > > +++ b/libselinux/src/label_file.c
>> > > @@ -480,7 +480,7 @@ static int load_mmap_ctxarray(struct mmap_area *=
mmap_area, const char *path, str
>> > >         return 0;
>> > >  }
>> > >
>> > > -static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool=
 validating,
>> > > +static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool=
 validating, uint8_t inputno,
>> > >                                   struct literal_spec *lspec, const =
struct context_array *ctx_array)
>> > >  {
>> > >         uint32_t data_u32, ctx_id;
>> > > @@ -489,6 +489,7 @@ static int load_mmap_literal_spec(struct mmap_ar=
ea *mmap_area, bool validating,
>> > >         int rc;
>> > >
>> > >         lspec->from_mmap =3D true;
>> > > +       lspec->inputno =3D inputno;
>> > >
>> > >
>> > >         /*
>> > > @@ -742,7 +743,7 @@ static int load_mmap_spec_node(struct mmap_area =
*mmap_area, const char *path, bo
>> > >                 node->literal_specs_alloc =3D lspec_num;
>> > >
>> > >                 for (uint32_t i =3D 0; i < lspec_num; i++) {
>> > > -                       rc =3D load_mmap_literal_spec(mmap_area, val=
idating, &node->literal_specs[i], ctx_array);
>> > > +                       rc =3D load_mmap_literal_spec(mmap_area, val=
idating, inputno, &node->literal_specs[i], ctx_array);
>> > >                         if (rc)
>> > >                                 return -1;
>> > >                 }
>> > > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file=
.h
>> > > index 67db78e5..b7aed0bc 100644
>> > > --- a/libselinux/src/label_file.h
>> > > +++ b/libselinux/src/label_file.h
>> > > @@ -96,6 +96,7 @@ struct literal_spec {
>> > >         char *regex_str;                        /* original regular =
expression string for diagnostics */
>> > >         char *literal_match;                    /* simplified string=
 from regular expression */
>> > >         uint16_t prefix_len;                    /* length of fixed p=
ath prefix, i.e. length of the literal match */
>> > > +       uint8_t inputno;                        /* Input number of s=
ource file */
>> > >         uint8_t file_kind;                      /* file type */
>> > >         bool any_matches;                       /* whether any pathn=
ame match */
>> > >         bool from_mmap;                         /* whether this spec=
 is from an mmap of the data */
>> > > @@ -368,7 +369,13 @@ static inline int compare_literal_spec(const vo=
id *p1, const void *p2)
>> > >                 return ret;
>> > >
>> > >         /* Order wildcard mode (0) last */
>> > > -       return (l1->file_kind < l2->file_kind) - (l1->file_kind > l2=
->file_kind);
>> > > +       ret =3D spaceship_cmp(l1->file_kind, l2->file_kind);
>> > > +       if (ret)
>> > > +               return -ret;
>> > > +
>> > These four lines should be removed. It makes sense to consider the
>> > wildcard mode as less specific and give priority to a rule that is not
>> > using a wildcard, but that is not how it was done in the past and that
>> > is not (from my testing) what is being done if a regex is involved. So
>> > for both consistency and in keeping with past practice, we should not
>> > use the file kind to sort here.
>> >
>> > By my testing, everything works as expected with those lines removed.
>>
>> The only difference I am seeing is when omitting specifying the file
>> type to lookup (-t for selabel_lookup, -m for matchpathcon).
>> Previously the last defined definition was returned, now the one with
>> the highest LABEL_FILE_KIND_* value (e.g. regular has currently the
>> highest value of 7).
>
> That is the difference.
>
>> But in practice that should not matter since for corretly labeling
>> files the type is important, and one could argue it is unspecified
>> what definition is returned if the type is omitted.
>>
>
> It is not unspecified. It means "all file types"
>
>> If the order should not depend on the mode one would need to store the
>> file linenumber in the compiled format (i.e. a binary format change),
>> since otherwise the order would be dependent on the used sorting
>> algorithm/implementation.
>>
>
> I am not following what you are saying here.
>
> In my testing, the file type only mattered when there was no regex in the=
 path.
> If you specify a file context with a regex in an fc file, then
> regardless of whether the file type was a regular file or it was not
> specified, setting the file context with semanage would override it.
> But if you specify a file context that does not have a regex in an fc
> file, then setting the file context with semanage would override it
> only if you set the file type or if the file context in the fc file
> did not specify a file type.
>
> So it is more consistent to not sort based on the file type here.
> Also not sorting based on file type matches the old behavior.
>
> If this was new and we did not have to worry about regressions, then I
> would agree with you. I think that it would make sense to have a fc
> rule that specified a specific file type be selected over one that did
> not (everything else being equal).
>

I'd like to push this forward with the change Jim proposed as it follows
the original behavior.

The patch itself does not fix the regression:

    # semanage fcontext -a -t bin_t /usr/bin/sshd=20
    # matchpathcon /usr/bin/sshd=20
    /usr/bin/sshd   system_u:object_r:bin_t:s0

Without those 4 lines
-       /* Order wildcard mode (0) last */
-       ret =3D spaceship_cmp(l1->file_kind, l2->file_kind);
-       if (ret)
-               return -ret;
-

    # semanage fcontext -a -t bin_t /usr/bin/sshd=20
    # matchpathcon /usr/bin/sshd=20
    /usr/bin/sshd   system_u:object_r:bin_t:s0


Christian, are you ok to update your patch?


>
>> > The rest of the patch looks good to me.
>> >
>> > Thanks,
>> > Jim
>> >
>> > > +       /* Order by input number (higher number means added later, m=
eans higher priority) */
>> > > +       ret =3D spaceship_cmp(l1->inputno, l2->inputno);
>> > > +       return -ret;
>> > >  }
>> > >
>> > >  static inline int compare_spec_node(const void *p1, const void *p2)
>> > > @@ -754,6 +761,7 @@ static int insert_spec(const struct selabel_hand=
le *rec, struct saved_data *data
>> > >                         .regex_str =3D regex,
>> > >                         .prefix_len =3D prefix_len,
>> > >                         .literal_match =3D literal_regex,
>> > > +                       .inputno =3D inputno,
>> > >                         .file_kind =3D file_kind,
>> > >                         .any_matches =3D false,
>> > >                         .lr.ctx_raw =3D context,
>> > > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/seli=
nux_internal.h
>> > > index 964b8418..3fe7d4c3 100644
>> > > --- a/libselinux/src/selinux_internal.h
>> > > +++ b/libselinux/src/selinux_internal.h
>> > > @@ -150,4 +150,6 @@ static inline void fclose_errno_safe(FILE *strea=
m)
>> > >  # define unlikely(x)                   (x)
>> > >  #endif /* __GNUC__ */
>> > >
>> > > +#define spaceship_cmp(a, b)            (((a) > (b)) - ((a) < (b)))
>> > > +
>> > >  #endif /* SELINUX_INTERNAL_H_ */
>> > > --
>> > > 2.49.0
>> > >
>> > >

