Return-Path: <SRS0=XRjJ=4B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DE4C352A3
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 20:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2E720848
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 20:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="eY0r3Sgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBMU7X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:59:23 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:28540 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBMU7W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 15:59:22 -0500
X-EEMSG-check-017: 58714804|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,438,1574121600"; 
   d="scan'208";a="58714804"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Feb 2020 20:59:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581627560; x=1613163560;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Q6KSKnwYICLUFyTmnziQGiIrHiiJCp6vKxtmWvm6jxg=;
  b=eY0r3SgxjJ/eRJCPGFZP352gXlro1H2bXN1nQGeUBZihVvJuN1sGdYtO
   Zpy7s7tJ7vRqpvet7rceVieE2qiANh56TkhGwn/KoKPGSHR5CdD1KO04j
   KHCM/ADhZwwWcZ2xSFKhPWvwcwF1EPe8Ov81ZAxSrWj9Rdxhw7fRqEUQ0
   TUB+iNNoNZVbumDvug3wbMp+mhO7ExFZ8PGkG5d/NCgaHIJTBD3YduZ3o
   XalY5T3XeUeg33wPyK7wVlK6x6MJylYgARYCz4DvyXX8rN5GuRgaG3giT
   a0FdIuxL1GZaEMXTTpMBsPipQ8XdPFsfLxu7WcT3s5ji6YyUsTOulpyPL
   w==;
X-IronPort-AV: E=Sophos;i="5.70,438,1574121600"; 
   d="scan'208";a="33052769"
IronPort-PHdr: =?us-ascii?q?9a23=3AdVHSmhAyo0crp2bWlwYfUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX/rsbcNUDSrc9gkEXOFd2Cra4d16yI4+u5BTdIyK3CmU5BWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRq7oR/Qu8QVjoduN6k8xx?=
 =?us-ascii?q?XUqXZUZupawn9lKl2Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElRrFGDzooLn?=
 =?us-ascii?q?446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXj?=
 =?us-ascii?q?Si8rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTm?=
 =?us-ascii?q?ZFR8pdSjBNDp+5Y4YJAeUBJ+JYpJTjqVUIoxW1GA2gCPrvxzJMg3P727Ax3e?=
 =?us-ascii?q?Y8HgHcxAEuAtIAvmrarNv2OqkdX++6w6vUwjvMdP5WxTTw5ZLUfhw9r/yBX7?=
 =?us-ascii?q?R9etfRx0k1EAPFi02dp5H5PzyLzuQNs3aU7+x9Xuyyjm4osQVxojyxycYsl4?=
 =?us-ascii?q?LEgZkVxU3f9Shi3IY0JcG3SE58YdK+FptQrDuVO5F5QsMlXWFloSA3waAFt5?=
 =?us-ascii?q?6jZCUG1ZsqyhHFZ/GHboSE+AzvWemPLTtimX5ofq+0iQyo/ki60OL8U9G50F?=
 =?us-ascii?q?NNriVYjNbBrmsN1xnP6sifTft941uh1S6P1w/N7uFEJlg5lbbBJJ47w74wi4?=
 =?us-ascii?q?ETvV7CHi/wlkX2i7SWeVs49eSy9+TmYqnppp+bN4NujAHxLr8uldClDeQ9Mw?=
 =?us-ascii?q?gOW3CX+eW61LL94U30WKhGg/I5n6XDsJ3WON4XqrC2DgNLyIov9g6zDzK839?=
 =?us-ascii?q?QZmXkHIkhFeBWCj4XxIFHBPev4AOyjg1WsjDhrx/fGMqfnApXWNHfPirjhfb?=
 =?us-ascii?q?Fj60JE0go80chf545ICrEGOP/zQE7xu8DYDhAjKQy73v7oB8ll2YMeQ22PA6?=
 =?us-ascii?q?mZP73JsVKT/e0vP+iMZIkJuDnjMfgl4eDhjWMjlVABeqmp2IMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88aEWgUugo+TerqiECNUDNIeXayULwz5ishBIKlE4jDXIatj6KF3C?=
 =?us-ascii?q?uhGZ1WfG9GWRiwFiLSdo6EUu0AIAKbI8lsiXRQT7mqS4Y72Salgw/zyrxqNc?=
 =?us-ascii?q?Le5iweqZ/50tVpoebUkEd2vSd5C8WbznGlUW55hCULSiUw0aQ5plZymXmZ1q?=
 =?us-ascii?q?0tuOBVDdxe4btyVw4+MZPNh7hhB8vaRhPKftDPTk2vBNqhH2diHZoK39YSbh?=
 =?us-ascii?q?MlSJ2ZhRfZ0n/vWuJEmg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AHBADBt0Ve/wHyM5BcChwBAQEBAQcBAREBBAQBAYF7A?=
 =?us-ascii?q?oF7gRhVIBIqhBSJA4ZfBoE3iXCRSgkBAQEBAQEBAQEjFAQBAYRAAoJwOQUNA?=
 =?us-ascii?q?hABAQEFAQEBAQEFAwEBbIU3DII7KQGDAgEFIw8BBVELGAICJgICVwYBDAgBA?=
 =?us-ascii?q?YJjPwGCViWuCYEyiReBPoEOKow+eYEHgTgPgl0+gkuBU4M9gjwiBJgLl2uCR?=
 =?us-ascii?q?IJPhH6OfgYcmxeOaJ0/IYFYKwgCGAghDzuCbAlHGA2YYYQgIwMwjyEBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Feb 2020 20:59:18 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01DKwM3n140673;
        Thu, 13 Feb 2020 15:58:22 -0500
