Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D647C33C9E
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C0F2082F
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 18:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HcFJeN5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgAQSXe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:23:34 -0500
Received: from UHIL19PA35.eemsg.mail.mil ([214.24.21.194]:17821 "EHLO
        UHIL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgAQSXe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 13:23:34 -0500
X-EEMSG-check-017: 67533930|UHIL19PA35_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="67533930"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Jan 2020 18:23:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579285412; x=1610821412;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=481d840C1CNQAOnJOTIFjo+Tw927kjMJg7GUeGXX6TE=;
  b=HcFJeN5D/KmfgH+b+raNQUzRc8tokWv6NTebbYLDGd0+CZeNRvuIfiFJ
   xqf3+e0V5i3QOOemkVGSMwS4I8e3OwdXHKcTJb07gzLCHoDU7teIj+YfN
   ej+GmJmYcKh3vhMNbVGmUjZ79Qm2ykfrF6nh8ra8qnFyeFF8hz4UV1UTD
   KFnfT6qPi1Ax21tN5jIBrK0nIrAm50rh40bhqvnn8da+wr5ICSsrJrAyE
   I6lNJqRRaheVATcbIdpkQ+apSZlVEhDtPk+3unMDz3AZi+Euoo/gi9TP7
   GMTb0HybttE1KdkyBq0iXj1PozCqC0xLnCpKqIPmpiiWgbJzbaidhHjq3
   A==;
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="32086715"
IronPort-PHdr: =?us-ascii?q?9a23=3AicqAbB///p2M8P9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B22u8cTK2v8tzYMVDF4r011RmVBNmds6IP0rWe8/i5HzBZutDZ6DFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sArcutMKjYZhJao91x?=
 =?us-ascii?q?nEqWZMd+hK2G9kP12ekwvy68uq4JJv7yFcsO89+sBdVqn3Y742RqFCAjQ8NG?=
 =?us-ascii?q?A16szrtR3dQgaK+3ARTGYYnAdWDgbc9B31UYv/vSX8tupmxSmVJtb2QqwuWT?=
 =?us-ascii?q?Sj9KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjZa7WY88USn?=
 =?us-ascii?q?RdUcZQTyxBA52zb40TD+oaIO1Uq5Dxq0YSoReiAAWhAu3gyiVMhnTrw6M01e?=
 =?us-ascii?q?ovGhzC0AA5Ad4DtHHYodPoP6kQTO+11rHFwyjdYfNY2Tnz64bGfR4urv6OQb?=
 =?us-ascii?q?1+ftHcyVUtGg7fklmctYLoMjGT2+8Qs2ab9e1gVee3hmA6twF+vCCvxscyhY?=
 =?us-ascii?q?nPm4kb11XE+j99wIYxO9K5SFNwbNm/EJRNrCGXLJd2Q8M+TGFovyY20LsGuY?=
 =?us-ascii?q?WhcyQQx5QnwADfZuWBfoOV7BzjU+ORLi15hHJjYL+/iQi9/lWnyu3mTMa00V?=
 =?us-ascii?q?BKriRfktbWqn8N0xvT6tWaRfdn+UehwzmP2gbO4e9HOUA5jbfXJpEuz7Iqlp?=
 =?us-ascii?q?cfrF7PEjH5lUnolqOaa0Mp8fWy5ev9eLXpvJqcOpdxigH5L6shhNSyAf89Mg?=
 =?us-ascii?q?gSR2ib/vm81KH78U35XrpKivo2n7HFsJ/AP8Qbp7O5AxRP3oYi7Ra/ATCm0M?=
 =?us-ascii?q?8GknYbNl5FZBKGgJTpO1HJOvz4C+uwg0+wnztxwvDGP7nhDo3MLnjFjrjhYa?=
 =?us-ascii?q?5w51NTxQc819xS549YBqsfLP/8REP9rsHUAgc8MwOuwubnDNt91pkZWWKKGq?=
 =?us-ascii?q?KZK77dsUST6+IzI+iDeI8VuDHnJ/gj/P7hl2U1mVAafam3xZcXcmy3Hux6I0?=
 =?us-ascii?q?WFZnrhms8BEWMQsQojUOzqkkaNXiRIanaoQa0z+zE7B5i6DYvZWo+th7mB1j?=
 =?us-ascii?q?+hHpJKfmBGFkyMEXDweoWfRfgMbCOSIsl8kj0LTrWhVYAh2g+0tAPgyLpoMP?=
 =?us-ascii?q?DU+isGupLnztR14PfTlR5hvQBzWvyQz3vFa2hpgnkCTjQ2lPRnpUVg1k2J2I?=
 =?us-ascii?q?BijvBYHMAV7PRMBENyLpPYzupnG/jsVQ/bONSEUlCrRpOhGz5iYMg2xoo1f0?=
 =?us-ascii?q?tlG9ikxivG1i6uDq5dw6eHH7Qo46nc2D73PM87xHHYgvpyx2I6S9dCYDX1zp?=
 =?us-ascii?q?V08BLeUsuQyRSU?=
X-IPAS-Result: =?us-ascii?q?A2AkAwAA+yFe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBe?=
 =?us-ascii?q?AWBGHUSKoQRiQOGYgaBN4luj2KBZwkBAQEBAQEBAQEtCgEBhEACgi44EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFNwyCOykBgnoBBSMVUQsOCgICJgICVwYBDAYCAQGCY?=
 =?us-ascii?q?z8BglYlD60ngTKFSoMwgTgGgQ4ojC55gQeBOA+CKDU+hAIvgyiCXgSXMEaXV?=
 =?us-ascii?q?oJDgkmEdI5tBhuaci2OL4hhlDUigVgrCAIYCCEPO4I4AQEyUBgNkQiFXSMDM?=
 =?us-ascii?q?AKNZQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Jan 2020 18:23:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00HIMtQQ240983;
        Fri, 17 Jan 2020 13:22:55 -0500
Subject: Re: [PATCH] libselinux: remove flask.h and av_permissions.h
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20200115155523.69438-1-sds@tycho.nsa.gov>
 <pjdh80vqivt.fsf@redhat.com> <pjdd0biq95r.fsf@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5d7eb243-1dbe-9c54-9cf6-b3e7cdfba7c7@tycho.nsa.gov>
Date:   Fri, 17 Jan 2020 13:24:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <pjdd0biq95r.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/20 12:34 PM, Petr Lautrbach wrote:
> 
> Petr Lautrbach <plautrba@redhat.com> writes:
> 
>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>
>>> The flask.h and av_permissions.h header files were deprecated and
>>> all selinux userspace references to them were removed in
>>> commit 76913d8adb61b5 ("Deprecate use of flask.h and av_permissions.h.")
>>> back in 2014 and included in the 20150202 / 2.4 release.
>>> All userspace object managers should have been updated
>>> to use the dynamic class/perm mapping support since that time.
>>> Remove these headers finally to ensure that no users remain and
>>> that no future uses are ever introduced.
>>
>> I've patched libselinux and I'm building all packages which requires
>> libselinux-devel [1] in Fedora. I'm in the middle of package list and so far there
>> are only 3 packages which fails to build without flask.h or
>> av_permission.h - libuser (the particular file wasn't updated since
>> 2012), ipsec-tools and mesa. When it's finished I'll investigate all
>> results, but I don't think there will be some blocker.
>>
>> [1] https://copr.fedorainfracloud.org/coprs/plautrba/libselinux-without-flask.h/builds/
>>
> 
> So the complete list of Fedora packages dependent on selinux/flask.h is:
> 
> xinetd
> usermode
> sed
> pam
> oddjob
> libuser
> ipsec-tools
> 
> Problems are usually in tests or in Fedora specific patches. I'll start
> to work on fixes with affected maintainers.

Great, thank you.  Hopefully the other patch for libsepol,checkpolicy to 
prune its copy of flask.h of all SECCLASS_* definitions and take it 
private to libsepol won't break anything.  With those two changes, we 
should be free of any lingering uses of hardcoded class and permission 
definitions.  Then all we need is for dbus-daemon to either set up a 
POLICYLOAD callback and re-fresh its mapping at that time or switch over 
to looking up the class and permissions each time as per the guidance in 
the updated libselinux man pages (per my third patch) and userspace 
should be safe for class or permission changes.


