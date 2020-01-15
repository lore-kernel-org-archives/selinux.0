Return-Path: <SRS0=JZpt=3E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C81C33CB1
	for <selinux@archiver.kernel.org>; Wed, 15 Jan 2020 14:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0AA2084D
	for <selinux@archiver.kernel.org>; Wed, 15 Jan 2020 14:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="We9OU6fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAOOI2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:08:28 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:40341 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAOOI2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jan 2020 09:08:28 -0500
X-EEMSG-check-017: 45917684|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,322,1574121600"; 
   d="scan'208";a="45917684"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Jan 2020 14:08:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579097305; x=1610633305;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=sIsugGoIZpv90fLglLshP/hb/TWJ9T7qNx9SIEXpMN0=;
  b=We9OU6fjXAkeVhtI0lHmCLAWy4DojSqOHfVnh9raTiI2EXw9hhA3o47N
   BBenGKZPbxT57OS7UjiIuIm+pKiBYJbmkmc9odK44A7dGpvKIlJHymYOa
   O64hXCHjpcYXb2dCK8uf2brWMVAzaL0JR+nGvSRtGiq/G7VZHdElgJJ8l
   xbqXxDNYRRghI6OpLvUQ/WSPIvjaupopkQmf8fdcYG7PLVytgf3pPeeJl
   gsUwugcMS9fPC3PP5GqlcZSmywEYnF3QXDixD99SoXCdVJ6iBMkn9Ge/u
   eou9oApxgbEALXcuGlhBBQc3rlez13siB6XhprRBDXUHUpGQ3Lp+mjAGs
   A==;
X-IronPort-AV: E=Sophos;i="5.70,322,1574121600"; 
   d="scan'208";a="31974081"
