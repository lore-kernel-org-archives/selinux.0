Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EF2C43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 13:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D86520C01
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 13:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Ft+Eg8gY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfB0Nwv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:52:51 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:23074 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbfB0Nwv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Feb 2019 08:52:51 -0500
X-EEMSG-check-017: 647699231|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,419,1544486400"; 
   d="scan'208";a="647699231"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Feb 2019 13:52:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551275568; x=1582811568;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=01kU7cGsbI2ckuCeO76t8bvrInqFkhUIXMF4jxf0zl8=;
  b=Ft+Eg8gYsY+mJlqd4IRNTCUa8yFsJGT+3/zwOitaZZ1pJY+H2Bymme5t
   3bWa+2io2+aQps9UbaAf2Dtrtw+ju/NIaIj/tC/1XUrrAuW0VTL5lA5j8
   pikwJfMiphbcSRxm631wwAUVA4WXeOe9Wv/egRGNu/dqmYZfzSpoVmMt/
   fkzrT8G51UDEBeBbzSCSfQUNC6jAvHkH2IKmEhFpizo+zeUCRc/xWjCTf
   pFCiH3eUbyOgdTyE145nApibbU9IZjQTwWqUF/2dLq61XcoMPFbbc2dMb
   zMefhYUdySlOIH9fCih6udFHb/qeiDse+K2MCb4GzoQx09DF4XZkZqzrH
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,419,1544486400"; 
   d="scan'208";a="24386572"
IronPort-PHdr: =?us-ascii?q?9a23=3AZB3UtBKXpLww/Ba03tmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKv76rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz?=
 =?us-ascii?q?+s87lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvdxcLndfdcHTm?=
 =?us-ascii?q?RfWMhfWTFKDoelY4YOCuYMO/tToYvgqFsUtRawGAmiCv3hyjFLiHH506I13O?=
 =?us-ascii?q?Y9Hg/JxwEgA9EDvW7IoNnpOqofU+a4x7TIwzXZaPNW3C/w5pXUch8/ufGMXa?=
 =?us-ascii?q?x/cczMwkcyEgPKlFGQqYj7MDKVy+8AtHOb4Pd7Ve+0l24mqx1+ojioxss2jI?=
 =?us-ascii?q?nJnZgaxkrL9SV+3oY4PNu1Q1N1b96jFZtfrSCaN41uT8M5XW5ovCc6yrsbuZ?=
 =?us-ascii?q?+0ZCgK0pMnxxzBZPObb4iE+BXjVPyeITtgi3Jlf7W/hxm28Ue+0e38UdS00E?=
 =?us-ascii?q?xWoSVbiNXDqncN1xnV58OaSfV95l+s1SuA2g3c8O1JIV04mbDFJ5Mu3LI8jI?=
 =?us-ascii?q?cfvELeFSHsgkr2lrWZdkA89+it7OTof6vpq4eHN49xlgH+KqMumtGjAeggMg?=
 =?us-ascii?q?gBQWyb+eOk2b3/50L5WrRKjuAtkqXDrJDbJdgUpq6+AwNP1IYs9w2/ACu83N?=
 =?us-ascii?q?QdnHkHKEpJeBOBj4f3J1HDOO30APiwjli2kDpn2urKMqPuD5nTNHTPja/tfb?=
 =?us-ascii?q?Nn5E5dzAozw8pf55VRCrwZO/L8R1TxucfEDh45LwO0w+HnBM971oMFQ22DGK?=
 =?us-ascii?q?CZMKTMsVOQ/OIgP/GMZJMJuDb6M/Ul/+DhgmQnll8bfKmpwZwXZWu5Hvt4PU?=
 =?us-ascii?q?qWf2DggtAbEWcFpgA+VvDliEWeUT5PYHa/R6A85jYlB4+9C4fMXIStgLib0C?=
 =?us-ascii?q?inGZ1WY3hMCkqQHnfwa4WER/AMZTqJIsB/ljwEVL6hS5Iu1By1qg/6xKRoLv?=
 =?us-ascii?q?DO9i0bq53jzt516PPXlR0o8jx0FcudgCmxSDRfnnkJXHcO0Ypyp01hzR/Xya?=
 =?us-ascii?q?VyjvpZCdt75v5EX0E9L5GKi6RYDN26fAvFep/dSlGratOvBTV3RdU0lZtGeE?=
 =?us-ascii?q?t5GtO/njjd0CewRbwYjbqGANoz6K2P8WL2IpNG13ve1KQnx2IjS89LOHzu0r?=
 =?us-ascii?q?Vz7CDPFoXJlAOfjK/seqMCin2evFyfxHaD6RkLGDV7Vr/ICDVGPhXb?=
