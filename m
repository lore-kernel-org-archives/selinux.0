Return-Path: <SRS0=m98w=3S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D42C2D0DB
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 19:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A933820663
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 19:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Pfg6NzrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgA2T3U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:29:20 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:57054 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgA2T3U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jan 2020 14:29:20 -0500
X-EEMSG-check-017: 50681046|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="50681046"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Jan 2020 19:29:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580326158; x=1611862158;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=w1izRsHWmocrHCtANnEFZGDcw6LvieTVwc78Vzlq/xE=;
  b=Pfg6NzrQz4okXmQC8QCRm1oscakCJSzevrEps6/A9cUkES1rYbPvYMu+
   +pDYxFYUABM4T/8PHGZ3x3Obxf8577qwP9Csx9toFUyTaOQ5JCRPkCKZh
   uPnjNvnxzjRQeDi53ATIJHRa/o50ZiObo4+WwSpU82MpFBv7HLVvFfTt1
   LlpPWNl2zLD1STc9ncqTe4kHK9vdsSU6n29z8u+4j5WKacetc6ThmTkiw
   ZvQ3qonv+c7F8XgqzVCHlSvoYDP2/uR25aCUotyqhcFd3EKuWWLoIU0ch
   b/WfnXGaqf04EJHdIC5aAnmTOzK1KntHL0cpQA1AfyH+fIYR0o2yisJu3
   g==;
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="32472638"
IronPort-PHdr: =?us-ascii?q?9a23=3Akt7THxW466zx4Caoel7A7s/PFCvV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSEvKdThVPEFb/W9+hDw7KP9fy5BSpbv93Y6ipKMMQVEU?=
 =?us-ascii?q?Nc0oNOx01oKfXGIHWzFOTtYS0+EZYKf35e1Fb/D3JoHt3jbUbZuHy44G1aMB?=
 =?us-ascii?q?z+MQ1oOra9QdaK3Iy42O+o5pLcfRhDiiajbrNuNhW2qhjautULjYd4Jas91x?=
 =?us-ascii?q?TErmFGdulXym9kOEyfkwjh7cu04JJv7j5ctv08+8NOS6n2Y7g0QblFBzk6Lm?=
 =?us-ascii?q?4549HmuwPeRgWV/HscVWsWkhtMAwfb6RzxQ4n8vCjnuOdjwSeWJcL5Q6w6Vj?=
 =?us-ascii?q?Sk9KdrVQTniDwbOD4j8WHYkdJ/gaRGqx+8vRN/worUYIaINPpie67WYN0XSX?=
 =?us-ascii?q?ZdUstXSidODJm8b48SBOQfO+hWoZT2q18XoRawAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHwHY0gwuHNwAvnrbo9r3O6gOXu6417XIwDbZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9mvyY6z6cJuZ?=
 =?us-ascii?q?+9fCUSx5QnxgLfa/yac4eT+B7sSOGRITJ+iXl4e7y/nw6//VWvx+DzTMW50E?=
 =?us-ascii?q?tGojBbntTDqHwBzQHf586aQfVn5EihwyyA1wXL5+FBJkA7iLTUJoY6wr41ip?=
 =?us-ascii?q?oTqUPDHjLqmEnujK+ZaEEk+u+w5uT7eLrmvJ6cN5Jvig3kM6QunMK/AeMjMg?=
 =?us-ascii?q?cQQ2eX4/i81b3/8k35R7VGlPs2nbXCsJ/GP8gbo6+5AwtN3oYi7RawESum3c?=
 =?us-ascii?q?wFkXQII19JYhKKg5XzN13QL/30E+2zj0m0nDdu3f/GP7nhApvXLnjElbfsZa?=
 =?us-ascii?q?195FNHyAco0dBe545bCrEGIP7pXE/xr8bXAgU2Mwyz3ebrEM992Z8GWWKTHq?=
 =?us-ascii?q?+ZN7vfsUSW6eIrIumMYpIVuTnmJvg76P7hk2U5lUUefaa3x5sXbm63HvB8L0?=
 =?us-ascii?q?Wee3rsjc8LEX0WsQomUOzqlFqCXCZUZ3a3WKI8/Tc7B5i6AojdXY2tmqKO0z?=
 =?us-ascii?q?q7HpJMemBKEEyDEXDtd4+cQfcDdDqSItN9kjwDTbWhU5Uu1QyqtALh07poNP?=
 =?us-ascii?q?fU+ikBuZLm09h14PfTmg8o+TNoCMSd1nmHT3tokWMQWz82wKd/rFRnyleCza?=
 =?us-ascii?q?d4g+ZXFcZO6PxRTgg1LZ7cwPZ7C9D0RA3BZcyER026QtWnBzExUsw+w8UIY0?=
 =?us-ascii?q?ljB9WulAzM3y2vA+xdq7veH5Ew86TBz1DvKMtnjXXLzq8six8hWMQcG3ehg/?=
 =?us-ascii?q?tE6wXLB4PP236cnqKueLVUiDXB70+f3GGOuwdeSwc2XqLbCyNMLnDKpMj0sx?=
 =?us-ascii?q?uRB4SlDq4qZ04amMM=3D?=
