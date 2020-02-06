Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F83C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 16:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEEF214AF
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 16:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HWZNAtRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgBFQgZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:36:25 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:36043 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgBFQgZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 11:36:25 -0500
X-EEMSG-check-017: 55595845|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="55595845"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 16:36:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581006981; x=1612542981;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vl5kLX4ENAdO4Jth8Yso4e6WJN8eDxuKUC1ZVMjkJ1A=;
  b=HWZNAtRAonqKekQgZJA+u2iLsiZSQG6T5Rr0HkLCd5x900aKdaC3zqVl
   0Fa5GF3EXP/tOU/9d6ZQR/R1N0UGNR/yFkz7GuRI9AUsf8Is4uOH4rVTU
   9mmiYlMO7p81F3jV+rx97gTS8EtEr+I4dchsfYDS6NZHrjq/fqWAG11Re
   JI7kXvgg3WB6s6RDgD64VPKw+yvsP9E+Zp+XZZo264W6fBZ2A//K5sfcm
   t/AH0MVFTKvRho1QvhjVEU/TT2n6zRoRsKH19A31yvw/l7bBA9qCzlCLD
   x6czOrXt4ss2byBiK1OKGVe13M6V5Q2FLIbaxr3feh3zP5KAA4AqkTmMR
   A==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="32768340"
IronPort-PHdr: =?us-ascii?q?9a23=3A2BmfXxBgyUy4pxWSpviWUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37pciwAkXT6L1XgUPTWs2DsrQY0raQ7vurCTNIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrwxxx?=
 =?us-ascii?q?bHrXdFeOZbzn5sKV6Pghrw/Mi98INt/ihKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHS2?=
 =?us-ascii?q?VBRMJRXDFfDI26YYUEEu4NMf9WooT5olcDqwa1CwuxC+P10jJGm3/407M00+?=
 =?us-ascii?q?oiHw/J0gMvENASv3rbt9j1KKQfXPqpwKXUwzjObfVb0ir95ojSdRAhpOmBU6?=
 =?us-ascii?q?9sccXP0UkvFx3KjlONooL4OjOazOANs2yF4OtgSOmijHUnpBxqojW02sctip?=
 =?us-ascii?q?XGhoISylze8yV525w6Kce3SE58f96pCZ1dvDyUOYtxR8MtWWBouCAix70JuJ?=
 =?us-ascii?q?67YCgKyIk8yBLFd/OHdI2I7xT+X+iSOTd1nG9pdb2wihqo8UWs1/fwWte73V?=
 =?us-ascii?q?pUtCZJj9/BvW0X2RPJ8MiIUP5981+k2TaIyg/c9PlJIVsxlarHM54hxaMwlo?=
 =?us-ascii?q?YLvUTDACD2nEL2gbeKdko+4Oio6vnnYq78qp+dMY90hAb+Mr8wlcOjG+g4Lg?=
 =?us-ascii?q?gPUHSb+eS7zrHj+1H2QK5WgfEsl6nZsZTaKdwapq6/HQBVzp4u5wuwAjqpyt?=
 =?us-ascii?q?gVnWQLIEhbdB+IkYTlIUzCLOj9DfilglSslDlrx+rBPr3kGpjNNWXMkKz6cL?=
 =?us-ascii?q?Zh609T1AozzddF65JSEbEOOuj/WkD2tNzGFhM5KRC7w/77CNVh0YMTQXqPDb?=
 =?us-ascii?q?WEMKPWqlKI/vggI/SIZIMMvTb9LP8l5+TwgnMjhVAdeqyp14MNaH+kBvRmP1?=
 =?us-ascii?q?mZYX30j9caD2gKugs+TOr3iFyNSjNTeXmyULwm5j0hC4KpE53DRoazj7yFxi?=
 =?us-ascii?q?u7GYdWZm9eAFCWDXjob5mEW+sLaC+KJc9hlzsEVaOnS4A7yR6hqhT3y6B5Ie?=
 =?us-ascii?q?XJ+i0Xr47j2MJp6O3UkBE47SZ0ANiF02GRU2F0mXsFRyU33K9joUxy0E2D3r?=
 =?us-ascii?q?VgjPNEDdNT5+lGUgY8NZHC1Ox3EMv9Wh7AftePVFapXM+mATcvQdIt2dMBf0?=
 =?us-ascii?q?F9G9DxxizEijKjHrs9j7WWANkx9aXG0j76IMMu5WzB0fwak1Q+QsZJfVajj6?=
 =?us-ascii?q?p7+hmbU5XFiG2Fhq2qcuIaxyeL+2Cdmznd9HpEWRJ9BP2WFUsUYVHb+JGit0?=
 =?us-ascii?q?4=3D?=
