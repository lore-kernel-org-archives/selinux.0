Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4PK2VrI020755
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2010 16:02:31 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o4PK3nrP007228
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2010 20:03:50 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 25 May 2010 16:02:29 -0400
Message-ID: <1274817749.8988.121.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
the Tresys OSS site, http://oss.tresys.com.  This release primarily
focused on reducing the differences between the Fedora policy and
Reference Policy.

The complete change log for this release follows at the end of the
email.

For people interested in helping Reference Policy development, the X
desktop and role separation needs testing, in addition to general
testing.

* Mon May 24 2010 Chris PeBenito <selinux@tresys.com> - 2.20100524
- Merged a significant portion of Fedora policy.
- Move rules from mta mailserver delivery from interface to .te to use
  attributes.
- Remove concept of users from terminal module interfaces since the
  attributes are not specific to users.
- Add non-drawing X client support, for consolekit usage.
- Misc Gentoo fixes from Chris Richards.
- AFS and abrt fixes from Dominick Grift.
- Improved the XML docs of 55 most-used interfaces.
- Apcupsd and amavis fixes from Dominick Grift.
- Fix network_port() in corenetwork to correctly handle port ranges.
- SE-Postgresql updates from KaiGai Kohei.
- X object manager revisions from Eamon Walsh.
- Added modules:
        chronyd (Miroslav Grepl)
        cobbler (Dominick Grift)
        dbadm (KaiGai Kohei)
        denyhosts (Dan Walsh)
        nut (Stefan Schulze Frielinghaus, Miroslav Grepl)
        likewise (Scott Salley)
        plymouthd (Dan Walsh)
        pyicqt (Stefan Schulze Frielinghaus)
        sectoolm (Miroslav Grepl)
        usbmuxd (Dan Walsh)
        vhostmd (Dan Walsh)


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