Subject: Re: [RFC PATCH 0/1] selinux-testsuite: Use native filesystem for fs
 tests
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200213163037.14494-1-richard_c_haines@btinternet.com>
 <9ee7126b-b021-b384-ecb5-615f041d0a09@tycho.nsa.gov>
Message-ID: <1761fd15-6d7d-7f2f-71c5-ffb2e930727b@tycho.nsa.gov>
Date:   Thu, 13 Feb 2020 16:00:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9ee7126b-b021-b384-ecb5-615f041d0a09@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/13/20 3:55 PM, Stephen Smalley wrote:
> On 2/13/20 11:30 AM, Richard Haines wrote:
>> This is a first attempt at running the filesystem and fs_filesystem tests
>> on the native filesystem.
>>
>> It supports NFS when using the tools/nfs.sh script. NFS will support 
>> options
>> with rootcontext and fscontext, however due to the fsconfig(2) they 
>> bug will
>> not pass with these (see note in nfs.sh).
>>
>> The filesystem types supported are: ext2, ext3, ext4, xfs, btrfs, 
>> hfsplus,
>> reiserfs, nfs4. If not in this list, tests are skipped. I'm not sure what
>> others need supporting, these seem reasonable and available on Fedora.
> 
> Didn't receive the patch but will comment on a few items in your cover 
> letter.
> 
> Offhand, I'd suggest pruning it to just ext4, xfs, and nfs4.  There is 
> no separate ext3 filesystem in the kernel anymore (ext4 provides the 
> implementation for both ext3 and ext4).  ext2 and reiserfs seem to be 
> legacy filesystems and reiserfs never supported SELinux well to my 
> knowledge.  btrfs SELinux support seems to not be well supported; absent 
> a distro supporting them both that seems unlikely to change. hfsplus is 
> orphaned per MAINTAINERS and not likely to be used as a primary 
> filesystem for SELinux regardless.
> 
>> I've had to add a number of policy rules to support these types, however
>> I've made no attempt to consolidate them. Most are for supporting 
>> rootcontext
>> and fscontext on NFS. Rules for the 'context' option were many more so
>> decided not to add them - any views on this.
> 
> Wasn't sure what issue you are encountering there.  Could you use an 
> attribute ala file_type and/or fs_type or the corresponding refpolicy 
> interfaces to allow what you need with just a few rules?
>> When testing btrfs, most tests will fail on tests/fs_filesystem due to
>> the fsconfig(2) bug.
> 
> Yes, I'm disinclined to include btrfs in our testing until/unless a 
> SELinux maintainer is using a distro that defaults to it (or the 
> maintainer defaults to using it regardless) and ensures that it is kept 
> functioning.

Actually, I take that back.  I wouldn't want the testsuite to 
automatically try to create and test btrfs filesystems itself, but if 
you are just whitelisting on which filesystem types the testsuite will 
try to apply its tests when run there, including btrfs makes sense. 
Then it won't break automated testing runs on distros not using btrfs 
but we can still refer btrfs developers to the testsuite to identify and 
reproduce bugs/regressions.
