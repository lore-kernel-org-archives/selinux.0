Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: kernel daemons runs in init_t
Date: Thu, 29 Aug 2002 16:23:23 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0208290723570.447-100000@raven> 
MIME-Version: 1.0
Message-Id: <20020829142324.054ED12DB@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Aug 2002 16:21, Russell Coker wrote:
>  PID    SID CONTEXT                                  COMMAND
>     1      7 system_u:system_r:init_t                 init [2]
>     2      7 system_u:system_r:init_t                 [keventd]
>     3      7 system_u:system_r:init_t                 [kapmd]
>     4      7 system_u:system_r:init_t                 [ksoftirqd_CPU0]
>     5      7 system_u:system_r:init_t                 [kswapd]
>     6      7 system_u:system_r:init_t                 [bdflush]
>     7      7 system_u:system_r:init_t                 [kupdated]
>    27     39 system_u:system_r:mount_t                [kreiserfsd]
>   152      7 system_u:system_r:init_t                 [khubd]

Sorry I should have noted that the above is not from the same machine as the 
first one (this time it's a machine without software RAID and without 
speedtouch device driver).  But apart from that it's quite a similar setup.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
