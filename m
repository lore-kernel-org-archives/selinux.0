Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFDDC6FD18
	for <selinux@archiver.kernel.org>; Tue, 28 Mar 2023 20:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjC1UUK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjC1UUI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Mar 2023 16:20:08 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380333C19
        for <selinux@vger.kernel.org>; Tue, 28 Mar 2023 13:20:07 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id e65so16691376ybh.10
        for <selinux@vger.kernel.org>; Tue, 28 Mar 2023 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680034806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTUjsnH0pjAMPCdWUs8KgtrmbEQ7uRQfh39xHtc1mOI=;
        b=ZISzzUBAp2B86WTvie3LaaTm+XXMV1NsBYT+ss9Ay2P2TZV18c736vvSEzIoAMgiAD
         yyMfrBITnvGzSe0zitTngdlv9FE5B7kqtcVHa5dUfi5qBhCuM018z5BcpYSoI7bEVt2z
         ZC3kowL2cQRNQzFOhwJRwPeyH2MQqrp8NURsIr5JDzQpyL3WseVUnD7mAC626z6TQglg
         UoOeDKCOiKNAkc7HGHrpOlFtTEimlh5Dg4uX3bQo4lcrs02hnNHTYJq/Kw3dPuYr2VQI
         hXkP49aeyOtDyuAYueE49r0lldY98MycnxQ5Y1KBuHU/CwgwrBTDgx/qGu38MPY3mDw7
         CiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680034806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTUjsnH0pjAMPCdWUs8KgtrmbEQ7uRQfh39xHtc1mOI=;
        b=bxORf58fbKBPLtuaXj9MstLEGwlxaUUShTAtfh7W4NouGoewl2QnzCEDmkregO32E7
         J+mmzOM5OEP42if4SevANRMql9oHQyh9c0cuf+nmom202wz76Cu85Az2W+IGmvmS9k51
         MvN3RLnfTD1NU9XnXPJfwlI1+QqykgncAacuqdYEmPXaY2nxYSZkn63GskzZIJV4LwX6
         WDGGmsX6griRpYwXe+3WM/f0MU1lE/0Xsw9VVR6mEkW8Bl3V7+0jQaPCD3aTSaxyva1p
         dbK8vwk69gCWimx2qUEDf1rQahY+4hAHw7rHR49W/GxofHfiN66pb86Ya/Z3SyowrFzL
         mnmg==
X-Gm-Message-State: AAQBX9dBNdaHBQ6woqteN1ZjMm5uy8nscx3HrwQBfsMLIXhuMRS7Yf58
        ozmvIKs6NAIY5bLvxesO6giED9olhBtU1LE4scsQ
X-Google-Smtp-Source: AKy350ZEFOCwjRsMkv4tCJSQFPlfwfLVNNFZyIK63atBOV/sH54NXrYaRWqhboUJbp5+ys+9+LucpxgK3fri3wARgIs=
X-Received: by 2002:a05:6902:102a:b0:b71:f49f:8d22 with SMTP id
 x10-20020a056902102a00b00b71f49f8d22mr8605060ybt.3.1680034806304; Tue, 28 Mar
 2023 13:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com>
 <20230314081720.4158676-5-roberto.sassu@huaweicloud.com> <CAHC9VhTD3EyDiJs9+NQrgp84JcUs_sx8WONtRk2YYH4m1C8nVw@mail.gmail.com>
 <939e6c88662ad90b963993c4cc1b702083e74a7a.camel@huaweicloud.com>
 <ffc86b3907f7b87d3c568ae62bea3cdb3275be4e.camel@huaweicloud.com>
 <CAHC9VhRNjvjMOF5KLM6BoGfk=QpEBs_ur_CgRdGL5R1bA-JAwg@mail.gmail.com>
 <8b63d00d8ac3f686e51889ea4fc8d83f8ecb300d.camel@huaweicloud.com>
 <CAHC9VhRaKtsM=CuNhDy0Kx0NGSUrVhG+MhwKnHiyJxfgUwx7nA@mail.gmail.com> <1e08006f9011efa48deaf656c358ca3d438b9768.camel@huaweicloud.com>
In-Reply-To: <1e08006f9011efa48deaf656c358ca3d438b9768.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Mar 2023 16:19:55 -0400
Message-ID: <CAHC9VhRNWeZtxain_Hi-EfS49Vac8_vg7KRRyV4a9Sq3XPhZsg@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 28, 2023 at 3:47=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Mon, 2023-03-27 at 17:02 -0400, Paul Moore wrote:
> > On Mon, Mar 27, 2023 at 3:30=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Fri, 2023-03-24 at 17:39 -0400, Paul Moore wrote:
> > > > On Fri, Mar 24, 2023 at 9:26=E2=80=AFAM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > On Fri, 2023-03-24 at 11:18 +0100, Roberto Sassu wrote:
> > > > > > On Thu, 2023-03-23 at 20:09 -0400, Paul Moore wrote:
> > > > > > > On Tue, Mar 14, 2023 at 4:19=E2=80=AFAM Roberto Sassu
> > > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>

...

> > Okay, that's fair, but we could still pass the full xattrs array and a
> > reference to the current count which could be both read and updated by
> > the individual LSMs, right?
>
> Yes, we could do.
>
> > The issue is that the separate compaction stage is not something we
> > want to have to do if we can avoid it.  Maybe we're stuck with it, but
> > I'm not yet convinced that we can't make some minor changes to the
> > LSMs to avoid the compaction step.
>
> I liked more the idea that LSMs do what they are most familiar with,
> get an offset in a security blob or, in this case, a starting slot in
> the new_xattrs array, and write there.
>
> v3 had the lsm_find_xattr_slot() helper, to get the starting slot, but
> somehow I find it less intuitive.
>
> Ok, if you prefer to avoid the compaction stage, I will rewrite this
> patch.

My concern is having to look through the xattr array after each LSM
has been run and in at least one case having to then do a memcpy() to
keep the array packed.  There are some cases where there is no way to
avoid all that extra work, but here I think we have the LSMs do the
Right Thing with respect to packing the xattr array without overly
burdening the individual LSMs.

Does that make sense?  It basically comes down to being smart about
our abstractions and both selectively, and carefully, breaking them
when there is a reasonable performance gain to be had.

--=20
paul-moore.com
