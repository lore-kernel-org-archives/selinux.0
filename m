Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p89HBYYl024839
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 13:11:34 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p89HBXhl012640
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 17:11:34 GMT
Received: from [192.168.2.2] (151.76.41.242) by cp-out7.libero.it (8.5.133)
        id 4E68B6BF0035D036 for selinux@tycho.nsa.gov; Fri, 9 Sep 2011 19:11:33 +0200
Subject: Re: [PATCH] Fix include semanage/handle.h for semanage_set_root()
 as used by semodule
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Date: Fri, 09 Sep 2011 19:11:33 +0200
In-Reply-To: <1315587716.2170.16.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315588293.2170.22.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Heads-up. No patch is needed for the semanage files (as the new semanage/modules.h file already includes semanage/handle.h).

It's probably just the build system that needs to be modified to include the local header files during the build process instead of the already installed system-wide ones.

Otherwise the libraries need to be installed beforehand ?

Regards,

Guido

On Fri, 2011-09-09 at 19:01 +0200, Guido Trentalancia wrote:
> Hello,
> 
> I am not able to build semodule from the current git unless the
> following patch is applied.
> 
> Also, it would still be problematic if an outdated version of handle.h
> is getting picked up directly from the root include directory (as it
> happens now) and not from the local build directory... In other words,
> the Makefile and build system should be modified so that the local
> header files are picked up during each new build rather than the
> system-wide ones from previous installations.
> 
> But at least this is a start:
> 
> Include <semanage/handle.h> for semodule_set_root() currently used by semodule
> 
> --- selinux-05092011/policycoreutils/semodule/semodule.c	2011-09-02 04:19:47.357716917 +0200
> +++ selinux-05092011-fix-semanage_set_root/policycoreutils/semodule/semodule.c	2011-09-09 18:41:24.078319022 +0200
> @@ -21,6 +21,7 @@
>  #include <sys/types.h>
>  
>  #include <semanage/modules.h>
> +#include <semanage/handle.h>
>  
>  enum client_modes { NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, ENABLE_M, DISABLE_M, REMOVE_M,
>  	LIST_M, RELOAD
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
