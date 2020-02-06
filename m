Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D8C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 18:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0E5214AF
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 18:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="fwm3+8ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgBFSrG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:47:06 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:7884 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFSrG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 13:47:06 -0500
X-EEMSG-check-017: 55811868|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="55811868"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 18:46:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581014804; x=1612550804;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=lfsQnKYygyTYrt0xc+c2plgzgw3v+6QggtMypt27Zaw=;
  b=fwm3+8eye8trEljf2IbeNxB6p0w8z45Olu729lB283tdtl652zR5Fp+b
   2aufirp/e1xnijTqgs4OSwXyv4o9uy4h8Sm+F2e0cpkgeAiHEKBhBw7Zm
   pBTl4IH2pDlkasA1Zx8siEB1bv/9XoPZt62wPY+BlDgqwTwOjY7bPyr4i
   ffpE5bw0NnpeMnpR9cPWkydT7GMsDSNHfd1/y4Tya5/ZVIATG8lzGHHBB
   OhnupYbvmLrDOUjltBb8TLTsOZ5Qio2G8WcaxuFQycchgcrdvv0WqGKyQ
   m9USGg5+2nCYNs5w03inqXkWlFA5NI287IgnbdmySXyXaM+27qnKn8ULt
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="32778617"
IronPort-PHdr: =?us-ascii?q?9a23=3A2JVxOBVDXq3QdjMzN9u4TMIk/MTV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbROHt8tkgFKBZ4jH8fUM07OQ7/m8HzFbqs/Y7DhCKMUKC0?=
 =?us-ascii?q?Zez51O3kQJO42sMQXDNvnkbig3ToxpdWRO2DWFC3VTA9v0fFbIo3e/vnY4Ex?=
 =?us-ascii?q?T7MhdpdKyuQtaBx8u42Pqv9JLNfg5GmCSyYa9oLBWxsA7dqtQajZFtJ6osxR?=
 =?us-ascii?q?bFuHtFdupZyW91OF6ekAv36sOs8JJ+6ShdtO8t+sBaXanmY6g0SKFTASg7PW?=
 =?us-ascii?q?wy+MDlrwTIQxGV5nsbXGUWkx5IDBbA4RrnQJr/sTb0u/Rk1iWCMsL4Ub47WT?=
 =?us-ascii?q?K576d2UxDokzsINyQ48G7MlMN9ir9QrQ+7qBx+x47UZ5yVNOZ7c6jAc94WWX?=
 =?us-ascii?q?ZNU8BMXCFaHIiyc5UAAPYAPeZAronyuV0OrQelBQKxAO/j0yJEimPq0aE/1e?=
 =?us-ascii?q?kuHxvG3Ag9FNwQtnraosj+OKMLXe21yKTEyDPOZO5U1zjg8ojFag0vr/GSU7?=
 =?us-ascii?q?J+csTfx0cgGAzHgVqMpoLoJC+V2+cXvmSH8+ZtW+Cihmg6oA9xuDivwcIsh5?=
 =?us-ascii?q?HUiIIJ1F/E7SV5z5gzJdalVUB7ZMSrEJ9Uty6EN4p9X8QvQ3p1tyYh0bAGpZ?=
 =?us-ascii?q?66czQKyJQg3RLfbeeHfJKS7hLsU+aRPy51iXR4c7y8nxa/6VWsx+LzW8Wu0F?=
 =?us-ascii?q?tGszBJnsfDu3wTzRDf986KQeZn8Ei7wzaAzQXT5/lBIUAziKXUNYYswqU1lp?=
 =?us-ascii?q?oPqUTDGTL2mFnugK+WaEok/u+o5vz7Yrr8vJ+cNpJ0ihrkPqQvnMy/D+M4Mh?=
 =?us-ascii?q?MQUGeH4+i8yL3i8lH5QLVNlPE2lLXWsIvGKsgBo665AgtV3p4i6xa5ETimzM?=
 =?us-ascii?q?wVkWQIIV9KYh6Kj5XlN0vQLP33E/uzmUmgnC9ux//cP73hBpvNLmLEkLfkZb?=
 =?us-ascii?q?t98FNTyBEowNBD55NbFrEBIPXpVk/3r9zXFAU1MwOzw+b5ENl9zJ8RWXqTAq?=
 =?us-ascii?q?+FN6PfqViI5ucoI+mXYo8aoiryJOY+6v70k3A2hF8dcrO13ZcNdH+4GfFmKV?=
 =?us-ascii?q?2DYXXwmtcBDXsKvg0mQezxllKCVT9TZ3CvX6Mz/Tw7Fo2mApnZRoy3g7yOwj?=
 =?us-ascii?q?27HptIaWBCEFyMFm3od4qcUfcWdC2SOtNhkiADVbW5U48h0QuhtBLmy7p9Ne?=
 =?us-ascii?q?Xb4DYVtYj929do5+3cjw0y+SZoAMSa1mHeB11zy0QOSyU73uhapld7w1yO0u?=
 =?us-ascii?q?AshPlfDtpa7P5hSAo2NZfAied9DoahdBjGe4KyVFu+QtigSQo0R9Y1zs5GN1?=
 =?us-ascii?q?1xAP2+nxvD2GysGLZTmLuVUs9nupnA1mT8cp4ug03N07Ms2hx/H5pC?=
