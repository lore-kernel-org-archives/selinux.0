Return-Path: <SRS0=nflz=SO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F245C10F0E
	for <selinux@archiver.kernel.org>; Fri, 12 Apr 2019 19:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B15820869
	for <selinux@archiver.kernel.org>; Fri, 12 Apr 2019 19:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Z8J01E5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfDLT3j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:29:39 -0400
Received: from upbd19pa10.eemsg.mail.mil ([214.24.27.85]:8966 "EHLO
        upbd19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLT3j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Apr 2019 15:29:39 -0400
X-EEMSG-check-017: 215880677|UPBD19PA10_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Apr 2019 19:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1555097371; x=1586633371;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FRGpROlvtFe9pRmK/2N5myAsf6Ggrw5cRWmacaxxuKc=;
  b=Z8J01E5jv2Nduhmv6oEqpEo1tIZK3iwbc+B9TR2c3IjxCte5SIRIZOJC
   eTcUZYGFbvFZtma3GEmjB/WwJtViIZwgkmY2kJwvLfbRpcnh2Z8SGaNTE
   XJAwgcHbsebFrTqfJ/DzoHsHpdk5kVotDZWCi4bq+76u03K4r+gkZ8I2k
   JLYiNiQY593Q3aRo1lfFZMVlcv3z+id6LngI2iFKzzvHH7SOkBenJouhs
   3toLVe+7HXrTpEYoe33ED9rTqgFY3LJ2t452AhskUp/I9OziWLlVH3tYm
   JOLnhbuBCqBVpK2Pifyb3TisjOtjS1LXnJHWc6qQoo5Vy/+TAiUsRRU1g
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,342,1549929600"; 
   d="scan'208";a="26262796"
IronPort-PHdr: =?us-ascii?q?9a23=3ACoxNcBOUhNpmD350osEl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z8psbcNUDSrc9gkEXOFd2Cra4d0qyM6uu5ADZIoc7Y9ixbKNoUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanJZuJrwvxh?=
 =?us-ascii?q?fUrXdEZvlayX11Ll6Xgxrw+9288ZF+/yhMof4t69JMXaDndKkkULJUCygrPX?=
 =?us-ascii?q?oo78PxrxnDSgWP5noYUmoIlxdDHhbI4hLnUJrvqyX2ruVy1jWUMs3wVrA0RC?=
 =?us-ascii?q?+t77x3Rx/yiScILCA2/WfKgcFtlq1boRahpxtiw47IZYyeKfRzcr/Bcd4cWG?=
 =?us-ascii?q?FMRdhaWTBfDYygbosPF+sBMvher4nhvFsFsB+yCRCxCO/z1jNEg3n70qMg0+?=
 =?us-ascii?q?QlDArIwgouEdwTu3jQtdn4OqMfXeWzwaLVzzvMculW1C/g5obWfBAvofKCU7?=
 =?us-ascii?q?x+fsXey0YgCwzLg06MqYHmJT6ZyvgBvmaZ4udmSOmhi3QnqwZ0ojW328kslp?=
 =?us-ascii?q?fGhpoVyl/a8yVy3Zs7JdiiR05/Zd6rDptRvDydOottX8wiWHpluDo6y7IauZ?=
 =?us-ascii?q?67ezIGyJI8xxHFcfCHfI+I4gz6WeuXPDx2h2pldaqiixu9/kWs0O3xWtSu3F?=
 =?us-ascii?q?pUoSdJjMPAum0L2hfO8MaIUOF98V2k2TuX0gDT7fxLLl4smKrALp4h3qYwlp?=
 =?us-ascii?q?0OsUTfBiP2mFv5jKuRdkg85uin8f7nYrT7pp+HLYN0lgH/Pbgumsy4G+g4NB?=
 =?us-ascii?q?QBX3OH9uim0b3j/En5TK1Ljv0wjKbZrIjXKdkUq6O2GQNY0psv5wyhAzqpzt?=
 =?us-ascii?q?gUh2QLIEpAeB2djojpP1/OIOr/Dfe6m1msiypkx+vdM739ApTCMnjDkLD7cb?=
 =?us-ascii?q?Z78E5T0hA/zd9Y55JKEr0BOu78WlfttNzECR80KxS0zPz6CNV5zY4eQXiAAr?=
 =?us-ascii?q?KdMK/LtF+I4eUvI/OSa4MPpDn9LP0l7eb0jXAlgV8dYbWp3ZwPZXCiH/RpP0?=
 =?us-ascii?q?WZbmD2gtgcCWgFohIxTOzwh12DVz5ceW2yUrkn6TEnCYKmC5vDSZ63gLyHwi?=
 =?us-ascii?q?i7AodaaXxBClCJCX3obZmLW+8QaCKOJc9siicEWqalS48g0xGuqQD7xqF5Lu?=
 =?us-ascii?q?rb5CIYr4jv1Ntr6O3JkxE96zh0A96a02GXQGF+hnkISCMu3KBjvUx9zU+O0b?=
 =?us-ascii?q?R7g/xaEtxT/OhEUgg9NZ7bwOx6D879VhjdcdeOTVb1CumhVAk4U9Z55tgJeU?=
 =?us-ascii?q?s1T82rkxTrxyO3B/oQkLuRCdo/9aeKmzDLJs19wmzKnIkojl8rWYMbL2ythq?=
 =?us-ascii?q?dl+z/YMI7AkkOUjI6gaaUawCPX8mqfi2GJuRcLfhR3VPD+QX0HZkbQ5e/870?=
 =?us-ascii?q?fGQq7mXa8rKSNd2MWCLe1McdSvglJYEqSwcO/Can68zj/jTS2DwamBOc+zID?=
 =?us-ascii?q?QQ?=
X-IPAS-Result: =?us-ascii?q?A2AcAAA15rBc/wHyM5BlGwEBAQEDAQEBBwMBAQGBUgUBA?=
 =?us-ascii?q?QELAYFmKmhQATIohA6TKkwBAQEBAQEGgQgtiUePAYF7KxEBhEAChXYjNQgOA?=
 =?us-ascii?q?QMBAQEJAQEBAQIBbBwMgjopAYJnAQUjBAsBBUEQCxgCAhUCDwICVwYBDAYCA?=
 =?us-ascii?q?QGCXz8BgWkDCBStBHwzhUaEbIELJwGLSBd4gQeBOIJrPoEOgQyCA34HgiyCV?=
 =?us-ascii?q?wOmJgmCB4YIjAYGGoIIXZINi2KBHZRwATWBVisIAhgIIQ+DJwmCDReHVIZnI?=
 =?us-ascii?q?wMwgQYBAWCMOAIkgisBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Apr 2019 19:29:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x3CJTTBq018348;
        Fri, 12 Apr 2019 15:29:29 -0400
Subject: Re: [PATCH 1/1] selinux-testsuite: Update binder test applications
To:     Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, tkjos@google.com
References: <20190403122611.6543-1-richard_c_haines@btinternet.com>
 <CAHC9VhTTeetqR03+zaV0d_2rdHr4r6eKnqKNrXO6k9O7+tz=gQ@mail.gmail.com>
 <a1869fe6f41148a956ff902d7077356fc729b28b.camel@btinternet.com>
 <CAHC9VhRXgNk0qMS+-=wUt3wYoteauCv3UdPuPrYPyTEV8zXcHw@mail.gmail.com>
 <2ef270d1e0ce2edbbddc07fba754cb99f2b093d4.camel@btinternet.com>
 <CAHC9VhQujkY+Cbkb=ge10JXYyCmftphNOzCCeBaHXLXGMa6_ig@mail.gmail.com>
 <CAHC9VhSDzofwhqhAKaScfzB21cnus8=iir-TayjEeWfDa9h9rA@mail.gmail.com>
 <05b9c3920262f93f8f7af0058821a5301b138526.camel@btinternet.com>
 <CAHC9VhTUSm1vx_TtmrX+VRd5C56=tKOt8dP2MYwFGsKwCRfKPw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f14a6336-164c-a607-e149-257af30d8ffa@tycho.nsa.gov>
Date:   Fri, 12 Apr 2019 15:28:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTUSm1vx_TtmrX+VRd5C56=tKOt8dP2MYwFGsKwCRfKPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/12/19 3:20 PM, Paul Moore wrote:
> On Fri, Apr 12, 2019 at 12:37 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
>> On Fri, 2019-04-12 at 10:46 -0400, Paul Moore wrote:
>>> On Thu, Apr 11, 2019 at 6:07 PM Paul Moore <paul@paul-moore.com>
>>> wrote:
>>>> On the negative side I realized when playing with your test changes
>>>> that I wasn't building BINDERFS in my test kernels - oops.  I'm
>>>> fixing
>>>> that now, but I might not get a chance to do another test until
>>>> tomorrow; at least I can verify that your BINDERFS testing logic
>>>> works
>>>> :)
>>>
>>> I rebuilt my test kernel (the latest "secnext" builds have it) with
>>> BINDERFS only to realize that Fedora Rawhide doesn't seem to ship
>>> /usr/include/linux/android/binderfs.h so I manually copied the file
>>> from the kernel-devel package only to run into this when building the
>>> new binder tests:
>>>
>>> # make
>>> cc -DHAVE_BINDERFS    check_binder.c binder_common.c binder_common.h
>>> -lselinux -lrt -o check_binder
>>> binder_common.c: In function ‘cmd_name’:
>>> binder_common.c:35:7: error: ‘BR_TRANSACTION_SEC_CTX’ undeclared
>>> (first use in t
>>> his function); did you mean ‘BC_TRANSACTION_SG’?
>>>    35 |  case BR_TRANSACTION_SEC_CTX:
>>>       |       ^~~~~~~~~~~~~~~~~~~~~~
>>>       |       BC_TRANSACTION_SG
>>> binder_common.c:35:7: note: each undeclared identifier is reported
>>> only once for
>>> each function it appears in
>>> binder_common.c: In function ‘print_trans_data’:
>>> binder_common.c:126:23: error: ‘FLAT_BINDER_FLAG_TXN_SECURITY_CTX’
>>> undeclared (f
>>> irst use in this function)
>>>   126 |          obj->flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX ?
>>> "YES" : "NO");
>>>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> make: *** [<builtin>: check_binder] Error 1
>>> # grep "BR_TRANSACTION_SEC_CTX" *
>>> binder_common.c:        case BR_TRANSACTION_SEC_CTX:
>>> binder_common.c:                return "BR_TRANSACTION_SEC_CTX";
>>> service_provider.c:             case BR_TRANSACTION_SEC_CTX: {
>>> # grep "BR_TRANSACTION_SEC_CTX" /usr/include/linux/android/binderfs.h
>>> # grep "BR_TRANSACTION_SEC_CTX" /usr/include/linux/android/binder.h
>>>
>>> ... and that's when I stopped playing with this.  If it helps, I
>>> pulled my binderfs.h file from a current Rawhide kernel.  What are
>>> you
>>> using to run these tests?
>>>
>>> At the very least, I'm thinking we'll also want to include some notes
>>> in the README.md file under the "Optional Prerequisites" section
>>> about
>>> how to get this running with BINDERFS.
>>
>> The BR_TRANSACTION_SEC_CTX is defined in an updated binder.h file, so
>> you need both binder.h and binderfs.h from devel.
>>
>> I guess I must have copied them over by hand as I tested on rawhide.
>> I'll add a note in the README.md file.
> 
> Okay, that solved the problem, thanks.
> 
> I just noticed that the kernel-headers package on my Rawhide systems
> are *really* old.  I suspect this may be due to the fact that I'm not
> running Fedora Rawhide kernels and thus my currently installed kernel
> packages don't match what is present in the main Rawhide repos; this
> problem might be limited to just me (and anyone exclusively running
> the secnext kernels on their system).
> 
> Can anyone with a Rawhide system confirm if they have the
> /usr/include/linux/android/binderfs.h header file?

Don't have rawhide handy, but Fedora 29 has it,
$ rpm -q -f /usr/include/linux/android/binderfs.h
kernel-headers-5.0.6-200.fc29.x86_64


