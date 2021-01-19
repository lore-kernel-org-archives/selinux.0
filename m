Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A1FC433DB
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 14:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5C222DFB
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 14:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391579AbhASOyo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:54:44 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:34500 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403818AbhASNUe (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 19 Jan 2021 08:20:34 -0500
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 6769B2A0D7E;
        Tue, 19 Jan 2021 14:18:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 6769B2A0D7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1611062330;
        bh=oRfqYsafVh4HdFLRHM7gUblkVFgZPwjBl8H0teVvNk0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IkP9/LSAvH1qNV/xuAYKOLxq2h11G+r/khCljpe+J5FoEWTy2/721/xN47OJg5+0p
         aavhv7338J9Z/oTOD/pgmkmw8+h7mpattnIk2q75BM+/r4eduM7y6GoCymYkMtc2Hd
         EXJjyqdd7Ryzp/pi69E515l8UWr0uM7KnIp8VVvw=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] selinux-notebook: Add new section for Embedded
 Systems
References: <20210119105747.9680-1-richard_c_haines@btinternet.com>
        <20210119105747.9680-2-richard_c_haines@btinternet.com>
Date:   Tue, 19 Jan 2021 14:18:47 +0100
In-Reply-To: <20210119105747.9680-2-richard_c_haines@btinternet.com> (Richard
        Haines's message of "Tue, 19 Jan 2021 10:57:47 +0000")
Message-ID: <ypjleeihm5e0.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Richard Haines <richard_c_haines@btinternet.com> writes:

> Add a new section and supporting examples for embedded systems.

Nice initiative, thanks. Looks pretty solid for a first iteration.

I wrote a document for OpenWrt here [1]. Basically the instructions needed
to assemble OpenWrt from modules applicable to a particular system, but also how
to build on top of it, or now to just fork it so that you can use it as
a base for your own policy.

[1] https://github.com/doverride/openwrt-selinux-policy/blob/master/README.md

I am currently pretty happy with the results so far (its a work in
progress, and there are known loose ends)

One of the differences compared with android is that SELinux is not
tightly integrated in OpenWrt, and so most of the tough aspects are addressed in policy
rather than adding selinux-awareness all over. SELinux in OpenWrt is therefore
fairly self-contained and considering the challenges fairly robust.

>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/embedded_systems.md                       | 517 ++++++++++++++++++
>  src/implementing_seaware_apps.md              |   2 +-
>  .../embedded-policy/android-policy/README.md  |  34 ++
>  .../android-policy/android-4/Makefile         |  32 ++
>  .../android-policy/android10/Makefile         |  40 ++
>  .../android-policy/brillo-device/Makefile     |  43 ++
>  .../android-policy/brillo/Makefile            |  36 ++
>  .../reference-policy/README.md                |   6 +
>  .../reference-policy/build.conf               |  84 +++
>  .../reference-policy/modules.conf             | 236 ++++++++
>  src/seandroid.md                              |   6 +-
>  src/section_list.txt                          |   1 +
>  src/toc.md                                    |   1 +
>  13 files changed, 1036 insertions(+), 2 deletions(-)
>  create mode 100644 src/embedded_systems.md
>  create mode 100644 src/notebook-examples/embedded-policy/android-policy/README.md
>  create mode 100644 src/notebook-examples/embedded-policy/android-policy/android-4/Makefile
>  create mode 100644 src/notebook-examples/embedded-policy/android-policy/android10/Makefile
>  create mode 100644 src/notebook-examples/embedded-policy/android-policy/brillo-device/Makefile
>  create mode 100644 src/notebook-examples/embedded-policy/android-policy/brillo/Makefile
>  create mode 100644 src/notebook-examples/embedded-policy/reference-policy/README.md
>  create mode 100644 src/notebook-examples/embedded-policy/reference-policy/build.conf
>  create mode 100644 src/notebook-examples/embedded-policy/reference-policy/modules.conf
>
> diff --git a/src/embedded_systems.md b/src/embedded_systems.md
> new file mode 100644
> index 0000000..203b1c2
> --- /dev/null
> +++ b/src/embedded_systems.md
> @@ -0,0 +1,517 @@
> +# Embedded Systems
> +
> +- [References](#references)
> +- [General Requirements](#general-requirements)
> +  - [Project Repositories](#project-repositories)
> +  - [Project Requirements](#project-requirements)
> +  - [SELinux Utilities and Libraries](#selinux-utilities-and-libraries)
> +  - [Labeling Files](#labeling-files)
> +  - [Loading Policy](#loading-policy)
> +- [The OpenWrt Project](#the-openwrt-project)
> +- [The Android Project](#the-android-project)
> +- [Building A Small Monolithic Reference Policy](#building-a-small-monolithic-reference-policy)
> +- [Building A Sample Android Policy](#building-a-sample-android-policy)
> +
> +This section lists some of the general decisions to be taken when implementing
> +SELinux on embedded systems, it is by no means complete.
> +
> +Two embedded SELinux projects are used as examples (OpenWrt and Android) with
> +the main emphasis on policy development as this is considered the most difficult
> +area.
> +
> +An alternative MAC service to consider is [**Smack**](http://www.schaufler-ca.com/)
> +(Simplified Mandatory Access Control Kernel) as used in the Samsung
> +[**Tizen**](https://www.tizen.org/) and
> +[**Automotive Grade Linux**](https://www.automotivelinux.org/) projects. Smack
> +can have a smaller, less complex footprint than SELinux.
> +
> +## References
> +
> +These papers on embedded systems can be used as references, however they are
> +old (2007 - 2015): TODO - Any new ones ????
> +
> +- **Security Enhanced (SE) Android: Bringing Flexible MAC to Android** from
> +  <http://www.cs.columbia.edu/~lierranli/coms6998-7Spring2014/papers/SEAndroid-NDSS2013.pdf>
> +  describes the initial Android changes.
> +- **Reducing Resource Consumption of SELinux for Embedded Systems with Contributions to Open-Source Ecosystems**
> +  from <https://www.jstage.jst.go.jp/article/ipsjjip/23/5/23_664/_article>
> +  describes a scenario where *libselinux* was modified and *libsepol* removed
> +  for their embedded system (however no links to their final modified code,
> +  although there are many threads on the <https://lore.kernel.org/selinux/>
> +  list discussing these changes). It should be noted that these libraries have
> +  changed since the original article, therefore it should be used as a
> +  reference for ideas only. They also used a now obsolete policy editor
> +  [***seedit***](http://seedit.sourceforge.net/) to modify Reference Policies.
> +- **Using SELinux security enforcement in Linux-based embedded devices** from
> +  <https://eudl.eu/doi/10.4108/icst.mobilware2008.2927> describes enabling
> +  SELinux on a Nokia 770 Internet Tablet.
> +
> +## General Requirements
> +
> +**Note 1** - This section discusses the Reference Policy 'Monolithic' and
> +'Modular' policy builds, however this can be confusing, so to clarify:
> +
> +- The Reference Policy builds both 'Monolithic' and 'Modular' policy using
> +  policy modules defined in a *modules.conf* file.
> +- The 'Monolithic' build process builds the final policy using
> +  ***checkpolicy**(8)* and therefore does NOT make use of the
> +  ***semanage**(8)* services to modify policy during runtime.
> +- The 'Modular' build process builds the final policy using
> +  ***semodule**(8)* and therefore CAN make use of the
> +  ***semanage**(8)* services to modify policy during runtime. This requires
> +  additional resources as it makes use of the 'policy store[^fn_em_1]' as
> +  described in the [**SELinux Configuration Files - The Policy Store**](configuration_files.md#the-policy-store)
> +  and [**Policy Store Configuration Files**](policy_store_config_files.md#policy-store-configuration-files)
> +  sections.
> +  To be clear, it is possible to build a 'Modular' policy on the host system,
> +  then install the resulting
> +  [**Policy Configuration Files**](policy_config_files.md#policy-configuration-files)
> +  onto the target system (i.e. no 'policy store' on the target system).
> +- Also note that the Reference Policy 'Monolithic' and 'Modular' builds do not
> +  build the exact same list of policy configuration files.
> +
> +**Note 2** - If the requirement is to build the policy in CIL, it is possible
> +to emulate the above by:
> +
> +- Building policy using ***secilc**(8)* will build a 'Monolithic' policy.
> +- Building policy using ***semodule**(8)* will build a 'Modular' policy.
> +  This can then make use of the ***semanage**(8)* services to modify policy
> +  during runtime as it makes use of the 'policy store[^fn_em_2]'.
> +- A useful feature of CIL is that statements can be defined to generate the
> +  *file_contexts* entries in a consistent manner.
> +
> +**Note 3** - Is there a requirement to build/rebuild policy on the target, if
> +so does it also need to be managed during runtime:
> +
> +- If build/rebuild policy on the target with NO semanage support, then only
> +  ***checkpolicy**(8)* or ***secilc**(8)* will be required on target.
> +- If building on the target with runtime changes then ***semodule**(8)* and
> +  ***semanage**(8)* are required.
> +- If no requirement to build policy on the target, then these are not needed.
> +
> +**Note 4** - Do any of the target filesystems support extended attributes
> +(***xattr**(7)*), if so then ***restorecon**(8)* or ***setfiles**(8)*
> +may be required on the target to label files (see the
> +[**Labeling Files**](#labeling-files) section).
> +
> +### Project Repositories
> +
> +The current SELinux userspace source can be obtained from
> +<https://github.com/SELinuxProject/selinux> and the current stable releases
> +from <https://github.com/SELinuxProject/selinux/releases>.
> +
> +The current Reference Policy source can be obtained from
> +<https://github.com/SELinuxProject/refpolicy> and the current stable releases
> +from <https://github.com/SELinuxProject/refpolicy/releases>.
> +
> +The current SETools (***apol**(1)* etc.) source can be obtained from
> +<https://github.com/SELinuxProject/setools> and the current stable releases
> +from <https://github.com/SELinuxProject/setools/releases>.
> +
> +### Project Requirements
> +
> +The project requirements will determine the following:
> +
> +- Kernel Version
> +  - The kernel version will determine the maximum policy version supported. The
> +    [**Policy Versions**](types_of_policy.md#policy-versions) section details
> +    the policy versions, their supported features and SELinux library
> +    requirements.
> +- Support ***xattr**(7)* Filesystems
> +  - If extended attribute filesystems are used then depending on how the target
> +    is built/loaded it will require ***restorecon**(8)* or ***setfiles**(8)* to
> +    label these file systems. The policy will also require a
> +    [*file_contexts*](policy_config_files.md#contextsfilesfile_contexts) that
> +    is used to provide the labels.
> +- Multi-User
> +  - Generally only one user and user role are required, this is the case for
> +    OpenWrt and Android. If multi-user then PAM services may be required.
> +- Support Tools
> +  - These would generally be either [**BusyBox**](https://www.busybox.net/)
> +    (OpenWrt) or [**Toybox**](http://landley.net/toybox/) (Android). Both of
> +    these can be built with SELinux enabled utilities.
> +- TODO OTHERS ????
> +  - Must be more - Boot options, read-only fs,
> +- SELinux Policy Support:
> +  - Use the Reference Policy, bespoke CIL policy or bespoke policy using
> +    ***m4**(1)* macros as used by Android (if starting with a bespoke policy
> +    then CIL is recommended). Also need to consider:
> +    - If using the Reference Policy on the target device use either:
> +      - Monolithic Policy - Use this for minimum resource usage. Also the policy
> +        is not so easy to update (need to push a new version to the device).
> +      - Modular Policy - Only use this if there is a requirement to modify the
> +        device policy during runtime.
> +    - Is MCS/MLS Support is required. The
> +      [**MLS or MCS Policy**](mls_mcs.md#mls-or-mcs-policy) section gives
> +      a brief introduction. The OpenWrt Project does not use MLS/MCS policy,
> +      however Android does use MCS for application sandboxing as shown in the
> +      [**SE Android - Computing Process Context Examples**](seandroid.md#computing-process-context-examples)
> +      section.
> +    - Is Conditional Policy (booleans) support required. This allows different
> +      policy rules to be enabled/disabled at runtime (Android and OpenWrt do
> +      not support Booleans).
> +    - SELinux 'user' and user 'roles' (the subject). Generally there would only
> +      be one of each of these, for example Android and the OpenWrt CIL policy
> +      both use user: *u* role: *r*, the OpenWrt Reference Policy version uses
> +      user: *root* role: *system_r* TODO - Is this correct for RefPol ??. Note
> +      that the *object_r* role is used to label objects.
> +
> +### SELinux Utilities and Libraries
> +
> +The [**Project Repositories**](#project-repositories) section lists the code
> +that should be installed on the host build system, not all of these would be
> +required on the target system.
> +
> +A possible minimum list of SELinux items required on the target system are:
> +
> +- *libselinux* - Provides functions to load policy, label processes and files
> +   etc. A list of functions is in
> +   [**Appendix B - libselinux API Summary**](libselinux_functions.md#appendix-b---libselinux-api-summary)
> +- *libsepol* - Provides services to build/load policy.
> +- *restorecon* - Label files.
> +- The policy plus supporting configuration files.
> +
> +Depending on the target memory available it would be possible to modify the
> +libraries as there is legacy code that could be removed. Also (for example) if
> +the userspace avc (***avc_\***(3)*) services in the *libselinux* library are not
> +required these could be removed. It should be noted that currently there are no
> +build options to do this.
> +
> +If the target policy is to be:
> +
> +- Built on the device, then either ***checkpolicy**(8)* or ***secilc**(8)* will
> +  be required.
> +- Managed on the device during runtime, then ***semanage**(8)*, ***semodule**(8)*
> +  and their supporting services will be required.
> +
> +### Labeling Files
> +
> +If there is a need to support ***xattr**(7)* filesystems on the target then
> +these need to be labeled via the *file_contexts* file that would be generated
> +as part of the initial policy build.
> +
> +For example RAM based filesystems will require labeling before use (as Andriod
> +does). To achieve this either ***setfiles**(8)* or ***restorecon**(8)* will
> +need to be run.
> +
> +These are based on common source code
> +(<https://github.com/SELinuxProject/selinux/tree/master/policycoreutils/setfiles>)
> +with the majority of functionality built into *libselinux*, therefore it matters
> +little which is used, although ***restorecon**(8)* is probably the best choice
> +as it's smaller and does not support checking files against a different policy.
> +
> +***setfiles**(8)* will label files recursively on directories and is generally
> +used by the initial SELinux installation process, whereas ***restorecon**(8)*
> +must have the *-r* flag set to label files recursively on directories and is
> +generally used to correct/update files on the running system.
> +
> +### Loading Policy
> +
> +When the standard *libselinux* and the ***load_policy**(8)* utility are used to
> +load policy, it will always be loaded from the
> +*/etc/selinux/\<SELINUXTYPE\>/policy* directory, where *\<SELINUXTYPE\>* is
> +the entry from the
> +[***/etc/selinux/config***](global_config_files.md#etcselinuxconfig) file:
> +
> +```
> +# This file controls the state of SELinux on the system.
> +# SELINUX= can take one of these three values:
> +#     enforcing - SELinux security policy is enforced.
> +#     permissive - SELinux prints warnings instead of enforcing.
> +#     disabled - No SELinux policy is loaded.
> +SELINUX=enforcing
> +# SELINUXTYPE= The <NAME> of the directory where the active policy and its
> +#              configuration files are located.
> +SELINUXTYPE=targeted
> +```
> +
> +The standard Linux SELinux policy load sequence is as follows:
> +
> +- Obtain policy version supported by the kernel.
> +- Obtain minimum policy version supported by *libsepol*.
> +- Determine policy load path via */etc/selinux/config* *\<SELINUXTYPE\>* entry.
> +- Search for a suitable policy to load by comparing the kernel and *libsepol*
> +  versions using the  */etc/selinux/\<SELINUXTYPE\>/policy/policy.\<ver\>*
> +  file extension.
> +- Load and if necessary downgrade the policy. This happens if the policy being
> +  loaded has a greater version than the kernel supports. Note that if the
> +  policy was built with *--handle-unknown=deny* (*UNK_PERMS* in *build.conf*)
> +  and there are unknown classes or permissions, the policy will not be loaded.
> +
> +The only known deviation from this is the Android project that has its own
> +specific method as described in the
> +[**SE for Android** - *external/selinux/libselinux*](seandroid.md#externalselinuxlibselinux)
> +section. To inspect the code, see the ***selinux_android_load_policy()***
> +function in
> +<https://android.googlesource.com/platform/external/selinux/+/refs/heads/master/libselinux/src/android/android_platform.c>.
> +Basically this maps the policy file to memory, then calls
> +***security_load_policy**(3)* to load the policy (as Android does not use the
> +version extension).
> +
> +## The OpenWrt Project
> +
> +The OpenWrt project is a Linux based system targeting embedded devices that can
> +be built with either the
> +[**Reference Policy**](https://github.com/SELinuxProject/refpolicy) or a
> +[**customised CIL policy**](https://git.defensec.nl/?p=selinux-policy.git;a=summary)
> +
> +The policy to configure is selected from the *menuconfig* options once OpenWrt
> +is installed:
> +
> +```
> +make menuconfig
> +
> +# Select:
> +    Global build settings  --->
> +# Enable SELinux:
> +      [*] Enable SELinux
> +            default SELinux type (targeted)  --->
> +# Select either Reference Policy or customised CIL policy (dssp):
> +            ( ) targeted
> +            (X) dssp
> +```
> +
> +To build and inspect the CIL policy:
> +
> +```
> +git clone https://git.defensec.nl/selinux-policy.git
> +cd selinux-policy
> +make policy
> +```
> +
> +There should be a binary *policy.\<ver\>* file that can be viewed using tools
> +such as ***apol**(1)*. The auto-generated *file_contexts* file can be viewed
> +with a text editor.
> +
> +Note that no *policy.conf* is generated when building CIL policy as
> +***secilc**(8)* is used. To build a *policy.conf* file for inspection via a
> +text editor run:
> +
> +```
> +checkpolicy -bF -o policy.conf policy.31
> +```
> +
> +## The Android Project
> +
> +This is fully discussed in the
> +[**SE for Android**](seandroid.md#security-enhancements-for-android) section
> +with a section below that explains
> +[**Building A Sample Android Policy**](#building-a-sample-android-policy) to
> +examine its construction.
> +
> +## Building A Small Monolithic Reference Policy
> +
> +This section describes how a smaller monolithic Reference Policy can be built
> +as a starter policy. It supports the minimum of policy modules that can be
> +defined in a *modules.conf* file, this file is described in the
> +[**Reference Policy Build Options -** *policy/modules.conf*](#reference-policy-build-options---policymodules.conf)
> +section.
> +
> +To start download the Reference Policy source:
> +
> +```
> +git clone https://github.com/SELinuxProject/refpolicy.git
> +cd refpolicy
> +```
> +
> +For the initial configuration, either replace the current *build.conf*
> +file with the sample
> +[***build.conf***](notebook-examples/embedded-policy/reference-policy/build.conf)
> +or edit the current *build.conf* file to the requirements (e.g. MONOLITHIC = y)
> +
> +Install the source policy in the build directory:
> +
> +```
> +make install-src
> +cd /etc/selinux/<NAME>/src/policy
> +```
> +
> +The following mandatory *make conf* step will build the initial
> +*policy/booleans.conf* and *policy/modules.conf* files.
> +
> +This process will also build the *policy/modules/kernel/corenetwork.te* and
> +*corenetwork.if* files. These would be based on the contents of
> +*corenetwork.te.in* and *corenetwork.if.in* configuration files.
> +
> +For this build only the *policy/modules.conf* will be replaced with the
> +sample version.
> +
> +```
> +make conf
> +```
> +
> +Replace the current *policy/modules.conf* with the sample
> +[***modules.conf***](notebook-examples/embedded-policy/reference-policy/modules.conf)
> +and run:
> +
> +```
> +make install
> +```
> +
> +The binary policy will now be built in the */etc/selinux/\<NAME\>/policy*
> +directory. The */etc/selinux/\<NAME\>/src/policy/policy.conf* file contains
> +the policy language statements used to generate the binary policy.
> +
> +The *policy.conf* file can be examined with a text editor and the binary
> +*policy.\<ver\>* file can be viewed using tools such as ***apol**(1)*.
> +
> +### Adding Additional Modules
> +
> +Note that if the *modules.conf* file is modified to add additional modules,
> +*make clean* MUST be run before *make install* or *make load*.
> +
> +The ease of adding additional modules to the *policy/modules.conf* file depends
> +on the modules dependencies, for example to add the *ftp* module:
> +
> +```
> +# Layer: services
> +# Module: ftp
> +#
> +# File transfer protocol service.
> +#
> +ftp = module
> +```
> +
> +Now run:
> +
> +```
> +make clean
> +make install
> +```
> +
> +to build the policy, this will flag a dependency error:
> +
> +```
> +policy/modules/services/ftp.te:488:ERROR 'type ssh_home_t is not within scope'
> +```
> +
> +This shows that the *ftp* module relies on the *ssh* module, therefore need to
> +also add:
> +
> +```
> +# Layer: services
> +# Module: ssh
> +#
> +# Secure shell client and server policy.
> +#
> +ssh = module
> +```
> +
> +Now run:
> +
> +```
> +make clean
> +make install
> +```
> +
> +This should build a valid policy. Although note that adding some modules will
> +lead to a string of dependent modules.
> +
> +If a suitable module cannot be found in the *policy/modules* directory, then
> +one can be generated and added to the store. To generate policy modules using
> +output from the audit log, see ***audit2allow**(1)* (however review any policy
> +generated). The
> +[**Reference Policy**](reference_policy.md#the-reference-policy) section
> +explains the format of these module files.
> +
> +### The Clean-up
> +
> +Once a policy is complete it could be cleaned up by removing components
> +that are not required for example:
> +
> +- The file_contexts generated will have entries that could be deleted.
> +- Unused boleans could be removed.
> +- Review Policy Capabilities.
> +- Remove unused classes and permissions (*policy/flask/security_classes* and
> +  *policy/flask/access_vectors*).
> +- There are a number of policy configuration files that can be removed within
> +  *etc/selinux/refpolicy* (e.g. *etc/selinux/refpolicy/contexts/x_contexts*).
> +
> +These will probably amount to small fry, but every little helps!!
> +
> +## Building A Sample Android Policy
> +
> +A purpose built embedded policy example is the Android policy that is
> +discussed in the
> +[**SE for Android**](seandroid.md#security-enhancements-for-android) section.
> +This policy has become more complex over time, however they did start with a
> +basic policy that can be explored as described below that does not require
> +obtaining the full AOSP source and build environment.
> +
> +[**Android - The SELinux Policy**](seandroid.md#the-selinux-policy) section
> +descibes how an Android policy is constructed using ***m4**(1)* macros, *\*.te*
> +files etc., similar to the
> +[**Reference Policy**](reference_policy.md#the-reference-policy).
> +
> +To build a sample policy for inspection:
> +
> +- Obtain a copy of the Android policy built for 4.1, note that only the core
> +  policy is built here as Android adds device specific policy modules as per
> +  its build configuration (an example build with a device is shown later).
> +
> +```
> +git clone https://android.googlesource.com/platform/external/sepolicy
> +cd sepolicy
> +git checkout android-4.1.1_r1
> +```
> +
> +- Copy the text below into a
> +  [*Makefile*](notebook-examples/embedded-policy/android-policy/android-4/Makefile)
> +  installed in the *sepolicy* directory.
> +
> +```
> +POL_VERS := $(shell checkpolicy -V | cut -f 1 -d ' ')
> +
> +build_policy:
> +	m4 -D mls_num_sens=1 \
> +		-D mls_num_cats=1024 \
> +		-s security_classes \
> +		initial_sids \
> +		access_vectors \
> +		global_macros \
> +		mls_macros \
> +		mls \
> +		policy_capabilities \
> +		te_macros \
> +		attributes \
> +		*.te \
> +		roles \
> +		users \
> +		ocontexts > policy.conf
> +	checkpolicy -U deny -M -c $(POL_VERS) -o sepolicy.$(POL_VERS) policy.conf
> +```
> +
> +- Run *make* to build the policy. There should be a *policy.conf* file that
> +  can be examined with a text editor and a binary *sepolicy.\<ver\>* policy
> +  file that can be viewed using tools such as ***apol**(1)*.
> +  Note the order in which the *policy.conf* file is built as it conforms to
> +  the layout described in the
> +  [**Kernel Policy Language**](kernel_policy_language.md#policy-source-files)
> +  section.
> +
> +Over time the Android policy locked down more and more processes and then
> +became more complex as policy version control was required when upgrading.
> +The **Brillo** release was their first IoT release and can be built using the
> +instructions in the
> +[*brillo/Makefile*](notebook-examples/embedded-policy/android-policy/brillo/Makefile)
> +To build a policy containing a device, follow the instructions in the
> +[*brillo-device/Makefile*](notebook-examples/embedded-policy/android-policy/brillo-device/Makefile)
> +as a device policy must be obtained from the Android repository.
> +
> +Later Android split policy into private and public segments, they also used
> +CIL for some policy components as described in the
> +[**Android - The SELinux Policy**](seandroid.md#the-selinux-policy) section.
> +The **Android 10** release policy is an example where this split policy is used.
> +This can be built using the instructions in the
> +[*Android 10/Makefile*](notebook-examples/embedded-policy/android-policy/android10/Makefile).
> +
> +[^fn_em_1]: As the 'policy store' holds the policy modules in the
> +'policy package' format (*\*.pp* files).
> +
> +[^fn_em_2]: As the 'policy store' holds the policy modules as compressed CIL
> +text files.
> +
> +<!-- %CUTHERE% -->
> +
> +---
> +**[[ PREV ]](implementing_seaware_apps.md)** **[[ TOP ]](#)** **[[ NEXT ]](seandroid.md)**
> diff --git a/src/implementing_seaware_apps.md b/src/implementing_seaware_apps.md
> index ee38258..924df16 100644
> --- a/src/implementing_seaware_apps.md
> +++ b/src/implementing_seaware_apps.md
> @@ -296,4 +296,4 @@ applied to their objects as defined by policy.
>  <!-- %CUTHERE% -->
>  
>  ---
> -**[[ PREV ]](reference_policy.md)** **[[ TOP ]](#)** **[[ NEXT ]](seandroid.md)**
> +**[[ PREV ]](reference_policy.md)** **[[ TOP ]](#)** **[[ NEXT ]](embedded_systems.md)**
> diff --git a/src/notebook-examples/embedded-policy/android-policy/README.md b/src/notebook-examples/embedded-policy/android-policy/README.md
> new file mode 100644
> index 0000000..028a591
> --- /dev/null
> +++ b/src/notebook-examples/embedded-policy/android-policy/README.md
> @@ -0,0 +1,34 @@
> +# Android Policy
> +
> +The Android policies defined in these *Makefile* files will allow them to be
> +built for inspection without obtaining the full AOSP source and build
> +environment.
> +
> +Note that the core policy is built in most cases as within Android each
> +device adds their specific policy modules.
> +
> +The build process will produce two files:
> +
> +- *policy.conf* that can be examined with a text editor.
> +- *sepolicy.POL_VERS* that can be viewed using tools such as ***apol**(1)*.
> +
> +The ***git**(1)* commands required to obtain the policies are defined in
> +each *Makefile*.
> +
> +- *android-4/Makefile*
> +  - The initial Android basic policy.
> +
> +- *brillo/Makefile*
> +  - The Brillo release was their first IoT release.
> +
> +- *android10/Makefile*
> +  - The Android 10 release split the policy into private and public segments
> +    and has started using some CIL modules (although for simplicity they are
> +    not built).
> +
> +## Build policy with a Device
> +
> +The *brillo-device/Makefile* has instructions to build the Brillo policy with
> +a suitable device using the
> +*https://android.googlesource.com/platform/external/sepolicy/+archive/refs/heads/brillo-m7-release.tar.gz*
> +device policy file.
> diff --git a/src/notebook-examples/embedded-policy/android-policy/android-4/Makefile b/src/notebook-examples/embedded-policy/android-policy/android-4/Makefile
> new file mode 100644
> index 0000000..0159dcd
> --- /dev/null
> +++ b/src/notebook-examples/embedded-policy/android-policy/android-4/Makefile
> @@ -0,0 +1,32 @@
> +#### Build android-4.1.1_r1 base policy Makefile ####
> +
> +# git clone https://android.googlesource.com/platform/external/sepolicy
> +# cd sepolicy
> +# git checkout android-4.1.1_r1
> +# Copy this file to sepolicy/Makefile and run 'make' to build the policy files.
> +#
> +# The policy.conf file can be examined with a text editor and the binary
> +# sepolicy.POL_VERS file can be viewed using tools such as apol(1).
> +
> +POL_VERS := $(shell checkpolicy -V | cut -f 1 -d ' ')
> +
> +build_policy:
> +	#
> +	# Note the order in which the policy.conf file is built:
> +	#
> +	m4 -D mls_num_sens=1 \
> +		-D mls_num_cats=1024 \
> +		-s security_classes \
> +		initial_sids \
> +		access_vectors \
> +		global_macros \
> +		mls_macros \
> +		mls \
> +		policy_capabilities \
> +		te_macros \
> +		attributes \
> +		*.te \
> +		roles \
> +		users \
> +		ocontexts > policy.conf
> +	checkpolicy -U deny -M -c $(POL_VERS) -o sepolicy.$(POL_VERS) policy.conf
> diff --git a/src/notebook-examples/embedded-policy/android-policy/android10/Makefile b/src/notebook-examples/embedded-policy/android-policy/android10/Makefile
> new file mode 100644
> index 0000000..81d00df
> --- /dev/null
> +++ b/src/notebook-examples/embedded-policy/android-policy/android10/Makefile
> @@ -0,0 +1,40 @@
> +#### Build android10 base policy Makefile ####
> +
> +# git clone https://android.googlesource.com/platform/system/sepolicy
> +# cd sepolicy
> +# git checkout android10-dev
> +# Copy this file to sepolicy/Makefile and run 'make' to build the policy files.
> +#
> +# The policy.conf file can be examined with a text editor and the binary
> +# sepolicy.POL_VERS file can be viewed using tools such as apol(1).
> +
> +POL_VERS := $(shell checkpolicy -V | cut -f 1 -d ' ')
> +
> +build_policy:
> +	m4 -D mls_num_sens=1 \
> +		-D mls_num_cats=1024 \
> +		-D target_build_variant=eng \
> +		-D target_recovery=false \
> +		-s private/security_classes \
> +		private/initial_sids \
> +		private/access_vectors \
> +		public/global_macros \
> +		public/neverallow_macros \
> +		private/mls_macros \
> +		private/mls_decl \
> +		private/mls \
> +		private/policy_capabilities \
> +		public/te_macros \
> +		public/attributes \
> +		public/ioctl_defines \
> +		public/ioctl_macros \
> +		public/*.te \
> +		private/*.te \
> +		private/roles_decl \
> +		public/roles \
> +		private/users \
> +		private/initial_sid_contexts \
> +		private/fs_use \
> +		private/genfs_contexts \
> +		private/port_contexts > policy.conf
> +	checkpolicy -U deny -M -c $(POL_VERS) -o sepolicy.$(POL_VERS) policy.conf
> diff --git a/src/notebook-examples/embedded-policy/android-policy/brillo-device/Makefile b/src/notebook-examples/embedded-policy/android-policy/brillo-device/Makefile
> new file mode 100644
> index 0000000..23eee25
> --- /dev/null
> +++ b/src/notebook-examples/embedded-policy/android-policy/brillo-device/Makefile
> @@ -0,0 +1,43 @@
> +#### Build brillo-m10 + device policy Makefile ####
> +
> +# git clone https://android.googlesource.com/platform/external/sepolicy
> +# cd sepolicy
> +# git checkout brillo-m10-release
> +# To obtain a build-able device, download the brillo-m7-release.tar.gz file:
> +# https://android.googlesource.com/platform/external/sepolicy/+archive/refs/heads/brillo-m7-release.tar.gz
> +# and install into the sepolicy directory. Copy this file to sepolicy/Makefile
> +# and run 'make' to build the policy files.
> +#
> +# The dev_policy.conf file can be examined with a text editor and the binary
> +# dev_sepolicy.POL_VERS file can be viewed using tools such as apol(1).
> +
> +POL_VERS := $(shell checkpolicy -V | cut -f 1 -d ' ')
> +
> +build_policy:
> +	m4 -D mls_num_sens=1 \
> +		-D mls_num_cats=1024 \
> +		-D target_build_variant=eng \
> +		-D target_recovery=false \
> +		-s security_classes \
> +		brillo-refs_heads_brillo-m7-release-sepolicy/security_classes \
> +		initial_sids \
> +		access_vectors \
> +		brillo-refs_heads_brillo-m7-release-sepolicy/access_vectors \
> +		global_macros \
> +		mls_macros \
> +		mls \
> +		policy_capabilities \
> +		te_macros \
> +		brillo-refs_heads_brillo-m7-release-sepolicy/te_macros \
> +		neverallow_macros \
> +		attributes \
> +		ioctl_macros \
> +		*.te \
> +		brillo-refs_heads_brillo-m7-release-sepolicy/*.te \
> +		roles \
> +		users \
> +		initial_sid_contexts \
> +		fs_use \
> +		genfs_contexts \
> +		port_contexts > dev_policy.conf
> +	checkpolicy -U deny -M -c $(POL_VERS) -o dev_sepolicy.$(POL_VERS) dev_policy.conf
> diff --git a/src/notebook-examples/embedded-policy/android-policy/brillo/Makefile b/src/notebook-examples/embedded-policy/android-policy/brillo/Makefile
> new file mode 100644
> index 0000000..8855f4f
> --- /dev/null
> +++ b/src/notebook-examples/embedded-policy/android-policy/brillo/Makefile
> @@ -0,0 +1,36 @@
> +#### Build brillo-m10 base policy Makefile ####
> +
> +# git clone https://android.googlesource.com/platform/external/sepolicy
> +# cd sepolicy
> +# git checkout brillo-m10-release
> +# Copy this file to sepolicy/Makefile and run 'make' to build the policy files.
> +#
> +# The policy.conf file can be examined with a text editor and the binary
> +# sepolicy.POL_VERS file can be viewed using tools such as apol(1).
> +
> +POL_VERS := $(shell checkpolicy -V | cut -f 1 -d ' ')
> +
> +build_policy:
> +	m4 -D mls_num_sens=1 \
> +		-D mls_num_cats=1024 \
> +		-D target_build_variant=eng \
> +		-D target_recovery=false \
> +		-s security_classes \
> +		initial_sids \
> +		access_vectors \
> +		global_macros \
> +		mls_macros \
> +		mls \
> +		policy_capabilities \
> +		te_macros \
> +		neverallow_macros \
> +		attributes \
> +		ioctl_macros \
> +		*.te \
> +		roles \
> +		users \
> +		initial_sid_contexts \
> +		fs_use \
> +		genfs_contexts \
> +		port_contexts > policy.conf
> +	checkpolicy -U deny -M -c $(POL_VERS) -o sepolicy.$(POL_VERS) policy.conf
> diff --git a/src/notebook-examples/embedded-policy/reference-policy/README.md b/src/notebook-examples/embedded-policy/reference-policy/README.md
> new file mode 100644
> index 0000000..6d78a58
> --- /dev/null
> +++ b/src/notebook-examples/embedded-policy/reference-policy/README.md
> @@ -0,0 +1,6 @@
> +# Building A Small Monolithic Reference Policy
> +
> +The *modules.conf* file supports the minimum of policy modules that can be
> +defined to build a small monolithic policy as described in the
> +[Building A Small Monolithic Reference Policy](embedded_systems.md#building-a-small-monolithic-reference-policy)
> +section.
> diff --git a/src/notebook-examples/embedded-policy/reference-policy/build.conf b/src/notebook-examples/embedded-policy/reference-policy/build.conf
> new file mode 100644
> index 0000000..f6d0f46
> --- /dev/null
> +++ b/src/notebook-examples/embedded-policy/reference-policy/build.conf
> @@ -0,0 +1,84 @@
> +########################################
> +#
> +# Policy build options
> +#
> +
> +# Policy version
> +# By default, checkpolicy will create the highest
> +# version policy it supports.  Setting this will
> +# override the version.  This only has an
> +# effect for monolithic policies.
> +#OUTPUT_POLICY = 18
> +
> +# Policy Type
> +# standard, mls, mcs
> +TYPE = standard
> +
> +# Policy Name
> +# If set, this will be used as the policy
> +# name.  Otherwise the policy type will be
> +# used for the name.
> +NAME = refpolicy
> +
> +# Distribution
> +# Some distributions have portions of policy
> +# for programs or configurations specific to the
> +# distribution.  Setting this will enable options
> +# for the distribution.
> +# redhat, gentoo, debian, suse, and rhel4 are current options.
> +# Fedora users should enable redhat.
> +#DISTRO = redhat
> +
> +# Unknown Permissions Handling
> +# The behavior for handling permissions defined in the
> +# kernel but missing from the policy.  The permissions
> +# can either be allowed, denied, or the policy loading
> +# can be rejected.
> +# allow, deny, and reject are current options.
> +UNK_PERMS = deny
> +
> +# Direct admin init
> +# Setting this will allow sysadm to directly
> +# run init scripts, instead of requiring run_init.
> +# This is a build option, as role transitions do
> +# not work in conditional policy.
> +DIRECT_INITRC = n
> +
> +# Systemd
> +# Setting this will configure systemd as the init system.
> +SYSTEMD = n
> +
> +# Build monolithic policy.  Putting y here
> +# will build a monolithic policy.
> +MONOLITHIC = y
> +
> +# User-based access control (UBAC)
> +# Enable UBAC for role separations.
> +UBAC = n
> +
> +# Custom build options.  This field enables custom
> +# build options.  Putting foo here will enable
> +# build option blocks named foo.  Options should be
> +# separated by spaces.
> +CUSTOM_BUILDOPT =
> +
> +# Number of MLS Sensitivities
> +# The sensitivities will be s0 to s(MLS_SENS-1).
> +# Dominance will be in increasing numerical order
> +# with s0 being lowest.
> +MLS_SENS = 16
> +
> +# Number of MLS Categories
> +# The categories will be c0 to c(MLS_CATS-1).
> +MLS_CATS = 1024
> +
> +# Number of MCS Categories
> +# The categories will be c0 to c(MLS_CATS-1).
> +MCS_CATS = 1024
> +
> +# Set this to y to only display status messages
> +# during build.
> +QUIET = n
> +
> +# Set this to treat warnings as errors.
> +WERROR = n
> diff --git a/src/notebook-examples/embedded-policy/reference-policy/modules.conf b/src/notebook-examples/embedded-policy/reference-policy/modules.conf
> new file mode 100644
> index 0000000..091a22b
> --- /dev/null
> +++ b/src/notebook-examples/embedded-policy/reference-policy/modules.conf
> @@ -0,0 +1,236 @@
> +#
> +# This file contains a listing of available modules.
> +# To prevent a module from  being used in policy
> +# creation, set the module name to "off".
> +#
> +# For monolithic policies, modules set to "base" and "module"
> +# will be built into the policy.
> +#
> +# For modular policies, modules set to "base" will be
> +# included in the base module.  "module" will be compiled
> +# as individual loadable modules.
> +#
> +
> +# Layer: kernel
> +# Module: corecommands
> +# Required in base
> +#
> +# Core policy for shells, and generic programs
> +# in /bin, /sbin, /usr/bin, and /usr/sbin.
> +#
> +corecommands = base
> +
> +# Layer: kernel
> +# Module: corenetwork
> +# Required in base
> +#
> +# Policy controlling access to network objects
> +#
> +corenetwork = base
> +
> +# Layer: kernel
> +# Module: devices
> +# Required in base
> +#
> +# Device nodes and interfaces for many basic system devices.
> +#
> +devices = base
> +
> +# Layer: kernel
> +# Module: domain
> +# Required in base
> +#
> +# Core policy for domains.
> +#
> +domain = base
> +
> +# Layer: kernel
> +# Module: files
> +# Required in base
> +#
> +# Basic filesystem types and interfaces.
> +#
> +files = base
> +
> +# Layer: kernel
> +# Module: filesystem
> +# Required in base
> +#
> +# Policy for filesystems.
> +#
> +filesystem = base
> +
> +# Layer: kernel
> +# Module: kernel
> +# Required in base
> +#
> +# Policy for kernel threads, proc filesystem,
> +# and unlabeled processes and objects.
> +#
> +kernel = base
> +
> +# Layer: kernel
> +# Module: mcs
> +# Required in base
> +#
> +# Multicategory security policy
> +#
> +mcs = base
> +
> +# Layer: kernel
> +# Module: mls
> +# Required in base
> +#
> +# Multilevel security policy
> +#
> +mls = base
> +
> +# Layer: kernel
> +# Module: selinux
> +# Required in base
> +#
> +# Policy for kernel security interface, in particular, selinuxfs.
> +#
> +selinux = base
> +
> +# Layer: kernel
> +# Module: terminal
> +# Required in base
> +#
> +# Policy for terminals.
> +#
> +terminal = base
> +
> +# Layer: kernel
> +# Module: ubac
> +# Required in base
> +#
> +# User-based access control policy
> +#
> +ubac = base
> +
> +# Layer: kernel
> +# Module: storage
> +#
> +# Policy controlling access to storage devices
> +#
> +storage = module
> +
> +# Layer: system
> +# Module: application
> +#
> +# Policy for user executable applications.
> +#
> +application = module
> +
> +# Layer: system
> +# Module: authlogin
> +#
> +# Common policy for authentication and user login.
> +#
> +authlogin = module
> +
> +# Layer: system
> +# Module: clock
> +#
> +# Policy for reading and setting the hardware clock.
> +#
> +clock = module
> +
> +# Layer: system
> +# Module: getty
> +#
> +# Manages physical or virtual terminals.
> +#
> +getty = module
> +
> +# Layer: system
> +# Module: init
> +#
> +# System initialization programs (init and init scripts).
> +#
> +init = module
> +
> +# Layer: system
> +# Module: libraries
> +#
> +# Policy for system libraries.
> +#
> +libraries = module
> +
> +# Layer: system
> +# Module: locallogin
> +#
> +# Policy for local logins.
> +#
> +locallogin = module
> +
> +# Layer: system
> +# Module: logging
> +#
> +# Policy for the kernel message logger and system logging daemon.
> +#
> +logging = module
> +
> +# Layer: system
> +# Module: miscfiles
> +#
> +# Miscellaneous files.
> +#
> +miscfiles = module
> +
> +# Layer: system
> +# Module: modutils
> +#
> +# Policy for kernel module utilities
> +#
> +modutils = module
> +
> +# Layer: system
> +# Module: mount
> +#
> +# Policy for mount.
> +#
> +mount = module
> +
> +# Layer: system
> +# Module: selinuxutil
> +#
> +# Policy for SELinux policy and userland applications.
> +#
> +selinuxutil = module
> +
> +# Layer: system
> +# Module: sysnetwork
> +#
> +# Policy for network configuration: ifconfig and dhcp client.
> +#
> +sysnetwork = module
> +
> +# Layer: system
> +# Module: udev
> +#
> +# Policy for udev.
> +#
> +udev = module
> +
> +# Layer: system
> +# Module: unconfined
> +#
> +# The unconfined domain.
> +#
> +unconfined = module
> +
> +# Layer: system
> +# Module: userdomain
> +#
> +# Policy for user domains
> +#
> +userdomain = module
> +
> +# Layer: roles
> +# Module: sysadm
> +#
> +# General system administration role
> +#
> +sysadm = module
> diff --git a/src/seandroid.md b/src/seandroid.md
> index 409afe0..e04a85d 100644
> --- a/src/seandroid.md
> +++ b/src/seandroid.md
> @@ -210,6 +210,10 @@ The Android specific object classes are described in the
>  [**Android Classes & Permissions**](#android-classes-permissions)
>  section.
>  
> +The [**Embedded Systems - Building A Sample Android Policy**](embedded-systems#building-a-sample-android-policy)
> +section explains how to build basic Android policies. These can be explored
> +without requiring the full AOSP source and build environment.
> +
>  ### ***kernel***
>  
>  All Android kernels support the Linux Security Module (LSM) and SELinux
> @@ -1593,4 +1597,4 @@ USERDEBUG : $DEFAULT_SYSTEM_DEV_CERTIFICATE/testkey.x509.pem
>  <!-- %CUTHERE% -->
>  
>  ---
> -**[[ PREV ]](implementing_seaware_apps.md)** **[[ TOP ]](#)** **[[ NEXT ]](object_classes_permissions.md)**
> +**[[ PREV ]](embedded_systems.md)** **[[ TOP ]](#)** **[[ NEXT ]](object_classes_permissions.md)**
> diff --git a/src/section_list.txt b/src/section_list.txt
> index 340e516..dcca883 100644
> --- a/src/section_list.txt
> +++ b/src/section_list.txt
> @@ -53,6 +53,7 @@ xen_statements.md
>  modular_policy_statements.md
>  reference_policy.md
>  implementing_seaware_apps.md
> +embedded_systems.md
>  seandroid.md
>  object_classes_permissions.md
>  libselinux_functions.md
> diff --git a/src/toc.md b/src/toc.md
> index d915b42..f5778bd 100644
> --- a/src/toc.md
> +++ b/src/toc.md
> @@ -54,6 +54,7 @@
>      - [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
>  - [The Reference Policy](reference_policy.md#the-reference-policy)
>  - [Implementing SELinux-aware Applications](implementing_seaware_apps.md#implementing-selinux-aware-applications)
> +- [Embedded Systems](embedded_systems.md#embedded-systems)
>  - [SE for Android](seandroid.md#security-enhancements-for-android)
>  - [Appendix A - Object Classes and Permissions](object_classes_permissions.md#appendix-a---object-classes-and-permissions)
>  - [Appendix B - *libselinux* API Summary](libselinux_functions.md#appendix-b---libselinux-api-summary)

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
