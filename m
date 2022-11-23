Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6634BC433FE
	for <selinux@archiver.kernel.org>; Wed, 23 Nov 2022 15:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbiKWPE5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Nov 2022 10:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiKWPEs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Nov 2022 10:04:48 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F47217074
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 07:04:47 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m22so43347260eji.10
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 07:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hylpjMQYM2Kd71WlPN4NMoLr7fKYkcWUOWB9gMVcIeM=;
        b=IUPm98ffsZSppvLARMXQPpWcft0SGLPlQVPbhz4k75BWldEdsNddvzAximdFk7LGJ2
         0nIbKop/sHwHsd0tB7F8JTCkgffLTnzCWdax6MZVEhAPGN3LkpuURt3yq48/sP/xmGUW
         owqS6L6tfXGvsrDFA/mX2TYbf2cpaSXzMwJZcQxDz/4KGW45uIpqrZgPO38C9MRugREi
         OODpyxmbplCmaegPqh5Nibq/PbHT1vtB08BROEaGio1uoGjN3bm0bXbqvoCjEKIujiWX
         Umn1ft5Y+gpNLGFoXMg4a3l6BSTZV6ie6AT6p+FmhhWrG60Em5Hz71ciQmkRMw8pL7q3
         7xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hylpjMQYM2Kd71WlPN4NMoLr7fKYkcWUOWB9gMVcIeM=;
        b=IZUF3YknGHCm5tvPd22gqOPg5jVfRtvdwlj6r12u1Z3Ty5B8d8MaN6iVj/bYbdFiTB
         +6zar23HJ+Pa2Vic5FYrIyyl9RB3Otf9SKjPeHx+sJnkYv1DvNV1kpaIqwP905u6EXGx
         Ff6C8JEywyXp56CFF/q/Pq0gfzZdhWlDM6hc5Emd0TCClXcoRaC8BFS8E1C7dGbfVjW3
         mXDZXQ7mdK1ovv2q8u0CkuVA7c4do+ynPclTigOfQzELpOC1Fw/swprgEPKXtrtAIiZK
         5I+jrpgrA3WJGDVuVWMmg6oZvsc5SeKtFbMOqBfRi/BUrTAfJd3cLpKvkVuc7c5zQEdr
         AejQ==
X-Gm-Message-State: ANoB5pnxgtoEy14yYhqGq4S31aXFQRFJcrgFr5XuL8fFFjqO8NsBUuUJ
        ye5+0utYzaclYQluv1mrwyRx5FH+obGd6iaMwskLpuqO
X-Google-Smtp-Source: AA0mqf4UczHqhxAdwXNv0bsiQ40z3xK3C/zcM/BxImWKGTxNLYquD7VdunTK9VR/gSMOIdGCPCGmttE6eV/ejr2ildU=
X-Received: by 2002:a17:906:38a:b0:7a7:1d4f:c7d9 with SMTP id
 b10-20020a170906038a00b007a71d4fc7d9mr12482376eja.402.1669215885713; Wed, 23
 Nov 2022 07:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20221118125153.453700-1-lautrbach@redhat.com> <CAP+JOzR6nuK1SOcS-ADGSQBTV7Go2V=7ybXcevJUCzEjaFTp4g@mail.gmail.com>
In-Reply-To: <CAP+JOzR6nuK1SOcS-ADGSQBTV7Go2V=7ybXcevJUCzEjaFTp4g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 23 Nov 2022 10:04:33 -0500
Message-ID: <CAP+JOzQo-MdS2Be4PeTaOvDiR357GDUG=QUy4sHXiKLa_vK+Vg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] python/sepolicy: Fix sepolicy manpage -w ...
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 21, 2022 at 9:58 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Nov 18, 2022 at 8:07 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
> >
> > Commit 7494bb1298b3 ("sepolicy: generate man pages in parallel")
> > improved sepolicy performance but broke `sepolicy manpage -w ...` as it
> > didn't collect data about domains and roles from ManPage() and so
> > HTMLManPages() generated only empty page. This is fixed now, domains
> > and roles are being collected and used for HTML pages.
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>
These three patches have been merged.
Thanks,
Jim

