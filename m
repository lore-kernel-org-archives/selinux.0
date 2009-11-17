Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAHFSL8n027531
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 10:28:21 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id nAHFUQSO022300
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 15:30:26 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 17 Nov 2009 10:28:40 -0500
Message-ID: <1258471720.27504.253.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
the Tresys OSS site, http://oss.tresys.com.  This release primarily
focused on general policy development for supporting new applications
and improving support of current ones.

The complete change log for this release follows at the end of the
email.

For people interested in helping Reference Policy development, the X
desktop and role separation needs testing.

* Tue Nov 17 2009 Chris PeBenito <selinux@tresys.com> - 2.20091117
- Add separate x_pointer and x_keyboard classes inheriting from x_device. 
  From Eamon Walsh.
- Deprecated the userdom_xwindows_client_template().
- Misc Gentoo fixes from Corentin Labbe.
- Debian policykit fixes from Martin Orr.
- Fix unconfined_r use of unconfined_java_t.
- Add missing x_device rules for XI2 functions, from Eamon Walsh.
- Add missing rules to make unconfined_cronjob_t a valid cron job domain.
- Add btrfs and ext4 to labeling targets.
- Fix infrastructure to expand macros in initrc_context when installing.
- Handle unix_chkpwd usage by useradd and groupadd.
- Add missing compatibility aliases for xdm_xserver*_t types.
- Added modules:
        abrt (Dan Walsh)
        dkim (Stefan Schulze Frielinghaus)
        gitosis (Miroslav Grepl)
        gnomeclock (Dan Walsh)
        hddtemp (Dan Walsh)
        kdump (Dan Walsh)
        modemmanager(Dan Walsh)
        nslcd (Dan Walsh)
        puppet (Craig Grube)
        rtkit (Dan Walsh)
        seunshare (Dan Walsh)
        shorewall (Dan Walsh)
        tgtd (Matthew Ife)
        tuned (Miroslav Grepl)
        xscreensaver (Corentin Labbe)


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
