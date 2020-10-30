Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0864C4741F
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 16:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FAD120725
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 16:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hk5vG6G8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgJ3QnP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 12:43:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42548 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgJ3QnP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 12:43:15 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6DB2820B4905;
        Fri, 30 Oct 2020 09:43:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DB2820B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604076194;
        bh=IaotcXMpeIJAOCC8PWk+3p2VsFBW9Ups0sK9vDE+00k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hk5vG6G8Al3QxurWYrUGXqSAQ+3w04Az1PgUaOLf8xwTrTMMmR5sjqwK/Pqlnf59j
         SSLvMpp4DjrfNLT6ctT1RSSjzQO3JzBYq/h4tKqo13Y2QyxCqg+Rke8IhEdhylpHV3
         8dzLBo7QaFTurX5PWmqKIvdosJ3SHshWXH3Ecp78=
Subject: Re: [RFC] Finding the right target branch for patches that span IMA
 and SeLinux
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        paul@paul-moore.com
Cc:     SELinux <selinux@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
References: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
 <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <2ea3d341-6299-ec40-b553-f9f59a36cfb3@linux.microsoft.com>
Date:   Fri, 30 Oct 2020 09:43:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> Unless this patch set is specifically dependent on the two patches in
> the SELinux tree beyond v5.10.0-rc1, please base it on v5.10.0-rc1.
> 
Thanks Mimi. We don't have dependencies on those two patches in SELinux 
tree.

We'll base our changes on v5.10.0-rc1 in SELinux tree.

Thanks for the quick response.

~Tushar

> thanks,
> 
> Mimi
> 