> > ---
> >
> > - v3: improved the result loop, based on Ondrej Mosnacek <omosnace@redhat.com>'s suggestion
> >
> >
> >  python/sepolicy/sepolicy.py         | 13 +++++++++++--
> >  python/sepolicy/sepolicy/manpage.py | 12 +++++-------
> >  2 files changed, 16 insertions(+), 9 deletions(-)
> >
> > diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> > index 733d40484709..82ff6af2bc2d 100755
> > --- a/python/sepolicy/sepolicy.py
> > +++ b/python/sepolicy/sepolicy.py
> > @@ -332,9 +332,10 @@ def manpage_work(domain, path, root, source_files, web):
> >      from sepolicy.manpage import ManPage
> >      m = ManPage(domain, path, root, source_files, web)
> >      print(m.get_man_page_path())
> > +    return (m.manpage_domains, m.manpage_roles)
> >
> >  def manpage(args):
> > -    from sepolicy.manpage import HTMLManPages, manpage_domains, manpage_roles, gen_domains
> > +    from sepolicy.manpage import HTMLManPages, gen_domains
> >
> >      path = args.path
> >      if not args.policy and args.root != "/":
> > @@ -347,9 +348,17 @@ def manpage(args):
> >      else:
> >          test_domains = args.domain
> >
> > +    manpage_domains = set()
> > +    manpage_roles = set()
> >      p = Pool()
> > +    async_results = []
> >      for domain in test_domains:
> > -        p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web])
> > +        async_results.append(p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web]))
> > +    for result in async_results:
> > +        domains, roles = result.get()
> > +        manpage_domains.update(domains)
> > +        manpage_roles.update(roles)
> > +
> >      p.close()
> >      p.join()
> >
> > diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
> > index 3e61e333193f..de72cb6cda5f 100755
> > --- a/python/sepolicy/sepolicy/manpage.py
> > +++ b/python/sepolicy/sepolicy/manpage.py
> > @@ -21,7 +21,7 @@
> >  #                                        02111-1307  USA
> >  #
> >  #
> > -__all__ = ['ManPage', 'HTMLManPages', 'manpage_domains', 'manpage_roles', 'gen_domains']
> > +__all__ = ['ManPage', 'HTMLManPages', 'gen_domains']
> >
> >  import string
> >  import selinux
> > @@ -147,10 +147,6 @@ def _gen_types():
> >  def prettyprint(f, trim):
> >      return " ".join(f[:-len(trim)].split("_"))
> >
> > -# for HTML man pages
> > -manpage_domains = []
> > -manpage_roles = []
> > -
> >  fedora_releases = ["Fedora17", "Fedora18"]
> >  rhel_releases = ["RHEL6", "RHEL7"]
> >
> > @@ -408,6 +404,8 @@ class ManPage:
> >      """
> >      modules_dict = None
> >      enabled_str = ["Disabled", "Enabled"]
> > +    manpage_domains = []
> > +    manpage_roles = []
> >
> >      def __init__(self, domainname, path="/tmp", root="/", source_files=False, html=False):
> >          self.html = html
> > @@ -453,10 +451,10 @@ class ManPage:
> >          if self.domainname + "_r" in self.all_roles:
> >              self.__gen_user_man_page()
> >              if self.html:
> > -                manpage_roles.append(self.man_page_path)
> > +                self.manpage_roles.append(self.man_page_path)
> >          else:
> >              if self.html:
> > -                manpage_domains.append(self.man_page_path)
> > +                self.manpage_domains.append(self.man_page_path)
> >              self.__gen_man_page()
> >          self.fd.close()
> >
> > --
> > 2.38.1
> >
