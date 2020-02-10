Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB5FC352A4
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 20:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3482020715
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 20:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZexXh70V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgBJUsb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:48:31 -0500
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:36270 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgBJUsa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 15:48:30 -0500
X-EEMSG-check-017: 75313490|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,426,1574121600"; 
   d="scan'208";a="75313490"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Feb 2020 20:48:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581367702; x=1612903702;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=BA1IwcUb098B89G6mAvR8LQq9V6wd3AjmJ4CZ2IcQy0=;
  b=ZexXh70VSOUApVZmBOwaoX8UaiUlhUFjd3AEPI1cjgOJTZTmIywCv/er
   yF1GIrSjJKoCmzZ6vfAp6pEaS/y3ibuM3+g9/BJQxoF2aMA/RqOLwnNhq
   32lwHKfwv8hPYffnCpHzk6vQIo0MEc+FCab31EYHOfEOuxk8tyOn1u1CA
   o3CoB0qrvWLT3MLF70KF/lfCBazYGNesopojo7gZizu033cekzpPZHJXs
   6nLTfSVrpzKjcqo03szlkhABXXjjxjtH8EHavQDdE4nUUea9BRxhDlz+z
   f8kf2p3y/Jbuy6ZvuqlEOy5QhrbNwO83gYMdk1Mp2mPtyA7MOZFPVJb6w
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,426,1574121600"; 
   d="scan'208";a="38917696"
IronPort-PHdr: =?us-ascii?q?9a23=3AyGHNfRJS63psTQ8wfdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKvX6rarrMEGX3/hxlliBBdydt6sYzbSP+Pm7ACRAuc/H7ClZNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULjoZuMKc8xg?=
 =?us-ascii?q?bGrndVdela2H5jKVaPkxrh/Mu984Nv/ipKt/4968JMVLjxcrglQ7BfEDkoKX?=
 =?us-ascii?q?0+6tfxtRnEQwuP538cXXsTnxFVHQXL7wz0U4novCfiueVzxCeVPcvtTbApQj?=
 =?us-ascii?q?ui9LtkSAXpiCgcKTE09nzch9Fqg6JapBKhoAF/w5LRbYqIOvdyYr/RcNUHTm?=
 =?us-ascii?q?daQM1fSzJODZ+9b4sXDuoOI+BYr5Xmp1ATqReyHBSgCP/zxjNNgHL507c60+?=
 =?us-ascii?q?A8Gg/Y2gIuEc8FvHDNoNj7MKoeVOa4x7TKwzredfNbwSrz5pbGch4hov+CU7?=
 =?us-ascii?q?x/fsXTxkYzGA3IlUmQpI7/Mj+JyugAvWqW4ux9XuyvkW4nrARxryCyyMcwlI?=
 =?us-ascii?q?bJnoIVxU7C9S5k3Yg1IMe3SEp/YdG6EJpbqiaXN5BrTcM5WGxopCY7xaEGuZ?=
 =?us-ascii?q?68ZiQKzo8nyATFZ/yIdIiI/AvuWeCMKjl2g3Jlfaiwhxe08UW4xezzSs6030?=
 =?us-ascii?q?tUoSdBiNXDrGgN1wTV58OaSfV95l+s1SuA2g3c8O1JIV04mbDFJ5Mu3LI8jI?=
 =?us-ascii?q?cfvELeFSHsgkr2lrWZdkA89+it7OTof6vpq4eHN49xlgH+KqMumtGjAeggMg?=
 =?us-ascii?q?gBQWyb+eOk2b3/50L5WrRKjuAtkqXDsZDaI8obpqmiAwBLzokv8Qq/Dje639?=
 =?us-ascii?q?QYmnkLNlRFdw6cj4f1IV3OJfH4DfOnj1Stljdk2ezGM6X8DpjCIXXPirfsca?=
 =?us-ascii?q?tn50JCxwc/08pT649MBrEEOv3zW0vxtNLCDh8+Ngy52/3nB8hm1o4FRWKOAr?=
 =?us-ascii?q?OWMKPVsVOS4OIvOPODaJUauDb6Nfgp/+TugmMhmV8BYamp2oMaaHa+HvRlOE?=
 =?us-ascii?q?iZbn3sgtAOEWcOoAUyVvDliFqHUTRLfXa9Q7o85i0nCIKhFYrDXZ6igLiA3C?=
 =?us-ascii?q?e9A51XaXtLCk6DEXj2bYWIQfQMZzyIIs9njDMEUaKtS4g71RGhrAX60aZoLv?=
 =?us-ascii?q?LI+i0EspLuzMJ15+zPmhEy7zN0FdmS3HmRQG5snmMHXT423KZhrkxm0VqMyr?=
 =?us-ascii?q?R4g/1eFdxP+fxJSAE6OoDAz+BgF9/yXQfBLZ+1TwOAQ96lSRIrR9Y83d4FYw?=
 =?us-ascii?q?4pHdOhph/E2CWuDvkekLndQNQv/6bd2WXhD9hyxmyA16Q7iVQiBMxVOinuvK?=
 =?us-ascii?q?909wHJC8bpmkSfmr3iIb4d1y7E7mu0xl2OtUBeXRVYW7nEW2wSfE3bsZLy4U?=
 =?us-ascii?q?aUHJG0DrFyCRdM0c6PLONxb9TtiVhXDKP4NM/2f3O6m2D2Aw2BgLyLcty5KC?=
 =?us-ascii?q?0mwCzBBR1cwEgo9nGcOF17X3zwrg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2D5AgCOwEFe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBWJA4ZmAQEBBoESJYlwkHQDVAkBAQEBAQEBAQE3AQGEQAKCajgTA?=
 =?us-ascii?q?hABAQEEAQEBAQEFAwEBbIVDgjspAYMCAQUjFVELDgoCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?mM/glclqUSBMoVKgy+BPoEOKow9eYEHgTgMA4JdPoQSg0mCPCIEll9jRpdqg?=
 =?us-ascii?q?kSCTpN4BhubDy2ON502IjeBISsIAhgIIQ+DJ1AYDY4oAReOQSMDMIwlgkMBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Feb 2020 20:48:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01AKlORo183488;
        Mon, 10 Feb 2020 15:47:26 -0500
