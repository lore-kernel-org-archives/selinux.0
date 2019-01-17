Return-Path: <SRS0=ZoZM=PZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2FAC43387
	for <selinux@archiver.kernel.org>; Thu, 17 Jan 2019 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C5F20851
	for <selinux@archiver.kernel.org>; Thu, 17 Jan 2019 16:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Cltdg5ZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfAQQiB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:38:01 -0500
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:31703 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfAQQiB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Jan 2019 11:38:01 -0500
X-EEMSG-check-017: 182453021|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Jan 2019 16:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547743074; x=1579279074;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ExqSTP7dHPREs1Kx11in364X3aory7Q7qTK1CTknpgU=;
  b=Cltdg5ZJCE+1/A9uSLfxWz+CVjn8J+imqZqfMSaKRT7uO4ugQfSqQZk0
   lZYHqRRj0bGhQ/Ap7qu8t8Cl9RvFP5Lp/BGyuax0An+xB83KNaOnntt4/
   7gQmu7GWjvJP9jRyfg43gexCytmu+x9ZJ5T3X1kgyJQ1ZYGnw8BgyL+q3
   N0ZyM26KAdHkVtC+PdHuqe5XaSlLYCUaKG6/6CHl3ubTGUt7fE+EE/hVP
   ke0NXjtHE/oPXcF8/944Y5FRjc0dXhacMTMHWbUDaadDkejril+FjbR2+
   YuXUZkd2D7wZOtbZ64rWFSlpSxOOtzfpVZUDUB78+JBzSVLQsUNsTkcDv
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539648000"; 
   d="scan'208";a="19627353"
IronPort-PHdr: =?us-ascii?q?9a23=3ANNaF+hxv5rRVS9HXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0ukXLvad9pjvdHbS+e9qxAeQG9mDu7Qc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYAhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcZcDA+8HMO1FrYfyukEOoAOjCweyCuPhyjxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98NqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1YsakHYNNuyyVOIZ6WMMvT3xytCokxbAKp4?=
 =?us-ascii?q?S3cDUMxZ863RDQceaHfJKN4h/7UeaRJip3i2x9dbKkghay7VCgyurhVsmoyF?=
 =?us-ascii?q?pKrjRKkt3Ltn0Vyxzc8NKHSvpg/ke6wzqPywDS5f1EIUAzj6bbLYIuwqUsmZ?=
 =?us-ascii?q?YJtETDHyv2lF33jK+QaEok5vCl5/nob7jpvJORN5J4hhvgPqkhhMCzG/k0Ph?=
 =?us-ascii?q?ALX2eB+OS80LPj/Vf+QLVPlvA2ibTWsIvBKMQHpq+2Hw9V0oE55xa5FDepys?=
 =?us-ascii?q?4UnXYALFJbYB6HlZTmO0nSIPDkCveym0iskDVwyvDFILLhGJPNIWbHkLv7er?=
 =?us-ascii?q?Z98UFcwhIpzd9D/5JUFq0BIPXrV0Dsut3XFBs5Mxe0w+v8EtVyyJ4RWWKVDa?=
 =?us-ascii?q?+FKq/drViI5uc3KemWeIAVoCr9K+Qi5/P2in85nFgdfbKv3ZQNdH+3AO9rI1?=
 =?us-ascii?q?+HbnXxgtcOC3sKshAiQ+ztjV2ISSRTaGqqX6Ig+jE7D5qrDZzdSYCpgbyB2j?=
 =?us-ascii?q?q7H5JNa2BYBVCDD23oe5+HW/gSciKSJNFukjgeWbimUY8h2gmktBXmxLp/Mu?=
 =?us-ascii?q?rU5ioYuIr71Ndv+u3TkQo/9SRuAMSA12GBVmR0nmQPRz8swq9zu1ByylCG0a?=
 =?us-ascii?q?JgmfxXCcRT5+9VUgc9LZPcy+16C9bvWgPOZ9uJU0ipTcm7ATErT9Ix398Pb1?=
 =?us-ascii?q?94G9Wlkx/Dwi6qDKEOmryVC5w77Ljc02LyJ8lj0XbG0rcuj108TstIL22mib?=
 =?us-ascii?q?Z19xLPCI7Rj0WZi6GqeLwT3C7X6miDwmmOvEFDXQ50UKXFW20fZ0TYrdT++0?=
 =?us-ascii?q?PCSaKhBq47MgtAzs6CLLFGatrzjVVJXP3jIsjRY3qtm2esAhaF3reMbIvse2?=
 =?us-ascii?q?UA0yTREUYEkxsO8nmYKwgxGCOhrnnADDxhC13veVng8epgp3OhSE870QWKY1?=
 =?us-ascii?q?dm17qv9R4fneacRO8L3rIYpCchrC15E0qy39LMDNqAuhJhfL5HbNMj71dIy3?=
 =?us-ascii?q?jZuxZ+PpO+NaBigEARcwBts0PpzRV3BdYIrc9/kH4o0Qw6Ca+fmAdddRub0I?=
 =?us-ascii?q?r2N7mRLXP9qlTnR6fQ21zamOmf/rwPoKA0tFznpwGBDEcu83x7ldJS1i3PyI?=
 =?us-ascii?q?/NCV8pTZ/pUksxvyN/rrXebzh1s5jYzlVwIKK0tXnEwNtvC+w7nEXzN+xDOb?=
 =?us-ascii?q?+JQVehW/YRANKjfalzwQCk?=
