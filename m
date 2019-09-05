Return-Path: <SRS0=j8XY=XA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE51C41514
	for <selinux@archiver.kernel.org>; Thu,  5 Sep 2019 12:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F1222CF7
	for <selinux@archiver.kernel.org>; Thu,  5 Sep 2019 12:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="n3PEXKGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbfIEMHo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:07:44 -0400
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:51638 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732003AbfIEMHo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Sep 2019 08:07:44 -0400
X-EEMSG-check-017: 5783151|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,470,1559520000"; 
   d="scan'208";a="5783151"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Sep 2019 12:07:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567685258; x=1599221258;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BCNBVFmjzCpk1W7vqVwtLwbkZZ0klrjkwkEZQZoQ0Yw=;
  b=n3PEXKGuKt7hUbBXH3IXHTMq0Pm3T0snrO+gR4AipzsR4Z6pos1QBF5z
   vsRUbwRBRXm3UJCO4m8drt5FBHnc6cJbXkXqS9h33LqiQFFPYnTz9CDHn
   /D5/8VFwVgOIGWX4Z38Gc4Q7PaxBmcOVwjqXjflJJ7bhIY4rRZZvTWyRS
   YYpcyA23GWBm/iNzwrSRGAMMgJEr+8Paw7K4FcmHh6l5cEQ+f2zQX7bi2
   CGEbjiWovb/gMf3LiVWm+1mY+M41e7teKJqbPZkO+yxnBLTJuOtRAP2FB
   cYc7IFHVm4HhBo2Dggcmic9hV2FMJfd4bYj7N0ksoZpOpT4GGFypCLrRs
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,470,1559520000"; 
   d="scan'208";a="32393753"
IronPort-PHdr: =?us-ascii?q?9a23=3AeuAvQx1wcjg16J/zsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesXLfTxwZ3uMQTl6Ol3ixeRBMOHsqgC0rWJ+Py5EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCejbb9oMRm7rwfcusYZjId/N6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5DxqlUKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TM0lQ2Ftoik6y7sGtI?=
 =?us-ascii?q?agcygNz5Qn2xrfa/2Bc4SS/h3jU+ORLDFlj3xmYLKynwu+/Eevx+HmVsS4zU?=
 =?us-ascii?q?xGojRKn9XSrHwByhre4dWdRPRn5EeuwzOP2hjW6uFDPE87i7LWK4Ukwr4sjp?=
 =?us-ascii?q?oTtlnDHjPulEX2kqCWckIk9/C06+v9eLXmp4KcN5RuhgHiMqUhhsy/AeMiPg?=
 =?us-ascii?q?gIQ2eb4viz2Kfm/U34RLVGlvw2kq/Hv5DGPckXu6G0DgBP3osj9hqzFSmq3d?=
 =?us-ascii?q?sGkXUdMV5JYBeHgJLoO1HKLvD4F/C/g1G0nTdw2v/GJabsAonNL3ffkLfheq?=
 =?us-ascii?q?xx60hHyAUp19xf6JVUCq8ZLPLpRkDxrMDYDgM+MwGs2+boEsh91ocFVGKXGK?=
 =?us-ascii?q?CZLafSvUaN5uIoJOmMfpEatCzhJPgi4v7klWU5lkMFfam1wZsXb2i1Eel8LE?=
 =?us-ascii?q?WfYHrjnNMBEWURswo7UuPqjFmCXiRVZ3a1UKMw/C00CIWjDY3bXICinKSB3D?=
 =?us-ascii?q?unHp1Rfm1GEU6DEXPpd4WCRvcNZzmfItFukjMaT7itUYwh2g+0tA/81bVnKv?=
 =?us-ascii?q?DY+ioCtZLszNJ1/fHclQku9TxoCMSQy3qNQH9wnmMJQT82wa9+rVVnylid36?=
 =?us-ascii?q?h4m/tYFdhS5/xVUgY3LoDcz+NkBNDoQA7BfcmGSEygQtq4BTE9VNUxw8UBY0?=
 =?us-ascii?q?xlAdWtkgjD3za2A78Sj7GLAII08rjG0HfqOcly123L1LM/gFY7QstAL3Gmir?=
 =?us-ascii?q?Rj+AjUAo7Di1+ZmLqydaQAwC7N83+OzXKQs05DTgFwV6TFXWwYZkbNrNT2+F?=
 =?us-ascii?q?3NQKG0BbQgKAtBxp3KFqwfUtT0iR1jQ/D5NZyKe2usn0+oDAuMg7aLa5DnPW?=
 =?us-ascii?q?4a2XOZQGQNlQEe+T6kKBIxCyG66zbSBTpvGFbtS0bh9e13rnSrCEQzylfZQV?=
 =?us-ascii?q?dm0u+O5hMNhfGaA8gW17YAtTZp/y54B36hztnWDJyGvAMnc6JCN4BuqGxb3H?=
 =?us-ascii?q?7U4lQudqerKLpv0xtHKFV6?=
X-IPAS-Result: =?us-ascii?q?A2BOAQDf+XBd/wHyM5BlHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?W0qbVMyKoQhjwxOAQEBAQEGgREliW+RJgkBAQEBAQEBAQErCQECAQGENQoCg?=
 =?us-ascii?q?jYjNwYOAgsBAQEEAQEBAQEGAwEBbIUuDII6KQGCZwEFIxU2CxALGAICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz8BgXYUD6lFgTKFS4M6gUmBDCgBhH+GeBh4gQeBOAyCXz6EH?=
 =?us-ascii?q?YMyglgEjD+JFoEwlSuCKYIohE+JH4RMBhuCNC9AlVKNeoE4hkWScCKBWCsIA?=
 =?us-ascii?q?hgIIQ87gmwJgkUXg0+FSIUnJAMwgQYBAYxuglQBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Sep 2019 12:07:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x85C7WIu014389;
        Thu, 5 Sep 2019 08:07:33 -0400
