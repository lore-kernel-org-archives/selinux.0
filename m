Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: kernel daemons runs in init_t
Date: Wed, 28 Aug 2002 18:31:22 +0200
References: <200208281614.QAA28639@jazzband.ncsc.mil>
In-Reply-To: <200208281614.QAA28639@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <20020828163123.00B4227AF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Aug 2002 18:15, Carsten Grohmann wrote:
> with the new release, all kernel daemons runs in the init_t domain.
> Is this a new feature or my mistake?
> But I don't found any anormaly.

That does not appear to be the case.  Below I have pasted ps output from one 
of my machines.  kernel_t is used for threads started by the kernel itself, a 
raid1d thread is running as kernel_t because it was started from an initrd 
script (which entirely runs as kernel_t because I haven't finished my initrd 
policy), the other raid1d threads for my other RAID-1 arrays are in fsadm_t 
becase they are started by /sbin/raidstart which has context 
system_u:object_r:fsadm_exec_t and runs in fsadm_t.  kSpeedSARd is started at 
module load time and runs in insmod_t.

Some other threads appear to have been started by /sbin/init which is why 
they have init_t.

  PID    SID CONTEXT                                  COMMAND
    1      7 system_u:system_r:init_t                 init [2]
    2      1 system_u:system_r:kernel_t               [keventd]
    3      1 system_u:system_r:kernel_t               [kapmd]
    4      7 system_u:system_r:init_t                 [ksoftirqd_CPU0]
    5      7 system_u:system_r:init_t                 [kswapd]
    6      7 system_u:system_r:init_t                 [bdflush]
    7      7 system_u:system_r:init_t                 [kupdated]
   19      1 system_u:system_r:kernel_t               [mdrecoveryd]
   22      7 system_u:system_r:init_t                 [khubd]
   31      1 system_u:system_r:kernel_t               [raid1d]
   40      1 system_u:system_r:kernel_t               [kreiserfsd]
  246    330 system_u:system_r:insmod_t               [kSpeedSARd]
  288    331 system_u:system_r:fsadm_t                [raid1d]
  298    331 system_u:system_r:fsadm_t                [raid1d]


-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
