Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24A1C4332F
	for <selinux@archiver.kernel.org>; Thu, 17 Nov 2022 18:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiKQSgU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiKQSgT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Nov 2022 13:36:19 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F28F53
        for <selinux@vger.kernel.org>; Thu, 17 Nov 2022 10:36:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b3so4253102lfv.2
        for <selinux@vger.kernel.org>; Thu, 17 Nov 2022 10:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nYZho7annDKmej/9sH87pMuoVwCtrnLLDmeOrVUdLJs=;
        b=Zp5oswy2Bu4yIB70jjY8ZMA2LGQye/qmwPds9OrjgUcYzhe2A+147/DTwrHzPRpZOm
         UQ1ZM7Gnj/XuNYkc6BLjwM4XZ5xFGbwAh01FXrdVFL+gwe9kb0Q4j+sBa2TP+eRnJkIL
         nQYDNs7C54ULleT4pCmWYUMqP6G+4Y7sWavKkqQbx62UbKnoUPU7sZswjiRzqNnn3SUJ
         ehipvYHL2kkF12gtmAp0VtfI+T0AuStgS74l6WPiFhz4fZXkxvm6LOz+rBtwJ50bWn8u
         UfclojHE54lS/esXzcNZ+NZzPXnqAZqnH3TWKCJuHeAO0kEgbSj5/R125PdbPQbXAwF8
         myjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYZho7annDKmej/9sH87pMuoVwCtrnLLDmeOrVUdLJs=;
        b=pJ64VrTrOCKI7Q34QOZVcn+TcpDoSs4CAaUb6w1w0CQ326qswp3mqlwf4083pJh4M7
         val+riMSH9aZ7GQEjnJiIOqu5E9A6/myFLpMWPcxb1DK96Gk13ysOGUFYMTTEv/dft97
         pv7DAcsVdT3w/hEFl/6QVPngtqQUIPqJmiTGDl5ARAaQO1xx2orUVsuSe9ipowRAQyTK
         K/jInQbyEELfoPzRb/X/s/01OWqiWchPwRe71D6hHjPXc8Z/jvLEZvR94VPWNi2AInSB
         jqhkAID83XY+PoszGk4ftPcxIOk3n7a7p1QBwILbJGFoOaFbwUpGkMQQ/KyUaIELAEHQ
         NT8g==
X-Gm-Message-State: ANoB5pmIdmwKdn73N8RmJ/XyIAq2Xw1LwH+xs8unByxddr3dVhKmTOIF
        bteXN06OO5anQNBLuxPgVhu3vZpzfvEyT0EfgWM=
X-Google-Smtp-Source: AA0mqf5zh8UtMU+PIebHfiRqILb1ZGpO8m7hMpx39HqNBg+0OyGmWrRLl/P4SSnelenFguVoDiDkFhsE/sw8UBgOPZo=
X-Received: by 2002:ac2:5de5:0:b0:499:4f:2582 with SMTP id z5-20020ac25de5000000b00499004f2582mr1494578lfq.515.1668710176732;
 Thu, 17 Nov 2022 10:36:16 -0800 (PST)
MIME-Version: 1.0
References: <20221115194552.338640-1-plautrba@redhat.com> <CAP+JOzSM8QkAKiKVk+dUFagFu-zJ2GCzcjnY0mYqX3Hh=p7AUA@mail.gmail.com>
 <87mt8p21rf.fsf@redhat.com>
In-Reply-To: <87mt8p21rf.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 17 Nov 2022 13:36:05 -0500
Message-ID: <CAP+JOzRPcDVuYwnXu6=3ruLk0L=_QrhOg-mG0n=QGLE01YkAfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] python/sepolicy: Fix sepolicy manpage -w ...
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 17, 2022 at 7:39 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Tue, Nov 15, 2022 at 2:58 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >>
> >> From: Petr Lautrbach <lautrbach@redhat.com>
> >>
> >> Commit 7494bb1298b3 ("sepolicy: generate man pages in parallel")
> >> improved sepolicy performance but broke `sepolicy manpage -w ...` as it
> >> didn't collect data about domains and roles from ManPage() and so
> >> HTMLManPages() generated only empty page. This is fixed now, domains
> >> and roles are being collected and used for HTML pages.
> >>
> >> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> >
> > I ran `sepolicy manpage -w -d unconfined_t` and received the following error:
> > """
> > Traceback (most recent call last):
> >   File "/usr/lib64/python3.10/multiprocessing/pool.py", line 125, in worker
> >     result = (True, func(*args, **kwds))
> >   File "/home/jim/local/usr/bin/./sepolicy", line 335, in manpage_work
> >     return (m.manpage_domains, m.manpage_roles)
> > AttributeError: 'ManPage' object has no attribute 'manpage_domains'
> > """
> >
>
> I think you nee to remove "-Es" command line options from /home/jim/local/usr/bin/./sepolicy
>
>     sed -i '1s/ -Es//' /home/jim/local/usr/bin/./sepolicy
>

