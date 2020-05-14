Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A89DC433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 15:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4007320643
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 15:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="f3iWdTeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgENPAg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 11:00:36 -0400
Received: from mailomta1-re.btinternet.com ([213.120.69.94]:62865 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728058AbgENPAf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 11:00:35 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200514150033.HAKZ8887.re-prd-fep-048.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Thu, 14 May 2020 16:00:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1589468433; 
        bh=mlxvMw0zZQEqD7zlkPUPppOQdq12vJ96iSnPU0wlVWo=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=f3iWdTeHvuL72u4p/rkon5ZFMWmwxdgPImQiHRYJupzGImhXFWNmTLUQk16k/jhX1CMBC1kvsaz7KVAzJuahqjFtqsvwZHy3+89WvhoZNol5xBw2XtrB0Errh15PX4zdCcx6ANCjkrhJjMvVjt2ESdp5EeZ02u04YxYJminh29R3Aczlj9d04h5Ey3/+42nn2knXBTL007snLSWOzCLQqDvctdrrM0yxwBUTrBI7J/0LqirroMrkDiQA+INcMWAXnSfxk1q7Yi4tETx727RXAXHHzj3AymKSD+gQmnVx79bPCxtULvi1M0E3iklJwFlPzmmEB4/HNWg3+W0Sbqs1+g==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.156.13.4]
X-OWM-Source-IP: 86.156.13.4 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrleeigdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepkeegfedtffekieekudegvdekjeehieffveevleegtdeludetveduleffudfggfeinecukfhppeekiedrudehiedrudefrdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehiedrudefrdegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoughhohifvghllhhssehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghp
        thhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.156.13.4) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A15B610773806; Thu, 14 May 2020 16:00:33 +0100
Message-ID: <572ec8d0d9082d076287cd0e4c06003c03258ea0.camel@btinternet.com>
Subject: Re: [RFC PATCH] selinux-testsuite: Add check for key changes on
 watch_queue
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        David Howells <dhowells@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Date:   Thu, 14 May 2020 16:00:32 +0100
In-Reply-To: <CAFqZXNtrXaYR3tJ1awcu6_CAG=syA0GqcHg+UTCZQFpQv3hY-w@mail.gmail.com>
References: <20200417163804.307854-1-richard_c_haines@btinternet.com>
         <CAFqZXNtrXaYR3tJ1awcu6_CAG=syA0GqcHg+UTCZQFpQv3hY-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-05-14 at 10:50 +0200, Ondrej Mosnacek wrote:
> On Fri, Apr 17, 2020 at 6:38 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Kernel 5.7 introduced the watch_queue service that allows watching
> > for
> > key changes. This requires key { view } permission, therefore check
> > if
> > allowed or not.
> > 
> > Note that the keyctl_watch_key() function is not yet built into the
> > keyutils library, therefore a syscall() is used.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> 
> OK, so I tried to build kernel RPMs(*) from the linux-next tree and
> try out this patch, but I ran into a few problems:
> 1. <linux/watch_queue.h> includes <linux/fcntl.h>, which conflicts
> with glibc's <sys/fcntl.h>. This will maybe get fixed in glibc/kernel
> eventually, but I can't apply the patch as-is (maybe we can #define
> _LINUX_FCNTL_H before including <linux/watch_queue.h> as a temporary
> workaround?).
> 2. Even when I got the test program to build, the test failed. I ran
> out of time to dig further, but it may be due to the issues I spotted
> later in the test policy (see below).
> 
> (*) I wanted to try out the new Fedora's kernel build machinery, so I
> burnt too much time on this... but I now have a semi-automated way to
> build linux-next kernels as RPMs, which might come in handy in the
> future :)

