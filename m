Return-Path: <SRS0=jmdh=SU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599B3C10F0E
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 13:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD0A20674
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 13:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ewo0IAN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbfDRNtx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:49:53 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:8664 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388888AbfDRNtx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 09:49:53 -0400
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2019 09:49:52 EDT
X-EEMSG-check-017: 8999952|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Apr 2019 13:39:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1555594782; x=1587130782;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jbsVzhdGN2qxQBaPleRMdtIYmErmkoL9LrkNXSB5a6U=;
  b=ewo0IAN737hr5NrexZKuhPL0DoCR0ybh+J9UOWUFG0LYjzxXufPRu4C8
   qKyTzAAkeoLxKhXy9jN0mJwzVpZiarFdcUjZN6rMRsQrViN9Y24f+zmi3
   v96CsuklpWgG4r75pidDhD97Mz3dnRgoG2XDsr9HTM12Sf60fy5unMGlu
   lWk5I116FzbqZv/4N9oBlx0qZGP3m6mpinkXHo7whWYJoxq4DMui9hoiB
   GWIwqVzfHNDGYtxMMS4Ov4BDzjoDz4UWaOH7Pl/UagPN/sVD57QYkBwv8
   MfnACqRRUnLZDQv4wY+8fl7MU4eDifhuuFAjFWcdG3I/jfZ7WVM93xnWz
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,366,1549929600"; 
   d="scan'208";a="26474121"
