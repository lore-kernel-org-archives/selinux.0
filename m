To: Jaap <jjb@xs4all.nl>, selinux@tycho.nsa.gov
References: <10d21875-321f-28fb-3c94-92f91a06947a@xs4all.nl>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <99f11a38-42f0-0dac-8205-7f2cab015298@tycho.nsa.gov>
Date: Wed, 18 Apr 2018 16:01:57 -0400
MIME-Version: 1.0
In-Reply-To: <10d21875-321f-28fb-3c94-92f91a06947a@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Subject: Re: selinux crashes always at startup
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/18/2018 03:40 PM, Jaap wrote:
> 
> selinux crashes always at startup. problem is always reported (says selinux) But it does not get better.

None of the SELinux messages you showed are errors.  They are just informational, and the message "the above unknown
classes and permissions will be allowed" indicates that they won't cause any permission denials.

> 
> from journalctl:
> 
> 
> n systemd-journald[207]: Received SIGTERM from PID 1 (systemd).
> Aug 15 20:43:44 localhost.localdomain kernel: systemd: 15 output lines suppressed due to ratelimiting
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux: 32768 avtab hash slots, 107409 rules.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux: 32768 avtab hash slots, 107409 rules.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  8 users, 14 roles, 5094 types, 312 bools, 1 sens, 1024 cats
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  94 classes, 107409 rules
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class sctp_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class icmp_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class ax25_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class ipx_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class netrom_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class atmpvc_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class x25_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class rose_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class decnet_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class atmsvc_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class rds_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class irda_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class pppox_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class llc_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class can_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class tipc_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class bluetooth_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class iucv_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class rxrpc_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class isdn_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class phonet_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class ieee802154_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class caif_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class alg_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class nfc_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class vsock_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class kcm_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class qipcrtr_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class smc_socket not defined in policy.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux: the above unknown classes and permissions will be allowed
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Completing initialization.
> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Setting up existing superblocks.
