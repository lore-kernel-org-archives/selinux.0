Return-Path: <SRS0=JZpt=3E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB24C33CB1
	for <selinux@archiver.kernel.org>; Wed, 15 Jan 2020 14:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415BE206D7
	for <selinux@archiver.kernel.org>; Wed, 15 Jan 2020 14:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="k+vczh8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgAOOFr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:05:47 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:24888 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgAOOFq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jan 2020 09:05:46 -0500
X-EEMSG-check-017: 44851758|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,322,1574121600"; 
   d="scan'208";a="44851758"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Jan 2020 14:05:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579097144; x=1610633144;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zuJApGmOTz44mJIoH8ldk3I8Xh6XeyzfBbYlmsnjOa4=;
  b=k+vczh8y71SZthM07Pa8Xp4wSUe/ZZiq9WzmaUhvQahc1HmXu0MLeFEB
   nrd4/bEVp4QucXOXT56RtRxhLhhisU7d362iF//LHb9T5P3z0itK8q77I
   tvtyOMrNmLwj7JPKuCCm5hfcVxn9ESiyyeqK/zsAPPwR1Z3iH4aJoPKlv
   UmSLvYzUuNUvlKpW8zpw4x9gtqHCmxzbTM7mt2xP2I0BjoscBUSYurCCy
   prbsvDzsQi7RspypBEffwwj1R9P36hJqAeL6J6UPji56R947fJfXu17jE
   tzMMdOOXSWsrb8tRSjGoxeyrP4QqVbwt/1bV/mcQ5u1eik/hYQPIQXom2
   A==;
X-IronPort-AV: E=Sophos;i="5.70,322,1574121600"; 
   d="scan'208";a="31973944"