IronPort-PHdr: =?us-ascii?q?9a23=3AK2MDxBwzWfGlbt7XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uIQL/ad9pjvdHbS+e9qxAeQG9mCsrQf1qGN7uigATVGvc/Z9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMq8Uam4VvJ6Y+xh?=
 =?us-ascii?q?bHonZDZuBayX91KV6JkBvw+9u88IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sAvXnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwDIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqpRxtojex3scsip?=
 =?us-ascii?q?fGhoQIwV7Z8CV22oI1JdmmR097fNWpF4BQuDyBN4ZtXsMjQ31nuCY9yrEcv5?=
 =?us-ascii?q?67ZzIFxI4oxx7YdfyKao6F6Q/gWuaJOTp0mX1odb2lixuy7ESs0PPwW8aq3F?=
 =?us-ascii?q?pQsyZIlMTHuGoX2BzJ8MeHT+Nw/kKm2TmSyQ/e8vpEIUUolarDLJ4h36Iwmo?=
 =?us-ascii?q?ITsUvdGi/2n137jLOMeUU+++io9v/nbq/6pp6cK4B0igb+Pr4omsOjGuQ3Lh?=
 =?us-ascii?q?ICX22a+eS4zLHj/Ev5T6tWjvAuj6XUv5/XKd4bq6KkGQNZzIku5wilAzu7yN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLejjDfiimFShiytrxvDaMb3hBZXBNH7DkKz7cr?=
 =?us-ascii?q?pn5E5czxQzwchF551IErEBPO7zWkjpudPEFBA5KBK7wub8BdVmyoweWXiAAr?=
 =?us-ascii?q?KXMKPWr1CI/PsjLPWWa4MPpDn9LP0l7eb0jXAlgV8dYbWp3ZwPZXC/GvRpPU?=
 =?us-ascii?q?qZbGH2gtgfDGgKvhAxTPDwhFKeVj5TYm64X7gg6TEjFIKmEYDDS5i1gLObwS?=
 =?us-ascii?q?e7GoZbZnhcBVCRFXfkboCEW/ALaCKIPMBtiCALVb+kS4U5zxGhqBf6y6Z7Lu?=
 =?us-ascii?q?rT4iAXqZDj2MJp6O3Tix4y8zN0D8ac026XSWF5hWMIRyIs06Fxv0N9y02P3r?=
 =?us-ascii?q?R/g/xdDdZT/e9GUh8mNZ7AyOx3E9PyVRzfcdeSVFmmRdKmATIqQ90tw98OeU?=
 =?us-ascii?q?F9G9CjjhDe2iqmGbgVl6aEBJYs6KLTw2DxJ9phy3bBzKQhiUcpQspLNWK9na?=
 =?us-ascii?q?N/7BXTB5XXnEmDi6mqcqEc1jbX9Gif1WqOoF1YUAloXKjZW3AfYFHZoc7k6E?=
 =?us-ascii?q?zeT7+uFLEnPRFCycGcMKtHcdvpgktaRPj5INTee3i9lHu3BRaN3rmMdpble3?=
 =?us-ascii?q?0B3CXBD0gJiwQT/XeANQgjCSatumHeAyJ0FVLpfUzs9fJzqG20TkAq1QGGdU?=
 =?us-ascii?q?5h2KSv+h4Tm/OcT+kf3rUeuCcusz90Bkqy38rKC9qcoApsZLtcYdIn4FdAzm?=
 =?us-ascii?q?/YthJyPpqhL6B8nFIedwV3v0Xz1xR4EIlAltIqrHwwwApvKqKSyElBeC+A3Z?=
 =?us-ascii?q?DsJr3XLXH//R+ua6HI1VDe0cuW+r4O6Pkjq1XjoRumF0Q8/HVmydVaz3yc5p?=
 =?us-ascii?q?DSBgoITZ3xSlo39wR9p7zCYik9+pnb1HNyPqm1qDPC39MpC/AkyhamZNpfML?=
 =?us-ascii?q?6EGxX8EsIEBsiiMvAlm1+sbhgcJuBd6LY0P9+6d/uBwKOqPPxvnDS8gmRG4o?=
 =?us-ascii?q?B901yD+jF8Su7VxZkEze+X3gqdWzjgi1eht9j9mZpYajEKAmq/1S/kCZZJZq?=
 =?us-ascii?q?JsYYYEF32uIsysy9V/gZ7tVWRY+0S+CFwYwsCmZACeb1vn3Q1fzU4Xu2ComT?=
 =?us-ascii?q?OkzzxolDEktq+f3C3Iw+TtcxoKIXRLS3d/glfsO4e0k8oWU1SvbwgsjBGl/1?=
 =?us-ascii?q?r1x7BHpKRjKGneWUNIfynwL2F/Xaq8r6GCbNBT55M1qyVXUfi8YFCDRr74pB?=
 =?us-ascii?q?sVzj7jH29Ayz0gaTGqtYv2nwZghGKeMnlztnzZdt90xRvF49zcX/FR1CIcRC?=
 =?us-ascii?q?ZkkTnXGkS8P96x8NWPiZjDtuG+V2S8VpxcaiTr04yAuzWh5WFwAh2wgeqzmt?=
 =?us-ascii?q?v5Hgg+yyP70MNqVSrQphbmfobrz7i6Mf5gfkRwBF7z8cx6Go5+k4sxgpEQ1n?=
 =?us-ascii?q?wahpSP8noBnmf+KtVb2b/kY3sDWzELwsTZ7xTi2E1mfTq1wNfSX26Q04NabN?=
 =?us-ascii?q?mzf20S1zh1u8tDE6qFxKdPnSJorF61t0faaL52mTJLjbMJ7HMVy8cEoxYg1C?=
 =?us-ascii?q?KDSuQVGURXFTbhmxSB85a1q6ABIC6XeKW0nG95msqsROWaqxxYcG7wZ5NnGC?=
 =?us-ascii?q?h39Mg5O1XJhi7d8IbhLeLMYMoTuxvcqBLJi+xYOdpljfYRrTZ2MmL6+3s+wq?=
 =?us-ascii?q?g0igI4jsLyh5SON2g4pPHxORVfLDCgIppIqzw=3D?=