Subject: Re: IB pkey policy problem found via the selinux-testsuite
To:     Paul Moore <paul@paul-moore.com>,
        Daniel Jurgens <danielj@mellanox.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "selinux-refpolicy@vger.kernel.org" 
        <selinux-refpolicy@vger.kernel.org>,
        Lukas Vrabec <lvrabec@redhat.com>,
        Chris PeBenito <pebenito@ieee.org>
References: <CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsdbgxSL1v04mouWw@mail.gmail.com>
 <CAHC9VhR1ZNyZqGB3Si-z77zLwaTBf-pkQk19rVqofs4P_oVtFg@mail.gmail.com>
 <CAHC9VhSKxgCB_j-eT65tSvqFDbBe_Wu_b+XsvN0Si2eDrEROMQ@mail.gmail.com>
 <5817f158-9ba2-420d-3a9e-59ee43be3472@mellanox.com>
 <9048b292-b9fa-49f7-d66e-1f0ceaa39290@tycho.nsa.gov>
 <CAHC9VhTiWg+ZP7p1ebDNFsfC5Lca1WaMGC-mbv1i9jR9E1pK+g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <06c3964b-d0c5-530f-3573-9a9ce85ecfd8@tycho.nsa.gov>
Date:   Thu, 5 Sep 2019 08:07:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTiWg+ZP7p1ebDNFsfC5Lca1WaMGC-mbv1i9jR9E1pK+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/4/19 6:32 PM, Paul Moore wrote:
> On Tue, Sep 3, 2019 at 10:45 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 9/3/19 10:30 AM, Daniel Jurgens wrote:
>>>
>>> On 8/27/2019 12:24 PM, Paul Moore wrote:
>>>> On Thu, Feb 28, 2019 at 4:58 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>> On Wed, Feb 13, 2019 at 4:35 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>> Hello all,
>>>>>>
>>>>>> On a fully up-to-date Rawhide system you need the following line added
>>>>>> to the policy/test_ibpkey.te file to get a clean run of the
>>>>>> selinux-testsuite:
>>>>>>
>>>>>>     allow test_ibpkey_access_t self:capability { ipc_lock };
>>>>>>
>>>>>> The breakage doesn't appear to be due to a kernel change (previously
>>>>>> working kernels now fail), or a Fedora Rawhide policy change (nothing
>>>>>> relevant changed since the last clean run), but I did notice that my
>>>>>> libibverbs package was updated just prior to the breakage.  I haven't
>>>>>> had the time to dig into the library code, but I expect that to be the
>>>>>> source of the problem.
>>>>> Just to be clear, I don't believe this breakage is limited to the test
>>>>> suite, I expect any users of the SELinux IB hooks will run into this
>>>>> problem.  I believe we need to update the upstream and distro
>>>>> policies.
>>>> A ping to bring this issue back to the top of the mailing list.
>>>
>>> Hi Paul, I looked in the libraries and don't see explicit use of mlock. Maybe there was a change to use that access control for get_user_pages? That doesn't really jive with previously working kernels no longer working though.
>>
>> It would be useful to see the audit messages for that ipc_lock denial,
>> including the SYSCALL record.
>>
>> There are a number of kernel operations that can trigger ipc_lock checks,
>> https://elixir.bootlin.com/linux/latest/ident/CAP_IPC_LOCK
>>
>> Several of those are infiniband-specific.
> 
> Hi all,
> 
> Sorry for the delay in responding.  Here is what I see when running
> the infiniband_pkey test on a current Fedora Rawhide system (run
> individually to capture the output):
> 
> 1..4
> # Running under perl version 5.030000 for linux
> # Current time local: Wed Sep  4 18:24:39 2019
> # Current time GMT:   Wed Sep  4 22:24:39 2019
> # Using Test.pm version 1.31
> ok 1
> Unable to create cq.
> not ok 2
> # Test 2 got: "256" (./test at line 50)
> #   Expected: "0"
> #  ./test line 50 is:     ok( $result, 0 );
> Unable to create cq.
> not ok 3
> # Test 3 got: "1" (./test at line 71)
> #   Expected: "13"
> #  ./test line 71 is: if (@unlabeled_pkeys) {
> ok 4
> 
> ... and I see the following AVCs:
> 
> type=AVC msg=audit(1567635879.312:15018): avc:  denied  { ipc_lock } for
>    pid=15726 comm="create_modify_q" capability=14
>    scontext=unconfined_u:unconfined_r:test_ibpkey_access_t:s0-s0:c0.c1023
>    tcontext=unconfined_u:unconfined_r:test_ibpkey_access_t:s0-s0:c0.c1023
>    tclass=capability permissive=0
> type=AVC msg=audit(1567635884.022:15020): avc:  denied  { ipc_lock } for
>    pid=15732 comm="create_modify_q" capability=14
>    scontext=unconfined_u:unconfined_r:test_ibpkey_access_t:s0-s0:c0.c1023
>    tcontext=unconfined_u:unconfined_r:test_ibpkey_access_t:s0-s0:c0.c1023
>    tclass=capability permissive=0
> 
> If I apply the workaround patch I mentioned earlier, the test succeeds
> and the only AVC is a infiniband_pkey:access denial (which is expected
> given the test).

I don't suppose you have SYSCALL (and possibly other auxiliary) audit 
records from those denials?
Trying to figure out what system call triggered the CAP_IPC_LOCK check.
