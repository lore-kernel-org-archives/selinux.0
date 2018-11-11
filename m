Return-Path: <SRS0=1+jG=NW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80684C43441
	for <selinux@archiver.kernel.org>; Sun, 11 Nov 2018 20:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF5920869
	for <selinux@archiver.kernel.org>; Sun, 11 Nov 2018 20:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF5920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeKLGhy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:37:54 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:36508 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeKLGhx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Nov 2018 01:37:53 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2BB2756121E
        for <selinux@vger.kernel.org>; Sun, 11 Nov 2018 21:48:15 +0100 (CET)
Received: by mail-oi1-f177.google.com with SMTP id u130-v6so5596682oie.7
        for <selinux@vger.kernel.org>; Sun, 11 Nov 2018 12:48:15 -0800 (PST)
X-Gm-Message-State: AGRZ1gJQ6rIdJI0Ye3EVgC+jkhleKdU2xMCWZIA2uNNqoPb8RiprCXHn
        51XlDlqwWV0BG4ntuevTvdMg51QB93smIP9rWiw=
X-Google-Smtp-Source: AJdET5fUOA2sqUen3O+CXofucmDI56UWmr3uRjLPDGboJWnz7H6zzINadDiTm/adwEt+ru73cxmIZI3HPbYcp9VphAw=
X-Received: by 2002:aca:5747:: with SMTP id l68-v6mr10201830oib.200.1541969294130;
 Sun, 11 Nov 2018 12:48:14 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7==UCR-a=mfLY1TRad++g+nbpZ6QMxFz5N6JV5_W6QomDQ@mail.gmail.com>
 <20181030152629.7438-1-vmojzis@redhat.com> <20181030152629.7438-2-vmojzis@redhat.com>
 <CAJfZ7==a_f6sJhHRwec1MkU70uOXZ0CLEqy7qK-53titStTWUQ@mail.gmail.com> <38deb58a-f063-58ff-6178-9e8d4c7ab946@redhat.com>
In-Reply-To: <38deb58a-f063-58ff-6178-9e8d4c7ab946@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 11 Nov 2018 21:48:02 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=m6-h2zr=iZwhjhR0+eshZ7ZJ2POayLMbw-E4+vuVhf9w@mail.gmail.com>
Message-ID: <CAJfZ7=m6-h2zr=iZwhjhR0+eshZ7ZJ2POayLMbw-E4+vuVhf9w@mail.gmail.com>
Subject: Re: [PATCH] python: replace aliases with corresponding type names
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Nov 11 21:48:15 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 9, 2018 at 9:53 AM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> On 05. 11. 18 21:51, Nicolas Iooss wrote:
> > On Tue, Oct 30, 2018 at 4:27 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> >> Aliases are not used in the selinux database. When user enters a type
> >> alias as a parameter it should be converted to the corresponding type
> >> in order to be processed correctly further in the userspace logic.
> >>
> >> Fixes e.g.:
> >>
> >> \#sepolicy transition -s phpfpm_t
> >> /* where phpfpm_t is a type alias of httpd_t */
> >>
> >> Traceback (most recent call last):
> >>    File "/usr/bin/sepolicy", line 691, in <module>
> >>      args.func(args)
> >>    File "/usr/bin/sepolicy", line 458, in transition
> >>      mytrans = setrans(args.source, args.target)
> >>    File "/usr/lib/python3.6/site-packages/sepolicy/transition.py", line 48, in __init__
> >>      self._process(self.source)
> >>    File "/usr/lib/python3.6/site-packages/sepolicy/transition.py", line 54, in _process
> >>      trans = _get_trans(source)
> >>    File "/usr/lib/python3.6/site-packages/sepolicy/transition.py", line 36, in _get_trans
> >>      src_list = [src] + list(filter(lambda x: x['name'] == src, sepolicy.get_all_types_info()))[0]['attributes']
> >> IndexError: list index out of range
> >> ---
> >>   python/semanage/seobject.py          | 43 ++++++++++++++++++++--------
> >>   python/sepolicy/sepolicy.py          | 11 ++++---
> >>   python/sepolicy/sepolicy/__init__.py | 14 ++++-----
> >>   3 files changed, 45 insertions(+), 23 deletions(-)
> >>
> > [...]
> >> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> >> index b18683e4..7db43957 100644
> >> --- a/python/sepolicy/sepolicy/__init__.py
> >> +++ b/python/sepolicy/sepolicy/__init__.py
> >> @@ -172,7 +172,7 @@ def info(setype, name=None):
> >>           results = list(q.results())
> >>
> >>           if name and len(results) < 1:
> >> -            # type not found, try alias
> >> +            #type not found, try alias
> >>               q.name = None
> >>               q.alias = name
> >>               results = list(q.results())
> > Hi, your patch looks good to me, but the comments you are using do not
> > follow PEP-8 (https://www.python.org/dev/peps/pep-0008/#block-comments)
> > and raise warnings in some linters that I am using. For example,
> > flake8 reports:
> >
> > python/sepolicy/sepolicy/__init__.py:172:13: E265 block comment should
> > start with '# '
> > python/sepolicy/sepolicy/__init__.py:1072:9: E265 block comment should
> > start with '# '
> >
> > I would like to apply the patch with the spaces added between "#" and
> > the comment line. Does it suits you?
>
>
> Sure, whatever needs fixing.
>
> Thank you :)

All right, I merged this patch. Thanks!
Nicolas

