Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C165C2BA83
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 13:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7272086A
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 13:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="iGyEzuNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgBNNQV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:16:21 -0500
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:24581 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgBNNQU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 08:16:20 -0500
X-EEMSG-check-017: 78012772|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,440,1574121600"; 
   d="scan'208";a="78012772"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2020 13:16:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581686179; x=1613222179;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Rx1W+R1ZR+iU1R3mY2P11aY6t1aWDLRB9rTUS9wKs68=;
  b=iGyEzuNbjk4ge0xZFNkQi30Q/oSvmF/I6K9hkiNUubwCjkKoCjAe57rX
   AJQKS8m5R0AmT4j3V7+B5GyrOI2FJfaOHZzG7HVPUlCybJZAByEr+F5hn
   Iaq5C+W83jkCFVzZEeyfxyJwBPSDfONU3nvDie8+0SXeV8lIPIKp//pPP
   Nacx+1Ja5kPRmu6d6Z8dHkpv4ewjytDMGYWSLSS6iIEQGuf1Jg++UlWaC
   HWO1ZSr0rwRdn7ilKB6pznYBlGIFF9uydz+80t6tJmZgKtk2NHACsJX4q
   /0tRgIfOdqODr+d2xpFXXK+iUkNVCW0UzCaRnHu8fXBoGLALcmg7WMdB4
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,440,1574121600"; 
   d="scan'208";a="39125970"
IronPort-PHdr: =?us-ascii?q?9a23=3Ac+5N7h+ll0YX+/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+sVIJqq85mqBkHD//Il1AaPAdyHra0cwLaH+4nbGkU+or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCeybL9oLhi6sQrdu8YSjIB/Nqs/1x?=
 =?us-ascii?q?zFr2dHdOhR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRa+AQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9roCY30qAKtJ?=
 =?us-ascii?q?G0cSQQyJkr2gTTZ+KIfoSW+B7vSeCcKipiin1/YrKwnROy/FClyu37S8a7zk?=
 =?us-ascii?q?5HrjFAktnQrnAN0AHT6tSfRvt94Eih3TGP2hjP6u5eO0A0lLfbK4U7zr4xkJ?=
 =?us-ascii?q?oTv0PDHjTol0rqlqOWakUl9fSo6+TgeLnmoIOTN5RohQ3kN6Qum8i/Dfw5Mg?=
 =?us-ascii?q?gIQWeb5fyx2KDs8ED2WrlHjuA6nrPHvJ3VO8gXvLO1DxdQ0ok56ha/Czmm0M?=
 =?us-ascii?q?4fnXkCNF9FYw+Ij5PyNlHSIPH3Efe/g1O2nDdt3PDJJKftAprKLnjdiLvhZ6?=
 =?us-ascii?q?py61ZAyAovytBS/4pUBascIPL3QULxrMbXDgI9MwCtxubnD9J91pkAVm6VHq?=
 =?us-ascii?q?CZN6bSu0eS5u0zO+mMeJMVuDHlJvg++fHuiX45mVkAfaimxpYXdn+4Eep8I0?=
 =?us-ascii?q?mDYnrjnM0BEWEUsQo6VuDqj0eCUTFLbXaoQ608/i07CJ6hDYrbQYCthbuB3D?=
 =?us-ascii?q?y9HpJMem9JFEuBEW32eIqZW/cDcj6SLtV9nTwDULirU5Uh2g22tA/m17pnKf?=
 =?us-ascii?q?LZ+jcZtZ3/1Nh6/ffTmgwq+jNoF8ud03uCT2BynmwWXD87x7twoVB8yleFza?=
 =?us-ascii?q?h3neZYFdpN6PNVSAs1KZncz+kpQ+z1DzrIY9PBbVGhWNjuVSk4U9YZ29YTZw?=
 =?us-ascii?q?N4HNK4g1bI2C/8UJEPkLneP4A56qLR2TDKIs95z3vXnP06g0IOXtpENWrggL?=
 =?us-ascii?q?V2sQfUGdiawA2ii6+2ePFEj2b2/2CZwD/L5RwJXQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CUAAD2nEZe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gRhVIBIqhBSJA4ZaAQEEBoE3iXCRSgkBAQEBAQEBAQEjFAQBAYRAA?=
 =?us-ascii?q?oIlNwYOAhABAQEFAQEBAQEFAwEBbIU3DII7KQGDAgEFIxVBEAsYAgImAgJXB?=
 =?us-ascii?q?g0GAgEBgmM/AYJWJa15gTKFSoNNgT6BDioBjD15gQeBOA+CXT6CS4UQgl4El?=
 =?us-ascii?q?0dGl22CRIJPhH6OfgYcgjmBCpdVrCYjgVgrCAIYCCEPgycJRxgNlhiCSYQgI?=
 =?us-ascii?q?wMwkFgBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Feb 2020 13:16:18 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01EDFKvB081330;
        Fri, 14 Feb 2020 08:15:20 -0500
Subject: Re: [PATCH v3 2/2] testsuite: add further nfs tests
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com
References: <20200130202239.11498-1-sds@tycho.nsa.gov>
 <20200130202239.11498-2-sds@tycho.nsa.gov>
 <306f9a78-695c-dfd3-3524-3814997fac51@tycho.nsa.gov>
 <099d42f9-f26a-be99-8bac-f151812a4726@tycho.nsa.gov>
 <CAHC9VhQMPEcgQVid2L4a4iO=2DUW+vwM1_vVxf0+KAum5+bYnA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e5de947b-4b80-6f1e-8dc5-c434c1fa6201@tycho.nsa.gov>
Date:   Fri, 14 Feb 2020 08:17:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQMPEcgQVid2L4a4iO=2DUW+vwM1_vVxf0+KAum5+bYnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/13/20 5:12 PM, Paul Moore wrote:
> On Thu, Feb 6, 2020 at 11:36 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> It would be good if we could get tools/nfs.sh running on kernels going
>> forward in addition to regular runs of selinux-testsuite.
> 
> I've never tried this ... is it possible to mount a NFS mount over
> loopback?  What about labeled NFS?

Yes to both.  That's how tools/nfs.sh works.  I added instructions to 
the README.md as part of the patch for dependencies and running it, but 
it isn't run by default.


