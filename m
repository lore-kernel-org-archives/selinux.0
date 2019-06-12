Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B954C31E46
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 14:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84AF2082C
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 14:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="jJwGnmum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfFLOd3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:33:29 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:37520 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfFLOd3 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Jun 2019 10:33:29 -0400
Received: from 34-41-5D-CA-59-C7 (82-203-159-32.bb.dnainternet.fi [82.203.159.32])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x5CEVvq5026127
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 17:31:57 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x5CEVvq5026127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1560349917;
        bh=FjHtTfYiG5wcdxHZL0awdD14tylS7q3nzqF6N7GxF3E=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jJwGnmumYeY4VoF2VCAri8VDalBcZ5UDU84oAPWebZq7O87luXmJlDc+G+W2TGCQA
         M+yl+J7Gq92PPKzhWsK4OHDRxLN5uLQ4k3RrzYsuD+1mLgEoNRNwVvd4sz3eUnvJcU
         bz7gAaBPsxXFJxAxDr2HGCXE4/BI9OvLB6shx9mqw8+9FIK06b0Hd0NY3elX+Q6Q/z
         00qs1lFXaBSNSO7I9A+4HpdjjM9ELBqYxhU7Lrh36X4sGrTbC7WBP2gQAXTBtleYH2
         u1C/mOLdnI0qUZCBS9FJqhOiccAGKqG5OYI1cZxDsqSncpkmkhTSpJqofaGZvn9cnm
         4leQSUoyiIxqw==
Date:   Wed, 12 Jun 2019 17:32:29 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     Petr Lautrbach <plautrba@redhat.com>
cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] trivial: remove unneeded int
In-Reply-To: <pjd4l51v4ge.fsf@redhat.com>
Message-ID: <alpine.LFD.2.21.1906121730070.28042@34-41-5D-CA-59-C7>
References: <alpine.LFD.2.21.1905242306150.9521@34-41-5D-CA-59-C7> <pjd5zphv6ei.fsf@redhat.com> <pjd4l51v4ge.fsf@redhat.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463786495-1987666125-1560349950=:28042"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463786495-1987666125-1560349950=:28042
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT


Hello,

On Fri, 7 Jun 2019, Petr Lautrbach wrote:

> The same comment applies also to your other unmerged patches
> 
> * trivial: remove unneeded int
> * remove redundant if
> * More accurate error messages
> * trivial fix incorrect indentation
> * trivial typo fix

The simple patches now have a "Signed-off-by:" line in
the description.

Pull requests have been done.

Best regards,
Jokke Hämäläinen
---1463786495-1987666125-1560349950=:28042--
