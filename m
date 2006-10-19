Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9JCtrZN003473
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 08:55:53 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9JCt9wO017164
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 12:55:11 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 08:57:08 -0400
Message-Id: <1161262628.22531.16.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on the
Tresys OSS site, from http://oss.tresys.com.  This release was delayed
due to its dependence on the release of checkpolicy 1.32, for it's
support for optionals in the base module.  Since the last release was in
March, the change log is correspondingly long.  There have been several
improvements, notably the completion of the conversion of modules from
the example policy, improved infrastructure for defining roles, and
support for the new netfilter-based network access controls (secmark).
The change log for this release follows at the bottom of the email.  

For those that are interested in contributing, right now the best help
would be to test the strict policy.

* Wed Oct 18 2006 Chris PeBenito <selinux@tresys.com> - 20061018
- Patch from Russell Coker Thu, 5 Oct 2006
- Move range transitions to modules.
- Make number of MLS sensitivities, and number of MLS and MCS
  categories configurable as build options.
- Add role infrastructure.
- Debian updates from Erich Schubert.
- Add nscd_socket_use() to auth_use_nsswitch().
- Remove old selopt rules.
- Full support for netfilter_contexts.
- MRTG patch for daemon operation from Stefan.
- Add authlogin interface to abstract common access for login programs.
- Remove setbool auditallow, except for RHEL4.
- Change eventpollfs to task SID labeling.
- Add key support from Michael LeMay.
- Add ftpdctl domain to ftp, from Paul Howarth.
- Fix build system to not move type declarations out of optionals.
- Add gcc-config domain to portage.
- Add packet object class and support in corenetwork.
- Add a copy of genhomedircon for monolithic policy building, so that a
  policycoreutils package update is not required for RHEL4 systems.
- Add appletalk sockets for use in cups.
- Add Make target to validate module linking.
- Make duplicate template and interface declarations a fatal error.
- Patch to stabilize modules.conf `make conf` output, from Erich Schubert.
- Move xconsole_device_t from devices to xserver since it is
  not actually a device, it is a named pipe.
- Handle nonexistant .fc and .if files in devel Makefile by
  automatically creating empty files.
- Remove unused devfs_control_t.
- Add rhel4 distro, which also implies redhat distro.
- Remove unneeded range_transition for su_exec_t and move the
  type declaration back to the su module.
- Constrain transitions in MCS so unconfined_t cannot have
  arbitrary category sets.
- Change reiserfs from xattr filesystem to genfscon as it's xattrs
  are currently nonfunctional.
- Change files and filesystem modules to use their own interfaces.
- Add user fonts to xserver.
- Additional interfaces in corecommands, miscfiles, and userdomain
  from Joy Latten.
- Miscellaneous fixes from Thomas Bleher.
- Deprecate module name as first parameter of optional_policy()
  now that optionals are allowed everywhere.
- Enable optional blocks in base module and monolithic policy.
  This requires checkpolicy 1.30.1.
- Fix vpn module declaration.
- Numerous fixes from Dan Walsh.
- Change build order to preserve m4 line number information so policy
  compile errors are useful again.
- Additional MLS interfaces from Chad Hanson.
- Move some rules out of domain_type() and domain_base_type()
  to the TE file, to use the domain attribute to take advantage
  of space savings from attribute use.
- Add global stack smashing protector rule for urandom access from
  Petre Rodan.
- Fix temporary rules at the bottom of portmap.
- Updated comments in mls file from Chad Hanson.
- Patches from Dan Walsh:
        Fri, 17 Mar 2006
        Wed, 29 Mar 2006
        Tue, 11 Apr 2006
        Fri, 14 Apr 2006
        Tue, 18 Apr 2006
        Thu, 20 Apr 2006
        Tue, 02 May 2006
        Mon, 15 May 2006
        Thu, 18 May 2006
        Tue, 06 Jun 2006
        Mon, 12 Jun 2006
        Tue, 20 Jun 2006
        Wed, 26 Jul 2006
        Wed, 23 Aug 2006
        Thu, 31 Aug 2006
        Fri, 01 Sep 2006
        Tue, 05 Sep 2006
        Wed, 20 Sep 2006
        Fri, 22 Sep 2006
        Mon, 25 Sep 2006
- Added modules:
        afs
        amavis (Erich Schubert)
        apt (Erich Schubert)
        asterisk
        audioentropy
        authbind
        backup
        calamaris
        cipe
        clamav (Erich Schubert)
        clockspeed (Petre Rodan)
        courier
        dante
        dcc
        ddclient
        dpkg (Erich Schubert)
        dnsmasq
        ethereal
        evolution
        games
        gatekeeper
        gift
        gnome (James Carter)
        imaze
        ircd
        jabber
        monop
        mozilla
        mplayer
        munin
        nagios
        nessus
        netlabel (Paul Moore)
        nsd
        ntop
        nx
        oav
        oddjob (Dan Walsh)
        openca
        openvpn (Petre Rodan)
        perdition
        portslave
        postgrey
        pxe
        pyzor (Dan Walsh)
        qmail (Petre Rodan)
        razor
        resmgr
        rhgb
        rssh
        snort
        soundserver
        speedtouch
        sxid
        thunderbird
        tor (Erich Schubert)
        transproxy
        tripwire
        uptime
        uwimap
        vmware
        watchdog
        xen (Dan Walsh)
        xprint
        yam

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
