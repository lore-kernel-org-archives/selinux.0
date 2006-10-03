Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93KPoC5024873
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 16:25:50 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93KPFGw007167
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 20:25:16 GMT
Message-ID: <4522C711.2040303@hp.com>
Date: Tue, 03 Oct 2006 16:24:49 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Range transitions in modules+refpolicy
References: <1159893626.14831.51.camel@sgc>
In-Reply-To: <1159893626.14831.51.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a nit but don't we have 1024 categories now, so s15:c0.c1023?

-- ljk

Christopher J. PeBenito wrote:
> Now that range transitions have been integrated into refpolicy
> appropriately, I came up with the following changes,
> 
> MLS:
> 
> -range_transition kernel_t lvm_exec_t s0 - s15:c0.c255;
> +range_transition NetworkManager_t initrc_exec_t:process s0 - s15:c0.c255;
> +range_transition anaconda_t initrc_exec_t:process s0 - s15:c0.c255;
> +range_transition apmd_t initrc_exec_t:process s0 - s15:c0.c255;
> +range_transition dpkg_script_t initrc_exec_t:process s0 - s15:c0.c255;
> +range_transition dpkg_t initrc_exec_t:process s0 - s15:c0.c255;
> +range_transition firstboot_t initrc_exec_t:process s0 - s15:c0.c255;
> +range_transition hald_t initrc_exec_t:process s0 - s15:c0.c255;
> +range_transition hotplug_t initrc_exec_t:process s0 - s15:c0.c255;
> +range_transition init_t initrc_exec_t:process s0 - s15:c0.c255;
> +range_transition initrc_t lvm_exec_t s0 - s15:c0.c255;
> +range_transition logrotate_t initrc_exec_t:process s0 - s15:c0.c255;
> +range_transition rpm_script_t initrc_exec_t:process s0 - s15:c0.c255;
> +range_transition rpm_t initrc_exec_t:process s0 - s15:c0.c255;
> 
> MCS:
> 
> +range_transition NetworkManager_t initrc_exec_t:process s0;
> +range_transition anaconda_t initrc_exec_t:process s0;
> +range_transition apmd_t initrc_exec_t:process s0;
> +range_transition dpkg_script_t initrc_exec_t:process s0;
> +range_transition dpkg_t initrc_exec_t:process s0;
> +range_transition firstboot_t initrc_exec_t:process s0;
> +range_transition hald_t initrc_exec_t:process s0;
> +range_transition hotplug_t initrc_exec_t:process s0;
> +range_transition init_t initrc_exec_t:process s0;
> +range_transition logrotate_t initrc_exec_t:process s0;
> +range_transition rpm_script_t initrc_exec_t:process s0;
> +range_transition rpm_t initrc_exec_t:process s0;
> 
> In both cases, the additions are because the range transition was added
> to the interface for transitioning to initrc_t to handle the prexisting
> range transitions on initrc_exec_t.  I looked into the removal in the
> MLS policy, and there isn't a way for kernel_t to transition to lvm_t,
> so that removal should be ok.
> 
> Comments on this change (in particular the MLS changes)?  Are they
> reasonable, or do we need a separate interface for non range transition
> to initrc_t?
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