X-IPAS-Result: =?us-ascii?q?A2BKAAARrkBc/wHyM5BjGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?YFbKYE1M4Qok31MAQEBAQEBBoE1iTCQSTgBhEACglgiOBIBAwEBAQEBAQIBb?=
 =?us-ascii?q?CiCOikBgmcBBSMPAQVBEAsOCgICJgICVwYBDAgBAYJfP4F1DawBgS+FQ4Rxg?=
 =?us-ascii?q?QuLNBd4gQeBOIJrhFqDMIJXAolOhzaQMloJkg0GGIFlhSqKfIoAkmshgVYrC?=
 =?us-ascii?q?AIYCCEPgyiCJheOPCEDgTUBAYdfgk0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Jan 2019 16:37:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0HGbphK023995;
        Thu, 17 Jan 2019 11:37:51 -0500
Subject: Re: [PATCH 0/3] Allow initializing the kernfs node's secctx based on
 its parent
To:     Tejun Heo <tj@kernel.org>, Daniel Walsh <dwalsh@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <20190109091028.24485-1-omosnace@redhat.com>
 <20190111205053.GV2509588@devbig004.ftw2.facebook.com>
 <CAFqZXNu-bHGmUi80UiyW3djcbedycC+0KUyiQuv9-8b+WmrYuA@mail.gmail.com>
 <CAFqZXNsxVpxXHQ4qOZQpnpck24O5ofskLgU-B0ahbDK8MgxGCA@mail.gmail.com>
 <64977013-e2a5-809d-7a3f-bffbda9276aa@redhat.com>
 <20190117161521.GA50184@devbig004.ftw2.facebook.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <46abb960-f047-c2eb-96a8-72114cc44c86@tycho.nsa.gov>
Date:   Thu, 17 Jan 2019 11:39:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117161521.GA50184@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/19 11:15 AM, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jan 17, 2019 at 10:01:23AM -0500, Daniel Walsh wrote:
>> The above comment is correct.  We want to be able to run a container
>> where we hand it control over a limited subdir of the cgroups hierachy.
>> We can currently do this and label the content correctly, but when
>> subdirs of the directory get created by processes inside the container
>> they do not get the correct label.  For example we add a label like
>> system_u:object_r:container_file_t:s0 to a directory but when the
>> process inside of the container creates a fd within this directory the
>> kernel says the label is the default label for cgroups
>> system_u:object_r:cgroup_t:s0.  This forces us to write looser policy
>> that from an SELinux point of view allows a process within the container
>> to write anywhere on the cgroup file system, rather then just the
>> designated directories.
> 
> Can you please go into a bit more details on why the existing
> cgroup delegation model isn't enough?

I would hazard a guess that it is because the existing cgroup delegation 
model is based on user IDs and discretionary access control (DAC), 
whereas they are using per-container SELinux security contexts and 
mandatory access control (MAC) to enforce the separation of containers 
irrespective of UID and DAC.  Optimally both would be supported by 
cgroup, as DAC and MAC have different properties and use cases.
