Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4B7C87FDD
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 16:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbjFHQAn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237680AbjFHQAf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Jun 2023 12:00:35 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC672D6D
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 09:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686239995; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=g6ssk39oXR9in+QP4BXmE/DrV1D2Qar6DKvSma/q2zxvKFZMLuLcR+cxk8qXAMHklYjokoRbZk0RZyBPHEkZmntEMkI2SIffmFoxqznH3mNyjoFpdarf+msphm7SDGmO0ZDOALw0W4BzYr8RgdsogzRsdHkSn7KDWa5sWWXXgcg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1686239995; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=2GJU8WzLRxNQLAgZtMU/6SAiw9RHff0iJ61lEftuIi8=; 
        b=FO/95VZSd65FsNsPCqwRPsD2m2a2FZLOcyBH7n6iH0PcOkxYRQfYWhZYj7elm+eP29Su30JrpJ0MlwlAAPKL9udbPQGfkRuHvcVcEqQ84t54izq1HpS6iuorEG3xht4W4VJFN/29UqBoJrEC9KD+jS4ZbLJ1C9k7ZsSnhUDHt5A=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686239995;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=2GJU8WzLRxNQLAgZtMU/6SAiw9RHff0iJ61lEftuIi8=;
        b=EjqMGTvbsRLU4rs31Pv2WJKPGTEdnHIL6zKVpNhDJoPBb6TsAc3K7qz630ZizMnN
        sLXW3J2ybmucui6QwIf9M1DKZ4cSUc0uFpQY2uet3jELisa3NyJYOtSQqW+p7E0xDua
        HkVUDCbL2wJz2bXrnzEkOHANa/IIsC10J+VWaGtA=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1686239993311704.1084574111043; Thu, 8 Jun 2023 17:59:53 +0200 (CEST)
Received: from jmarcin-t14s-01 (unknown [213.175.37.10])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 5956C2081F76;
        Thu,  8 Jun 2023 15:59:52 +0000 (UTC)
Date:   Thu, 8 Jun 2023 17:59:51 +0200
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH 2/5] selinux: move filename transitions to avtab
Message-ID: <20230608155951.osvhubn3zyqzx4ep@jmarcin-t14s-01>
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
 <20230531112927.1957093-3-juraj@jurajmarcin.com>
 <CAJ2a_DfHubNBa46kcGCsTfY2OmOCJkNMstFebERU3mXeEMajng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ2a_DfHubNBa46kcGCsTfY2OmOCJkNMstFebERU3mXeEMajng@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2023-06-02 15:13, Christian G=F6ttsche wrote:
> On Wed, 31 May 2023 at 13:32, Juraj Marcin <juraj@jurajmarcin.com> wrot=
e:
> >
> > Currently, filename transitions are stored separately from other type
> > enforcement rules. This leads to possibly sub-optimal performance and
> > makes further improvements cumbersome.
> >
> > This patch adds a symbol table of filename transitions to the transit=
ion
> > structure added to avtab in the previous patch. It also implements
> > functions required for reading and writing filename transitions in
> > kernel policy format and updates computation of new type to use filen=
ame
> > transitions embedded in avtab. Last but not least, it updates the
> > conflict check in the conditional avtab to account for empty transiti=
ons
> > in the non-conditional avtab.
> >
> > These changes are expected to cause higher memory usage, as now there
> > needs to be a filename transition structure for every stype. This pat=
ch
> > effectively undoes most of the commit c3a276111ea2 ("selinux: optimiz=
e
> > storage of filename transitions"), but this will be mitigated by
> > providing support for matching prefix/suffix of the filename for
> > filename transitions in future patches which will reduce to need to h=
ave
> > so many of them.
> >
> > On the other hand, the changes do not significantly slow down the
> > creation of new files.
> >
> > Kernel     | Mem   | Create test_tty | Create test_tty | osbench [1]
> >            | usage | (real time)     | (kernel time)   | create_files
> > -----------+-------+-----------------+-----------------+-------------=
-
> > reference  | 155MB |  1.3440 ms/file |  1.0071 ms/file | 10.6507 us/f=
ile
> > this patch | 198MB |  1.3912 ms/file |  1.0172 ms/file | 10.5567 us/f=
ile
> >
> > Create test_tty benchmark:
> >
> >     mknod /dev/test_tty c 4 1
> >     time for i in `seq 1 10000`; do
> >         mknod /dev/test_tty$i c 4 1
> >     done
> >
> > This benchmark should simulate the worst case scenario as many filena=
me
> > transitions affect files created in the /dev directory.
> >
> > [1] https://github.com/mbitsnbites/osbench
> >
> > Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> > ---

<snip>

> > diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.=
h
> > index 6c8eb7c379cf..162ef1be85e7 100644
> > --- a/security/selinux/ss/avtab.h
> > +++ b/security/selinux/ss/avtab.h
> > @@ -22,6 +22,7 @@
> >  #define _SS_AVTAB_H_
> >
> >  #include "security.h"
> > +#include "symtab.h"
> >
> >  struct avtab_key {
> >         u16 source_type;        /* source type */
> > @@ -49,6 +50,7 @@ struct avtab_key {
> >
> >  struct avtab_trans {
> >         u32 otype;              /* default resulting type of the new =
object */
> > +       struct symtab name_trans;       /* filename transitions */
>=20
> What about using a bare hashtab to save the 4 bytes for the unused
> nprim member (+padding)?
>=20
> Also what about instead of storing an extra allocated u32 in the
> tables use the pointer itself as value?

Hi

I have implemented both optimizations to see the gain in performance and
memory usage, here are the results:


[1] Fedora policy (format v33)
[2] Fedora policy without prefix/suffix rules (format v35)
[3] Fedora policy with prefix rules (format v35)
before - before optimizations
opt1   - replace symtab with hashtab
opt2   - storing u32 value in the hashtab directly instead of a pointer

 Test || Mem usage            || Policy load time
      || (MiB)                || (ms) =20
      || before | opt1 | opt2 || before | opt1 | opt2
------++--------+------+------++----------------------
 [1]  ||    202 |  198 |  199 ||    228 |  227 |  208
 [2]  ||    170 |  171 |  167 ||    120 |  114 |  107
 [3]  ||    164 |  161 |  161 ||     91 |  94  |   92

(Average values from 5 runs, measured 15 seconds after boot.)


As can be seen from the table, replacing the symtab with bare hashtab
does not seem to provide real world difference, but could be done easily
by adding helper functions to hashtab.c.

With Fedora policy, there were around 16.7k (combinations of src, tgt,
class) symtab tables, so replacing them with hashtab saves around 65 KiB
(+padding for each) in total.


However, even though storing the u32 value directly shows some small
difference in the loading time, I am not sure if it is worth it
considering the hacky nature of the optimization.

This optimization should in theory save around 900 KiB without prefix
rules [1][2] or 350 KiB with prefix rules [3] with Fedora policy.

>=20
> >  };
> >
> >  /*

<snip>


--=20
Juraj Marcin