X-IPAS-Result: =?us-ascii?q?A2BoBQAsfbhc/wHyM5BlHQEBBQEHBQGBZYFnKoE5ATIoh?=
 =?us-ascii?q?A6Ie4otTAEBAQEBAQaBECWJSI8WgWc8AYRAAoYZIzgTAQMBAQEEAQEBAQIBb?=
 =?us-ascii?q?CiCOikBgmcBBSMPAQVBEAsYAgImAgJXBgEMBgIBAYJfP4F1FKkJgS+FR4Rmg?=
 =?us-ascii?q?Qsni0oXeIEHgTgMgl8+hC2DIYJXBIx+mUoJggiFPYxhBhuVB4t4ljohgVYrC?=
 =?us-ascii?q?AIYCCEPgyeQbCMDMIEGAQGPagEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Apr 2019 13:39:41 +0000
Received: from localhost.localdomain (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x3IDddRh029733;
        Thu, 18 Apr 2019 09:39:40 -0400
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     "chengjian (D)" <cj.chengjian@huawei.com>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <20190415134331.GC22204@redhat.com>
 <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com>
 <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
 <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com>
 <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
 <20190417145711.GI32622@redhat.com>
 <CAHC9VhSzo4DsMRknOA-4KKYJEir0wW74+quLheTjRw94OmhscA@mail.gmail.com>
 <20190417162723.GK32622@redhat.com>
 <939a45a6-fc1b-0ac3-759b-0e7c3ce3d670@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4493cc24-4023-028c-1007-0f61f63a5bda@tycho.nsa.gov>
Date:   Thu, 18 Apr 2019 09:39:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <939a45a6-fc1b-0ac3-759b-0e7c3ce3d670@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/17/19 12:42 PM, Casey Schaufler wrote:
> On 4/17/2019 9:27 AM, Oleg Nesterov wrote:
>> On 04/17, Paul Moore wrote:
>>> On Wed, Apr 17, 2019 at 10:57 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>>> On 04/17, Paul Moore wrote:
>>>>> I'm tempted to simply return an error in selinux_setprocattr() if
>>>>> the task's credentials are not the same as its real_cred;
>>>> What about other modules? I have no idea what smack_setprocattr() is,
>>>> but it too does prepare_creds/commit creds.
>>>>
>>>> it seems that the simplest workaround should simply add the additional
>>>> cred == real_cred into proc_pid_attr_write().
>>> Yes, that is simple, but I worry about what other LSMs might want to
>>> do.  While I believe failing if the effective creds are not the same
>>> as the real_creds is okay for SELinux (possibly Smack too), I worry
>>> about what other LSMs may want to do.  After all,
>>> proc_pid_attr_write() doesn't change the the creds itself, that is
>>> something the specific LSMs do.
>> Yes, but if proc_pid_attr_write() is called with cred != real_cred then
>> something is already wrong?
>>
>> In fact, I think that something is already wrong if it is not called by
>> user-space directly. Too late to ask, but why is this /proc/self/attr/
>> magic not implemented via syscall(s) ?
> 
> Shell scripts, for one thing. It's a straightforward and appropriate
> use of the /proc interface. System calls would require additional change
> to existing programs, whereas using the /proc interface allows a good
> deal to be done in the containing scripts.

It is fairly awkward/fragile to use these interfaces from shell scripts 
due to limitations of the interface (e.g. no partial writes, thereby 
breaking if the shell splits up the data into multiple write() calls) 
and due to the fact that most of the attributes (except for current) are 
typically reset/cleared upon exec to prevent undue caller/callee 
influence.  It works well enough for echo -n "somelabel" > 
/proc/self/attr/current but not much else, and even that doesn't work 
without the -n due to multiple write() calls.

Just for the record, this functionality was originally implemented via 
separate system calls at least for SELinux (in its original kernel 
patch), then multiplexed through the single LSM security system call 
upon porting to LSM (before merging to mainline), but viro and others 
strongly favored using /proc as the interface for getting/setting any 
new process attributes.  Understandable, but it does impose some 
limitations, including a dependency on having a writable proc mount in 
the namespace of any process that needs to set any of these attributes,