IronPort-PHdr: =?us-ascii?q?9a23=3AqPxwkRzihJ4dEy/XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0u8UIvad9pjvdHbS+e9qxAeQG9mCt7Qc0KGL7eigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam5duJ6g+xh?=
 =?us-ascii?q?bJo3ZDZuBayX91KV6JkBvw+8m98IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sQvHnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwDIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqpRxtojex3scsip?=
 =?us-ascii?q?fGhoQIwV7Z8CV22oI1JdmmR097fNWpF4BQuDyBN4ZtXsMjQ31nuCY9yrEcv5?=
 =?us-ascii?q?67ZzIFxI4oxx7YdfyKao6F6Q/tWuaWJDd3nnNleLSniha99kigzeL8Vs2q31?=
 =?us-ascii?q?pQsiVFldzMu3YQ3BLQ8siKUuZx80iu1DqV1w3f9/tILV47mKbFMZIt37g9nY?=
 =?us-ascii?q?cJv0vZBC/5gkD2gbeTdkUj5+en9fzqYq7jpp+AL490jRz+Mrg2lsy/H+s4Ng?=
 =?us-ascii?q?8OUnCH+eumzr3j/FD5QK5Qgv03lKnZvpfaJd8FqaGlGQNVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2UILElZdx6diojpOlXOLOj5Dfe5nVusjC9my+3JM7DuGJnALmXPnK3/cb?=
 =?us-ascii?q?ty9UJQ0hc/wcha551OC7EBJPzzWlX2tNzdFhI5KBG7w/38BdVh1oIRRWKPAq?=
 =?us-ascii?q?iDPKPUql+H/PgjI+aLZI8LoDr9MeQq5+byjX8lnl8QZaeo0oURaHC4A/RmIl?=
 =?us-ascii?q?6UYXXig9cEC2gKvw4+QPbliFyMTD5ffWi9UL8h5jsjEoKpEZ/DRpyxgLyGxC?=
 =?us-ascii?q?q0AodZZntYBVGMCnrobJmLW/cWZyKPLM9hliILVaK4R4A9zx6irhP1y71iLu?=
 =?us-ascii?q?DM4C0XqYrj1MRp5+3UjRw96SZ7D9+D3GCNVW10hX8HRz8s06Bir0x9zkmM0b?=
 =?us-ascii?q?JjjvxZE9xT++1GUgMgOZHAyOx6Dsj4WhjdcdeRVFamXtKmDCkzTtI0xN8OeV?=
 =?us-ascii?q?x9G9S5jh3Y2SqlGboVmKKKBJAu9aLcxXfxLd5ny3nazKkhk0UmQsxXOG2ih6?=
 =?us-ascii?q?5/8RXTBoHQn0WCiamlabkc3DTM9GefzWuCpURYUAltXqXYWXAQeFDbrcr25k?=
 =?us-ascii?q?zcVb+iE7cnPRVbyc6ENKRKbsfljVJcRPfsIN7eeX6+m3+sBRaUwbOBdJHqdH?=
 =?us-ascii?q?sZ3CXcDkgEjg8S8G2YNQgxGCihuXjSDD9wGlL1ZUPj7+1+pGm8Tk8uwAGAd1?=
 =?us-ascii?q?dh2Kat+h4JmfycTOse3rEatyg/sDV7AFG939XVC9ebuwVhfL9cYdQ44FdGyG?=
 =?us-ascii?q?LZshZxPpu6L6BtnlQeaRh4v1vy1xVrDYVNicoqrHQqzAp0M66Y0lRBdzOC0p?=
 =?us-ascii?q?D2Ib3YNG/y8QuzZKHM3FHe19CW+qYT5/sir1Xvph2mFk0n839/ydlaz2Oc5o?=
 =?us-ascii?q?nWDAoVSZ/xSlg49x51p7HHYyk94ZrY1X5yPqmutD/NxdYpCfAkyhq5e9dfN7?=
 =?us-ascii?q?2EGxHoH80BHceuK/Eqm0KzYR4eOuBd6rQ4P8G+d/Gewq6kIP5gnC66jWRA+I?=
 =?us-ascii?q?19yliD9zd4SuPTx5YK2eyY3g+eWzf5i1ehtdr3lp5eaT4OGWq/zHusOIkEWa?=
 =?us-ascii?q?B0fZsKQVWuKsu4joFhipjtRn9w+0GmDlICnsC2ZFyfY0GrmUV73F8asDScki?=
 =?us-ascii?q?ux0jJwnith+qGWxyHf6//pdBMaNGpGXixphBHnJo3i3P4AW039VBQkjBuo4w?=
 =?us-ascii?q?7BwqFfoKluZz3ITVxgYzn9L2YkVLC58LWFfZgcu9sTrSxLXbHkMhihQbnnrk?=
 =?us-ascii?q?5finmyEg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DEBQDvGh9e/wHyM5BhAw4OAQEBAQEHAQERAQQEAQGBe?=
 =?us-ascii?q?4F9gRhUASASKoQPiQOGXAaBN4luj2KBDlkJAQEBAQEBAQEBLQoBAYRAAoIjO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYJ5AQEBAQIBIwQLAQVBEAkCGAICI?=
 =?us-ascii?q?wMCAkYRBgEMBgIBAYJjPwGCVgUgDwOJeZp/dX8zhDUBgRSDTYE4BoEOKIwye?=
 =?us-ascii?q?YEHgREnD4FfUC4+gmQCgTABEgFAJoJJgl4EkBGHX5dUgkKCSYR0jm0GG4JHi?=
 =?us-ascii?q?AOQJI5ciF2UNCI3MHErCAIYCCEPgycISBgNiA0Xg1CKGFkjAzCLLoIyAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Jan 2020 14:05:42 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00FE4wKK056417;
        Wed, 15 Jan 2020 09:04:59 -0500
Subject: Re: Perf Data on LSM in v5.3
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        SELinux <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>
References: <CAOSEQ1poqrUQdRc+ZLNbEoPqgd4MMomeYmefjca_mj-2zxrdUA@mail.gmail.com>
 <7ebd42d8-5392-90f6-fc08-4364176cfbb6@schaufler-ca.com>
 <CAOSEQ1p0q4gxVwN3MJkP=xxn4GUVaKsaArtQpxNy5rv7vYvVVw@mail.gmail.com>
 <3993c054-8094-56aa-b66c-1f97b325ca96@schaufler-ca.com>
 <CAOSEQ1qipfe0Juz+4V9FgebAPDDXePd29s8=G1pFtHGqx4Sedg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <53c1c2ca-77e6-aee8-4a34-a0704e47a9b7@tycho.nsa.gov>
