Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8489C433FE
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 12:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7E6233FD
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 12:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLGMkQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Dec 2020 07:40:16 -0500
Received: from mailomta12-re.btinternet.com ([213.120.69.105]:57064 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgLGMkP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Dec 2020 07:40:15 -0500
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20201207123930.QRYJ14484.re-prd-fep-047.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Mon, 7 Dec 2020 12:39:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1607344770; 
        bh=PK4hc9OEmZcIJu33VOpS1CgOAj8AglMbzo7zporPjJM=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=Iu5PZy7JpdcXiZTpoNgmvnd0At9ZVhnfn+I7ofQMrA7/we5w4G6E5HR9nlq82T33o217KcjpIt4aZ5n1Pwi3JDjiLMlIxwJ+R+mhQXTjycg1iYTp5scO3a+WtTd3zuaBoSEUeUPOvDFXiTYz2oA+V2Jito1zw2b0UOZB9szmElHzI6emDsM2akL39bCM3gqTKVZiJrmLaKOoC8UDbZfNjRBvvU+X88+lvg4vmSQ7x9mmrPAA0jFjiNzFp3q/ZBDBcQ8Ke4XTwq57tb7GGVr84kBIPDG17ArNhUUil+3YzJRInZhz7U/Z41LX87xFUBdzHSlwXwdYTfXufX7tW8AU0Q==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C0CC1D77109D
X-Originating-IP: [109.158.127.67]
X-OWM-Source-IP: 109.158.127.67 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudejgedggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvieduhfdvjeetffejledvuedvhefgffelgffhfeelgeeijeejleekleejjefhvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedutdelrdduheekrdduvdejrdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudelkegnpdhinhgvthepuddtledrudehkedruddvjedrieejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeorghshhhishhhmhesmhhvihhsthgrrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigqdhrvghfphholhhitgihsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeo
        shgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (109.158.127.67) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C0CC1D77109D; Mon, 7 Dec 2020 12:39:30 +0000
Message-ID: <0b58a502b5036e8b92b274068fbea53ca915992e.camel@btinternet.com>
Subject: Re: How is policy.31 created from modules under /usr/share/selinux
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     selinux-refpolicy@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Date:   Mon, 07 Dec 2020 12:39:24 +0000
In-Reply-To: <CAP2OjchJjMo8zMVvHk-_esu-53E0=367yV8cuZtwQwubi7+q=Q@mail.gmail.com>
References: <CAP2OjcjCFYiyMfqa=X__X6g0U0143U5Fd-xGaKJgGNabFUpr7w@mail.gmail.com>
         <858c9383f7c75e1e39bafaeab6388cd6af902c4f.camel@btinternet.com>
         <CAP2OjciTWXRsYWw9VtOJGUOGj9B35HMXBHF94O6Qc=csg5=Spw@mail.gmail.com>
         <e82841a8b652f4b4b697ba1e417fdac56f443adb.camel@btinternet.com>
         <CAP2OjchJjMo8zMVvHk-_esu-53E0=367yV8cuZtwQwubi7+q=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-12-07 at 06:51 +0530, Ashish Mishra wrote:
> Hi Richard ,
> 
> 1) There are approx 426 *.pp files being created under
> /usr/share/selinux/refpolicy
>     Attached is the log , which contains the list of files .
> 
> 2) I can confirm the stages till semodule
> 
> 3) This is a custom Linux SDK 4.x series BSP on which i am trying to
> get the refpolicy
>      installed .
> 
> 4) Any pointers to verify if make load is happening as expected or
> https://github.com/SELinuxProject/selinux installation
>     Because i am not observing any error here during make -v .
> 
> I am trying to look at the probable cause / pointers to debug the
> missing policy.31 file here.
> Any inputs will be helpful .

Have you tried building a monolithic policy as this does not use
semodule (uses checkpolicy). Just change the build.conf 'MONOLITHIC =
y'
Building this on a clean system does not build/install the
/usr/share/selinux/refpolicy modules so quite simple build.
You could also set 'OUTPUT_POLICY = <ver>' to build a lower version
binary policy (e.g. 21).

Otherwise (running out of ideas):
1) Is this already a working SELinux system (e.g. do you have the
'targeted' or 'mls' policy installed)
2) When 'make load' gets to semodule, what errors do you see.
3) When semodule builds it installs a policy store (default) at
/var/lib/selinux/refpolicy. Do you have this when you build a modular
policy ?