X-IPAS-Result: =?us-ascii?q?A2A9BAC+Xjxe/wHyM5BmHQEBAQkBEQUFAYF7gX2BbSASK?=
 =?us-ascii?q?oQViQOGYQEBAQEBAQaBN4lwkUsJAQEBAQEBAQEBNwEBhEACgmE4EwIQAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFQ4I7KQGDAgEFIw8BBUEQCw4KAgImAgJXBg0GAgEBgmM/g?=
 =?us-ascii?q?lclrU6BMokqgT6BDiqMPXmBB4E4D4JdPodbgl4EjT4giiaXZ4JEgk6TcgYbg?=
 =?us-ascii?q?kiIEJAzkC2baSKBWCsIAhgIIQ+DJ1AYDZ0BIwMwjkoBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Feb 2020 18:46:19 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016IjOVe205883;
        Thu, 6 Feb 2020 13:45:27 -0500
Subject: Re: [RFC PATCH 2/2] semodule: support changing policyvers via command
 line
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20200206131253.535302-1-omosnace@redhat.com>
 <20200206131253.535302-3-omosnace@redhat.com>
 <dfd44a69-8ba1-9de7-c3a8-bca702fdf6a0@tycho.nsa.gov>
 <CAFqZXNvkvuP2qVna2uj3zPPJC5rgJuOei7rF9=gLUo6QUxyvZw@mail.gmail.com>
 <5714f2b9-2dc1-feaf-1f73-2a50a464101b@tycho.nsa.gov>
 <CAFqZXNuAZWx4b9UrT68ui2HbD8mY94jz393ErowaC2soV6f7Vw@mail.gmail.com>
 <f3af0abe-1705-2ef3-80ac-13c9fbacda94@tycho.nsa.gov>
Message-ID: <b1014a44-296a-f417-850e-969986cdce0a@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 13:47:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f3af0abe-1705-2ef3-80ac-13c9fbacda94@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/20 10:35 AM, Stephen Smalley wrote:
> On 2/6/20 10:28 AM, Ondrej Mosnacek wrote:
>> On Thu, Feb 6, 2020 at 3:52 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>
>>> On 2/6/20 9:19 AM, Ondrej Mosnacek wrote:
>>>> On Thu, Feb 6, 2020 at 2:44 PM Stephen Smalley <sds@tycho.nsa.gov> 
>>>> wrote:
>>> Seems like you could just have selinux-policy depend on the version of
>>> libsepol used to build it.
>>>
>>> The problem with both your current approach and your proposed one is
>>> that it means that if a user or package does a semodule -B (or any other
>>> semodule/semanage command) on their system, that will generate the
>>> latest policy.N version supported by their libsepol, and libselinux will
>>> give precedence to that policy at load time.  So if they then later
>>> update their selinux-policy package, and it only installs a prebuilt
>>> policy.(N-1), that won't actually get loaded - libselinux
>>> selinux_mkload_policy() will keep using the policy.N file (which may be
>>> older).  Unless I'm missing something.
>>
>> Hm, yes, you're right... It seems we have no other choice than to
>> better handle the dependency between selinux-policy and libsepol.
>> Please disregard this patch series.
> 
> Historically, I think we got to this point because originally 
> selinux-policy would run semodule from %post to generate the policy.N 
> file at install time, thereby always generating the latest version 
> supported, and then later switched to pre-building policy.N at package 
> build time and just dropping it in place at install time to avoid the 
> runtime and memory overhead.  Particularly because it could otherwise 
> fail at install time on low-memory systems/VMs.
> 
> As a separate matter, one could possibly argue that libselinux 
> selinux_mkload_policy() should give preference to the newest file (i.e. 
> timestamp-based) rather than the latest policy version.  But even if we 
> were to make that change going forward, it won't help with existing 
> distro releases.

I guess that doesn't help either since the timestamp of the policy.N 
file generated at package build may still be older than that of any 
locally generated one, even if the package was installed later.
