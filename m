Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1E5C4361B
	for <selinux@archiver.kernel.org>; Sun,  6 Dec 2020 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECC222509
	for <selinux@archiver.kernel.org>; Sun,  6 Dec 2020 17:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgLFRQJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 6 Dec 2020 12:16:09 -0500
Received: from mailomta31-re.btinternet.com ([213.120.69.124]:48562 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726043AbgLFRQJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 6 Dec 2020 12:16:09 -0500
X-Greylist: delayed 6345 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Dec 2020 12:16:06 EST
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20201206171524.EJAL29010.re-prd-fep-044.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Sun, 6 Dec 2020 17:15:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1607274924; 
        bh=RAAbkhFgb0x9S/IS8jL6h6/4g4d1h01s1edFXYH5FwQ=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=iCGp3B+gqHYDP9Gyk6s2mkKRof8oDgxwyu3X4uMONdZq9u/QzHBlglf2JwTzobm5Wpwv3f2fsHoiRphVu19aHTmwfY60rRE+4jz3p3jFaZl6e74a/oV2ANQSMXyUgS4M3y8SpS20KuHg1njB2qQ7QqC43LeguHDlHQ4fcBAhUyK4s0diQ6bSEAh/QeB2H8q9eyj4xvWJkCvBeJiy/eQ+JLziIweXGyYtafJIFiBWh4gZ/mwN6G5W0fLUrLzfjVmxG/vUG6gpHd4cCo86F0i6dgoUUwsVnBx72Kns0Hvxpqb5n2xCwOBnSxCq4QF/ErHxjyJw+CGTTd2YYNiTjgmerw==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C5061D5A96A0
X-Originating-IP: [86.183.114.64]
X-OWM-Source-IP: 86.183.114.64 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudejvddguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepvdeiudfhvdejteffjeelvdeuvdehgffflefghfefleegieejjeelkeeljeejhfdvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeirddukeefrdduudegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudelkegnpdhinhgvthepkeeirddukeefrdduudegrdeigedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegrshhhihhshhhmsehmvhhishhtrgdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugidqrhgvfhhpohhlihgthiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehs
        vghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (86.183.114.64) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C5061D5A96A0; Sun, 6 Dec 2020 17:15:24 +0000
Message-ID: <e82841a8b652f4b4b697ba1e417fdac56f443adb.camel@btinternet.com>
Subject: Re: How is policy.31 created from modules under /usr/share/selinux
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     selinux-refpolicy@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Date:   Sun, 06 Dec 2020 17:15:24 +0000
In-Reply-To: <CAP2OjciTWXRsYWw9VtOJGUOGj9B35HMXBHF94O6Qc=csg5=Spw@mail.gmail.com>
References: <CAP2OjcjCFYiyMfqa=X__X6g0U0143U5Fd-xGaKJgGNabFUpr7w@mail.gmail.com>
         <858c9383f7c75e1e39bafaeab6388cd6af902c4f.camel@btinternet.com>
         <CAP2OjciTWXRsYWw9VtOJGUOGj9B35HMXBHF94O6Qc=csg5=Spw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, 2020-12-06 at 22:00 +0530, Ashish Mishra wrote:
> Hi Richard ,
> 
> Thanks for replying back.
> 
> 1) The policy.31 binary is not getting  created at:
>   /etc/selinux/refpolicy/policy/policy.31
> 
> 2) Using the verbose of makefile I can see that the semodule command
> is reached .
>    But even in verbose mode , I can't see any action / command
> message
>    shown for policy.31 being created.
>    Hence I am trying to understand how the final policy.31 file is
> being created .

You will not see a reference to 'policy.31' when running semodule. It
just takes the large list of modules and its store id, the rest is
magic (the default name is 'policy', the version is derived from the
policy-version= entry in the semanage.conf file or the kernel default).
It then adds the policy binary file to:

/etc/selinux/<SELINUXTYPE>/policy/policy.<ver>

Where <SELINUXTYPE> is the policy store id that should match the
/etc/selinux/config SELINUXTYPE= entry when loading the policy.

For example when I run 'make -d load' I see (cutdown):

Loading configured modules.
/usr/sbin/semodule -s refpolicy -i /usr/share/selinux/refpolicy/base.pp
-i /usr/share/selinux/refpolicy/abrt.pp ......

