To: Jaap <jjb@xs4all.nl>, SELinux <selinux@tycho.nsa.gov>
References: <10d21875-321f-28fb-3c94-92f91a06947a@xs4all.nl>
 <99f11a38-42f0-0dac-8205-7f2cab015298@tycho.nsa.gov>
 <a01e6aec-2cf0-5d4c-b4b5-2149666fe192@tycho.nsa.gov>
 <8fce61a3-9973-24aa-048d-01c410afc333@xs4all.nl>
From: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "selinux@lists.fedoraproject.org" <selinux@lists.fedoraproject.org>
Message-ID: <7a1b6984-9a42-38bf-e634-bdac7a4e07bc@tycho.nsa.gov>
Date: Thu, 19 Apr 2018 09:31:40 -0400
MIME-Version: 1.0
In-Reply-To: <8fce61a3-9973-24aa-048d-01c410afc333@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Subject: Re: selinux crashes always at startup
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/18/2018 04:44 PM, Jaap wrote:
> I am on Fedora 28, 4.16.2-300.fc28.x86_64 On a Dell laptop
> policy:   selinux-policy.noarch 3.14.1-18.fc28

(restored selinux list to cc line)

Since this is Fedora-specific, I also added the Fedora selinux mailing list to the cc line above.
You may wish to subscribe to that list if not already on it.

> I do not know if / where Selinux messages are about the crash of selinux. Does selinux have a log?

ausearch -i -m AVC,SELINUX_ERR,USER_AVC -ts boot will show all SELinux kernel permission denials (AVC), kernel errors (SELINUX_ERR), and userspace permission denials (USER_AVC) since boot.  You can use other start time values (e.g. recent, today, ...) and other selectors to control exactly what is reported.