Thanks for the feedback I'll see about fixing the issues.
> 
> > ---
> >  defconfig                 |   5 ++
> >  policy/Makefile           |   2 +-
> >  policy/test_watchkey.te   |  34 ++++++++++++
> >  tests/Makefile            |   4 ++
> >  tests/watchkey/.gitignore |   1 +
> >  tests/watchkey/Makefile   |   7 +++
> >  tests/watchkey/test       |  29 ++++++++++
> >  tests/watchkey/watchkey.c | 113
> > ++++++++++++++++++++++++++++++++++++++
> >  8 files changed, 194 insertions(+), 1 deletion(-)
> >  create mode 100644 policy/test_watchkey.te
> >  create mode 100644 tests/watchkey/.gitignore
> >  create mode 100644 tests/watchkey/Makefile
> >  create mode 100755 tests/watchkey/test
> >  create mode 100644 tests/watchkey/watchkey.c
> > 
> > diff --git a/defconfig b/defconfig
> > index 0574f1d..9afbc2f 100644
> > --- a/defconfig
> > +++ b/defconfig
> > @@ -78,3 +78,8 @@ CONFIG_KEY_DH_OPERATIONS=y
> >  # Test key management socket.
> >  # This is not required for SELinux operation itself.
> >  CONFIG_NET_KEY=m
> > +
> > +# watch_queue for key changes.
> > +# They are not required for SELinux operation itself.
> > +CONFIG_WATCH_QUEUE=y
> > +CONFIG_KEY_NOTIFICATIONS=y
> > diff --git a/policy/Makefile b/policy/Makefile
> > index 87b2856..b3f5e3d 100644
> > --- a/policy/Makefile
> > +++ b/policy/Makefile
> > @@ -86,7 +86,7 @@ TARGETS += test_bpf.te test_fdreceive_bpf.te
> > test_binder_bpf.te
> >  endif
> > 
> >  ifeq ($(shell grep -q all_key_perms
> > $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > -TARGETS += test_keys.te
> > +TARGETS += test_keys.te test_watchkey.te
> >  endif
> > 
> >  ifeq ($(shell grep -q all_file_perms.*watch
> > $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > diff --git a/policy/test_watchkey.te b/policy/test_watchkey.te
> > new file mode 100644
> > index 0000000..e1d4c78
> > --- /dev/null
> > +++ b/policy/test_watchkey.te
> > @@ -0,0 +1,34 @@
> > +#
> > +######### Check watch_queue for key changes policy module
> > ##########
> > +#
> > +attribute watchkeydomain;
> > +
> > +################# Allow watch_queue key { view }
> > ##########################
> > +type test_watchkey_t;
> > +domain_type(test_watchkey_t)
> > +unconfined_runs_test(test_watchkey_t)
> > +typeattribute test_watchkey_t testdomain;
> > +typeattribute test_watchkey_t keydomain;
> 
> You declare attribute "watchkeydomain" above and later call some
> interfaces on it, but assign all the types to "keydomain". I assume
> you meant to assign them to "watchkeydomain"?
> 
> > +
> > +allow test_watchkey_t self:capability { ipc_lock };
> > +allow test_watchkey_t device_t:chr_file { ioctl open read write };
> > +allow test_watchkey_t self:key { view };
> > +allow_map(test_watchkey_t, device_t, chr_file)
> > +
> > +################# Deny watch_queue key { view }
> > ##########################
> > +type test_watchkey_no_view_t;
> > +domain_type(test_watchkey_no_view_t)
> > +unconfined_runs_test(test_watchkey_no_view_t)
> > +typeattribute test_watchkey_no_view_t testdomain;
> > +typeattribute test_watchkey_no_view_t keydomain;
> > +
> > +allow test_watchkey_no_view_t self:capability { ipc_lock };
> > +allow test_watchkey_no_view_t device_t:chr_file { ioctl open read
> > write };
> > +neverallow test_watchkey_no_view_t self:key { view };
> > +allow_map(test_watchkey_no_view_t, device_t, chr_file)
> > +
> > +#
> > +########### Allow these domains to be entered from sysadm domain
> > ############
> > +#
> > +miscfiles_domain_entry_test_files(watchkeydomain)
> > +userdom_sysadm_entry_spec_domtrans_to(watchkeydomain)
> [...]
> 

