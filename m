Return-Path: <SRS0=KzaI=W7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80849C41514
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 22:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D3A2053B
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 22:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WfGIhJ/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfIDWdJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:33:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45737 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbfIDWdJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Sep 2019 18:33:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id l1so289937lji.12
        for <selinux@vger.kernel.org>; Wed, 04 Sep 2019 15:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgGexA4aZYbidVi99IBOmeiYvwlCH1G1/j5NPjadEes=;
        b=WfGIhJ/nPl3b6cZo7xGnWehIvQjqclKTNywqLZWgiaNm4Ft6U2O8SMYT/dGNbklFW4
         HfIIYpZtxlylkgqpklTn+0EkZI6UVkaVVMZ5AU65wjOF32GFvEGOiK/O57njdES2XMoD
         JXRhR91/NHRhXSQqiNnJHSjbjvBPWN1K4k2ietCUsO5yP79YbRv//TPHDxLxtCqvdgSQ
         ox1E1APK08gbEgzf1j+283sXIWnwlsKSpV8jHOe3nHiaXO5qyf+f0lKukd7k9Wedf7Tm
         MbG9/Q9cr11ogmgSJQhyWM4T0cXu8cMaYWJC2cFj0aewoFx6nZqppaYOWAJcIJ05UjZo
         cMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgGexA4aZYbidVi99IBOmeiYvwlCH1G1/j5NPjadEes=;
        b=a/mLa8RRMYKPfLSZGyD+Z+9jwIJ5jbdwXS1mcWfVHYESosDq6DevQ259M/LTyobB5e
         lB+QtCAWXHHyA/hOPl6HlW18pV20j8tyehJ8sPmkZtjWw08xOm7jQL+d9VWYwdkNrxC4
         4dVHVXxElP5tjXzdE2FlI1refdCKz3ohmxA1wW0Jtq+HPj2jkRTVDfl8ksz88R9pMqa5
         KlNn7pawbtNIhAwkRae9E8U0GzfNhLgcObl7Z8ysN+YR4CjBvv7hKHfIHX+DzC4ehaFg
         +y95pGt79r7VRq1VUfHkwsjk0HVyXGzt1PCWmLw8oDGFQoRqMyfuuhSVTeHhcCRq/0Wx
         mFHg==
X-Gm-Message-State: APjAAAWr6S2o38op3DxAnkT8kwaOT3p+ampL3BX5PZ4+wsBaqpAqBz6q
        raS5NY4oRxWhqAwAl88xuuV2FBFzIHM9CiqjnoSz
X-Google-Smtp-Source: APXvYqyjcsXkjEtw595UnzAPIOF/EGKdrSUAlvX6/ECJl37QgSNtEsq3/xHnmQVtsQoeQho9+g3nJjA0kN5DhifnNUM=
X-Received: by 2002:a2e:84c5:: with SMTP id q5mr9823ljh.158.1567636387058;
 Wed, 04 Sep 2019 15:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsdbgxSL1v04mouWw@mail.gmail.com>
 <CAHC9VhR1ZNyZqGB3Si-z77zLwaTBf-pkQk19rVqofs4P_oVtFg@mail.gmail.com>
 <CAHC9VhSKxgCB_j-eT65tSvqFDbBe_Wu_b+XsvN0Si2eDrEROMQ@mail.gmail.com>
 <5817f158-9ba2-420d-3a9e-59ee43be3472@mellanox.com> <9048b292-b9fa-49f7-d66e-1f0ceaa39290@tycho.nsa.gov>
In-Reply-To: <9048b292-b9fa-49f7-d66e-1f0ceaa39290@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Sep 2019 18:32:55 -0400
Message-ID: <CAHC9VhTiWg+ZP7p1ebDNFsfC5Lca1WaMGC-mbv1i9jR9E1pK+g@mail.gmail.com>
Subject: Re: IB pkey policy problem found via the selinux-testsuite
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel Jurgens <danielj@mellanox.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "selinux-refpolicy@vger.kernel.org" 
        <selinux-refpolicy@vger.kernel.org>,
        Lukas Vrabec <lvrabec@redhat.com>,
        Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 3, 2019 at 10:45 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 9/3/19 10:30 AM, Daniel Jurgens wrote:
> >
> > On 8/27/2019 12:24 PM, Paul Moore wrote:
> >> On Thu, Feb 28, 2019 at 4:58 PM Paul Moore <paul@paul-moore.com> wrote:
> >>> On Wed, Feb 13, 2019 at 4:35 PM Paul Moore <paul@paul-moore.com> wrote:
> >>>> Hello all,
> >>>>
> >>>> On a fully up-to-date Rawhide system you need the following line added
> >>>> to the policy/test_ibpkey.te file to get a clean run of the
> >>>> selinux-testsuite:
> >>>>
> >>>>    allow test_ibpkey_access_t self:capability { ipc_lock };
> >>>>
> >>>> The breakage doesn't appear to be due to a kernel change (previously
> >>>> working kernels now fail), or a Fedora Rawhide policy change (nothing
> >>>> relevant changed since the last clean run), but I did notice that my
> >>>> libibverbs package was updated just prior to the breakage.  I haven't
> >>>> had the time to dig into the library code, but I expect that to be the
> >>>> source of the problem.
> >>> Just to be clear, I don't believe this breakage is limited to the test
> >>> suite, I expect any users of the SELinux IB hooks will run into this
> >>> problem.  I believe we need to update the upstream and distro
> >>> policies.
> >> A ping to bring this issue back to the top of the mailing list.
> >
> > Hi Paul, I looked in the libraries and don't see explicit use of mlock. Maybe there was a change to use that access control for get_user_pages? That doesn't really jive with previously working kernels no longer working though.
>
> It would be useful to see the audit messages for that ipc_lock denial,
> including the SYSCALL record.
>
> There are a number of kernel operations that can trigger ipc_lock checks,
> https://elixir.bootlin.com/linux/latest/ident/CAP_IPC_LOCK
>
> Several of those are infiniband-specific.

Hi all,

Sorry for the delay in responding.  Here is what I see when running
the infiniband_pkey test on a current Fedora Rawhide system (run
individually to capture the output):

1..4
# Running under perl version 5.030000 for linux
# Current time local: Wed Sep  4 18:24:39 2019
# Current time GMT:   Wed Sep  4 22:24:39 2019
# Using Test.pm version 1.31
ok 1
Unable to create cq.
not ok 2
# Test 2 got: "256" (./test at line 50)
#   Expected: "0"
#  ./test line 50 is:     ok( $result, 0 );
Unable to create cq.
not ok 3
# Test 3 got: "1" (./test at line 71)
#   Expected: "13"
#  ./test line 71 is: if (@unlabeled_pkeys) {
ok 4

... and I see the following AVCs:

type=AVC msg=audit(1567635879.312:15018): avc:  denied  { ipc_lock } for
  pid=15726 comm="create_modify_q" capability=14
  scontext=unconfined_u:unconfined_r:test_ibpkey_access_t:s0-s0:c0.c1023
  tcontext=unconfined_u:unconfined_r:test_ibpkey_access_t:s0-s0:c0.c1023
  tclass=capability permissive=0
type=AVC msg=audit(1567635884.022:15020): avc:  denied  { ipc_lock } for
  pid=15732 comm="create_modify_q" capability=14
  scontext=unconfined_u:unconfined_r:test_ibpkey_access_t:s0-s0:c0.c1023
  tcontext=unconfined_u:unconfined_r:test_ibpkey_access_t:s0-s0:c0.c1023
  tclass=capability permissive=0

If I apply the workaround patch I mentioned earlier, the test succeeds
and the only AVC is a infiniband_pkey:access denial (which is expected
given the test).

--
paul moore
www.paul-moore.com