> 
> 
> On 04/18/2018 10:04 PM, Stephen Smalley wrote:
>> On 04/18/2018 04:01 PM, Stephen Smalley wrote:
>>> On 04/18/2018 03:40 PM, Jaap wrote:
>>>> selinux crashes always at startup. problem is always reported (says selinux) But it does not get better.
>>> None of the SELinux messages you showed are errors.  They are just informational, and the message "the above unknown
>>> classes and permissions will be allowed" indicates that they won't cause any permission denials.
>> Also, you didn't provide any information about your kernel, distro, policy, etc.
>> Please provide a more complete log (particularly one that shows the actual error) and
>> information about the system in question.
> journalctl | grep selinux gives this:
> 
> Apr 18 21:26:06 localhost.localdomain audit[1170]: USER_START pid=1170 uid=0 auid=42 ses=1 subj=system_u:system_r:init_t:s0 msg='op=PAM:session_open grantors=pam_selinux,pam_selinux,pam_loginuid,pam_keyinit,pam_limits,pam_systemd,pam_unix acct="gdm" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Apr 18 21:26:06 localhost.localdomain systemd[1170]: selinux: avc: denied  { status } for auid=n/a uid=42 gid=42 cmdline="/usr/libexec/gdm-wayland-session gnome-session --autostart /usr/share/gdm/greeter/autostart" scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=system permissive=0
> Apr 18 21:26:07 localhost.localdomain systemd[1170]: selinux: avc: denied  { reload } for auid=n/a uid=42 gid=42 cmdline="/usr/libexec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=system permissive=0
> Apr 18 21:26:07 localhost.localdomain systemd[1170]: selinux: avc: denied  { reload } for auid=n/a uid=42 gid=42 cmdline="/usr/libexec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=system permissive=0
> Apr 18 21:26:07 localhost.localdomain systemd[1170]: selinux: avc: denied  { reload } for auid=n/a uid=42 gid=42 cmdline="/usr/libexec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=system permissive=0
> Apr 18 21:26:07 localhost.localdomain systemd[1170]: selinux: avc: denied  { reload } for auid=n/a uid=42 gid=42 cmdline="/usr/libexec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=system permissive=0
> Apr 18 21:26:07 localhost.localdomain systemd[1170]: selinux: avc: denied  { reload } for auid=n/a uid=42 gid=42 cmdline="/usr/libexec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=system permissive=0
> Apr 18 21:26:07 localhost.localdomain systemd[1170]: selinux: avc: denied  { reload } for auid=n/a uid=42 gid=42 cmdline="/usr/libexec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=system permissive=0
> Apr 18 21:26:08 localhost.localdomain systemd[1170]: selinux: avc: denied  { reload } for auid=n/a uid=42 gid=42 cmdline="/usr/libexec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=system permissive=0
> Apr 18 21:26:08 localhost.localdomain systemd[1170]: selinux: avc: denied  { reload } for auid=n/a uid=42 gid=42 cmdline="/usr/libexec/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart" scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=system permissive=0
> Apr 18 21:26:17 localhost.localdomain audit[1613]: USER_START pid=1613 uid=0 auid=1000 ses=3 subj=system_u:system_r:init_t:s0 msg='op=PAM:session_open grantors=pam_selinux,pam_selinux,pam_loginuid,pam_keyinit,pam_limits,pam_systemd,pam_unix acct="jaap" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Apr 18 21:26:17 localhost.localdomain audit[1606]: USER_START pid=1606 uid=0 auid=1000 ses=2 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='op=PAM:session_open grantors=pam_selinux,pam_loginuid,pam_selinux,pam_keyinit,pam_namespace,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_gnome_keyring acct="jaap" exe="/usr/libexec/gdm-session-worker" hostname=localhost.localdomain addr=? terminal=/dev/tty2 res=success'
> Apr 18 21:26:50 localhost.localdomain audit[1606]: USER_END pid=1606 uid=0 auid=1000 ses=2 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='op=PAM:session_close grantors=pam_selinux,pam_loginuid,pam_selinux,pam_keyinit,pam_namespace,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_gnome_keyring acct="jaap" exe="/usr/libexec/gdm-session-worker" hostname=localhost.localdomain addr=? terminal=/dev/tty2 res=success'
> Apr 18 21:26:57 localhost.localdomain audit[2919]: USER_START pid=2919 uid=0 auid=1000 ses=5 subj=system_u:system_r:init_t:s0 msg='op=PAM:session_open grantors=pam_selinux,pam_selinux,pam_loginuid,pam_keyinit,pam_limits,pam_systemd,pam_unix acct="jaap" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Apr 18 21:26:57 localhost.localdomain audit[2869]: USER_START pid=2869 uid=0 auid=1000 ses=4 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='op=PAM:session_open grantors=pam_selinux,pam_loginuid,pam_selinux,pam_keyinit,pam_namespace,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_gnome_keyring acct="jaap" exe="/usr/libexec/gdm-session-worker" hostname=localhost.localdomain addr=? terminal=/dev/tty2 res=success'
> Apr 18 21:27:33 localhost.localdomain audit[2869]: USER_END pid=2869 uid=0 auid=1000 ses=4 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='op=PAM:session_close grantors=pam_selinux,pam_loginuid,pam_selinux,pam_keyinit,pam_namespace,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_gnome_keyring acct="jaap" exe="/usr/libexec/gdm-session-worker" hostname=localhost.localdomain addr=? terminal=/dev/tty2 res=success'
> Apr 18 21:27:40 localhost.localdomain audit[3983]: USER_START pid=3983 uid=0 auid=1000 ses=7 subj=system_u:system_r:init_t:s0 msg='op=PAM:session_open grantors=pam_selinux,pam_selinux,pam_loginuid,pam_keyinit,pam_limits,pam_systemd,pam_unix acct="jaap" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Apr 18 21:27:40 localhost.localdomain audit[3940]: USER_START pid=3940 uid=0 auid=1000 ses=6 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='op=PAM:session_open grantors=pam_selinux,pam_loginuid,pam_selinux,pam_keyinit,pam_namespace,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_gnome_keyring acct="jaap" exe="/usr/libexec/gdm-session-worker" hostname=localhost.localdomain addr=? terminal=/dev/tty2 res=success'
> [jaap@localhost ~]$
> 
>>>> from journalctl:
>>>>
>>>>
>>>> n systemd-journald[207]: Received SIGTERM from PID 1 (systemd).
>>>> Aug 15 20:43:44 localhost.localdomain kernel: systemd: 15 output lines suppressed due to ratelimiting
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux: 32768 avtab hash slots, 107409 rules.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux: 32768 avtab hash slots, 107409 rules.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  8 users, 14 roles, 5094 types, 312 bools, 1 sens, 1024 cats
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  94 classes, 107409 rules
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class sctp_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class icmp_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class ax25_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class ipx_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class netrom_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class atmpvc_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class x25_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class rose_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class decnet_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class atmsvc_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class rds_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class irda_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class pppox_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class llc_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class can_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class tipc_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class bluetooth_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class iucv_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class rxrpc_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class isdn_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class phonet_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class ieee802154_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class caif_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class alg_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class nfc_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class vsock_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class kcm_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class qipcrtr_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class smc_socket not defined in policy.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux: the above unknown classes and permissions will be allowed
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Completing initialization.
>>>> Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Setting up existing superblocks.
>>>
> 
> 
