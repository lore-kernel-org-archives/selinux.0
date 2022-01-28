Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E6BC433EF
	for <selinux@archiver.kernel.org>; Fri, 28 Jan 2022 01:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345183AbiA1Bxx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345179AbiA1Bxw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 20:53:52 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE7DC061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 17:53:52 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so6745280edn.0
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 17:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BksNA5S+udLGQFWNRur5mtnPIKBdIcol8nSGG5bpXY=;
        b=esFdDFaph7U2Rhf8i8w3+GyDTK6bATgu1eQZApvy6tgZyeZBVZ7S4iK+i2giHzgGhO
         C7PUaMmiPxLx67rOjRLEeZldRdYhwyyvoGxWfvcH6f1RiTJgwR6t5mAdS8sD5BVB4EpV
         E20LFd2HnHzKT/ImQj64oOerKbFxOkV3btqw5VbEuGjk7MsOZIk4npq9GVROJzQcifbP
         eon219Ij8PPL4e1a3eus6YcSuUS0gs8FeO5Gfacwn857JqMcgwxwH8J2S0IXI+l2YREs
         J4xPMeiqMkTJo9tipGj1cVHTG4HuQ7xL5gmDYDXd0Qgz9DGF6mGrQnuiK6S/M9SXJNa/
         5Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BksNA5S+udLGQFWNRur5mtnPIKBdIcol8nSGG5bpXY=;
        b=PziDHCu5Yv1xwZWAT8L0WRV1Fls1pyFyFs5iWaLXT5twZp7BBiXEs3GPOyH8MhGZc7
         dBqV6vJvREIV4nrTZNbZmmWQPB8rv9FjMTNmdqfbaYmfsU/P+zkJ+LZ0RJUIDORa55Fc
         jNsENMncXdfhJr431PxSsc8q6x8PrmaMWDmHs4Y+NnHuoxQyk2N7iKfF+6EVBvzSf1nF
         ae6C2hCYapSxCBkFWrpd52sVR0gM8f/oY36bb5L/7ch5rqqxbczymRm2pwDdwPB3t63t
         lTOSYgOxoBYY6PWzMpwJY3aT+mHug2IDjgQeaOswcflSvr3dhWhEq1BhMHECMNBDQiKh
         NePQ==
X-Gm-Message-State: AOAM5339gpwG7L0lk3aanzXiC2tJw9683BWA/UNprsfkH3FUb5nyF299
        +ANWbWPkuZKBTzv4Grm0frtUtvAxHdBh5vp0TMFA
X-Google-Smtp-Source: ABdhPJzS/fNYvMDz6oqEtIhz9NPgu0S5jmTalBOZ2xNAdzuLu5p/7iYGcqIQC9Hrn+co7coW1V3/d/BiY9Cpa3vTwNA=
X-Received: by 2002:a05:6402:4390:: with SMTP id o16mr5915559edc.343.1643334831162;
 Thu, 27 Jan 2022 17:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAHC9VhT2RhnXtK3aQuDCFUr5qayH25G8HHjRTJzhWM3H41YNog@mail.gmail.com>
 <YfAz0EAim7Q9ifGI@aion.usersys.redhat.com> <CAHC9VhTwXUE9dYBHrkA3Xkr=AgXvcnfSzLLBJ4QqYd4R+kFbbA@mail.gmail.com>
 <YfBGx+M9jQZa80rZ@aion.usersys.redhat.com> <CAHC9VhRoWbnV-cs2HzmiTEd7_kP914stdVpN9Tm2-6uua2-ELA@mail.gmail.com>
 <YfGyFhA0ZQPagROG@aion.usersys.redhat.com>
In-Reply-To: <YfGyFhA0ZQPagROG@aion.usersys.redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Jan 2022 20:53:40 -0500
Message-ID: <CAHC9VhTOT-XfOQvjowGpOcG_S-hSoKZtGMwhwVZy05VHMyv3zA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 26, 2022 at 3:42 PM Scott Mayhew <smayhew@redhat.com> wrote:
> On Tue, 25 Jan 2022, Paul Moore wrote:
> > On Tue, Jan 25, 2022 at 1:51 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > On Tue, 25 Jan 2022, Paul Moore wrote:
> > > > On Tue, Jan 25, 2022 at 12:31 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > > > On Mon, 24 Jan 2022, Paul Moore wrote:
> > > > > > On Thu, Jan 20, 2022 at 4:50 PM Scott Mayhew <smayhew@redhat.com> wrote:

...

> Sorry for being unclear.  The parts where the sids are (potentially)
> being parsed are inside an "if (opts) { ... }" block... but later in the
> function those sids are used in various tests/assignments.  So if we
> wanted to eliminate the four local context_sid variables (using the
> variables in opts instead), then there would need to be additional
> checks to avoid dereferencing opts when it's NULL.

Okay, gotcha.  I think keeping the local variables is the right thing
to do.  My apologies for not noticing that earlier.

-- 
paul-moore.com