BTW what distro/version are you using as I use Fedora 33 that by
default generates an '/etc/selinux/refpolicy/policy/policy.32' binary
file.

> 
> 3) Below are the files being created under /etc/selinux :
>    refpolicy/contexts:
>    customizable_types  default_type      initrc_context
> removable_context  userhelper_context      virtual_image_context
>    dbus_contexts       failsafe_context  lxc_contexts
> securetty_types    users                   x_contexts
>    default_contexts    files             openrc_contexts
> sepgsql_contexts   virtual_domain_context
> 
>    refpolicy/policy:
My initial thought is that 'make load' is not being called or something
is wrong with 'https://github.com/SELinuxProject/selinux' installation

> 
>    refpolicy/src:
>    policy
> 
> 
> 4) Below are the files being created under

Are there any *.pp files under:
/usr/share/selinux/refpolicy

If not again looks like 'https://github.com/SELinuxProject/selinux'
installation problem checkpolicy/checkmodule ??

> /usr/share/selinux/refpolicy/include/
>    admin      apps      build.conf           global_tunables.xml
> kernel.xml  roles      services      support  system.xml
>    admin.xml  apps.xml  global_booleans.xml  kernel
> Makefile    roles.xml  services.xml  system
> 
> Any pointer of probable aspect which can cause such error as I am
> trying to understand
> how policy.31 binary is created from individual modules
> 
> Thanks ,
> Ashish
> 
> 
> 
> 
> On Sun, Dec 6, 2020 at 8:59 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > 
> > On Sun, 2020-12-06 at 00:49 +0530, Ashish Mishra wrote:
> > > Hi All  ,
> > > 
> > > Good Morning .
> > > 
> > > I am following the SELINUX NOTEBOOK & trying the same at my end .
> > > 
> > > - The refpolicy modules are copied at
> > > /usr/share/selinux/refpolicy
> > >    i can see around 400+ modules there .
> > >    But can senior member' s please help me understand how is the
> > >    /etc/selinux/refpolicy/policy/policy.31  created using the
> > > modules
> > > available at
> > >    /usr/share/selinux
> > >    The command i followed :
> > >                 $ make install-src
> > >                 $ make conf
> > >                 $ make load ( tried even $ make install )
> > >                 $ make install-headers
> > > 
> > 
> > Just to be clear (as you didn't state whether the binary policy
> > file
> > was built at all), if you run these commands:
> > 
> > mkdir refpol
> > cd refpol
> > git clone https://github.com/SELinuxProject/refpolicy.git
> > Edit build.conf file to requirements (e.g. NAME = refpolicy etc.)
> > make install-src
> > cd /etc/selinux/refpolicy/src/policy
> > make conf
> > make load
> > make install-headers
> > 
> > The policy binary file should now be created at:
> >   /etc/selinux/refpolicy/policy/policy.31 (or .32 if Fedora 33)
> > True ??
> > 
> > To add a new module (that will rebuild the binary policy file) you
> > can
> > install the new *.te *.if and *.fc files in a directory and run
> > from
> > that directory (you will need to ensure /etc/selinux/config has
> > SELINUXTYPE=refpolicy set):
> > 
> > make -f /usr/share/selinux/refpolicy/include/Makefile load
> > 
> > This Makefile basically reads the build.conf file, uses checkmodule
> > to
> > build the *.pp file, then semodule to add to store and build the
> > binary
> > policy (also using the prebuilt /usr/share/selinux/refpolicy/*.pp
> > files).
> > 
> > I've just tried this on Fedora 33 with no problems.
> > 
> > Note: While running through example this I noticed an error in the
> > Notebook - the Reference policy does not have a contibute section,
> > I'll
> > send patch to remove:
> > 
> > Add the contibuted modules (policy/modules/contrib)
> > git submodule init
> > git submodule update
> > 
> > > 
> > > - This can help me to debug an issue where i am trying to get
> > > selinux
> > > of my custom
> > >    distro where all the make command are successfully executed
> > > but
> > > the policy.31
> > >    is not getting created
> > > 
> > > - I can even see the "include" folder also getting created for
> > > make
> > > install-headers
> > > 
> > > Any pointers will be helpful or please let me know if i am
> > > missing
> > > any
> > > aspect here .
> > > 
> > > Thanks ,
> > > Ashish.
> > 
> > 


