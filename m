Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDFFC77B7A
	for <selinux@archiver.kernel.org>; Thu,  1 Jun 2023 17:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjFARDN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFARDM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 13:03:12 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456D5136
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 10:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685638987; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=dgvH+3V9N66kmpe2d2DCyz7EfjCwsb6w2iar3KWh/ivrtJQ6cQfJRTK42Ci4VAlX9fLYMVo7lfoDHZItczXY7IFMggFtwjaHTIohgOm6QRBElOLU5kPsQU0fMmSynwu+ozN2DJeYZ7pmwtjo2oLesgvoE0FWPK72v6vncez27r0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685638987; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6CRZzQ7NDhNem3iRtqdr7C5h5DCcCDuWM4CA4iujKCo=; 
        b=MFbtK16/PwYKYrY+eNOvnAdTUUYSWr4AR3iqF0VpE13Op92BVYso5qbyG3NY4+/TwGms1uvHFvg9ho6sDgYJ/aim4YsXuKWkNsucngzG5TPtDf58AtpR0Sgo6aIFNQ/uE3SPapJStb/C/RGIYgFYWCZ8fvM+GH/U4pN3j0R1Xx8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685638987;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=6CRZzQ7NDhNem3iRtqdr7C5h5DCcCDuWM4CA4iujKCo=;
        b=LRyTV6oaBMkQ64TiFjdnbxtv1Zq3gmotUF2NmwPpNjBAbRqSptLfD7rXIziX4bu7
        SuUzCoVNN2H12pWXKFbkznFyYrTrk/u2AwkIQF11hE89EJ6r3TcugB/uq1WiytYCQtx
        wgfIFcq3WkCoYAKcvfqZTITNaRgMS831wkPcDQUw=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1685638985263141.66033061061626; Thu, 1 Jun 2023 19:03:05 +0200 (CEST)
Received: from jmarcin-t14s-01 (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 575732081F76;
        Thu,  1 Jun 2023 17:03:04 +0000 (UTC)
Date:   Thu, 1 Jun 2023 19:03:02 +0200
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 0/5] selinux: add prefix/suffix matching to filename type
 transitions
Message-ID: <20230601170302.nrhuay2wh44g6sh4@jmarcin-t14s-01>
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
 <CAHC9VhQZE9Qtsu=7N38sOjHkD=RS4GXsqHOcUgobsJOA+iq2_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhQZE9Qtsu=7N38sOjHkD=RS4GXsqHOcUgobsJOA+iq2_A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2023-05-31 18:24, Paul Moore wrote:
> On Wed, May 31, 2023 at 7:32=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin=
.com> wrote:
> >
> > Currently, filename transitions are stored separately from other type
> > enforcement rules and only support exact name matching. However, in
> > practice, the names contain variable parts. This leads to many
> > duplicated rules in the policy that differ only in the part of the na=
me,
> > or it is even impossible to cover all possible combinations.
> >
> > First, this series of patches moves the filename transitions to be pa=
rt
> > of the avtab structures. This not only makes the implementation of
> > prefix/suffix matching and future enhancements easier, but also reduc=
es
> > the technical debt regarding the filename transitions. Next, the last
> > patch implements the support for prefix/suffix name matching itself b=
y
> > extending the structures added in previous patches in this series.
> >
> > Even though, moving everything to avtab increases the memory usage an=
d
> > the size of the binary policy itself and thus the loading time, the
> > ability to match the prefix or suffix of the name will reduce the
> > overall number of rules in the policy which should mitigate this issu=
e.
> >
> > This implementation has been successfully tested using the existing a=
nd
> > also new tests in the SELinux Testsuite.
> >
> > Juraj Marcin (5):
> >   selinux: move transition to separate structure in avtab_datum
> >   selinux: move filename transitions to avtab
> >   selinux: implement new binary format for filename transitions in av=
tab
> >   selinux: filename transitions move tests
> >   selinux: add prefix/suffix matching support to filename type
> >     transitions
>=20
> Just a quick comment as I haven't had a chance to properly review this
> series yet; you show some memory usage and performance measurements in
> some of the intermediate patches, that's good, but I don't see the
> same measurements taken when the full patchset is applied.  Please
> provide the same memory usage and performance comparisons with the
> full patchset applied.

Of course, here are the measurements with the whole patchset applied.

I also included measurements with new policy (based on the Fedora
policy) that uses prefix filename transitions where possible. This new
policy has been generated by merging existing filename transitions into
prefix ones if it would reduce the number of transitions overall while
keeping the resulting type same.


[1] Reference kernel (c52df19e3759), Fedora policy (format v33)
[2] This patchset, Fedora policy (format v33)
[3] This patchset, Fedora policy without prefix/suffix rules (format v35)
[4] This patchset, Fedora policy with prefix rules (format v35)


 Test | Mem   | Binary | Policy | Create tty      | osbench
      | Usage | policy | load   |                 | create
      |       | size   | time   | (ms/file)       | files=20
      | (MiB) | (MiB)  | (ms)   | real   | kernel | (us/file)
------+-------+--------+--------+--------+--------+-----------
 [1]  |   157 |    3.4 |     78 | 1.1021 | 0.7586 | 7.8277
 [2]  |   200 |    3.4 |    206 | 1.1193 | 0.7724 | 8.2711
 [3]  |   169 |    5.8 |    106 | 1.1021 | 0.7724 | 8.0304
 [4]  |   164 |    3.8 |     86 | 1.1029 | 0.7586 | 7.9609


>=20
> --=20
> paul-moore.com

--=20
Juraj Marcin
