Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1FKJjY7019316
	for <selinux@tycho.nsa.gov>; Wed, 15 Feb 2012 15:19:45 -0500
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q1FKJimq013118
	for <selinux@tycho.nsa.gov>; Wed, 15 Feb 2012 20:19:44 GMT
Message-ID: <4F3C1348.4090003@tresys.com>
Date: Wed, 15 Feb 2012 15:19:20 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: "refpolicy@oss.tresys.com" <refpolicy@oss1.tresys.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: ANN: Reference Policy Release
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on the Tresys OSS site, http://oss.tresys.com.  This release reflects the git repository restructuring for core/contrib modules[1].

The complete change log for this release follows at the end of the email.

For people interested in helping Reference Policy development, the X desktop and role separation needs testing, in addition to general testing.

[1] http://oss.tresys.com/pipermail/refpolicy/2011-September/004619.html

* Wed Feb 15 2012 Chris PeBenito <selinux@tresys.com> - 2.20120215
- Sshd usage of mkhomedir_helper via oddjob, from Sven Vermeulen.
- Add slim and lxdm file contexts to xserver, from Sven Vermeulen.
- Add userdom interfaces for user application domains, user tmp files,
  and user tmpfs files.
- Asterisk administration fixes from Sven Vermeulen.
- Fix makefiles to install files with the correct DAC permissions if the
  umask is not 022.
- Remove deprecated support macros.
- Remove rolemap and per-role template support.
- Change corenetwork port declaration to apply the reserved port type
  attribute only, when the type has ports above and below 1024.
- Change secure_mode_policyload to disable only toggling of this Boolean
  rather than disabling all Boolean toggling permissions.
- Use role attributes to assist with domain transitions in interactive
  programs.
- Milter ports patch from Paul Howarth.
- Separate portage fetch rules out of portage_run() and portage_domtrans()
  from Sven Vermeulen.
- Enhance corenetwork network_port() macro to support ports that do not have
  a well defined port number, such as stunnel.
- Opendkim support in dkim module from Paul Howarth.
- Wireshark updates from Sven Vermeulen.
- Change secure_mode_insmod to control sys_module capability rather than
  controlling domain transitions to insmod.
- Openrc and portage updates from Sven Vermeulen.
- Allow user and role changes on dynamic transitions with the same
  constraints as regular transitions.
- New git service features from Dominick Grift.
- Corenetwork policy size optimization from Dan Walsh.
- Silence spurious udp_socket listen denials.
- Fix unexpanded MLS/MCS fields in monolithic seusers file.
- Type transition fix in Postgresql database objects from KaiGai Kohei.
- Support for file context path substitutions (file_contexts.subs).
- Added contrib modules:
        glance (Dan Walsh)
        rhsmcertd (Dan Walsh)
        sanlock (Dan Walsh)
        sblim (Dan Walsh)
        uuidd (Dan Walsh)
        vdagent (Dan Walsh)


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
