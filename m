Date: Thu, 29 Aug 2002 07:37:39 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: kernel daemons runs in init_t
In-Reply-To: <20020828163123.00B4227AF@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208290723570.447-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 28 Aug 2002, Russell Coker wrote:

>   PID    SID CONTEXT                                  COMMAND
>     1      7 system_u:system_r:init_t                 init [2]
>     2      1 system_u:system_r:kernel_t               [keventd]
>     3      1 system_u:system_r:kernel_t               [kapmd]
>     4      7 system_u:system_r:init_t                 [ksoftirqd_CPU0]
>     5      7 system_u:system_r:init_t                 [kswapd]
>     6      7 system_u:system_r:init_t                 [bdflush]
>     7      7 system_u:system_r:init_t                 [kupdated]
>    19      1 system_u:system_r:kernel_t               [mdrecoveryd]
>    22      7 system_u:system_r:init_t                 [khubd]
>    31      1 system_u:system_r:kernel_t               [raid1d]
>    40      1 system_u:system_r:kernel_t               [kreiserfsd]
>   246    330 system_u:system_r:insmod_t               [kSpeedSARd]
>   288    331 system_u:system_r:fsadm_t                [raid1d]
>   298    331 system_u:system_r:fsadm_t                [raid1d]

I see something more like what Carsten describes:
    2      7 system_u:system_r:init_t                 [keventd]
    3      7 system_u:system_r:init_t                 [ksoftirqd_CPU0]
    4      7 system_u:system_r:init_t                 [kswapd]
    5      7 system_u:system_r:init_t                 [bdflush]
    6      7 system_u:system_r:init_t                 [kupdated]
    8      7 system_u:system_r:init_t                 [khubd]
   11      7 system_u:system_r:init_t                 [kjournald]
  133      7 system_u:system_r:init_t                 [kjournald]

The ps -el output shows all of these "processes" having a PPID of 1, i.e.
init.

In part, the change may be due to the new hook in the kernel
reparent_to_init function.  This would affect the kjournald and khubd
threads, since they call this function.  But I don't think it fully
explains the change, and it doesn't explain why you see kernel_t on some
of the same threads.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