X-IPAS-Result: =?us-ascii?q?A2AsAACplXZc/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VkqZ4EDhC+IGotMTAEBAQEBAQaBECV8iECOZIF7MAgBg3pGAoQNIjQJDQEDA?=
 =?us-ascii?q?QEBAQEBAgFsHAyCOikBgmcBBSMPAQVRCxgCAiYCAlcGAQwIAQGCXz0BgWUND?=
 =?us-ascii?q?6sjgS+KLYELiz0XeIEHgREnDIIqNYMShHmCVwKRXpIMCYdCiyIGGYJLkFGKX?=
 =?us-ascii?q?YVWji84gVYrCAIYCCEPgygIgh8Xg0uFFIVdIQOBNQEBjnkrgiABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Feb 2019 13:52:48 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1RDqlsM027317;
        Wed, 27 Feb 2019 08:52:47 -0500
Subject: Re: neverallow rules
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Chris PeBenito <pebenito@ieee.org>, Joe Nall <joe@nall.com>,
        selinux@vger.kernel.org
References: <10D60D97-3E05-4F8C-86B5-8A56FCEFB3B1@nall.com>
 <6d65bb0be6bd5ccbdb1f99a646679e21955d6159.camel@ieee.org>
 <f1d65c8e-4490-5df0-7ba5-b589e3d85713@tycho.nsa.gov>
Message-ID: <be045c89-1c1e-7c1a-0223-0ba655980d7c@tycho.nsa.gov>
Date:   Wed, 27 Feb 2019 08:48:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f1d65c8e-4490-5df0-7ba5-b589e3d85713@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/27/19 8:29 AM, Stephen Smalley wrote:
> On 2/26/19 10:38 PM, Chris PeBenito wrote:
>> On Tue, 2019-02-26 at 19:29 -0600, Joe Nall wrote:
>>> Looking at neverallow rules, the semanage.conf file says
>>> "# expand-check check neverallow rules when executing all semanage
>>> commands.
>>>   # Large penalty in time if you turn this on. "
>>>
>>> If I don't set expand-check=1, are the neverallow rules actually
>>> enforced?
>>
>> Nope.
>>
>>> If so, when?
>>>
>>> An semodule -i of a policy module with neverallow rules that are
>>> violated by the existing binary policy succeeds without complaint
>>> unless expand-check=1 in RHEL 7.6. This is not what I expected.
>>>
>>> The time taken by a trivial module installation goes from ~.3 seconds
>>> to ~14 seconds, so the time hit for expand-check is pretty serious.
>>
>> The reason for adding the expand-check option is because the neverallow
>> checking is so expensive.
>>
>>> We are trying to establish some policy invariants to protect against
>>> unexpected/unnoticed RHEL upstream policy changes, some of which have
>>> bitten us recently. Any suggestions are welcome.
>>
>> One alternative would be to use the setools API to code up some policy
>> searches in Python, then process the results to find things you
>> do/don't want in your policy.
> 
> The approach taken in Fedora/RHEL is to run make validate as part of the 
> selinux-policy.spec recipe, which uses the validate target in the 
> refpolicy Makefile, which manually runs semodule_link and 
> semodule_expand to manually link and expand the modules and performs 
> full checking.  Then the cost is only paid at policy build time and is 
> only applied for the neverallow rules and allow rules in the Fedora/RHEL 
> policy, not for third party modules.  If you are rebuilding the RHEL 
> policy from source, you could add your neverallows to it there and the 
> make validate should catch the violations.
> 
> In Android, neverallow checking is done both at policy build time and as 
> part of device certification.  The latter is done using a 
> sepolicy-analyze tool we originally contributed; it can take a separate 
> neverallow rule configuration in source form and an already compiled 
> kernel binary policy and check them against each other.  That's useful 
> for cases where you don't have policy sources.
> 
> You can have libsemanage apply your own checker against policy as part 
> of module transactions by specifying a [verify kernel] stanza in 
> semanage.conf, see:
> http://selinuxproject.org/page/PolicyValidate

Also, FWIW, you can obtain, build, and use sepolicy-analyze outside of 
the Android build system as follows. If you are on RHEL 7, you likely 
need/want to obtain the upstream selinux userspace and build its version 
of libsepol.a for use below instead of using the libsepol-static package 
from RHEL since that is likely too old.

# Get source and build.
$ git clone https://android.googlesource.com/platform/system/sepolicy
$ cd sepolicy/tools/sepolicy-analyze
$ gcc -o sepolicy-analyze *.c /path/to/libsepol.a

# Run with neverallows specified on the command-line.
$ sepolicy-analyze /etc/selinux/targeted/policy/policy.31 neverallow -n 
"neverallow user_t self:process signal;"

# Run with neverallows from a separate file.
$ cat > neverallows.conf <<EOF
neverallow user_t self:process signal;
EOF
$ sepolicy-analyze /etc/selinux/targeted/policy/policy.31 neverallow -f 
neverallows.conf

There have been improvements to neverallow checking time upstream since 
RHEL 7, but it will still be a function of policy size and obviously 
RHEL has a much larger policy than Android...