> 
> Thanks .
> Ashish
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> On Sun, Dec 6, 2020 at 10:45 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > 
> > On Sun, 2020-12-06 at 22:00 +0530, Ashish Mishra wrote:
> > > Hi Richard ,
> > > 
> > > Thanks for replying back.
> > > 
> > > 1) The policy.31 binary is not getting  created at:
> > >   /etc/selinux/refpolicy/policy/policy.31
> > > 
> > > 2) Using the verbose of makefile I can see that the semodule
> > > command
> > > is reached .
> > >    But even in verbose mode , I can't see any action / command
> > > message
> > >    shown for policy.31 being created.
> > >    Hence I am trying to understand how the final policy.31 file
> > > is
> > > being created .
> > 
> > You will not see a reference to 'policy.31' when running semodule.
> > It
> > just takes the large list of modules and its store id, the rest is
> > magic (the default name is 'policy', the version is derived from
> > the
> > policy-version= entry in the semanage.conf file or the kernel
> > default).
> > It then adds the policy binary file to:
> > 
> > /etc/selinux/<SELINUXTYPE>/policy/policy.<ver>
> > 
> > Where <SELINUXTYPE> is the policy store id that should match the
> > /etc/selinux/config SELINUXTYPE= entry when loading the policy.
> > 
> > For example when I run 'make -d load' I see (cutdown):
> > 
> > Loading configured modules.
> > /usr/sbin/semodule -s refpolicy -i
> > /usr/share/selinux/refpolicy/base.pp
> > -i /usr/share/selinux/refpolicy/abrt.pp ......
> > 
> > BTW what distro/version are you using as I use Fedora 33 that by
> > default generates an '/etc/selinux/refpolicy/policy/policy.32'
> > binary
> > file.
> > 
> > > 
> > > 3) Below are the files being created under /etc/selinux :
> > >    refpolicy/contexts:
> > >    customizable_types  default_type      initrc_context
> > > removable_context  userhelper_context      virtual_image_context
> > >    dbus_contexts       failsafe_context  lxc_contexts
> > > securetty_types    users                   x_contexts
> > >    default_contexts    files             openrc_contexts
> > > sepgsql_contexts   virtual_domain_context
> > > 
> > >    refpolicy/policy:
> > My initial thought is that 'make load' is not being called or
> > something
> > is wrong with
> > 'https://github.com/SELinuxProject/selinux' installation
> > 
> > > 
> > >    refpolicy/src:
> > >    policy
> > > 
> > > 
> > > 4) Below are the files being created under
> > 
> > Are there any *.pp files under:
> > /usr/share/selinux/refpolicy
> > 
> > If not again looks like 'https://github.com/SELinuxProject/selinux'
> > installation problem checkpolicy/checkmodule ??
> > 
> > > /usr/share/selinux/refpolicy/include/
> > >    admin      apps      build.conf           global_tunables.xml
> > > kernel.xml  roles      services      support  system.xml
> > >    admin.xml  apps.xml  global_booleans.xml  kernel
> > > Makefile    roles.xml  services.xml  system
> > > 
> > > Any pointer of probable aspect which can cause such error as I am
> > > trying to understand
> > > how policy.31 binary is created from individual modules
> > > 
> > > Thanks ,
> > > Ashish
> > > 
> > > 
> > > 
> > > 
> > > On Sun, Dec 6, 2020 at 8:59 PM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > 
> > > > On Sun, 2020-12-06 at 00:49 +0530, Ashish Mishra wrote:
> > > > > Hi All  ,
> > > > > 
> > > > > Good Morning .
> > > > > 
> > > > > I am following the SELINUX NOTEBOOK & trying the same at my
> > > > > end .
> > > > > 
> > > > > - The refpolicy modules are copied at
> > > > > /usr/share/selinux/refpolicy
> > > > >    i can see around 400+ modules there .
> > > > >    But can senior member' s please help me understand how is
> > > > > the
> > > > >    /etc/selinux/refpolicy/policy/policy.31  created using the
> > > > > modules
> > > > > available at
> > > > >    /usr/share/selinux
> > > > >    The command i followed :
> > > > >                 $ make install-src
> > > > >                 $ make conf
> > > > >                 $ make load ( tried even $ make install )
> > > > >                 $ make install-headers
> > > > > 
> > > > 
> > > > Just to be clear (as you didn't state whether the binary policy
> > > > file
> > > > was built at all), if you run these commands:
> > > > 
> > > > mkdir refpol
> > > > cd refpol
> > > > git clone https://github.com/SELinuxProject/refpolicy.git
> > > > Edit build.conf file to requirements (e.g. NAME = refpolicy
> > > > etc.)
> > > > make install-src
> > > > cd /etc/selinux/refpolicy/src/policy
> > > > make conf
> > > > make load
> > > > make install-headers
> > > > 
> > > > The policy binary file should now be created at:
> > > >   /etc/selinux/refpolicy/policy/policy.31 (or .32 if Fedora 33)
> > > > True ??
> > > > 
> > > > To add a new module (that will rebuild the binary policy file)
> > > > you
> > > > can
> > > > install the new *.te *.if and *.fc files in a directory and run
> > > > from
> > > > that directory (you will need to ensure /etc/selinux/config has
> > > > SELINUXTYPE=refpolicy set):
> > > > 
> > > > make -f /usr/share/selinux/refpolicy/include/Makefile load
> > > > 
> > > > This Makefile basically reads the build.conf file, uses
> > > > checkmodule
> > > > to
> > > > build the *.pp file, then semodule to add to store and build
> > > > the
> > > > binary
> > > > policy (also using the prebuilt
> > > > /usr/share/selinux/refpolicy/*.pp
> > > > files).
> > > > 
> > > > I've just tried this on Fedora 33 with no problems.
> > > > 
> > > > Note: While running through example this I noticed an error in
> > > > the
> > > > Notebook - the Reference policy does not have a contibute
> > > > section,
> > > > I'll
> > > > send patch to remove:
> > > > 
> > > > Add the contibuted modules (policy/modules/contrib)
> > > > git submodule init
> > > > git submodule update
> > > > 
> > > > > 
> > > > > - This can help me to debug an issue where i am trying to get
> > > > > selinux
> > > > > of my custom
> > > > >    distro where all the make command are successfully
> > > > > executed
> > > > > but
> > > > > the policy.31
> > > > >    is not getting created
> > > > > 
> > > > > - I can even see the "include" folder also getting created
> > > > > for
> > > > > make
> > > > > install-headers
> > > > > 
> > > > > Any pointers will be helpful or please let me know if i am
> > > > > missing
> > > > > any
> > > > > aspect here .
> > > > > 
> > > > > Thanks ,
> > > > > Ashish.
> > > > 
> > > > 
> > 
> > 