Subject: Re: [PATCH] label_file.c: Fix MAC build
To:     Nick Kralevich <nnk@google.com>, selinux@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
References: <20200207230032.210843-1-nnk@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <92a60e95-f304-5361-82dc-89a3c3590962@tycho.nsa.gov>
Date:   Mon, 10 Feb 2020 15:49:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207230032.210843-1-nnk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/7/20 6:00 PM, Nick Kralevich wrote:
> On Android, the label_file.c file is compiled for all platforms,
> including OSX. OSX has a slightly different prototype for the
> getxattr function.
> 
> ssize_t getxattr(const char *path, const char *name, void *value, size_t size, u_int32_t position, int options);
> 
> which causes a compile error when compiling libselinux on OSX.
> 
>    ```
>    external/selinux/libselinux/src/label_file.c:1038:37: error: too few arguments to function call, expected 6, have 4
>                                         read_digest, SHA1_HASH_SIZE);
>                                                                  ^
>    /Applications/Xcode9.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/usr/include/sys/xattr.h:61:1: note: 'getxattr' declared here
>    ssize_t getxattr(const char *path, const char *name, void *value, size_t size, u_int32_t position, int options);
>    ^
>    1 error generated.
>    ```
> 
> On OSX builds, add the additional arguments so that the code compiles.
> 
> As both SELinux labels and the restorecon partial digest are stored in
> extended attributes, it's theoretically possible that someone
> could assign SELinux labels and hash digests on OSX filesystems.
> Doing so would be extremely weird and completely untested, but
> theoretically possible.
> 
> Signed-off-by: Nick Kralevich <nnk@google.com>

Wondering why the getxattr() call isn't done in the selinux_restorecon 
code instead, or why this is needed as a separate selabel_ interface at 
all. Probably too late though to change it though without breaking API/ABI.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libselinux/src/label_file.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 300625c2..f2aaf3ba 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -985,7 +985,11 @@ static bool get_digests_all_partial_matches(struct selabel_handle *rec,
>   {
>   	uint8_t read_digest[SHA1_HASH_SIZE];
>   	ssize_t read_size = getxattr(pathname, RESTORECON_PARTIAL_MATCH_DIGEST,
> -				     read_digest, SHA1_HASH_SIZE);
> +				     read_digest, SHA1_HASH_SIZE
> +#ifdef __APPLE__
> +				     , 0, 0
> +#endif /* __APPLE __ */
> +				    );
>   	uint8_t hash_digest[SHA1_HASH_SIZE];
>   	bool status = selabel_hash_all_partial_matches(rec, pathname,
>   						       hash_digest);
> 

q
