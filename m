Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E662EC34047
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 16:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23ED20578
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 16:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="luMTeK6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgBSQnu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:43:50 -0500
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:40602 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgBSQnu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 11:43:50 -0500
X-EEMSG-check-017: 73390759|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,461,1574121600"; 
   d="scan'208";a="73390759"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Feb 2020 16:43:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582130627; x=1613666627;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BVsVz5P3I55uA075t/OwjNH1oawm+2szP2ADrvzyncc=;
  b=luMTeK6FtLl/9ZPPn7vWsLJAQyDM8YQpHRqRini4obYXGsJPNe4PkijY
   zWLex6gZ83/1oyGdcW/yjHTqBg5P4UowkXrEOrVA7CW4oDcHx7p4oHiTI
   BxTvHgGk8HhASiWLcZzm6ILQIPECN5EcgPhrzTN5C84V21AqOKFTNwGsN
   NjrfZ4oVlllBA0mAwAW+jyV7mpw5gpRcK6QVFIIvp3TfD4kw3hOXvLp1W
   IKR68KDrzpjp8Dk0GKLYMf20qp6PI7JKLbclWEx53avFNV/S+zffrqmfB
   QV3glVPQGtM4lkN2AXp80/9CxUTnxakAUXixrpbwD+mIMLYfzhu3UDMLq
   A==;
X-IronPort-AV: E=Sophos;i="5.70,461,1574121600"; 
   d="scan'208";a="39297677"
IronPort-PHdr: =?us-ascii?q?9a23=3AJ+qrjBOseKlZhD3lkrIl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/3/p8bcNUDSrc9gkEXOFd2Cra4d16yG6+uxACQp2tWojjMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIxi6twbcutUZjYZmN6o61w?=
 =?us-ascii?q?fErGZPd+lKymxkIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWgGufixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gI+EdIAsHfaotv7O6gdU++60KbGwC7fb/5Uwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dk1uQtZLqPyuV1usTtWiQ8vduVee1hG4jrwF+vDiuzdorh4?=
 =?us-ascii?q?nSm40V0UvJ9Tl5wYkpJd24T1R3Ydi/EJRKrS2aOIx2Qt07TmxupS00xLoGuZ?=
 =?us-ascii?q?uhcygLzpQq3wTfZOKafIiI+B3jSPydLit/hHJgYL6/hAi98VKmyuLiUsm4yl?=
 =?us-ascii?q?FKrjBKktTKq3sD1ATT59CaRvZy8UqtwzaC2x3J5u1aLk04i7DXJ4Mnz7UtjJ?=
 =?us-ascii?q?Qcq17DETXzmEjuia+WcVgr9faw5uT8Z7XmuoecN4hpigHiKqgumtKwAeA/Mg?=
 =?us-ascii?q?UWQ2iU4/681Lz+/U3iWrlKj/s2kqfesJDBO8sUurS1AxNV04k/6xa/CC2q0N?=
 =?us-ascii?q?IEknkcMF1JYheHj4ntO13WIfD4C+mwg0i0nTt2yP3LMaftD5XQInTZjrvscq?=
 =?us-ascii?q?hx51RBxAYryNBQ/ZNUCrUPIPLpXU/xscTVDgQkPAyv2OvnFNV82Z8eWWKIGK?=
 =?us-ascii?q?OZNrjSvkWS6uIgJOmMepcZuCzhJPg9+/7ukXg5lEcafams2psXc3a4Ee56LE?=
 =?us-ascii?q?qHenfsmMkOHnoKvgUkUOzmkkGNUTlWZ3yqRaIz+ik7CJ66DYfEXo2inbKA0z?=
 =?us-ascii?q?2/Hp1NZmBLEUqMHmn1eIWEQfgMdDieLdNmkjwBTbKhUZMu1QmytA/mzLpqNv?=
 =?us-ascii?q?HU+jEGupLtztd14e3Tmgsp+DxuEcuSzmGNQHtonm8SWzA226V/q1Rnylifya?=
 =?us-ascii?q?h4n+BYFdtL6vNXUwc6L4Lcz+19C9zrVALBZcyESEy4Tdq7ATE+VM4xz8USbE?=
 =?us-ascii?q?Z6HtWolgrD0DayA78Ji7yLA4Q58rnC0Hj1JsZ9zWvG1aY6glk4TctAK3emir?=
 =?us-ascii?q?R89wfNHY7JlVuWl6KweaQbxi7N+zTL8W3bm0dUSgNyGYDCRnYWbUbV5YD+40?=
 =?us-ascii?q?TZSbalBJw9PwdBwNLEIaxPPJmhoVxARfrncOvXZ3mx0zO8Gh+M3bOkdofme2?=
 =?us-ascii?q?wBmi7aDR5XvRoU+CO9KQUmBiqn61nbBThqGEOnN1jg6sFiuXi7SQky1AjMYE?=
 =?us-ascii?q?p/genmsiUJjOCRHqtAlokPvz0s/nAtRgew?=
