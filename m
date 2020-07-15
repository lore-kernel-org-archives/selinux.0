Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA73C433E5
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 08:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A20E2064C
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 08:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="anNkJEBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgGOIi3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:38:29 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:49432 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730319AbgGOIi2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 15 Jul 2020 04:38:28 -0400
Received: from [IPv6:2001:985:d55d::438] (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id B2DC62A1007;
        Wed, 15 Jul 2020 10:38:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl B2DC62A1007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1594802304;
        bh=4FFRGk0zyx2J4/PfaI4rUseBwAOIFn2WoHj9N8aYWGo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=anNkJEBO5Tt7XQNJPxqcXdfL4y9V5uxJu93Faa4x9M4vsiPtZLLsNHy1Nv3sP+of9
         AKZBzet3L4zmV1hfNml5gaP52PWs86B7TGizZpc+FCJDOHzK+j91BjjdDsMHHOahva
         ybPK8mJrA3gZd0WYmmOWqjD2xFO2h+GVvpE3RTn0=
Subject: Re: [SELinux-notebook RFC v2] mypolicy is a simple CIL policy with
 Makefile to get started with
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200713173702.426543-1-dominick.grift@defensec.nl>
 <20200714122931.577823-1-dominick.grift@defensec.nl>
 <7a3f46808b8b2465ab798894f4609a96625cd045.camel@btinternet.com>
From:   Dominick Grift <dominick.grift@defensec.nl>
Message-ID: <eb75220d-65d1-b6b5-724e-81521f28e12f@defensec.nl>
Date:   Wed, 15 Jul 2020 10:38:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7a3f46808b8b2465ab798894f4609a96625cd045.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/15/20 10:15 AM, Richard Haines wrote:
> On Tue, 2020-07-14 at 14:29 +0200, Dominick Grift wrote:
>> This leverages some of the more modern features to make creating
>> a policy from scratch a bit more friendly, like the lifting of the
>> classorder requirement and the lifting of the used sidcontext
>> requirement.
>>
>> It is also omitting various aspects that are not strictly needed to
>> get started and that might actually vary in various environments.
>>
>> The policy is installed using semodule and this provides easy and
>> full
>> access to the full sources installed to the module store. Once
>> mypolicy is installed you can, with the help of the CIL
>> documentation,
> 
> Could you pick another name for "mypolicy", maybe "cil-policy" ??

Thanks, will do. As an aside I tagged this RFC because I first wanted to
get some feedback on the main idea.

> 
>> dive right in an start addressing your access control requirements
>> using semodule and your favorite editor.
>>
>> v2: added forgotten defaultrole rules, a filecon for /, and fixed
>> typos/grammar/spelling
>>
>> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>> ---
>>  src/cil_overview.md                         |  11 +
>>  src/notebook-examples/README.md             |   2 +
>>  src/notebook-examples/mypolicy/Makefile     |  46 ++
>>  src/notebook-examples/mypolicy/README.md    |  49 +++
>>  src/notebook-examples/mypolicy/mypolicy.cil | 445
>> ++++++++++++++++++++
>>  5 files changed, 553 insertions(+)
>>  create mode 100644 src/notebook-examples/mypolicy/Makefile
>>  create mode 100644 src/notebook-examples/mypolicy/README.md
>>  create mode 100644 src/notebook-examples/mypolicy/mypolicy.cil
>>
>> diff --git a/src/cil_overview.md b/src/cil_overview.md
>> index a05aad5..83a5e5f 100644
>> --- a/src/cil_overview.md
>> +++ b/src/cil_overview.md
>> @@ -135,6 +135,17 @@ Usage: build-sepolicy [-k] [-M] [-c|-p|-s] -d
>> flask_directory -o output_file
>>  -d    Directory containing the initial_sids, security_classes and
>> access_vectors Flask files.
>>  -o    The output file that will contain the policy source or header
>> file.
>>  ```
>> +There is another CIL policy in the notebook examples called
>> "mypolicy"
>> +that takes a slightly different approach where the goal is to keep
>> the
>> +policy as simple as possible. It requires `semodule`, Linux 5.7 and
>> +SELinux 3.1 and can be installed by executing `make install`. It
>> +leverages some modern SELinux features, most notably where the
>> +requirement for ordered security classes is lifted. With this you
>> are
>> +no longer expected to be aware of all the access vectors managed by
>> +Linux in order to align your security class declarations with to
>> order
>> +in which they are declared in the kernel. A module store is created
>> +by `semodule` that gives easy access to the source and that allows
>> for
>> +full control over the policy.
>>  
>>  <br>
>>  
>> diff --git a/src/notebook-examples/README.md b/src/notebook-
>> examples/README.md
>> index 488ec6e..32d679f 100644
>> --- a/src/notebook-examples/README.md
>> +++ b/src/notebook-examples/README.md
>> @@ -8,5 +8,7 @@ This area contains the following directories:
>>  
>>  ***sepgsql*** - Contains SE-PostgreSQL database example.
>>  
>> +***mypolicy*** - Contains info to build and install simple CIL
>> policy.
>> +
>>  **NOTE:** To run the majority of these examples requires root
>> privilege,
>>  therefore need to su etc. (or just log on as root and be damned)
>> diff --git a/src/notebook-examples/mypolicy/Makefile b/src/notebook-
>> examples/mypolicy/Makefile
>> new file mode 100644
>> index 0000000..d4048fe
>> --- /dev/null
>> +++ b/src/notebook-examples/mypolicy/Makefile
>> @@ -0,0 +1,46 @@
>> +# -*- Mode: makefile; indent-tabs-mode: t -*-
>> +# SPDX-License-Identifier: Unlicense
>> +
>> +.PHONY: clean install test
>> +
>> +all: clean test
>> +
>> +clean:
>> +	\rm -f policy.* file_contexts
>> +
>> +test:
>> +	secilc -vvv mypolicy.cil
>> +
>> +install:
>> +	mkdir -p
>> /etc/selinux/mypolicy/{contexts,logins,policy,contexts/files,contexts
>> /users}
>> +	touch /etc/selinux/mypolicy/contexts/customizable_types
>> +	touch /etc/selinux/mypolicy/contexts/file_contexts.subs_dist
>> +	echo -e """<!DOCTYPE busconfig PUBLIC \
>> +\"-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN\" \
>> +\n\"http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd\"> \
>> +\n<busconfig> \
>> +\n<selinux> \
>> +\n</selinux> \
>> +\n</busconfig>""" > /etc/selinux/mypolicy/contexts/dbus_contexts
>> +	echo "sys.role:sys.isid sys.role:sys.isid" >
>> /etc/selinux/mypolicy/contexts/default_contexts
>> +	echo "sys.role:sys.isid" >
>> /etc/selinux/mypolicy/contexts/default_type
>> +	echo "sys.role:sys.isid" >
>> /etc/selinux/mypolicy/contexts/failsafe_context
>> +	echo -e """cdrom sys.id:sys.role:sys.isid \
>> +\nfloppy sys.id:sys.role:sys.isid \
>> +\ndisk sys.id:sys.role:sys.isid""" >
>> /etc/selinux/mypolicy/contexts/files/media
>> +	echo "privsep_preauth=sys.isid" >
>> /etc/selinux/mypolicy/contexts/openssh_contexts
>> +	echo "sys.id:sys.role:sys.isid" >
>> /etc/selinux/mypolicy/contexts/removable_context
>> +	echo "sys.isid" >
>> /etc/selinux/mypolicy/contexts/securetty_types
>> +	echo "sys.id:sys.role:sys.isid" >
>> /etc/selinux/mypolicy/contexts/virtual_domain_context
>> +	echo -e """sys.id:sys.role:sys.isid \
>> +\nsys.id:sys.role:sys.isid""" >
>> /etc/selinux/mypolicy/contexts/virtual_image_context
>> +	echo -e """Section \"Module\" \
>> +\nSubSection \"extmod\" \
>> +\nOption \"SELinux mode disabled\" \
>> +\nEndSubSection \
>> +\nEndSection""" > /etc/selinux/mypolicy/contexts/x_contexts
> 
> This file should be generated in /etc/X11 or /etc/X11/xorg.conf.d as
> you are disabling XSELinux. However, if you use stock Fedora 32
> Workstation (as I do), then you will find that the system does not take
> any notice of this file. I guess it is because they now use Xwayland,
> where before (years ago ?), they used xserver and that did read this
> file. Not sure if this is a bug or 'as designed'
> 
> The only way I found to disable XSELinux on Fedora WS was to add
> the xserver_object_manager boolean and set it to false, otherwise
> Xwayland core dumps whether in permissive or enforcing mode.
> 
> As a test with the standard targeted policy you can add the xorg.conf
> files, reboot (as that should disable XSElinux) then run 'setsebool
> xserver_object_manager 1', log out then try to log back in again. On a
> system built from Fedora 32 ISO image it fails. Reboot and run
> 'journalctl -b -1', you will see the Xwayland abort.
> 
> I guess you could be using a different config for your tests.
> 
> Adding '(boolean xserver_object_manager false)' to your policy I was
> able to build, load policy, log out, then log back in again (after
> updating SELinux to 3.1)

Yes I am aware of this issue (i have that addressed in the way to
described above, and you also covered that in the notebook)

However, for the sake of simplicity I wanted to address it like this:

1. The xwayland issue is a bug IMHO, and even though it can be "worked
around" with these hacks. I feel that is not worth it. Also the xwayland
coredumping, AFAIK, happens when you exit xwayland (in this scenario).

2. Xserver itself will do the right thing with the
/etc/selinux/TYPE/contexts/x_contexts (ie, it will not be able to parse
it and therefore it will disable XACE, so the desired result with the
benefit that the file was reused to document it a little)

3. xwayland should be pretty niche by now.

But if you insist, then, if I decide to upgrade this RFC to PATCH, i
guess I will address it. (but I would prefer to address it as either a
note in the README or in a separate README, not as part of the cil
because I really want to have as little noise/distractions as possible
in there.

> 
> 
>> +	semodule --priority=100 -N -s mypolicy -i mypolicy.cil
>> +	echo "Installation done!"
>> +	echo "Enable:	sed -i
>> 's/SELINUXTYPE.*/SELINUXTYPE=mypolicy/' /etc/selinux/config"
>> +	echo "		semodule -B"
>> +	echo "No point relabeling since no persistent filesystems are
>> set up for labeling yet"
>> diff --git a/src/notebook-examples/mypolicy/README.md b/src/notebook-
>> examples/mypolicy/README.md
>> new file mode 100644
>> index 0000000..591994c
>> --- /dev/null
>> +++ b/src/notebook-examples/mypolicy/README.md
>> @@ -0,0 +1,49 @@
>> +# CIL policy from scratch: A different approach
>> +
>> +This example demonstrates an alternative approach to implementing a
>> +first iteration of a CIL policy from scratch. The main idea is to
>> +create a policy that is as small as reasonably possible, and to
>> +install that using `semodule`. This will provide you with bare
>> +miminums to get you started in enforcing mode.
>> +
>> +To achieve this there are two key features leveraged. The
>> +`handleunknown` statement and the `unlabeled` and `file` initial
>> +security identifiers. By allowing unknown access vectors by default
>> we
>> +can reduce the amount of classes and access vector permission
>> +declarations needed to get started. This was only recently made
>> +possible by lifting the requirement to order classes. Requiring
>> +classes to be ordered implies that the classes are declared, thus it
>> +requires that you know what classes are managed by Linux. Now we
>> only
>> +have to be aware of, and declare a small set of classes and a few
>> +permissions to get started. All the remaining unknown access vectors
>> +will be reported to us by SELinux via the kernel ring buffer, it is
>> +just a matter of looking at `dmesg` to see which access vectors are
>> +managed by Linux but are unknown to the policy, and then to address
>> +those in the policy as we go along.
>> +
>> +The `unlabeled` initial security identifier is used to associate a
>> +specified context with entities that have their existing context
>> +invalidated. The `file` initial security identifier is used to
>> +associate a context with objects that have no labels. This
>> +functionality can be taken advantage of to reduce the work needed to
>> +get a working first iteration of the policy that we can then build
>> +upon. Initial security identifier associated contexts are associated
>> +with entities in memory. This means that effectively we do not have
>> +to worry about persistent labels in our first iteration. We can
>> +address labeling requirements as we go along.
>> +
>> +By using `semodule` we create a module store that we can use to
>> +manage additional modules and that all the source policy is readily
>> +accessible through the store. Everything is accessible and mutable
>> at
>> +runtime, although some changes might require reboot in some
>> scenarios.
>> +The awesome thing about this example is that you can effectively
>> +switch to your new policy at runtime in enforcing mode if your
>> system
>> +was already enforcing a policy before. Otherwise you might have
>> +to reboot to load initial policy.
>> +
>> +This repository comes with a heavily commented CIL module and a make
>> +file that addresses installation. The make file does make some
>> +assumptions that are relatively safe but if something breaks, you
>> get
>> +to keep the pieces. This example requires Linux 5.7 and SELinux 3.1
>> +because it omits initial sid context specifications for unused
>> +security identifiers.
>> diff --git a/src/notebook-examples/mypolicy/mypolicy.cil
>> b/src/notebook-examples/mypolicy/mypolicy.cil
>> new file mode 100644
>> index 0000000..a554853
>> --- /dev/null
>> +++ b/src/notebook-examples/mypolicy/mypolicy.cil
>> @@ -0,0 +1,445 @@
>> +;; -*- mode: CIL; fill-column: 79; indent-tabs-mode: nil; -*-
>> +;; SPDX-License-Identifier: Unlicense
>> +
>> +;;
>> +;; Policy configuration:
>> +;;
>> +;; By allowing unknown access vectors we can start with a reduced
>> number
>> +;; of declared classes and access vectors. Use `dmesg | grep -i
>> selinux` to
>> +;; see which kernel classes and access vectors should be addressed
>> in the
>> +;; policy as you go along.
>> +;;
>> +
>> +(handleunknown allow)
>> +
>> +;;
>> +;; Policy configuration:
>> +;;
>> +;; We'll disable the MLS security model support for simplicity, but
>> CIL still
>> +;; requires us to write our policy with minimal MLS-awareness.
>> Remember, we can
>> +;; alway's add full or partial MLS support later. This is just to
>> get started.
>> +;;
>> +
>> +(mls false)
>> +
>> +;;
>> +;; Access vector declarations and (un)ordering:
>> +;;
>> +;; SELinux requires that the process security class, transition and
>> +;; dyntransition access vector permissions are declared. CIL
>> requires at least
>> +;; one declared access vector and avc rule as well so this is a good
>> starting
>> +;; point. All security classes can be "unordered" with Linux
>> 5.7/SELinux 3.1.
>> +;;
>> +
>> +(class process (dyntransition transition))
>> +(classorder (unordered process))
>> +
>> +;;
>> +;; Access vector declarations and (un)ordering:
>> +;;
>> +;; To be able to associate roles with files, we need defaultrole
>> rules that
>> +;; require file classes to be declared. For now we'll omit their
>> associated
>> +;; access vector permissions for simplicity (get them from `dmesg |
>> grep -i selinux`)
>> +;;
>> +
>> +(class blk_file ())
>> +(classorder (unordered blk_file))
>> +
>> +(class chr_file ())
>> +(classorder (unordered chr_file))
>> +
>> +(class dir ())
>> +(classorder (unordered dir))
>> +
>> +(class fifo_file ())
>> +(classorder (unordered fifo_file))
>> +
>> +(class file ())
>> +(classorder (unordered file))
>> +
>> +(class lnk_file ())
>> +(classorder (unordered lnk_file))
>> +
>> +(class sock_file ())
>> +(classorder (unordered sock_file))
>> +
>> +;;
>> +;; Initial security identifier declarations:
>> +;;
>> +;; The kernel isid is used to associate a specified context with
>> processes
>> +;; that were initialized before SELinux was initialized (mainly
>> kernel threads).
>> +;;
>> +
>> +(sid kernel)
>> +
>> +;;
>> +;; Initial security identifier declarations:
>> +;;
>> +;; The security isid is used to associate a specified context with
>> "fixed"
>> +;; SELinux "objects" used to enforce access control on SELinux
>> operations
>> +;; (for example setenforce, setbool etc).
>> +;;
>> +
>> +(sid security)
>> +
>> +;;
>> +;; Initial security identifier declarations:
>> +;;
>> +;; The port isid is used to associate a specified context with
>> "fixed"
>> +;; network port "objects" used to enforce access control on network
>> +;; operations (for example name_connect, name_bind etc).
>> +;;
>> +
>> +(sid port)
>> +
>> +;;
>> +;; Initial security identifier declarations:
>> +;;
>> +;; The netif isid is used to associate a specified context with
>> "fixed"
>> +;; network interface "objects" used to enforce access control on
>> network
>> +;; operations (for example egress, ingress etc).
>> +;;
>> +
>> +(sid netif)
>> +
>> +;;
>> +;; Initial security identifier declarations:
>> +;;
>> +;; The netmsg isid is used to associate a specified context with
>> "fixed"
>> +;; network peer "objects" used to enforce access control on network
>> +;; operations (for example recv).
>> +;;
>> +
>> +(sid netmsg)
>> +
>> +;;
>> +;; Initial security identifier declarations:
>> +;;
>> +;; The node isid is used to associate a specified context with
>> "fixed"
>> +;; network node "objects" used to enforce access control on network
>> +;; operations (for example node_bind etc).
>> +;;
>> +
>> +(sid node)
>> +
>> +;;
>> +;; Initial security identifier declarations:
>> +;;
>> +;; The devnull isid is used to associate a specified context with
>> "fixed"
>> +;; null device "objects" used to enforce access control on file
>> +;; operations (for example read, write etc).
>> +;;
>> +
>> +(sid devnull)
>> +
>> +;;
>> +;; Initial security identifier declarations:
>> +;;
>> +;; The file isid is used to associate a specified context with
>> objects
>> +;; that have no label (for example formatted filesystems that are
>> not labeled).
>> +;;
>> +
>> +(sid file)
>> +
>> +;;
>> +;; Initial security identifier declarations:
>> +;;
>> +;; The unlabeled isid is used to associate a specified context with
>> entities
>> +;; that had their security context invalidated (mainly due to
>> modifications to
>> +;; policy at runtime).
>> +;;
>> +
>> +(sid unlabeled)
>> +
>> +;;
>> +;; Initial security identifier declarations:
>> +;;
>> +;; The following initial security identifiers are unused but are
>> required
>> +;; for "sid ordering"
>> +;;
>> +
>> +(sid any_socket)
>> +(sid file_labels)
>> +(sid fs)
>> +(sid icmp_socket)
>> +(sid igmp_packet)
>> +(sid init)
>> +(sid kmod)
>> +(sid policy)
>> +(sid scmp_packet)
>> +(sid sysctl)
>> +(sid sysctl_dev)
>> +(sid sysctl_fs)
>> +(sid sysctl_kernel)
>> +(sid sysctl_modprobe)
>> +(sid sysctl_net)
>> +(sid sysctl_net_unix)
>> +(sid sysctl_vm)
>> +(sid tcp_socket)
>> +
>> +;;
>> +;; Initial security identifier ordering:
>> +;;
>> +;; Even though most initial security identifiers we declared are no
>> longer in
>> +;; use, we still have to retain a very specific order to stay
>> compatible with
>> +;; the kernel. This is certainly one of those things that make
>> policy writing
>> +;; seem like some sort of black magic and hopefully some day we can
>> lift the
>> +;; requirement to order initial sids in a specific way.
>> +;;
>> +
>> +(sidorder
>> + (kernel security unlabeled fs file file_labels init any_socket port
>> +         netif netmsg node igmp_packet icmp_socket tcp_socket
>> sysctl_modprobe
>> +         sysctl sysctl_fs sysctl_kernel sysctl_net sysctl_net_unix
>> +         sysctl_vm sysctl_dev kmod policy scmp_packet devnull))
>> +
>> +;;
>> +;; Security identifier declarations
>> +;;
>> +;; Security contexts are identifiers that are combinations of
>> security
>> +;; attribute and security identifier key value pairs corresponding
>> to security
>> +;; models.
>> +;;
>> +;; The s0 security identifier is associated with sensitivity
>> attribute in a
>> +;; security context used to enforce confidentiality with the Multi
>> level
>> +;; security model. (we only declare one sensitivity for simplicity
>> and to
>> +;; satisfy CIL.
>> +;;
>> +
>> +(sensitivity s0)
>> +
>> +;;
>> +;; Security identifier declarations
>> +;;
>> +;; Security contexts are identifiers that are combinations of
>> security
>> +;; attribute and security identifier key value pairs corresponding
>> to security
>> +;; models.
>> +;;
>> +;; The c0 security identifier is associated with category attribute
>> in a
>> +;; security context used to enforce compartmentalization with the
>> Multi level
>> +;; security model. (we only declare one compartment for simplicity
>> and to
>> +;; satisfy CIL.
>> +;;
>> +
>> +(category c0)
>> +
>> +;;
>> +;; Security identifier declarations
>> +;;
>> +;; Security contexts are identifiers that are combinations of
>> security
>> +;; attribute and security identifier key value pairs corresponding
>> to security
>> +;; models.
>> +;;
>> +;; The sys.id security identifier is associated with user attribute
>> in a
>> +;; security context used to associate with Linux DAC and role and
>> level security
>> +;; identifiers with the Identity-based access control security
>> model.
>> +;;
>> +;; Note that we leverage a simple CIL "sys" "container" here
>> +;;
>> +
>> +(block sys (user id))
>> +
>> +;;
>> +;; Security identifier declarations
>> +;;
>> +;; Security contexts are identifiers that are combinations of
>> security
>> +;; attribute and security identifier key value pairs corresponding
>> to security
>> +;; models.
>> +;;
>> +;; The sys.role security identifier is associated with role
>> attribute in a
>> +;; security context used to associate with types with the Role-based
>> +;; access control security model.
>> +;;
>> +;; Note that we insert into the previously defined CIL "sys"
>> "container" here
>> +;;
>> +
>> +(in sys (role role))
>> +
>> +;;
>> +;; Security identifier declarations
>> +;;
>> +;; Security contexts are identifiers that are combinations of
>> security
>> +;; attribute and security identifier key value pairs corresponding
>> to security
>> +;; models.
>> +;;
>> +;; The sys.isid security identifier is associated with type
>> attribute in a
>> +;; security context used to enforce integrity with the Type-
>> enforcement
>> +;; security model.
>> +;;
>> +;; Note that we insert into the previously defined CIL "sys"
>> "container" here
>> +;;
>> +
>> +(in sys (type isid))
>> +
>> +;;
>> +;; Sensitivity ordering:
>> +;;
>> +;; Usually there are multiple sensitivities declared. Sensitivities
>> represent
>> +;; a hierarchy. Since we only have one sensitivity our sensitivity
>> order is
>> +;; simple.
>> +;;
>> +
>> +(sensitivityorder (s0))
>> +
>> +;;
>> +;; Category ordering:
>> +;;
>> +;; Usually there are multiple categories declared. Categories
>> represent
>> +;; a hierarchy. Since we only have one category our category order
>> is
>> +;; simple.
>> +;;
>> +
>> +(categoryorder (c0))
>> +
>> +;;
>> +;; Security identifier authorisations
>> +;;
>> +;; The individually declared security identifiers need to be
>> authorized to
>> +;; associate to be able to define valid security contexts.
>> +;;
>> +;; Authorize the s0 sensitivity with c0 category association
>> +;;
>> +
>> +(sensitivitycategory s0 (range c0 c0))
>> +
>> +;;
>> +;; Security identifier authorisations
>> +;;
>> +;; The individually declared security identifiers need to be
>> authorized to
>> +;; associate to be able to define valid security contexts.
>> +;;
>> +;; Authorize the sys.id user with sys.role role association
>> +;;
>> +
>> +(userrole sys.id sys.role)
>> +
>> +;;
>> +;; Security identifier authorisations
>> +;;
>> +;; The individually declared security identifiers need to be
>> authorized to
>> +;; associate to be able to define valid security contexts.
>> +;;
>> +;; Authorize the sys.role role with sys.isid type association
>> +;;
>> +
>> +(roletype sys.role sys.isid)
>> +
>> +;;
>> +;; Security identifier authorisations
>> +;;
>> +;; The individually declared security identifiers need to be
>> authorized to
>> +;; associate to be able to define valid security contexts.
>> +;;
>> +;; Authorize the sys.id user with s0 lavel association
>> +;;
>> +
>> +(userlevel sys.id (s0))
>> +
>> +;;
>> +;; Security identifier authorisations
>> +;;
>> +;; The individually declared security identifiers need to be
>> authorized to
>> +;; associate to be able to define valid security contexts.
>> +;;
>> +;; Authorize the sys.id user with s0-s0:c0.c0 range association
>> +;;
>> +
>> +(userrange sys.id ((s0)(s0 (range c0 c0))))
>> +
>> +;;
>> +;; Security context specifications:
>> +;;
>> +;; We will change the default role behavior to inherit the role from
>> the source
>> +;; instead of the target, as this allows us to leverage roles
>> associated with
>> +;; files.
>> +;;
>> +
>> +(defaultrole blk_file source)
>> +(defaultrole chr_file source)
>> +(defaultrole dir source)
>> +(defaultrole fifo_file source)
>> +(defaultrole file source)
>> +(defaultrole lnk_file source)
>> +(defaultrole sock_file source)
>> +
>> +;;
>> +;; Security context specifications
>> +;;
>> +;; Now that we have a valid security context:
>> sys.id:sys.role:sys.isid:s0-s0,
>> +;; associate it with the used initial sids.
>> +;;
>> +
>> +(sidcontext kernel (sys.id sys.role sys.isid ((s0)(s0))))
>> +(sidcontext security (sys.id sys.role sys.isid ((s0)(s0))))
>> +(sidcontext port (sys.id sys.role sys.isid ((s0)(s0))))
>> +(sidcontext netif (sys.id sys.role sys.isid ((s0)(s0))))
>> +(sidcontext netmsg (sys.id sys.role sys.isid ((s0)(s0))))
>> +(sidcontext node (sys.id sys.role sys.isid ((s0)(s0))))
>> +(sidcontext devnull (sys.id sys.role sys.isid ((s0)(s0))))
>> +(sidcontext file (sys.id sys.role sys.isid ((s0)(s0))))
>> +(sidcontext unlabeled (sys.id sys.role sys.isid ((s0)(s0))))
>> +
>> +;;
>> +;; Security context specifications
>> +;;
>> +;; Now that we have a valid security context:
>> sys.id:sys.role:sys.isid:s0-s0,
>> +;; associate it with locations on the filesystems so that they can
>> be
>> +;; associated with inodes on filesystems that support extended
>> security
>> +;; attributes.
>> +;;
>> +
>> +(filecon "/" dir (sys.id sys.role sys.isid ((s0)(s0))))
>> +(filecon "/.*" any (sys.id sys.role sys.isid ((s0)(s0))))
>> +
>> +;;
>> +;; AVC rule
>> +;;
>> +;; CIL requires us to specify at least one AVC rule Since we were
>> required
>> +;; to at least declare the process security class and its
>> dyntransition and
>> +;; transition access vector permissions. lets just add a AVC rule
>> allowing
>> +;; entities associated with our sys.isid type identifier access to
>> all process
>> +;; access vectors.
>> +;;
>> +
>> +(allow sys.isid self (process (all)))
>> +
>> +;;
>> +;; Tieing some loose ends
>> +;;
>> +;; Addressing a hard coded reference to a rpm_script_t type
>> identifier in RPM
>> +;; using typealiases to our sys.isid type so that RPM does not get
>> confused.
>> +
>> +(typealias rpm_script_t)
>> +(typealiasactual rpm_script_t sys.isid)
>> +
>> +(typealias dpkg_script_t)
>> +(typealiasactual dpkg_script_t sys.isid)
>> +
>> +;;
>> +;; Tieing some loose ends
> 
> Tidy some loose ends

Thanks!

> 
>> +;;
>> +;; Generate a /etc/selinux/mypolicy/seusers file with a __default__
>> fall back
>> +;; entry so that Linux users with be associated with the sys.id
>> SELinux
>> +;; identity and s0-s0 level.
>> +;;
>> +
>> +(selinuxuserdefault sys.id ((s0)(s0)))
>> +
>> +;;
>> +;; Tieing some loose ends
> Tidy some loose ends
> 
> 
>> +;;
>> +;; We are associating valid roles with files. The userprefix
>> statement was
>> +;; recycled to allow us to tell genhomedircon what roles to
>> associate with
>> +;; SELinux identities associated with custmizable files (mainly
>> /home/user)
>> +;;
>> +
>> +(userprefix sys.id sys.role)
>> +
>> +;;
>> +;; Tieing some loose ends
> Tidy some loose ends
> 
>> +;;
>> +;; At the least /dev and /dev/pts need to be set up for labeling for
>> sudo
>> +;;
>> +
>> +(fsuse trans "devtmpfs" (sys.id sys.role sys.isid ((s0)(s0))))
>> +(fsuse trans "devpts" (sys.id sys.role sys.isid ((s0)(s0))))
> 