That worked.
Thanks,
Jim

>
> > I don't get the error from the master branch, but I do confirm the bug
> > you reported above.
> >
> > Thanks,
> > Jim
> >
> >> ---
> >>  python/sepolicy/sepolicy.py         | 13 +++++++++++--
> >>  python/sepolicy/sepolicy/manpage.py | 12 +++++-------
> >>  2 files changed, 16 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> >> index 733d40484709..2ca02ee9a0cf 100755
> >> --- a/python/sepolicy/sepolicy.py
> >> +++ b/python/sepolicy/sepolicy.py
> >> @@ -332,9 +332,10 @@ def manpage_work(domain, path, root, source_files, web):
> >>      from sepolicy.manpage import ManPage
> >>      m = ManPage(domain, path, root, source_files, web)
> >>      print(m.get_man_page_path())
> >> +    return (m.manpage_domains, m.manpage_roles)
> >>
> >>  def manpage(args):
> >> -    from sepolicy.manpage import HTMLManPages, manpage_domains, manpage_roles, gen_domains
> >> +    from sepolicy.manpage import HTMLManPages, gen_domains
> >>
> >>      path = args.path
> >>      if not args.policy and args.root != "/":
> >> @@ -347,9 +348,17 @@ def manpage(args):
> >>      else:
> >>          test_domains = args.domain
> >>
> >> +    manpage_domains = set()
> >> +    manpage_roles = set()
> >>      p = Pool()
> >> +    async_results = []
> >>      for domain in test_domains:
> >> -        p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web])
> >> +        async_results.append(p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web]))
> >> +    results = map(lambda x: x.get(), async_results)
> >> +    for result in results:
> >> +        manpage_domains.update(set(result[0]))
> >> +        manpage_roles.update(set(result[1]))
> >> +
> >>      p.close()
> >>      p.join()
> >>
> >> diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
> >> index 3e61e333193f..de72cb6cda5f 100755
> >> --- a/python/sepolicy/sepolicy/manpage.py
> >> +++ b/python/sepolicy/sepolicy/manpage.py
> >> @@ -21,7 +21,7 @@
> >>  #                                        02111-1307  USA
> >>  #
> >>  #
> >> -__all__ = ['ManPage', 'HTMLManPages', 'manpage_domains', 'manpage_roles', 'gen_domains']
> >> +__all__ = ['ManPage', 'HTMLManPages', 'gen_domains']
> >>
> >>  import string
> >>  import selinux
> >> @@ -147,10 +147,6 @@ def _gen_types():
> >>  def prettyprint(f, trim):
> >>      return " ".join(f[:-len(trim)].split("_"))
> >>
> >> -# for HTML man pages
> >> -manpage_domains = []
> >> -manpage_roles = []
> >> -
> >>  fedora_releases = ["Fedora17", "Fedora18"]
> >>  rhel_releases = ["RHEL6", "RHEL7"]
> >>
> >> @@ -408,6 +404,8 @@ class ManPage:
> >>      """
> >>      modules_dict = None
> >>      enabled_str = ["Disabled", "Enabled"]
> >> +    manpage_domains = []
> >> +    manpage_roles = []
> >>
> >>      def __init__(self, domainname, path="/tmp", root="/", source_files=False, html=False):
> >>          self.html = html
> >> @@ -453,10 +451,10 @@ class ManPage:
> >>          if self.domainname + "_r" in self.all_roles:
> >>              self.__gen_user_man_page()
> >>              if self.html:
> >> -                manpage_roles.append(self.man_page_path)
> >> +                self.manpage_roles.append(self.man_page_path)
> >>          else:
> >>              if self.html:
> >> -                manpage_domains.append(self.man_page_path)
> >> +                self.manpage_domains.append(self.man_page_path)
> >>              self.__gen_man_page()
> >>          self.fd.close()
> >>
> >> --
> >> 2.38.1
> >>
>