X-IPAS-Result: =?us-ascii?q?A2A8AwAJQDxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBe?=
 =?us-ascii?q?AWBGFQhEiqEFYkDhmMBAQEGgTeJcJFLCQEBAQEBAQEBASsMAQGEQAKCYTgTA?=
 =?us-ascii?q?hABAQEEAQEBAQEFAwEBbIU3DII7KYMDAQUjDwEFQRALGAICJgICVxMGAgEBg?=
 =?us-ascii?q?mM/AYJWJQ+sQIEyiRSBPoEOKow9eYEHgTgPgl0+gksZAoEsg0mCXgSNPkqJf?=
 =?us-ascii?q?HyWa4JEgk6EfIVGiTAGG5sLl06USCKBWCsIAhgIIQ+DJwlHGA2SEIZRhCAjA?=
 =?us-ascii?q?zCMB4JDAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Feb 2020 16:35:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016GZ3Gw142340;
        Thu, 6 Feb 2020 11:35:04 -0500
Subject: Re: [PATCH v3 2/2] testsuite: add further nfs tests
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com
References: <20200130202239.11498-1-sds@tycho.nsa.gov>
 <20200130202239.11498-2-sds@tycho.nsa.gov>
 <306f9a78-695c-dfd3-3524-3814997fac51@tycho.nsa.gov>
Message-ID: <099d42f9-f26a-be99-8bac-f151812a4726@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 11:36:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <306f9a78-695c-dfd3-3524-3814997fac51@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/5/20 12:10 PM, Stephen Smalley wrote:
> On 1/30/20 3:22 PM, Stephen Smalley wrote:
>> In addition to testing full NFS security labeling support,
>> make sure that context mounts continue to work independent
>> of whether the mount was exported with security_label, and
>> add a simple test of the default NFS file labeling.
>>
>> With the previous changes, this completes addressing
>> https://github.com/SELinuxProject/selinux-testsuite/issues/32
>>
>> Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/32
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>> v3 moves nfs.sh under tools/, updates README.md, and fixes nfs.sh for
>> the relocation.  As before, these patches depend on the previous one
>> ("testsuite: enable running over labeled NFS") in order to allow the
>> testsuite to pass on NFS mounts.
>>
>>   README.md    |  5 ++++-
>>   tools/nfs.sh | 38 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 42 insertions(+), 1 deletion(-)
> 
> Both are now applied.
> 
> [...]

It would be good if we could get tools/nfs.sh running on kernels going 
forward in addition to regular runs of selinux-testsuite.

A few potential enhancements and improvements that could still be made 
in the area of NFS testing:

1) There isn't yet a test that trying to mount the same NFS filesystem 
with two different sets of context mount options (or one with and one 
without context mount options) is rejected as expected.

2) There was an earlier bug where mounting a security_label exported NFS 
filesystem twice could clear the native labeling flags and thereby 
disable NFS security labeling support; this was fixed by kernel commit 
3815a245b50124f0865415dcb606a034e97494d4.  Adding a test to confirm that 
this behavior doesn't recur might be useful.

3) There was an earlier bug where context mounts of security_label 
exported NFS filesystems yielded mixed behavior with the top-level mount 
and newly created files appearing with the context mount value but 
pre-existing files appearing with the underlying xattr value; this was 
fixed by 0b4d3452b8b4a5309b4445b900e3cec022cca95a.  My original version 
of nfs.sh actually would have caught this because it was testing the 
context of the nfs.sh script file itself within the context mount but I 
dropped it back to only checking the top-level mount directory when I 
moved tools/nfs.sh to avoid depending on a fixed location for it, so it 
won't be caught currently.  We should probably change it back to testing 
the context of a pre-existing file within the mount; any file will do.

4) Ensuring that all of the tests/filesystem and tests/fs_filesystem 
tests that make sense for NFS are being run on the NFS mount itself and 
not just on an ext4 mount created by the test script.

5) We could have nfs.sh set a variable checked by tests/Makefile to skip 
any tests that are completely irrelevant from a filesystem security 
labeling perspective to minimize noise and duplication with regular runs 
of selinux-testsuite.  In a certain sense, they all exercise filesystem 
security labeling in that they are depending on file labels but they 
aren't all testing that functionality per se.  Deciding exactly which 
ones to include/exclude may not be entirely obvious though.
