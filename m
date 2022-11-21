Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D49AC4332F
	for <selinux@archiver.kernel.org>; Mon, 21 Nov 2022 20:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKUU4v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 15:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKUU4t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Nov 2022 15:56:49 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB76D02DA
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 12:56:48 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z20so16474143edc.13
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 12:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=me4Q8oZDrW7pxxMFTMMVyogRU1I2zRmJ8Vir5gclYgI=;
        b=Z29cCKIIzo/YD9057pMCxD7ZrpJXhiDwKCwEXIIHmZ2bbHMYtUP3vl9rs5+6gTsR5M
         n0TX74F4uI0numAZKQPT1Ejx1fN+eOixtLiJPIxvJws5CPqX3rkyEhKDP0Z/BI9e7vLt
         gB8vedWwREAx6gbRWQuLL/Dz1tYdagpYg3fY7ixkLu6W2JiAFiz79uinFhqZvFHe60DN
         qIaOjTVwimZZZDOYy2ypx4yM0arlWvMF3DCTL1Kuy2iz48M2Gx8T/fq0DMYwqYl8DoNC
         E29ycp3TVuNcYX78JPrULSrwEIccHOZCJXywv/uPjOfE2a/l5Lc0GQ9row3HP6pXTiEE
         q78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=me4Q8oZDrW7pxxMFTMMVyogRU1I2zRmJ8Vir5gclYgI=;
        b=PxZHbsrjInDZ8zU+GC7rm1UpG4g5n3fhSnDlbY//AnSuSnPKEqF8VTYG4z3L5SLSNX
         BKNd8wPfBkhjATCdGahKDWVh+W8MbiCo8oQ5rupoW8nfDzXjbn7lC+kvcm/cGKleoiit
         2SDdONSRkePstnGri/L8Jl36aS4nCS8lwhELxE7rrSIVFZQINh5jM2IGkg1z+e8BrtKT
         nv39X6Qqr0wcz6fSSGyOHpef8YkshZWvbnsZFfio/dzWqRVn/Qihztt7NPDJzkIYPStt
         8aq1RYSPo1QUjs3or4lZde9uGbJHea3LbsxnelU/KuOYjwVZqixruUONOlbvtZ4Osq6F
         zoWg==
X-Gm-Message-State: ANoB5pnLdiXfR+0VSX6WfSBV27Bfc0/kHIgu/8vSsFY2xwZXEkGJxBFi
        mHYSnj2DOwMVUjqda5/eixvNI+fuCQn5ekQQa8o=
X-Google-Smtp-Source: AA0mqf591XVXfLm3NP0U5ltUnlCa+D2gRw0nTZ2X4Kqd0I/JPhNfcqeWsWLxPmyhEp/s2TxGbybVJgrDGz69PDrraOI=
X-Received: by 2002:a50:fd0d:0:b0:469:c73c:e29a with SMTP id
 i13-20020a50fd0d000000b00469c73ce29amr3132216eds.423.1669064206837; Mon, 21
 Nov 2022 12:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20221115115536.2647075-1-lujie54@huawei.com> <CAP+JOzTD17kTpi-Uj=7FExieuJXMEKvdrUunu_fJw=i_BLyqbw@mail.gmail.com>
In-Reply-To: <CAP+JOzTD17kTpi-Uj=7FExieuJXMEKvdrUunu_fJw=i_BLyqbw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Nov 2022 15:56:35 -0500
Message-ID: <CAP+JOzSNSoiAxn-ZJaV1d77XXLNz15GGWcZshpfj008T+5FhHA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix memory leaks on the audit2why module init
To:     Jie Lu <lujie54@huawei.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 16, 2022 at 3:33 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Nov 15, 2022 at 9:31 AM Jie Lu <lujie54@huawei.com> wrote:
> >
> > Signed-off-by: Jie Lu <lujie54@huawei.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/audit2why.c | 32 +++++++++++++++++++++++---------
> >  1 file changed, 23 insertions(+), 9 deletions(-)
> >
> > diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> > index 44a9a341..ba1a66eb 100644
> > --- a/libselinux/src/audit2why.c
> > +++ b/libselinux/src/audit2why.c
> > @@ -191,7 +191,7 @@ static PyObject *finish(PyObject *self __attribute__((unused)), PyObject *args)
> >
> >  static int __policy_init(const char *init_path)
> >  {
> > -       FILE *fp;
> > +       FILE *fp = NULL;
> >         const char *curpolicy;
> >         char errormsg[PATH_MAX+1024+20];
> >         struct sepol_policy_file *pf = NULL;
> > @@ -235,18 +235,17 @@ static int __policy_init(const char *init_path)
> >                 snprintf(errormsg, sizeof(errormsg),
> >                          "policydb_init failed: %m\n");
> >                 PyErr_SetString( PyExc_RuntimeError, errormsg);
> > -               fclose(fp);
> > -               return 1;
> > +               goto err;
> >         }
> >         sepol_policy_file_set_fp(pf, fp);
> >         if (sepol_policydb_read(avc->policydb, pf)) {
> >                 snprintf(errormsg, sizeof(errormsg),
> >                          "invalid binary policy %s\n", curpolicy);
> >                 PyErr_SetString( PyExc_ValueError, errormsg);
> > -               fclose(fp);
> > -               return 1;
> > +               goto err;
> >         }
> >         fclose(fp);
> > +       fp = NULL;
> >         sepol_set_policydb(&avc->policydb->p);
> >         avc->handle = sepol_handle_create();
> >         /* Turn off messages */
> > @@ -256,13 +255,13 @@ static int __policy_init(const char *init_path)
> >                               avc->policydb, &cnt);
> >         if (rc < 0) {
> >                 PyErr_SetString( PyExc_RuntimeError, "unable to get bool count\n");
> > -               return 1;
> > +               goto err;
> >         }
> >
> >         boollist = calloc(cnt, sizeof(*boollist));
> >         if (!boollist) {
> >                 PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
> > -               return 1;
> > +               goto err;
> >         }
> >
> >         sepol_bool_iterate(avc->handle, avc->policydb,
> > @@ -273,11 +272,26 @@ static int __policy_init(const char *init_path)
> >         rc = sepol_sidtab_init(&sidtab);
> >         if (rc < 0) {
> >                 PyErr_SetString( PyExc_RuntimeError, "unable to init sidtab\n");
> > -               free(boollist);
> > -               return 1;
> > +               goto err;
> >         }
> >         sepol_set_sidtab(&sidtab);
> >         return 0;
> > +
> > +err:
> > +       if (boollist)
> > +               free(boollist);
> > +       if (avc){
> > +               if (avc->handle)
> > +                       sepol_handle_destroy(avc->handle);
> > +               if (avc->policydb)
> > +                       sepol_policydb_free(avc->policydb);
> > +               free(avc);
> > +       }
> > +       if (pf)
> > +               sepol_policy_file_free(pf);
> > +       if (fp)
> > +               fclose(fp);
> > +       return 1;
> >  }
> >
> >  static PyObject *init(PyObject *self __attribute__((unused)), PyObject *args) {
> > --
> > 2.27.0
> >
