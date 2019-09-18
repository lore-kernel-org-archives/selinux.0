Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B569C4CEC9
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 14:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF8521907
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 14:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="IuSvUcRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfIRORq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:17:46 -0400
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:2842 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfIRORq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 10:17:46 -0400
X-EEMSG-check-017: 15016232|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="15016232"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 14:17:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568816263; x=1600352263;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HpYzIcJ0iAAvcnAjYnYQVkkQjCyjIio+HrUOb4xj72c=;
  b=IuSvUcRfgyv/Sh1+URYFommXDa8WLh0miDRB82eCHrMfirPrctgnsI10
   7nZpiJQ5fcJiM42YBucxPGGT+9yKwn9jvIZRyoN/ufuHNaFx4FPrCnPt9
   xjCfjGWFE/XIBhfalL/DaWVEJh0wbFvg5BkyHqcWHQFH791Fw8tQyd8+L
   xwNB7zaqlxjPAkQkWV5Rw8ikwHg6rVJ2CvSmXTBCxuQglYn3mzPdl3ohU
   vIDJqCyDfIyGilL+GdvfXs3qxqoYWyR0zBNMe/0AS2Dca7TfRc/XH47vZ
   sS2Vj4GMgKYXv94jjMrmZ9cO1rHCinJREXmETfxFvfKC1N+R0oVpLuv7X
   g==;
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="28046936"
IronPort-PHdr: =?us-ascii?q?9a23=3A8b5/PR/mf8HZHP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B32+scTK2v8tzYMVDF4r011RmVBN6dsqIP1LOe8/i5HzBZu9DZ6DFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMLjYZhJao8yA?=
 =?us-ascii?q?bFqWZMd+hK2G9kP12ekwvi6suq4JJv7yFcsO89+sBdVqn3Y742RqFCAjQ8NG?=
 =?us-ascii?q?A16szrtR3dQgaK+3ARTGYYnAdWDgbc9B31UYv/vSX8tupmxSmVJtb2QqwuWT?=
 =?us-ascii?q?Sj9KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjZa7WY88USn?=
 =?us-ascii?q?RdUcZQTyxBA52zb40TD+oaIO1Uq5Dxq0YSoReiAAWhAu3gyiVMhnTrw6M01e?=
 =?us-ascii?q?ovGhzC0AA5H98DtHHYodPoP6kQTO+11rHFwyjdYfNY2Tnz64bGfR4urv6OQb?=
 =?us-ascii?q?1+ftHcyVUtGg7fklmctYLoMjGT2+8Qs2ab9e1gVee3hmA6twF+vCCvxscyhY?=
 =?us-ascii?q?nPm4kb11XE+j99wIYxO9K5SFNwbNm/EJRNrCGXLJd2Q8M+TGFovyY20LsGuY?=
 =?us-ascii?q?WhcyQQx5QnwADfZuWBfoOV4RzjTP6cLSp3iX9qYr6yhwu+/VK+xuDzSMW4yk?=
 =?us-ascii?q?tGoyxYmdfWrH8NzQbc6s2fR/t4+UeuxCiA2hjI6uFBPUA0ja3bK4M9wrIolp?=
 =?us-ascii?q?ocr0DDHijulUXqlqCWbEQk+vWz6+j9frXnpoOTN49zig3kNKQhhte/DvgiPg?=
 =?us-ascii?q?gLXmib/fyw1Lzl/ULnXLVHluA6n6bWvZzAJckXu7S1DxFa34o98RqzEi+q0N?=
 =?us-ascii?q?ECknkGKFJFdgiHj4/sO1zWO/D3EOy/jk+wkDZr2//GPrrhDo/LLnjYirjtZ7?=
 =?us-ascii?q?l960lCyAYr19BQ+4pUCq0dIPL0QkLxqNPZDgM+Mwyow+bqE9p91oYEVmKOBq?=
 =?us-ascii?q?+VKr/dsViN5ug3OemDeJcVuCrhK/gi//PulmE2mVscfamvwJsWZ2u1HuppI0?=
 =?us-ascii?q?qHe3rgmNQBHnkQvgo4UuPqjEeOUTlJZ3a9DOoA4WQHBY7uMYDfRsj5nKyd2z?=
 =?us-ascii?q?u7NpJTb2FCTFuLFCG7WZ+DXqI3dC+KIsJn2gcBXLylRp5pgQqiryfm2rFnKa?=
 =?us-ascii?q?zS4SReupX9gosmr9bPnA0/oGQnR/+W1HuAGiQtwzIF?=
X-IPAS-Result: =?us-ascii?q?A2CXAAAgO4Jd/wHyM5BmHQEBBQEHBQGBVQYBCwGBbSqBQ?=
 =?us-ascii?q?DIqhCKPXAEBAQEBAQaBNol0jy2BewkBAQEBAQEBAQE0AQIBAYQ/AoMDIzYHD?=
 =?us-ascii?q?gIMAQEBBAEBAQEBBQMBAWyFOYI6KQGCZwEFIxVBEAsOCgICJgICVwYNBgIBA?=
 =?us-ascii?q?YJfP4F3FLBSgTKFTIMvgUmBDCgBjAgYeIEHgTiCaz6HT4JYBIxsiRGXAIIsg?=
 =?us-ascii?q?i6SUAYbmSGpGwsmgVgrCAIYCCEPgydQEBSQLyQDMIEGAQGPbgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Sep 2019 14:17:42 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8IEHg8x006488;
        Wed, 18 Sep 2019 10:17:42 -0400
Subject: Re: strange tclass in AVCs
To:     Ted Toth <txtoth@gmail.com>
Cc:     selinux@vger.kernel.org
References: <CAFPpqQFwGgEKU9KY2kif4C95fZPvLH0TGdTxLKUAXuRgK2zxBw@mail.gmail.com>
 <ac6433e2-88a4-747c-66f5-d241499f40d6@tycho.nsa.gov>
 <CAFPpqQGfAifnShcWTMs1pJe1m7W_4wM8AUqFsvj4Zts5-9QiCQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b2c71d86-c574-43d6-2fcf-17a06078c8df@tycho.nsa.gov>
Date:   Wed, 18 Sep 2019 10:17:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFPpqQGfAifnShcWTMs1pJe1m7W_4wM8AUqFsvj4Zts5-9QiCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/18/19 10:03 AM, Ted Toth wrote:
> On Wed, Sep 18, 2019 at 8:53 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 9/18/19 9:35 AM, Ted Toth wrote:
>>> I'm seeing things like tclass=context#012 in some AVCs what is this telling me?
>>
>> Just a guess here, but octal 012 is '\n' aka a newline character, and
>> libselinux/src/avc.c:avc_audit() appends a "\n" at the end of the buffer
>> before calling avc_log() to log the entire string.  avc_log() will call
>> the logging callback, and dbusd does define one, which calls
>> audit_log_user_avc_message().  Maybe audit_log_user_avc_message() is
>> escaping the newline character in its output as well as appending
>> additional data.
>>
>> I'm a little unclear though on why dbusd is checking a context contains
>> permission?
> 
> These appear to only occur when systemd is starting the dbus daemon
> and they end up in /var/log/messages not /var/log/audit/audit.log as
> I'd expect.

Sounds like auditd isn't operational at that point and therefore the 
output just goes to syslog.

Arguably avc_audit() shouldn't be adding a newline at all and that 
should be handled by the logging callback (or default_selinux_log if no 
callback is set).  But it has been this way forever, so that would no 
doubt break some users.  Legacy of when this was a printk/printf.




