Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8HKAJrT005269
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 16:10:20 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8HK9MNM014167
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 20:09:22 GMT
Subject: Re: policy patch: some misc additions
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20040911133324.GA2557@jmh.mhn.de>
References: <20040911133324.GA2557@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1095451769.4295.7.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 17 Sep 2004 16:09:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-09-11 at 09:33, Thomas Bleher wrote:
> The following patch against latest CVS adds some misc policy:
> 
> logrotate.te: the suse version doesn't work without this
> modutil.te: I see no reason why user_r should ever touch insmod_t
> iptables.te: added tc (traffic control) to the iptables domain
> rpm.te: gpg doesn't want to verify signatures otherwise
> xdm.te: needed with XFree86 4.3, kdm 3.3 and nvidia
> types.fc: added file contexts for some kde and gnome libraries
>           (filenames are like /opt/kde3/lib/kde3/kcalc.so)
>           the nVidia libs need some extra file context, too
> gpg_agent_macros.te: permission was needed because of wrongly labeled
>                      files (see above)
> ssh_agent_macros.te: make sure user_home_t and nfs_t behave the same;
>                      also add my name (I'm the original author of this
>                      policy)
> ssh-agent.te: ssh wants to create ~/.ssh if it doesn't exist
> 
> Thomas

> diff -ur orig/file_contexts/types.fc mod/file_contexts/types.fc
> --- orig/file_contexts/types.fc 2004-09-11 14:31:47.000000000 +0200
> +++ mod/file_contexts/types.fc  2004-09-11 14:47:06.000000000 +0200
> @@ -224,6 +224,9 @@
>  /u?dev/n?osst[0-3].*   -c      system_u:object_r:tape_device_t
>  /u?dev/n?pt[0-9]+      -c      system_u:object_r:tape_device_t
>  /u?dev/tape.*          -c      system_u:object_r:tape_device_t
> +ifdef(`distro_suse', `
> +/u?dev/usbscanner      -c      system_u:object_r:scanner_device_t
> +')
>  /u?dev/usb/scanner.*   -c      system_u:object_r:scanner_device_t
>  /u?dev/usb/dc2xx.*     -c      system_u:object_r:scanner_device_t
>  /u?dev/usb/mdc800.*    -c      system_u:object_r:scanner_device_t
> @@ -242,6 +245,7 @@
>  /opt/[^/]*/lib(/.*)?           system_u:object_r:lib_t
>  /opt/[^/]*/lib/lib[^/]*\.so(\.[^/]*)*  --      system_u:object_r:shlib_t
>  /opt/[^/]*/lib/.*/lib[^/]*\.so(\.[^/]*)*       --      system_u:object_r:shlib_t
> +/opt/.*/lib/.*\.so     --      system_u:object_r:shlib_t
>  /opt/[^/]*/man(/.*)?           system_u:object_r:man_t
>  /opt/[^/]*/libexec(/.*)?       system_u:object_r:bin_t
>  
> @@ -336,11 +340,14 @@
>  /usr/lib(64)?/autofs/.*\.so    --      system_u:object_r:shlib_t
>  /usr/lib(64)?/perl5/man(/.*)?  system_u:object_r:man_t
>  /usr/lib(64)?/perl.*\.so       --      system_u:object_r:shlib_t
> +/usr/lib(64)?/(NORM|NVIDIA)_lib.*\.so(\.[^/]*)*        --      system_u:object_r:shlib_t
> +/usr/lib(64)?/tls/NVIDIA/(NORM|NVIDIA)_lib.*\.so(\.[^/]*)*     --      system_u:object_r:shlib_t
>  /usr/lib(64)?/selinux(/.*)?            system_u:object_r:policy_src_t
>  /usr/lib(64)?/emacsen-common/.*        system_u:object_r:bin_t
>  /usr/lib(64)?/.*/bin(/.*)?             system_u:object_r:bin_t
>  /usr/lib(64)?/gconv/.*\.so     --      system_u:object_r:shlib_t
>  /usr/share/guile/g-wrapped/.*\.so -- system_u:object_r:shlib_t
> +/usr/lib/[^/]*\.so     --      system_u:object_r:shlib_t

Why add this?  Why not /usr/lib(64)?/[^/]*\.so ?
If this rule is added, some other rules can be deleted.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
