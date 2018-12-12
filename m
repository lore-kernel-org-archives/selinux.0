Return-Path: <SRS0=wb4z=OV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599F5C04EB8
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F05E2084E
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 14:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F05E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbeLLOOd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:14:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbeLLOOd (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Dec 2018 09:14:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEE177F6A8;
        Wed, 12 Dec 2018 14:14:32 +0000 (UTC)
Received: from workstation (unknown [10.43.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F07C25ED48;
        Wed, 12 Dec 2018 14:14:31 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/1] python/semanage: do not show "None" levels when using a non-MLS policy
References: <20181209153702.24905-1-nicolas.iooss@m4x.org>
Date:   Wed, 12 Dec 2018 15:14:30 +0100
In-Reply-To: <20181209153702.24905-1-nicolas.iooss@m4x.org> (Nicolas Iooss's
        message of "Sun, 9 Dec 2018 16:37:02 +0100")
Message-ID: <pjdr2emde7t.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 12 Dec 2018 14:14:33 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> When MLS is disabled, "semanage export" shows records such as:
>
>     login -a -s sysadm_u -r 'None' me
>
> Prevent "semanage export" from displaying None or empty strings in level
> and categories arguments by checking them in all customized() methods.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

> ---
>  python/semanage/seobject.py | 44 +++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index b8c43efe0101..efec0a553f43 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -747,7 +747,10 @@ class loginRecords(semanageRecords):
>          l = []
>          ddict = self.get_all(True)
>          for k in sorted(ddict.keys()):
> -            l.append("-a -s %s -r '%s' %s" % (ddict[k][0], ddict[k][1], k))
> +            if ddict[k][1]:
> +                l.append("-a -s %s -r '%s' %s" % (ddict[k][0], ddict[k][1], k))
> +            else:
> +                l.append("-a -s %s %s" % (ddict[k][0], k))
>          return l
>  
>      def list(self, heading=1, locallist=0):
> @@ -1014,7 +1017,10 @@ class seluserRecords(semanageRecords):
>          l = []
>          ddict = self.get_all(True)
>          for k in sorted(ddict.keys()):
> -            l.append("-a -L %s -r %s -R '%s' %s" % (ddict[k][1], ddict[k][2], ddict[k][3], k))
> +            if ddict[k][1] or ddict[k][2]:
> +                l.append("-a -L %s -r %s -R '%s' %s" % (ddict[k][1], ddict[k][2], ddict[k][3], k))
> +            else:
> +                l.append("-a -R '%s' %s" % (ddict[k][3], k))
>          return l
>  
>      def list(self, heading=1, locallist=0):
> @@ -1292,10 +1298,11 @@ class portRecords(semanageRecords):
>          l = []
>          ddict = self.get_all(True)
>          for k in sorted(ddict.keys()):
> -            if k[0] == k[1]:
> -                l.append("-a -t %s -r '%s' -p %s %s" % (ddict[k][0], ddict[k][1], k[2], k[0]))
> +            port = k[0] if k[0] == k[1] else "%s-%s" % (k[0], k[1])
> +            if ddict[k][1]:
> +                l.append("-a -t %s -r '%s' -p %s %s" % (ddict[k][0], ddict[k][1], k[2], port))
>              else:
> -                l.append("-a -t %s -r '%s' -p %s %s-%s" % (ddict[k][0], ddict[k][1], k[2], k[0], k[1]))
> +                l.append("-a -t %s -p %s %s" % (ddict[k][0], k[2], port))
>          return l
>  
>      def list(self, heading=1, locallist=0):
> @@ -1549,10 +1556,11 @@ class ibpkeyRecords(semanageRecords):
>          ddict = self.get_all(True)
>  
>          for k in sorted(ddict.keys()):
> -            if k[0] == k[1]:
> -                l.append("-a -t %s -r '%s' -x %s %s" % (ddict[k][0], ddict[k][1], k[2], k[0]))
> +            port = k[0] if k[0] == k[1] else "%s-%s" % (k[0], k[1])
> +            if ddict[k][1]:
> +                l.append("-a -t %s -r '%s' -x %s %s" % (ddict[k][0], ddict[k][1], k[2], port))
>              else:
> -                l.append("-a -t %s -r '%s' -x %s %s-%s" % (ddict[k][0], ddict[k][1], k[2], k[0], k[1]))
> +                l.append("-a -t %s -x %s %s" % (ddict[k][0], k[2], port))
>          return l
>  
>      def list(self, heading=1, locallist=0):
> @@ -1793,7 +1801,10 @@ class ibendportRecords(semanageRecords):
>          ddict = self.get_all(True)
>  
>          for k in sorted(ddict.keys()):
> -            l.append("-a -t %s -r '%s' -z %s %s" % (ddict[k][0], ddict[k][1], k[1], k[0]))
> +            if ddict[k][1]:
> +                l.append("-a -t %s -r '%s' -z %s %s" % (ddict[k][0], ddict[k][1], k[1], k[0]))
> +            else:
> +                l.append("-a -t %s -z %s %s" % (ddict[k][0], k[1], k[0]))
>          return l
>  
>      def list(self, heading=1, locallist=0):
> @@ -2033,7 +2044,10 @@ class nodeRecords(semanageRecords):
>          l = []
>          ddict = self.get_all(True)
>          for k in sorted(ddict.keys()):
> -            l.append("-a -M %s -p %s -t %s -r '%s' %s" % (k[1], k[2], ddict[k][2], ddict[k][3], k[0]))
> +            if ddict[k][3]:
> +                l.append("-a -M %s -p %s -t %s -r '%s' %s" % (k[1], k[2], ddict[k][2], ddict[k][3], k[0]))
> +            else:
> +                l.append("-a -M %s -p %s -t %s %s" % (k[1], k[2], ddict[k][2], k[0]))
>          return l
>  
>      def list(self, heading=1, locallist=0):
> @@ -2227,7 +2241,10 @@ class interfaceRecords(semanageRecords):
>          l = []
>          ddict = self.get_all(True)
>          for k in sorted(ddict.keys()):
> -            l.append("-a -t %s -r '%s' %s" % (ddict[k][2], ddict[k][3], k))
> +            if ddict[k][3]:
> +                l.append("-a -t %s -r '%s' %s" % (ddict[k][2], ddict[k][3], k))
> +            else:
> +                l.append("-a -t %s %s" % (ddict[k][2], k))
>          return l
>  
>      def list(self, heading=1, locallist=0):
> @@ -2609,7 +2626,10 @@ class fcontextRecords(semanageRecords):
>          fcon_dict = self.get_all(True)
>          for k in sorted(fcon_dict.keys()):
>              if fcon_dict[k]:
> -                l.append("-a -f %s -t %s -r '%s' '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], fcon_dict[k][3], k[0]))
> +                if fcon_dict[k][3]:
> +                    l.append("-a -f %s -t %s -r '%s' '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], fcon_dict[k][3], k[0]))
> +                else:
> +                    l.append("-a -f %s -t %s '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], k[0]))
>  
>          if len(self.equiv):
>              for target in self.equiv.keys():