IronPort-PHdr: =?us-ascii?q?9a23=3ATwJZIRSQprrqDuNsgBfg4usrbdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YB2Et8tkgFKBZ4jH8fUM07OQ7/m8HzRbqsvQ+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTvndFdetayGNsKFmOmxrw+tq88IRs/ihNtf8t7dJMXbn/c68lUbFWETMqPn?=
 =?us-ascii?q?wv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qi?=
 =?us-ascii?q?mi4LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2?=
 =?us-ascii?q?dKQ91cXDJdDIyic4QPDvIBPedGoIn7u1sOtga1CQ21CO/y1jNEmnr60Ks03O?=
 =?us-ascii?q?Q7FQHNwRIuEdQAvn/JqNn5LacfXOSwwKTO0D7Nbe5Z2S3l5YbVch4vv/+MU7?=
 =?us-ascii?q?F+f8XfxkYgFR/KgFqLpIz5PD6YzPgBv3SV4udiU++klm4pqxt2ojiq3soil5?=
 =?us-ascii?q?XJiZwNylDE6yp5xps+K8C9SEFhZd6kFIVftiGHPIZxWcMtXnpotT0myrwGpZ?=
 =?us-ascii?q?G7fC8KxI4hxx7EcfOLaYeI4hX9VOuIJzpzmXFreKqnihqv/kWtxffwW8mp3F?=
 =?us-ascii?q?pQsCZIncfAumoQ2xHV98OJUOFy/l271jaKzw3T7+ZELl0qmqfDMJ4hx6Iwlo?=
 =?us-ascii?q?IUsUTeAi/6gEX2g7GSdkUj4uWo9/7oYq/npp+BLI94kAD+MqIgmsy4GuQ3LB?=
 =?us-ascii?q?QBU3KH+eW8yLLj/Ur5TK9MjvIqianWrIrWJcEapq69GwNV04Aj5AijDzq+zd?=
 =?us-ascii?q?gVknYKIEhFdR6alYTlJV7DLO7iAfuim1islS1kx/HCPr3vGJXNKX3Dna/6fb?=
 =?us-ascii?q?lg8E5R0xYzzNBD6JJUDbENOvTzWlTru9DCAR85NBK0z/79CNphzoMeRX6PAq?=
 =?us-ascii?q?iBPaLcr1CI4OIvI/SNZIIOtzb8Jf0l6OTvjX89g1Mdcqeo3YYNZH+mA/tmPl?=
 =?us-ascii?q?2TYWDwjdcZDWcKog0+QfToiF2FUT5TYWy+X6A75jE7Eo2mC5zDSZ6rgLGawC?=
 =?us-ascii?q?i0BJtWZmdAClCNDXjnbYGEV+0QZyKVJ89riiYEWqS5S489yRGusxf3xKZ9Ie?=
 =?us-ascii?q?rP5CIZtYnu1MNp6O3Tjx4y6DJ0D8CD3GGXVm17gnkHSyUq06B4pEx30k2D3r?=
 =?us-ascii?q?Rgg/xECdxT4OtEXRsgOp7H0eN7C8r+WhndcdeJUlmmX9umATUvQdIr2NIOYk?=
 =?us-ascii?q?B9G8m8gRDHxSalH7gVl7mTDpwu7q3cx2TxJ9p6y3ve1qkhil4mQtFVNW2nna?=
 =?us-ascii?q?5y7A7TCJTMk0qHlqamb6Mc3DTC9G2b12qBoFlYUBJsUaXCRX0fYkrWrdLk5k?=
 =?us-ascii?q?LNVrOuEqooPRdcyc6YK6tKdt3ogUxDRPfkJdvefmaxlHmrCBaWybODcpDqd3?=
 =?us-ascii?q?8e3CrDEkgElR4c/XKcOQg5HCehrHrUDCZyGlL3f0Ps7e5+pWugTkAqywGKbk?=
 =?us-ascii?q?th16e6+xMOm/ycRO0c3qgetCcitTp0BlC90MzSC9aaoAphZqpca8sn4FhbzW?=
 =?us-ascii?q?LZqxB9Ppu4IqBhmFERbR93sF/p1xVwCYVNitQlrHMwzAp1LKKY0U5BdzaC0Z?=
 =?us-ascii?q?D3IL3XJXH4/AqzZK7OxlHezNGW978X6PsmrVXjsxypFksk83l+0NlazWGc5p?=
 =?us-ascii?q?PUAwoWSp/xU1879xx9p7HEfCYx/ZjU2mdvMampqD/NwcglBO07xRq6fddfKL?=
 =?us-ascii?q?uOFBXuHM0CG8iuNOsqlkCxbh0eIeBS8LU5P9u8ePub3K6nJeNgnDWhjWRd/o?=
 =?us-ascii?q?9xyF6D9y15Sr2A45FQ/Pye3haGHwX8hVGu+pTolIZEeDA6EXW6wCngQoFOe+?=
 =?us-ascii?q?t/cZtdTS+MJM2xjvd5h5frQHNevAqhAFMAns2ueROUdFH79QZZ00MRoHeunW?=
 =?us-ascii?q?2zyDkiwB8zqa/K5zDD2+TvclI8P2dPQGRzxQP3LZOck8ERXE/uaRMg0hSi+x?=
 =?us-ascii?q?CplOBguK1jIjyLEg9zdC/sIjQnC/bhuw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BFAQDAGx9e/wHyM5BkDg0BAQEBAQEBBQEBAREBAQMDA?=
 =?us-ascii?q?QEBgXuBfYFsASAShDmJA4ZcBoE3iW6RSQkBAQEBAQEBAQE3AQGEQAKCIzgTA?=
 =?us-ascii?q?hABAQEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjDwEFQRALGAICJgICVwYBDAgBA?=
 =?us-ascii?q?YJjP4JXJaYAgTKJGIE+gQ4ojDJ5gQeBOA+CLy4+h1mCXgSQEYdfl1SCQoJJk?=
 =?us-ascii?q?2EGG4JHiAOQJI5cnREigVgrCAIYCCEPgyhPGA2IDReNaFkjA44QAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Jan 2020 14:08:12 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00FE7XlM056438;
        Wed, 15 Jan 2020 09:07:33 -0500
Subject: Re: Perf Data on LSM in v5.3
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>,
        John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        SELinux <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>
References: <CAOSEQ1poqrUQdRc+ZLNbEoPqgd4MMomeYmefjca_mj-2zxrdUA@mail.gmail.com>
 <7ebd42d8-5392-90f6-fc08-4364176cfbb6@schaufler-ca.com>
 <CAOSEQ1p0q4gxVwN3MJkP=xxn4GUVaKsaArtQpxNy5rv7vYvVVw@mail.gmail.com>
 <abd4dddb-8968-2655-3d80-ce446451b3de@canonical.com>
 <CAOSEQ1rBu+wRzgk_Jh2RsZpf8Lv1+WUi-Pte-EsBMphnEr4SsQ@mail.gmail.com>
 <e7cfc960-32fb-7712-b21c-37999cf29430@tycho.nsa.gov>