X-IPAS-Result: =?us-ascii?q?A2DSAgD12zFe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVAEgEiqEFIkDhlkGgTeJb5FJCQEBAQEBAQEBASsMAQGEQAKCTjgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIU3DII7KYJ7AQUjDwEFQRAJAhgCAiYCAlcTBgIBAYJjP?=
 =?us-ascii?q?wGCViUPkgebeIEyiHSBPoEOKow6eYEHgTgPgl0+gksZAoFNY4JDgl4EjTgSi?=
 =?us-ascii?q?jCXXoJDgkyEdo5vBhuaf4p/jEWUOiKBWCsIAhgIIQ+DJwlHGA2SEIZRhCAjA?=
 =?us-ascii?q?zCORwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 29 Jan 2020 19:29:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00TJSTE6227928;
        Wed, 29 Jan 2020 14:28:29 -0500
Subject: Re: [PATCH] testsuite/policy: fixes for running on a labeled NFS
 mount
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        richard_c_haines@btinternet.com
References: <20200123193415.34022-1-sds@tycho.nsa.gov>
 <7cf87c7f-c190-165d-a000-4238a03b91d4@tycho.nsa.gov>
Message-ID: <cb308cdd-e0ee-0ddc-990a-902457264409@tycho.nsa.gov>
Date:   Wed, 29 Jan 2020 14:30:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7cf87c7f-c190-165d-a000-4238a03b91d4@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/29/20 1:44 PM, Stephen Smalley wrote:
> On 1/23/20 2:34 PM, Stephen Smalley wrote:
>> When running the testsuite on a labeled NFS mount, certain
>> additional permissions are required for nfsd and its kernel threads
>> and for the nfs_t filesystem.  Allow them to avoid unnecessary
>> failures on NFS.  Also declare test_setfscreatecon_newcon_t as a
>> files_type() to ensure that it can be accessed as expected by
>> unconfined domains; otherwise, cleanup and repeated runs are not
>> guaranteed to work.  Saw denials for unconfined_t and kernel_t on
>> test_fscreatecon_newcon_t when running over labeled NFS, but
>> at least the unconfined_t access was possible even for running
>> locally.
>>
>> With these changes, all of the "filesystem" tests pass on a labeled NFS
>> mount.
>>
>> Certain test cases are still expected to fail over NFS; see
>> https://github.com/SELinuxProject/selinux-testsuite/issues/32
>> for more details.
>>
>> Test sequence for labeled NFS is:
>> $ cat nfs.sh
>> MOUNT=/home # must be a top-level mount
>> TESTDIR=$MOUNT/path/to/selinux-testsuite
>> exportfs -orw,no_root_squash,security_label localhost:$MOUNT
>> systemctl start nfs-server
>> mkdir -p /mnt/selinux-testsuite
>> mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
>> pushd /mnt/selinux-testsuite
>> make test
>> popd
>> umount /mnt/selinux-testsuite
>> exportfs -u localhost:$MOUNT
>> systemctl stop nfs-server
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   policy/test_filesystem.te |  8 ++++++++
>>   policy/test_sctp.te       | 18 ++++++++++++++++++
>>   2 files changed, 26 insertions(+)
> 
> I went ahead and applied this. Further policy changes will be needed to 
> support testing on labeled NFS once more of the filesystem and/or 
> fs_filesystem tests are migrated to running in the host/native 
> filesystem rather than within the ext4 mount created by the test itself. 
>   I'd like to get to the point where we can fully run the testsuite on 
> labeled NFS, which will require making some other tests conditional on 
> filesystem type.  Then hopefully those who are running the testsuite 
> automatically could also add the above nfs.sh script or something 
> similar to their test harness and start exercising labeled NFS on a 
> regular basis to catch regressions.

Looks like my sample nfs.sh script above isn't quite right; need to 
start nfs-server before the exportfs.

