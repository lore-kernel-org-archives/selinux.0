Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71A6C432C0
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 18:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA18206CB
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 18:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="cjsMiOHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKUSUO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:20:14 -0500
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:16692 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfKUSUO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Nov 2019 13:20:14 -0500
X-EEMSG-check-017: 50788909|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="50788909"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Nov 2019 18:20:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574360412; x=1605896412;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=VcKhJvLnTiBxMNYUNWUD6S0mAkGOWdySIIEbCh4dG6M=;
  b=cjsMiOHiS0CAWx+RNbqrksgA2gd4Fi4sHWLxe8GYzcOxcOcuIZ3npJKi
   AWJLwrz/RQF7HmUGgBONHvuWrBqr8t52Tpr0r9Y6XON+fd3Z6XxSvHCwe
   P58qUTz9hpJWL+zKEbQ9CbdxL84sEJ1eFdPbsuyBnjdlmI3NYXZtai8Oy
   PHK5HY+BwvQFtM4aAB9QEnnpETSwaUvKD9d/p7bjh0YKaEYx5dMxvZAsD
   q2gduA+kA8FaceKt59HmJN7MiEEL2RRil1jrdFPQjUVbAQz/EybTF/mcb
   65ADC+Bm3MMFtVjZsBhpeBtEXRrWHGej4hKOShClrMbOFz1oSUSk9bKNS
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="35858404"
IronPort-PHdr: =?us-ascii?q?9a23=3AzM7nzBHBRZPNKbgDSJbEep1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7ypsiwAkXT6L1XgUPTWs2DsrQY0rGQ6v26EjVZut6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txjdu8kIjYdtN6o91x?=
 =?us-ascii?q?XEqWZUdupLwm9lOUidlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q6FGATo/K2?=
 =?us-ascii?q?w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWT?=
 =?us-ascii?q?mn8qxmRgPkhDsBOjUk62zclNB+g7xHrxKgvxx/wpDbYIeJNPplY6jRecoWSX?=
 =?us-ascii?q?ddUspNUiBMBI2zb5ELD+EcI+hWqYfzrEYKoRenCwShAObjxzlVjXH0wKI6yf?=
 =?us-ascii?q?wsHxzY0gwuH9wAs3rao9v6O6gQTe+7w7LFzSnBYv5MxTvx9IbFfxInrPqRXb?=
 =?us-ascii?q?xwa83RyUw3Gg3YklWft5TlPzOL2eQLrmOV8u9gWviri24jtQ5woiWky8A3io?=
 =?us-ascii?q?bUnYIY0UzE9CVlz4Y1It20Ukh7YcW+H5dKuCGaMJV2T9okTmp1uyg60qULtY?=
 =?us-ascii?q?O0cSUF0pgqxwPTZ+aZf4WH/B7vTvudLDFlj3x/Yr2/nQy98U24x+35Ucm7zU?=
 =?us-ascii?q?hFozJektnJqnANzxvT6tWbSvdl/keuxzKP1wfL5+FYO080j6vbK4M6wrIqip?=
 =?us-ascii?q?oSsVjMHi/xmEnsiq+Zal4k9fSy5+TiY7XmooeQN45yig7gLqQjgtGzDOs3Pw?=
 =?us-ascii?q?QUX2WX5P6w2KPs8EHnWrlGk+U6kqzDv5DbIcQbqLS5AwhQ0os78BawEiym3c?=
 =?us-ascii?q?8EnXgHMF1FeBWHg5LvO1HVOv/0F/i/g1OykDtz3fDJIqXhAonRLnjEiLrhf7?=
 =?us-ascii?q?F961VcyAou199S/JBUCrYaIPLzR0/+rt3YDhk/Mwyz3eboEsl92Z0FWW6VH6?=
 =?us-ascii?q?+ZK7vYsUWU6eI3P+mMeIgVtS7mK/c74/7ujHk5mUISfKSyw5sXZ263Hu58L0?=
 =?us-ascii?q?Waf3XsmNEBHnkOvgYkS+zqklKCAnZvYCOQWLk8+zhzM4mmCIbPQoOqjrGblH?=
 =?us-ascii?q?O5GYZWe2luCFeXEWrhdoOCXOkFdC+JZNJ6xHhMTrWlSok8xTmwuwLgjblqNO?=
 =?us-ascii?q?zZ/msfr52w+sJy4rjoiRwq9TFyR/+Y2mWJQnA8yngEXBcqzat/pgp70V7F3q?=
 =?us-ascii?q?9m1a8LXedP7u9EB19pfaXXyPZ3XpWrAVPM?=
X-IPAS-Result: =?us-ascii?q?A2C+AQD81NZd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0LGxVMiqEKo8EVAaBN4lnkUMJAQEBAQEBAQEBIxEBAgEBhEACgigkO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYJsAQEBAQIBIxVGCwsYAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJfPwGCUgUgrTl1gTKFToM4gUiBDiiMFhp4gQeBOIJrPodVgl4Ej?=
 =?us-ascii?q?QOJXEaXC4I1gjeEY44wBhuDMZZnjkicHSKBWCsIAhgIIQ+DJwlHERSQIIUMI?=
 =?us-ascii?q?wMwgQUBAZA+AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 21 Nov 2019 18:20:07 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xALIK5K1029639;
        Thu, 21 Nov 2019 13:20:05 -0500
Subject: Re: [PATCH] Fix: check variable type of port before trying to split
To:     Joshua Schmidlkofer <joshua@joshuainnovates.us>,
        selinux@vger.kernel.org
References: <CAOCpKqn51K_QEzk__doirKztMPTZMuKoqBSDW4wdoWbfoPhNVw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <09e371a7-ba45-30d6-79ed-1777d0a74bcd@tycho.nsa.gov>
Date:   Thu, 21 Nov 2019 13:20:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAOCpKqn51K_QEzk__doirKztMPTZMuKoqBSDW4wdoWbfoPhNVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/21/19 12:36 PM, Joshua Schmidlkofer wrote:
> I ran into a bug passing port numbers are integers to the python
> policy tools.  Here is a proposed fix.

The subject line / one-line summary should be of the form "[PATCH] 
subsystem: logical description", e.g. "[PATCH] semanage: support integer 
port arguments".  Also, s/are/as/ above.

> 
> Signed-off-by: Joshua Schmidlkofer <joshua@joshuainnovates.us>
> ---
>   python/semanage/seobject.py | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index dc413ca5..c067222d 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1070,13 +1070,17 @@ class portRecords(semanageRecords):
>           if port == "":
>               raise ValueError(_("Port is required"))
> 
> -        ports = port.split("-")
> +        if isinstance(port, str):
> +            ports = port.split('-', 1)
> +        else:
> +            ports = (port,)
> +
>           if len(ports) == 1:
>               high = low = int(ports[0])
>           else:
>               low = int(ports[0])
>               high = int(ports[1])
> -
> +

Try to avoid unrelated whitespace changes in patches unless you happen 
to be touching the same lines and are fixing coding style issues.

>           if high > 65535:
>               raise ValueError(_("Invalid Port"))
> 

