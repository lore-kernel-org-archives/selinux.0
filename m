Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6UIjhX2029101
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 14:45:43 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n6UIjHXi010623
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 18:45:17 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 30 Jul 2009 14:45:52 -0400
Message-Id: <1248979554.24705.21.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
the Tresys OSS site, http://oss.tresys.com.  This release primarily
focused on general policy development for supporting new applications
and improving support of current ones.  In addition, support for labeled
Booleans was added.

The complete change log for this release follows at the end of the
email.

For people interested in helping Reference Policy development, the X
desktop and role separation needs testing.

* Thu Jul 30 2009 Chris PeBenito <selinux@tresys.com> - 2.20090730
- Gentoo fixes for init scripts and system startup.
- Remove read_default_t tunable.
- Greylist milter from Paul Howarth.
- Crack db access for su to handle password expiration, from Brandon Whalen.
- Misc fixes for unix_update from Brandon Whalen.
- Add x_device permissions for XI2 functions, from Eamon Walsh.
- MLS constraints for the x_selection class, from Eamon Walsh.
- Postgresql updates from KaiGai Kohei.
- Milter state directory patch from Paul Howarth.
- Add MLS constrains for ingress/egress and secmark from Paul Moore.
- Drop write permission from fs_read_rpc_sockets().
- Remove unused udev_runtime_t type.
- Patch for RadSec port from Glen Turner.
- Enable network_peer_controls policy capability from Paul Moore.
- Btrfs xattr support from Paul Moore.
- Add db_procedure install permission from KaiGai Kohei.
- Add support for network interfaces with access controlled by a Boolean
  from the CLIP project.
- Several fixes from the CLIP project.
- Add support for labeled Booleans.
- Remove node definitions and change node usage to generic nodes.
- Add kernel_service access vectors, from Stephen Smalley.
- Added modules:
        certmaster (Dan Walsh)
        cpufreqselector (Dan Walsh)
        devicekit (Dan Walsh)
        fprintd (Dan Walsh)
        git (Dan Walsh)
        gpsd (Miroslav Grepl)
        guest (Dan Walsh)
        ifplugd (Dan Walsh)
        lircd (Miroslav Grepl)
        logadm (Dan Walsh)
        pads (Dan Walsh)
        pingd (Dan Walsh)
        policykit (Dan Walsh)
        pulseaudio (Dan Walsh)
        psad (Dan Walsh)
        portreserve (Dan Walsh)
        sssd (Dan Walsh)
        ulogd (Dan Walsh)
        varnishd (Dan Walsh)
        webadm (Dan Walsh)
        wm (Dan Walsh)
        xguest (Dan Walsh)
        zosremote (Dan Walsh)


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
