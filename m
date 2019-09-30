Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA26FC32792
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 12:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCBF20842
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 12:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="e4P1PWgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfI3Mlj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:41:39 -0400
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:2317 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730769AbfI3Mli (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 08:41:38 -0400
X-EEMSG-check-017: 31238146|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="31238146"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Sep 2019 12:41:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569847297; x=1601383297;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8/WQOFWztYGkHqlSc2cKwGB4rw8f5suykAjxL5o6G8g=;
  b=e4P1PWgPCnhyIrJhjhQaNQiyzJrFm6uKqpCZgTlJQvahMS9+q5kae60o
   zO9LjS7SOC/eh/ocpc5zlNmGLMejWpWIYIsBGVDSbSRJ+bAC0srB2kVQx
   CTA6suVc1b+Otri6Cooe6ik1lg4SiVerK0TMvygGFVAipp5zKkjAJq7hh
   rF8auM+zzeBaszwqFNfLF+4MAGxJ7EJbyhK62YGbO9QuzICb6re7bbCu2
   qYSwuZ0zYsER4GTpMg3lkRJuSm6DJLIvVykRMw/AX57z23Lz9L4Xo+Ult
   5I+Jb/hgFbWjINP1EZ2piwHhRxJTaR/SkA4i7ahrcHmT7ehbHcRIzG7G4
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="33509261"
IronPort-PHdr: =?us-ascii?q?9a23=3AlsAouR+3rfF8uf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B20e8cTK2v8tzYMVDF4r011RmVBN6dt6gP1rKempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCCybL9sIxm7rRndvdQKjIV/Lao81g?=
 =?us-ascii?q?HHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9Lm?=
 =?us-ascii?q?A6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD?=
 =?us-ascii?q?+/9KpgVgPmhzkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe90VRX?=
 =?us-ascii?q?BFXs1MSSJPBI2yZJYLA+YYI+pVq4zxql0TphW8GAasHvvixCJWiH/43aM00O?=
 =?us-ascii?q?ovHg/J0wMiA90Av2/ZrMn3OaoITey50KfFwDfFYvhL2Tn98o/IchU5rP+RQb?=
 =?us-ascii?q?J/b9LRyUkxGAPDk16etInlMCmR1uQJrWea7/drWOW0i2E6sAF8uSSvx8cwhY?=
 =?us-ascii?q?nJgYIZ0FbE9T5jz4ovKt24T1B7bMeiHZBNuS+aMI52TdkjQ2FuoCs6xbwGuY?=
 =?us-ascii?q?K7fCgX05sr3QLQa/uCc4SQ+hLiVPqRITd/hHJjYr6/gAyy8Uemx+bhVce0yE?=
 =?us-ascii?q?5HojdKn9TDrHwA1wHf5tKZRvZy4EutwyuD2gbO4e9eO080j7DUK5s5z741kZ?=
 =?us-ascii?q?ocrFrMEzftmEXzkK+WbkIk+vW06+j/YrXpuJucN4hshwHiKKsugM2/AfkjMg?=
 =?us-ascii?q?QUQ2ia+fiz1L3k/UHjRrVFkuY2nbXDvJDfJMQbora1Aw5T0ok99xayFyqq3d?=
 =?us-ascii?q?sXkHUdLF9JZQiLg5bmNl3QOvz0EO+zg1G2nzdqw/DGMKfhApLILnXbi7fuYK?=
 =?us-ascii?q?195lVAyAsz0d9f55VUBqsHIPLoQED9rtPYDhgnMwCs2eboFM191p8CWWKIGq?=
 =?us-ascii?q?KZNqLSvkOP5uIrOeaMf5UZuDf6K/gi/P7ulmQ0mVoScKimx5cXb2q4Hvt+KU?=
 =?us-ascii?q?WDfXXsmssBEXsNvgcmV+zlllmCUT9VZ3avUKMx/S87CI24AofZXIytg6KO3D?=
 =?us-ascii?q?29HpJIYmBKEFeMEW3nd9bMZ/BZTiOZJctoiXQlUr+6UMd10xClswvz0PxmKe?=
 =?us-ascii?q?3P4QUd6YKl08J6sb79jxY3oAdoAtyd3mfFdGR9mmcFVndix6xkiVBswVeEl6?=
 =?us-ascii?q?5jirpXEsIFtKABaRszKZOJl78yMNv1QA+UO47TGVs=3D?=
X-IPAS-Result: =?us-ascii?q?A2B7AQDQ9pFd/wHyM5BmHQEBBQEMBQGBVQYBCwGBcyptU?=
 =?us-ascii?q?zIqhCKPPwMGgTaJdY8vFIFnCQEBAQEBAQEBASsJAQIBAYN7RQKDQyM2Bw4CD?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshS0MgjopAYJnAQEBAQIBIxVBEAsYAgImAgJXBg0GA?=
 =?us-ascii?q?gEBgl8/AYF2BQ8PrCF1gTKETEFAgyaBSIEMKAGMDRh4gQeBOIJrPoJhAgGBK?=
 =?us-ascii?q?R+DI4JYBJYKiCSOaYIsgi6EV44ABhuDKZYNljmTCAUsgVgrCAIYCCEPO4JsC?=
 =?us-ascii?q?UcQFIVAhRRRhQolAzABgQUBAY0kglQBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Sep 2019 12:41:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8UCfXNP009066;
        Mon, 30 Sep 2019 08:41:34 -0400
Subject: Re: [PATCH] python/sepolicy: call segenxml.py with python3
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20190926125218.22958-1-sds@tycho.nsa.gov>
 <CAJfZ7=ntt2dH6PN3tMQMdw99x4dpU3eRoAd62W4Fqgkvt5Lb5g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e96c532b-f469-fd52-ce6d-3e71dc9e145a@tycho.nsa.gov>
Date:   Mon, 30 Sep 2019 08:41:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=ntt2dH6PN3tMQMdw99x4dpU3eRoAd62W4Fqgkvt5Lb5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/26/19 5:58 PM, Nicolas Iooss wrote:
> On Thu, Sep 26, 2019 at 2:52 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> Fixes: https://github.com/SELinuxProject/selinux/issues/61
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   python/sepolicy/sepolicy/interface.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
>> index 583091ae18aa..b1b39a492d73 100644
>> --- a/python/sepolicy/sepolicy/interface.py
>> +++ b/python/sepolicy/sepolicy/interface.py
>> @@ -196,7 +196,7 @@ def get_xml_file(if_file):
>>           from subprocess import getstatusoutput
>>       basedir = os.path.dirname(if_file) + "/"
>>       filename = os.path.basename(if_file).split(".")[0]
>> -    rc, output = getstatusoutput("python /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
>> +    rc, output = getstatusoutput("/usr/bin/python3 /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
>>       if rc != 0:
>>           sys.stderr.write("\n Could not proceed selected interface file.\n")
>>           sys.stderr.write("\n%s" % output)
> 
> Considering that Python's "command" module was removed in Python 3
> (according to https://docs.python.org/2/library/commands.html), and
> that Python 3's subprocess.getstatusoutput() supports using a list of
> arguments instead of a string, it seems better to change this code to
> something like:
> 
>      from subprocess import getstatusoutput
>      basedir = os.path.dirname(if_file)
>      filename = os.path.basename(if_file).split(".")[0]
>      rc, output = getstatusoutput(["python3",
> "/usr/share/selinux/devel/include/support/segenxml.py", "-w", "-m",
> os.path.join(basedir, filename)])
> 
> The code that I suggest is not compatible with Python 2 (which does
> not support using list of arguments). Therefore, doing so makes
> sepolicy really Python-3 only. I do not consider this to be an issue,
> but others may prefer to wait for 3.0 to be released before dropping
> support for Python 2 completely.

Anyone else have an opinion on whether we should fix this in a 
python2-compatible manner?

Also, should it be just "python3" or "/usr/bin/python3"?

> 
> By the way, the current code is quite misleading because ("%s" % a +
> b) is interpreted as (("%s" % a) + b), not ("%s" % (a + b)).
> Thankfully the "%s" is at the end of the format string, but if you
> want to keep Python 2 compatibility, I suggest adding parentheses
> somewhere.
