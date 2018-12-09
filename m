Return-Path: <SRS0=r/KF=OS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F65FC07E85
	for <selinux@archiver.kernel.org>; Sun,  9 Dec 2018 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E2A20865
	for <selinux@archiver.kernel.org>; Sun,  9 Dec 2018 15:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E2A20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeLIPgP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 9 Dec 2018 10:36:15 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:50985 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeLIPgP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 9 Dec 2018 10:36:15 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 73D64564765
        for <selinux@vger.kernel.org>; Sun,  9 Dec 2018 16:36:12 +0100 (CET)
Received: by mail-oi1-f171.google.com with SMTP id y23so7093264oia.4
        for <selinux@vger.kernel.org>; Sun, 09 Dec 2018 07:36:12 -0800 (PST)
X-Gm-Message-State: AA+aEWZdDMy6CM1UbX1COw+kmGP31/JscHnjeVZfP/Co7S07cBSMENRH
        ugyQNKJL+I8M7xYa0b+gkDgKV8u8KpeVaX/FzLg=
X-Google-Smtp-Source: AFSGD/WEpRUjvH0o5UkH7JHxn7rDSQokkygBOe5ah1A3BqiRmGTZTkL7u+dCuEdg05W3CIWnV1LuUxGKlPDH8PVwuh0=
X-Received: by 2002:aca:e142:: with SMTP id y63mr5308090oig.314.1544369771535;
 Sun, 09 Dec 2018 07:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20181204163917.12949-1-vmojzis@redhat.com>
In-Reply-To: <20181204163917.12949-1-vmojzis@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 9 Dec 2018 16:36:00 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kMPF1SH-6bWaGjn6ZEAUVKAaCLb6MaoKe_qvT_y3SxXw@mail.gmail.com>
Message-ID: <CAJfZ7=kMPF1SH-6bWaGjn6ZEAUVKAaCLb6MaoKe_qvT_y3SxXw@mail.gmail.com>
Subject: Re: [PATCH] python/semanage: Include MCS/MLS range when exporting
 local customizations
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Dec  9 16:36:12 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 4, 2018 at 5:39 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/semanage/seobject.py | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index c4c65621..b8c43efe 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1293,9 +1293,9 @@ class portRecords(semanageRecords):
>          ddict = self.get_all(True)
>          for k in sorted(ddict.keys()):
>              if k[0] == k[1]:
> -                l.append("-a -t %s -p %s %s" % (ddict[k][0], k[2], k[0]))
> +                l.append("-a -t %s -r '%s' -p %s %s" % (ddict[k][0], ddict[k][1], k[2], k[0]))
>              else:
> -                l.append("-a -t %s -p %s %s-%s" % (ddict[k][0], k[2], k[0], k[1]))
> +                l.append("-a -t %s -r '%s' -p %s %s-%s" % (ddict[k][0], ddict[k][1], k[2], k[0], k[1]))
>          return l
>
>      def list(self, heading=1, locallist=0):
> @@ -1550,9 +1550,9 @@ class ibpkeyRecords(semanageRecords):
>
>          for k in sorted(ddict.keys()):
>              if k[0] == k[1]:
> -                l.append("-a -t %s -x %s %s" % (ddict[k][0], k[2], k[0]))
> +                l.append("-a -t %s -r '%s' -x %s %s" % (ddict[k][0], ddict[k][1], k[2], k[0]))
>              else:
> -                l.append("-a -t %s -x %s %s-%s" % (ddict[k][0], k[2], k[0], k[1]))
> +                l.append("-a -t %s -r '%s' -x %s %s-%s" % (ddict[k][0], ddict[k][1], k[2], k[0], k[1]))
>          return l
>
>      def list(self, heading=1, locallist=0):
> @@ -1793,7 +1793,7 @@ class ibendportRecords(semanageRecords):
>          ddict = self.get_all(True)
>
>          for k in sorted(ddict.keys()):
> -            l.append("-a -t %s -r %s -z %s %s" % (ddict[k][0], ddict[k][1], k[1], k[0]))
> +            l.append("-a -t %s -r '%s' -z %s %s" % (ddict[k][0], ddict[k][1], k[1], k[0]))
>          return l
>
>      def list(self, heading=1, locallist=0):
> @@ -2033,7 +2033,7 @@ class nodeRecords(semanageRecords):
>          l = []
>          ddict = self.get_all(True)
>          for k in sorted(ddict.keys()):
> -            l.append("-a -M %s -p %s -t %s %s" % (k[1], k[2], ddict[k][2], k[0]))
> +            l.append("-a -M %s -p %s -t %s -r '%s' %s" % (k[1], k[2], ddict[k][2], ddict[k][3], k[0]))
>          return l
>
>      def list(self, heading=1, locallist=0):
> @@ -2227,7 +2227,7 @@ class interfaceRecords(semanageRecords):
>          l = []
>          ddict = self.get_all(True)
>          for k in sorted(ddict.keys()):
> -            l.append("-a -t %s %s" % (ddict[k][2], k))
> +            l.append("-a -t %s -r '%s' %s" % (ddict[k][2], ddict[k][3], k))
>          return l
>
>      def list(self, heading=1, locallist=0):
> @@ -2609,7 +2609,7 @@ class fcontextRecords(semanageRecords):
>          fcon_dict = self.get_all(True)
>          for k in sorted(fcon_dict.keys()):
>              if fcon_dict[k]:
> -                l.append("-a -f %s -t %s '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], k[0]))
> +                l.append("-a -f %s -t %s -r '%s' '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], fcon_dict[k][3], k[0]))
>
>          if len(self.equiv):
>              for target in self.equiv.keys():
> --
> 2.17.2
>

When testing this on a system without MLS, it displayed "None", which
is quite ugly. As this behavior already exists in the code, I merged
your patch and will send one to produce a clean output on systems
without MLS.
Thanks!
Nicolas