Message-ID: <2a984c76-a499-53f6-68c5-5d3604094ba4@tycho.nsa.gov>
Date:   Wed, 15 Jan 2020 09:09:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <e7cfc960-32fb-7712-b21c-37999cf29430@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/15/20 8:40 AM, Stephen Smalley wrote:
> On 1/14/20 8:00 PM, Wenhui Zhang wrote:
>> Hi, John:
>>
>> It seems like, the MAC hooks are default to*return 0 or empty void 
>> hooks* if CONFIG_SECURITY, CONFIG_SECURITY_NETWORK , 
>> CONFIG_PAGE_TABLE_ISOLATION, CONFIG_SECURITY_INFINIBAND, 
>> CONFIG_SECURITY_PATH, CONFIG_INTEL_TXT,
>> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR, 
>> CONFIG_HARDENED_USERCOPY, CONFIG_HARDENED_USERCOPY_FALLBACK *are NOT 
>> set*.
>>
>> If HOOKs are "return 0 or empty void hooks", MAC is not enabled.
>> In runtime of fs-benchmarks, if CONFIG_DEFAULT_SECURITY_DAC=y, then 
>> capability is enabled.
>>
>> Please correct me if I am wrong.
>>
>> For the first test, wo-sec is tested with:
>> # CONFIG_SECURITY_DMESG_RESTRICT is not set
>> # CONFIG_SECURITY is not set
>> # CONFIG_SECURITYFS is not set
>> # CONFIG_PAGE_TABLE_ISOLATION is not set
>> # CONFIG_INTEL_TXT is not set
>> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>> # CONFIG_HARDENED_USERCOPY is not set
>> CONFIG_FORTIFY_SOURCE=y
>> # CONFIG_STATIC_USERMODEHELPER is not set
>> CONFIG_DEFAULT_SECURITY_DAC=y
>>
>>
>> For the second test, w-sec is tested with:
>> # CONFIG_SECURITY_DMESG_RESTRICT is not set
>> CONFIG_SECURITY=y
>> CONFIG_SECURITYFS=y
>> # CONFIG_SECURITY_NETWORK is not set
>> CONFIG_PAGE_TABLE_ISOLATION=y
>> CONFIG_SECURITY_INFINIBAND=y
>> CONFIG_SECURITY_PATH=y
>> CONFIG_INTEL_TXT=y
>> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>> CONFIG_HARDENED_USERCOPY=y
>> CONFIG_HARDENED_USERCOPY_FALLBACK=y
>> # CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
>> CONFIG_FORTIFY_SOURCE=y
>> # CONFIG_STATIC_USERMODEHELPER is not set
>> # CONFIG_SECURITY_SMACK is not set
>> # CONFIG_SECURITY_TOMOYO is not set
>> # CONFIG_SECURITY_APPARMOR is not set
>> # CONFIG_SECURITY_LOADPIN is not set
>> # CONFIG_SECURITY_YAMA is not set
>> # CONFIG_SECURITY_SAFESETID is not set
>> # CONFIG_INTEGRITY is not set
>> CONFIG_DEFAULT_SECURITY_DAC=y
>> # 
>> CONFIG_LSM="yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" 
>>
> 
> Your configs should only differ with respect to CONFIG_SECURITY* if you 
> want to evaluate LSM, SELinux, etc overheads.  PAGE_TABLE_ISOLATION, 
> INTEL_TXT, and HARDENED_USERCOPY are not relevant to LSM itself.
> 
> Also, what benchmarks are you using?  Your own home-grown ones, a set of 
> open source standard benchmarks (if so, which ones?).  You should 
> include both micro and macro benchmarks in your suite.
> 
> How stable are your results?  What kind of variance / standard deviation 
> are you seeing?
> 
> It is hard to get meaningful, reliable performance measurements so going 
> down this road is not to be done lightly.

Also, I note that you don't enable CONFIG_SECURITY_NETWORK above.  That 
means you aren't including the base LSM overhead for the networking 
security hooks.  So if you then compare that against SELinux (which 
requires CONFIG_SECURITY_NETWORK), you are going to end up attributing 
the cost of both the LSM overhead and SELinux overhead all to SELinux. 
If you truly want to isolate the base LSM overhead, you need to enable 
all the hooks.

