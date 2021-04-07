Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09E1C433B4
	for <selinux@archiver.kernel.org>; Wed,  7 Apr 2021 12:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A3961279
	for <selinux@archiver.kernel.org>; Wed,  7 Apr 2021 12:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347296AbhDGMtf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Apr 2021 08:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352453AbhDGMt3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Apr 2021 08:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617799758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nEfQU+mejvlAJ6HBEg7RQaKp2BWIxJJH7v43hOZUaw=;
        b=QlZCFHA5XylDuHLe3VKuzJOtfLhrELCTdYDkeEv2O4M4ukZ5cyyyc4QBn7MbpXSUlLCVnb
        8GVtLx0b96u96MDcgvvOr8RO0qlK5cK5C5F6oZCW54q+W7nkCATff4u4wm73lVKeyTztWZ
        pi+13SxmmuDRMLB+BMfawR5zZB1fC1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-XZxdDFZJOaWR5-yN7HcbNw-1; Wed, 07 Apr 2021 08:49:14 -0400
X-MC-Unique: XZxdDFZJOaWR5-yN7HcbNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA82F87A82A
        for <selinux@vger.kernel.org>; Wed,  7 Apr 2021 12:49:13 +0000 (UTC)
Received: from [10.40.194.135] (unknown [10.40.194.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23E165C27C
        for <selinux@vger.kernel.org>; Wed,  7 Apr 2021 12:49:12 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] selinux: add "mls" binary version of the policy
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
References: <CAEg-Je-mAOJc53LyMrmcHfgKAvaQm2-jYWKizCAjLW=15_XF3g@mail.gmail.com>
 <20210407101245.276527-1-vmojzis@redhat.com>
 <20210407101245.276527-4-vmojzis@redhat.com>
Message-ID: <229b25eb-4ab8-5dd3-dc01-2b2434ec12bd@redhat.com>
Date:   Wed, 7 Apr 2021 14:49:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210407101245.276527-4-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Please disregad these patches, they where intended for a different ML.
Sorry for the noise.

On 4/7/21 12:12 PM, Vit Mojzis wrote:
> Compile the module also for use with "mls" systems and allow
> installation to systems with any selinux type (targeted, mls and
> minimum).
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>   libvirt.spec.in           | 53 +++++++++++++++++++++++++++++++++------
>   selinux/compile_policy.py | 21 ++++++++++------
>   selinux/meson.build       | 11 +++++---
>   selinux/mls/meson.build   | 20 +++++++++++++++
>   4 files changed, 87 insertions(+), 18 deletions(-)
>   create mode 100644 selinux/mls/meson.build
> 
> diff --git a/libvirt.spec.in b/libvirt.spec.in
> index 1b807ec324..9efbd2e6db 100644
> --- a/libvirt.spec.in
> +++ b/libvirt.spec.in
> @@ -5,9 +5,8 @@
>   # or versions, but no effort will be made to ensure that going forward.
>   
>   %if 0%{?fedora} > 33 || 0%{?rhel} > 8
> -	%global with_selinux 1
> -	%global selinuxtype targeted
> -	%global modulename virt
> +    %global with_selinux 1
> +    %global modulename virt
>   %endif
>   
>   %define min_rhel 7
> @@ -1535,18 +1534,57 @@ exit 0
>   # SELinux contexts are saved so that only affected files can be
>   # relabeled after the policy module installation
>   %pre selinux
> -%selinux_relabel_pre -s %{selinuxtype}
> +if [ -e /etc/selinux/config ]; then
> +    . /etc/selinux/config
> +    %selinux_relabel_pre -s ${SELINUXTYPE}
> +fi
>   
>   %post selinux
> -%selinux_modules_install -s %{selinuxtype} %{_datadir}/selinux/packages/%{selinuxtype}/%{modulename}.pp.bz2
> +# only policy reload is needed - module installation is managed by triggers
> +/usr/sbin/selinuxenabled && /usr/sbin/load_policy || :
>   
>   %postun selinux
>   if [ $1 -eq 0 ]; then
> -    %selinux_modules_uninstall -s %{selinuxtype} %{modulename}
> +    /usr/sbin/selinuxenabled && /usr/sbin/load_policy || :
>   fi
>   
>   %posttrans selinux
> -%selinux_relabel_post -s %{selinuxtype}
> +if [ -e /etc/selinux/config ]; then
> +    . /etc/selinux/config
> +    %selinux_relabel_post -s ${SELINUXTYPE}
> +fi
> +
> +# install the policy module to corresponding policy store if
> +# selinux-policy-{targeted|mls|minimum} package is installed on the system
> +%triggerin -n %{name}-selinux -- selinux-policy-targeted
> +/usr/sbin/semodule -n -s targeted -X 200 -i %{_datadir}/selinux/packages/%{modulename}.pp.bz2 || :
> +
> +%triggerin -n %{name}-selinux -- selinux-policy-minimum
> +/usr/sbin/semodule -n -s minimum -X 200 -i %{_datadir}/selinux/packages/%{modulename}.pp.bz2 || :
> +# libvirt module is installed by default, but disabled -- enable it
> +/usr/sbin/semodule -n -s minimum -e %{modulename} || :
> +
> +%triggerin -n %{name}-selinux -- selinux-policy-mls
> +/usr/sbin/semodule -n -s mls -X 200 -i %{_datadir}/selinux/packages/mls/%{modulename}.pp.bz2 || :
> +
> +# remove the policy module from corresponding module store if
> +# libvirt-selinux or selinux-policy-* was removed from the system,
> +# but not when either package gets updated
> +%triggerun -n %{name}-selinux -- selinux-policy-targeted
> +if ([ $1 -eq 0 ] || [ $2 -eq 0 ]) && [ -e %{_sharedstatedir}/selinux/targeted/active/modules/200/%{modulename} ]; then
> +    /usr/sbin/semodule -n -s targeted -X 200 -r %{modulename} || :
> +fi
> +
> +%triggerun -n %{name}-selinux -- selinux-policy-minimum
> +if ([ $1 -eq 0 ] || [ $2 -eq 0 ]) && [ -e %{_sharedstatedir}/selinux/minimum/active/modules/200/%{modulename} ]; then
> +    /usr/sbin/semodule -n -s minimum -X 200 -r %{modulename} || :
> +    /usr/sbin/semodule -n -d %{modulename} || :
> +fi
> +
> +%triggerun -n %{name}-selinux -- selinux-policy-mls
> +if ([ $1 -eq 0 ] || [ $2 -eq 0 ]) && [ -e %{_sharedstatedir}/selinux/mls/active/modules/200/%{modulename} ]; then
> +    /usr/sbin/semodule -n -s mls -X 200 -r %{modulename} || :
> +fi
>   %endif
>   
>   %files
> @@ -2018,6 +2056,7 @@ fi
>   %if 0%{?with_selinux}
>   %files selinux
>   %{_datadir}/selinux/packages/%{modulename}.pp.*
> +%{_datadir}/selinux/packages/mls/%{modulename}.pp.*
>   %ghost %{_sharedstatedir}/selinux/targeted/active/modules/200/%{modulename}
>   %ghost %{_sharedstatedir}/selinux/minimum/active/modules/200/%{modulename}
>   %ghost %{_sharedstatedir}/selinux/mls/active/modules/200/%{modulename}
> diff --git a/selinux/compile_policy.py b/selinux/compile_policy.py
> index 2de26f21c7..7a703dbb3d 100755
> --- a/selinux/compile_policy.py
> +++ b/selinux/compile_policy.py
> @@ -24,16 +24,21 @@ import sys
>   import os
>   import glob
>   
> -if len(sys.argv) != 6:
> -    print("Usage: %s <policy>.te <policy>.if <policy>.fc <output>.pp <tmpdir>"
> -          % sys.argv[0], file=sys.stderr)
> +if len(sys.argv) != 7:
> +    print(("Usage: {} <policy>.te <policy>.if <policy>.fc <output>.pp <tmpdir>"
> +           " <type (mls/mcs)>").format(sys.argv[0]), file=sys.stderr)
>       exit(os.EX_USAGE)
>   
>   module_name = os.path.splitext(os.path.basename(sys.argv[1]))[0]
>   
> -m4param = ["-D", "enable_mcs", "-D", "distro_redhat", "-D",
> -           "hide_broken_symptoms", "-D", "mls_num_sens=16", "-D",
> -           "mls_num_cats=1024", "-D", "mcs_num_cats=1024"]
> +m4param = ["-D", "distro_redhat", "-D", "hide_broken_symptoms",
> +           "-D", "mls_num_sens=16", "-D", "mls_num_cats=1024",
> +           "-D", "mcs_num_cats=1024"]
> +
> +if sys.argv[6] == "mls":
> +    m4param = ["-D", "enable_mls"] + m4param
> +else:
> +    m4param = ["-D", "enable_mcs"] + m4param
>   
>   SHAREDIR = "/usr/share/selinux"
>   HEADERDIR = os.path.join(SHAREDIR, "devel/include")
> @@ -55,7 +60,9 @@ except Exception:
>       pass
>   
>   # remove old trash from the temp folder
> -for name in ["iferror.m4" "all_interfaces.conf" "{}.*".format(module_name)]:
> +tmpfiles = ["{}.{}".format(module_name, ext)
> +            for ext in ["mod", "mod.fc", "tmp"]]
> +for name in ["iferror.m4", "all_interfaces.conf"] + tmpfiles:
>       try:
>           os.remove(os.path.join(sys.argv[5], name))
>       except Exception:
> diff --git a/selinux/meson.build b/selinux/meson.build
> index 2737e60519..305cf59e72 100644
> --- a/selinux/meson.build
> +++ b/selinux/meson.build
> @@ -4,15 +4,16 @@ selinux_sources = [
>     'virt.fc',
>   ]
>   
> -compile_policy_prog = find_program('compile_policy.py')
> +set_variable('compile_policy_prog', find_program('compile_policy.py'))
>   
> +# targeted/minimum policy module
>   virt_pp = custom_target('virt.pp',
>     output : 'virt.pp',
>     input : selinux_sources,
> -  command : [compile_policy_prog, '@INPUT@', '@OUTPUT@', 'selinux/tmp'],
> +  command : [compile_policy_prog, '@INPUT@', '@OUTPUT@', 'selinux/tmp', 'mcs'],
>     install : false)
>   
> -bzip2_prog = find_program('bzip2')
> +set_variable('bzip2_prog', find_program('bzip2'))
>   
>   bzip = custom_target('virt.pp.bz2',
>     output : 'virt.pp.bz2',
> @@ -20,4 +21,6 @@ bzip = custom_target('virt.pp.bz2',
>     command : [bzip2_prog, '-c', '-9', '@INPUT@'],
>     capture : true,
>     install : true,
> -  install_dir : 'share/selinux/packages/')
> +  install_dir : 'share/selinux/packages')
> +
> +subdir('mls')
> diff --git a/selinux/mls/meson.build b/selinux/mls/meson.build
> new file mode 100644
> index 0000000000..20bab41fea
> --- /dev/null
> +++ b/selinux/mls/meson.build
> @@ -0,0 +1,20 @@
> +selinux_sources = [
> +  '../virt.te',
> +  '../virt.if',
> +  '../virt.fc',
> +]
> +
> +# MLS policy module
> +virt_pp_mls = custom_target('virt.pp',
> +  output : 'virt.pp',
> +  input : selinux_sources,
> +  command : [compile_policy_prog, '@INPUT@', '@OUTPUT@', 'selinux/mls/tmp', 'mls'],
> +  install : false)
> +
> +bzip_mls = custom_target('virt.pp.bz2',
> +  output : 'virt.pp.bz2',
> +  input : virt_pp_mls,
> +  command : [bzip2_prog, '-c', '-9', '@INPUT@'],
> +  capture : true,
> +  install : true,
> +  install_dir : 'share/selinux/packages/mls')
> 

