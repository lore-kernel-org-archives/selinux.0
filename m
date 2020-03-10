Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD9BC18E5A
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 01:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A070024649
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 01:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="M9s9SqLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCJBCz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Mar 2020 21:02:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35424 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbgCJBCy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Mar 2020 21:02:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id a20so8317840edj.2
        for <selinux@vger.kernel.org>; Mon, 09 Mar 2020 18:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlnrI8vvkVvEBpQcjfC0eTRxPLxDgLwApwMvNTDpDAQ=;
        b=M9s9SqLFDSiMTrIqz5zT2m7yZLnqTdN4U7lMb3OaNvsCOcQKPAxZAv2+Srb56oBxUg
         YxD93hIitjU7HUD5+VTLYY2wkN/J/Yo8o908igHk/qpkpAARNwglU4P6HmgVa/FuQzWU
         t8dyvHllCr/jh6A38B0SPWsN/dcPTGQ/g5/4iBjhAyjpc46cN086UFo0yaLb4rtUZfpd
         7KmSEjLp/rpzT5y9Eb1BzZuUa/35LDNAgUc70DilF3pXoAlpGI1M4imTIGr1u0S9cjMC
         v+sF6QM51oneiJgW2nC+YL3crC4N1nIeUSIy1jvsKOxhZdi8MfpTjE4Pk9XbOPSk3JhM
         uefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlnrI8vvkVvEBpQcjfC0eTRxPLxDgLwApwMvNTDpDAQ=;
        b=eepreVbFnolNEzQR4blyhxZKrHchZrJ0MZfW9kr/x8z37vWDzyAralsfETT72aE7IZ
         fil8DTfg1zL0HjTZ8JmEFoGqgUeqyyLCs1Gy2gJEGczz/YPJiOfgHgmqkJAfxB2BCK2t
         UPk6I4tUDoB+8xJExPvwjdlLNEu2MFc+3oMPhcqT0bOcppszI+UJI/iS3vlolfLUlKDy
         TXwAhfil3vP084zNYNoqMbkbEwVkGGA0oAWitqs/s1UYW0ie2gLU6q9Bv/eAo00M3qv7
         c6pH1acbjP0OUcMSO1ea28HoFsbbyhDAMc8RlevRjf6D2Z/GG3DeHtJBXvGQzlMFyLYl
         Yl9Q==
X-Gm-Message-State: ANhLgQ0195kIH213cldf3ddmyWlXlfLipBrh0ZRVDZ/42Sz2LTvignDA
        vHC5vfJ37O++aHP1VO+zud6AMRgFQXP0mjXbhbS/
X-Google-Smtp-Source: ADFU+vuq6G+fBfE6JXTIa4+WYhXiu3eBbVQ+YUbWfVLoIf3A8FQXf65d0q5R+HxuDnI+1A3FVSl1SMiGEzn9qtTeCdA=
X-Received: by 2002:aa7:c1d3:: with SMTP id d19mr19560358edp.12.1583802172478;
 Mon, 09 Mar 2020 18:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200214234203.7086-1-casey@schaufler-ca.com> <20200214234203.7086-6-casey@schaufler-ca.com>
 <CAHC9VhQzSqbEh_RN3zqnhOqVMCjrKwGhyBXnYb8Du4LUq7=txQ@mail.gmail.com> <50b463c1-1ff1-caad-3e4c-6e822e1c4a7a@schaufler-ca.com>
In-Reply-To: <50b463c1-1ff1-caad-3e4c-6e822e1c4a7a@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Mar 2020 21:02:41 -0400
Message-ID: <CAHC9VhTAk7+Zuh6vcOd=9hb-5aWY6=Rgv2aVqnSCm1q+TCHNGA@mail.gmail.com>
Subject: Re: [PATCH v15 05/23] net: Prepare UDS for security module stacking
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 9, 2020 at 8:13 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/6/2020 2:14 PM, Paul Moore wrote:
> > On Fri, Feb 14, 2020 at 6:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Change the data used in UDS SO_PEERSEC processing from a
> >> secid to a more general struct lsmblob. Update the
> >> security_socket_getpeersec_dgram() interface to use the
> >> lsmblob. There is a small amount of scaffolding code
> >> that will come out when the security_secid_to_secctx()
> >> code is brought in line with the lsmblob.
> >>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >> Reviewed-by: John Johansen <john.johansen@canonical.com>
> >> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> cc: netdev@vger.kernel.org
> >> ---
> >>  include/linux/security.h |  7 +++++--
> >>  include/net/af_unix.h    |  2 +-
> >>  include/net/scm.h        |  8 +++++---
> >>  net/ipv4/ip_sockglue.c   |  8 +++++---
> >>  net/unix/af_unix.c       |  6 +++---
> >>  security/security.c      | 18 +++++++++++++++---
> >>  6 files changed, 34 insertions(+), 15 deletions(-)
> > ...
> >
> >> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> >> index 17e10fba2152..59af08ca802f 100644
> >> --- a/include/net/af_unix.h
> >> +++ b/include/net/af_unix.h
> >> @@ -36,7 +36,7 @@ struct unix_skb_parms {
> >>         kgid_t                  gid;
> >>         struct scm_fp_list      *fp;            /* Passed files         */
> >>  #ifdef CONFIG_SECURITY_NETWORK
> >> -       u32                     secid;          /* Security ID          */
> >> +       struct lsmblob          lsmblob;        /* Security LSM data    */
> >>  #endif
> >>         u32                     consumed;
> >>  } __randomize_layout;
> > This might be a problem.  As it currently stands, the sk_buff.cb field
> > is 48 bytes; with CONFIG_SECURITY_NETWORK=n unix_skb_parms is 28 bytes
> > on a 64-bit system.  That leaves 20 bytes (room for 5 LSMs) assuming a
> > tight packing *and* that netdev doesn't swoop in and drop another few
> > fields in unix_skb_parms.
> >
> > This may work now, and you might manage to sneak this by the netdev
> > crowd, but I predict problems in the future.
>
> Do you think that making this a struct lsmblob * instead would make
> the change more likely to be accepted? It would complicate the code
> but remove the issue.

I honestly have no idea anymore when it comes to the netdev crowd.  I
can toss out a few examples, but you've been in this space long enough
to have seen the same things I have wrt to LSMs and the networking
folks.

Regardless of the implementation, I don't think you can embed the
lsmblob struct in the skb.cb; room for five LSMs is likely going to be
a limiting factor.  Once you settle on that, no matter what you do for
a reference, pointer/index/etc., the problems are all roughly the
same.  The trick is to find out what netdev will begrudgingly accept,
and for that I'm afraid you'll need to ask them directly.

-- 
paul moore
www.paul-moore.com