X-IPAS-Result: =?us-ascii?q?A2CQAAC5ZE1e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gRhUATIqhBSJA4ZTAQEBAQEBBoE3gQGIb5FKCQEBAQEBAQEBAS0KB?=
 =?us-ascii?q?AEBhEACgig3Bg4CEAEBAQUBAQEBAQUDAQFshTcMgjspAYMCAQUjBBE2CxALD?=
 =?us-ascii?q?goCAiYCAlcGAQwGAgEBgmM/AYJWJQ+uBn8zhDUBgRSDc4E4BoEOKgGMPXmBB?=
 =?us-ascii?q?4ERJw+CKDU+gmQDhHSCXgSNZjGJQEaXdIJFglCEf4VNhCwGhQwGHIcPlByMd?=
 =?us-ascii?q?IF7iHmUXCOBWCsIAhgIIQ87DQiCVxM9GA2OKReDUIUUhV0jAzACAQEBjw4BA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Feb 2020 16:43:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01JGgiip231687;
        Wed, 19 Feb 2020 11:42:44 -0500
Subject: Re: SELinux support in virtio-fs
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, virtio-fs@redhat.com,
        SElinux list <selinux@vger.kernel.org>
References: <20200210160639.GA411895@stefanha-x1.localdomain>
 <bbcbd9a0-a036-1c1e-ed66-ac2aaca454a5@redhat.com>
 <CAFqZXNsL4nC4N2XKgMmTNJGCayJ1E=ppiKCBhv2yFCt39dLWqg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6df9b58c-fe9b-28f3-c151-f77aa6dd67e7@tycho.nsa.gov>
Date:   Wed, 19 Feb 2020 11:44:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNsL4nC4N2XKgMmTNJGCayJ1E=ppiKCBhv2yFCt39dLWqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/19/20 11:11 AM, Ondrej Mosnacek wrote:
> On Wed, Feb 12, 2020 at 4:29 PM Daniel Walsh <dwalsh@redhat.com> wrote:
>> On 2/10/20 11:06 AM, Stefan Hajnoczi wrote:
>>> Hi Dan,
>>> I've CCed the public virtio-fs mailing list because SELinux support in
>>> virtio-fs has been asked about recently.
>>>
>>> It's time to figure out what level of SELinux support will be available
>>> in virtio-fs.  The file system client shares most of its code with FUSE
>>> and SELinux labels on files are currently not supported in FUSE.
>>>
>>> It would be possible to pass through extended attributes to the
>>> virtiofsd daemon running on the host.  However, passing through xattrs
>>> allows the client to relabel files on the host file system and this
>>> could pose a security problem.  virtiofsd already allows the client to
>>> set the uid/gid and permissions, but is passing through SELinux xattrs a
>>> bad idea?
>>>
>>> virtiofsd is in a position to mangle extended attribute names
>>> ("security.selinux" -> "virtiofs.security.selinux") in order to separate
>>> guest SELinux labels from host SELinux labels.
>>>
>>> As someone who knows very little about SELinux I'm eager to hear what
>>> you think would be a good approach.  Secure containers (e.g. Kata
>>> Containers) are an important use case but virtio-fs can also be used as
>>> the root file system for a guest (a scenario where full SELinux support
>>> is needed).
>>>
>>> Thanks,
>>> Stefan
>>
>> I am traveling right now.  We should add in the SELinux team, and I will
>> be able to look at this on Friday.
> 
> Cc'ing the upstream SELinux mailing list for more insight. Here is a
> public archive of the full thread:
> 
> https://www.redhat.com/archives/virtio-fs/2020-February/msg00005.html

FWIW, there were previous attempts to add FUSE support for per-file 
SELinux labeling (rather than just a single genfscon-based or context= 
mount option label for all files in the mount) but there were problems:

- deadlock during mount with userspace waiting for mount(2) to complete 
and the kernel blocked on requesting the security.selinux xattr of the 
root directory as part of superblock setup during mount [1] [2].
[1] 
https://lore.kernel.org/selinux/1280234607.4789.6.camel@moss-pluto.epoch.ncsc.mil/
[2] 
https://lore.kernel.org/selinux/20120824195928.22970.16209.stgit@paris.rdu.redhat.com/

- there was an attempt to introduce distinctions based on filesystem 
"subtype" so that whitelisted fuse filesystems could have xattr support 
enabled when it was known that their userspace would handle mount(2) 
safely [3] but this was apparently always broken and later reverted [4].
[3] 
https://lore.kernel.org/selinux/20130416225619.GA30164@sh-el5.eng.rdu2.redhat.com/
[4] 
https://lore.kernel.org/selinux/20131213195520.11231.81980.stgit@localhost/.

- there is the issue of trusting the fuse filesystem for its labeling 
information and for domain/context transitions.  At the least, we'd need 
a permission check to gate which contexts a fuse filesystem could supply 
(e.g. the filesystem associate check), and by default nosuid mounts 
disable domain transitions (although it is possible to selectively allow 
them via nosuid_transition now).  Also, if a non-init user namespace 
mount, even if policy is configured to use xattrs 
(SECURITY_FS_USE_XATTR), we flip to using mountpoint labeling (i.e. 
implicit context= mount with the context derived from the mounter's 
context and matching type_transition rule if any) and we don't permit 
use of context mount options.