Date:   Wed, 15 Jan 2020 09:06:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAOSEQ1qipfe0Juz+4V9FgebAPDDXePd29s8=G1pFtHGqx4Sedg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/14/20 7:14 PM, Wenhui Zhang wrote:
> Hi, Casey:
> 
> Nope, I did not test without CONFIG_SECURITY for v 5.3. (I could give it 
> a try later this week, please let me know if you need this data)
> However I did this test for v4.18.20, afterwards i switched  to v5.3 as 
> my base code.
> 
> I am attaching the three results to this email for your reference for 
> v4.18.20.
>   -- without_sec is without CONFIG_SECURITY
> -- with_sec_disable_all is with CONFIG_SECURITY, however no submodule is 
> CONFIG
> -- selinux is with CONFIG_SECURITY, and CONFIG integrity and selinux 
> only, however no policy enabled

Don't enable integrity if you want to evaluate just LSM/SELinux 
overheads.  Also not sure what kind of behavior you get from SELinux 
with no policy loaded; it wasn't designed to be used that way beyond 
early initialization up to the point where init/systemd loads policy. 
Better comparisons would be running standard benchmarks on e.g. Fedora 
with SELinux disabled versus enabled as well as with LSM completely 
disabled.  Then you'd be evaluating SELinux with a policy in enforcing 
mode on a distro that actually supports it.  Similarly, evaluating 
AppArmor perf is best done on a distro that supports it and provides a 
policy, e.g. Ubuntu or latest Debian.

> 
> One interesting fact generated from this test is that, selinux and 
> integrity CONFIG introduces about 20% performance downgrade for readdir.

Would have to see the actual benchmark code, complete kernel config, and 
kernel version to evaluate that result meaningfully.

BTW, it would be interesting to evaluating the LSM overhead alone (i.e. 
CONFIG_SECURITY=y CONFIG_SECURITY_NETWORK=y but all other 
CONFIG_SECURITY*=n) before and after the switch to LSM hook lists aka 
stacking support.  Don't think we ever saw micro benchmark data for that 
change IIRC.

> 
> without_sec 
> <https://drive.google.com/drive/folders/1TuUB1JT5bijG-hNvN1Dti7DyFIXM3u_g>
> 
> with_sec_disable_all 
> <https://drive.google.com/drive/folders/1bWrQ-dTSn1p05hVyvIUIAE4hkKgUp6D->
> 
> selinux 
> <https://drive.google.com/drive/folders/1132zzrw42XH8tbNgYvd44LuocgIw4Wq6>
> 
> 
> 
> On Tue, Jan 14, 2020 at 6:59 PM Casey Schaufler <casey@schaufler-ca.com 
> <mailto:casey@schaufler-ca.com>> wrote:
> 
>     On 1/14/2020 1:15 PM, Wenhui Zhang wrote:
>      >
>      > On Tue, Jan 14, 2020 at 4:08 PM Casey Schaufler
>     <casey@schaufler-ca.com <mailto:casey@schaufler-ca.com>
>     <mailto:casey@schaufler-ca.com <mailto:casey@schaufler-ca.com>>> wrote:
>      >
>      >     On 1/14/2020 12:15 PM, Wenhui Zhang wrote:
>      >     > Hi, Casey:
>      >     >
>      >     > I just performed a performance check on
>      >     > 1. v5.3 with DAC only, and
>      >     > 2. v5.3 with DAC and MAC framework, an empty-policy enabled
>     in sub-modules(e.g. selinux)
>      >
>     This is great. Do you have data for a system without CONFIG_SECURITY?
> 
> 
> 
> 
> -- 
> V/R,
> 
> Wenhui Zhang
> 
> Email: wenhui@gwmail.gwu.edu <mailto:wenhui@gwmail.gwu.edu>
>             Telephone: 1-(703) 424 3193
> 
> 
> 
> 
> 
> 

