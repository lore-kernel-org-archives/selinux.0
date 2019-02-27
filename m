Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEFAC43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 13:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24ACC20C01
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 13:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HwcpNLk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfB0NLl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:11:41 -0500
Received: from uphb19pa13.eemsg.mail.mil ([214.24.26.87]:5860 "EHLO
        usfb19pa16.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729740AbfB0NLl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Feb 2019 08:11:41 -0500
X-EEMSG-check-017: 170147910|USFB19PA16_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa16.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Feb 2019 13:11:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551273099; x=1582809099;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=UTNwVUyKgM9RSj4An4q+CUGZO6NY1bRdAKn/nrkK6Eo=;
  b=HwcpNLk68aIwMGgMqD25t7LGmf4iZRkGy+Ie92JdBYol9y6U2cJDL0E8
   AxxYaKiliaRsluTleLDqrnw3TVyBq8g7scfFHe/i1XL47I93z82Dp//lp
   FG+ViUcxtp09Xaj/3CFWV88Y47xUgUzm+WRnsKEo+iywLpt+dhjHxULY4
   Dt3n2zhWHsAwCLDQs2wsmWZlsiPA9PmCu0iJG98Aujww87hYDvCuDKGSB
   1ZP/b9CH7uW2ZrbkQgFQ0x1B4DrYmBItJsXSYC6D4F3Ttg2ekoU08S1Av
   RFFGvJd2ZA54oijIFaIiX8xt6ZL7k3G061IG8+O6iemgkKYbxcOGnVoYs
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,419,1544486400"; 
   d="scan'208";a="24384705"
IronPort-PHdr: =?us-ascii?q?9a23=3AIoK6CxEDk0GwENimfoewJ51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zoc2wAkXT6L1XgUPTWs2DsrQY07qQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDmwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC?=
 =?us-ascii?q?+85Kl3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zTZ9MaQX?=
 =?us-ascii?q?dKUNhXWSJPH4iwa5IDA/QdMepdqYT2ulkAogakBQS0Ge3h1DFIiH/106M03e?=
 =?us-ascii?q?suHgPJ0xAvEd8VrHTZrs/4OLsOXe27zqTFyyjIYfNM2Tf67YjFag0voe2SUr?=
 =?us-ascii?q?Joccre108vHB7YgFWVs4PlOzeV2foNsmOG6OdgTv+gi3U8pgFtojmg2scsio?=
 =?us-ascii?q?7TioIT0VDL7z91wIkyJd2mUUN2Z8OvHphItyyCKod7TcwvT3totSon0LEKp5?=
 =?us-ascii?q?G2cDYQxJg6wRPUduaJfJKS4h35UeacOTJ4hHV4d72hnxuy6k2gyvHkVsmzzV?=
 =?us-ascii?q?ZKsjJJktnSuXAJ0Bze8tSHReFn/kegxDaPzBrf6v1EIE8olarbLIQtwrgsmZ?=
 =?us-ascii?q?oIrUvPBCr2mETyjKOOd0Uk/Pan6/j/b7n7qZKROJV4hwHjPqg0hMCyDvo0Ph?=
 =?us-ascii?q?ITU2SD/OSzzrzj/Un3QLVQif02l7HUsIvHKsQAvaO5Hw9U3Zoj6xa4FTum1s?=
 =?us-ascii?q?8YkmMdIFJKfxKHkZDlO0vSL/DgEfe/n1OsnS93x/HJIr3hBYnNLnjYnbfueL?=
 =?us-ascii?q?Zy8U9cyA4pwd9D4JJUD6kLIOjvVU/pqNzYEhg5PhSvw+n5DNV914UeWX+AA6?=
 =?us-ascii?q?KCLqPSvkGH5vg1L+mPeoAVojD9JOYh5/L0in85g1AdLuGV2s4rZXzwIvN6Iw?=
 =?us-ascii?q?3NfWrwhcsBOWgPtws6CuftjQvGGSVeY3e0QrIU+D42EsSlAJ3FS4Trh6aOjw?=
 =?us-ascii?q?mhGZgDXXxLElCBFz/TcoyAX/odIHaJLtRJji0PVb/nTZQokx6pqlmpmPJcMu?=
 =?us-ascii?q?PI93hA5trY399v6riWzEtq+A=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DOAAAVjHZc/wHyM5BkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VkqgWqEL5N2TAEBAQEBAQaBECWJPIlThww4AYRAAoQMIjcGDQEDAQEBAQEBA?=
 =?us-ascii?q?gFsKII6KQGCZwEFIxVRCw4KAgImAgJXBgEMCAEBgl89gWYNqxyBL4VEhGuBC?=
 =?us-ascii?q?4s9F3iBB4ERJwyCX4gLglcCkSM7kgwJkmQGGZMcLYowlBsigVYrCAIYCCEPg?=
 =?us-ascii?q?yiQeiEDgTUBAZFEAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Feb 2019 13:11:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1RDBbLu014223;
        Wed, 27 Feb 2019 08:11:37 -0500
Subject: Re: RHEL auth_role using logging_send_audit_msgs
To:     Ted Toth <txtoth@gmail.com>, selinux@vger.kernel.org
References: <CAFPpqQEHRb5pW7HGx7-yZgBbneA3US_nb4HqRAG5uSkYbxg+Jw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c2fe520a-b054-b964-2495-8e06b19f32c9@tycho.nsa.gov>
Date:   Wed, 27 Feb 2019 08:07:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFPpqQEHRb5pW7HGx7-yZgBbneA3US_nb4HqRAG5uSkYbxg+Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/26/19 5:20 PM, Ted Toth wrote:
> The RHEL version of the auth_role macro which we are getting through
> our use of userdom_unpriv_user_template uses logging_send_audit_msgs
> which give a type the audit_write capability and allow rules for a
> number of netlink_audit_socket operations. It seem counterintuitive to
> give an unprivileged user type audit write related policy.The
> ref-policy version of auth_role does not use logging_send_audit_msgs.
> We're considering patching our policy but I wanted to see what others
> though about giving unprivileged user types this policy?

I agree that it doesn't seem like a good idea.  Should probably file a 
bugzilla for redhat.


