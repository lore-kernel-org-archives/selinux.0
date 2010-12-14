Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBEGdZB5017372
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2010 11:39:40 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id oBEGddRv023496
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2010 16:39:39 GMT
Message-ID: <4D079DCB.90200@tresys.com>
Date: Tue, 14 Dec 2010 11:39:39 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Subject: ANN: Reference Policy Release
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
the Tresys OSS site, http://oss.tresys.com.  This release primarily
focused on general maintenance.

The complete change log for this release follows at the end of the
email.

For people interested in helping Reference Policy development, the X
desktop and role separation needs testing, in addition to general
testing.

* Mon Dec 13 2010 Chris PeBenito <selinux@tresys.com> - 2.20101213
- Git man page from Dominick Grift.
- Alsa and oident home content cleanup from Dominick Grift.
- Add support for custom build options.
- Unconditional staff and user oidentd home config access from Dominick
Grift.
- Conditional mmap_zero support from Dominick Grift.
- Added devtmpfs support.
- Dbadm updates from KaiGai Kohei.
- Virtio disk file context update from Mika Pfluger.
- Increase bindreservport range to 512-1024 in corenetwork, from Dan Walsh.
- Add JIT usage for freshclam.
- Remove ethereal module since the application was renamed to wireshark.
- Remove duplicate/redundant rules, from Russell Coker.
- Increased default number of categories to 1024, from Russell Coker.
- Added modules:
        accountsd (Dan Walsh)
        cgroup (Dominick Grift)
        hadoop (Paul Nuzzi)
        kdumpgui (Dan Walsh)
        livecd (Dan Walsh)
        mojomojo (Lain Arnell)
        sambagui (Dan Walsh)
        shutdown (Dan Walsh)
        sosreport (Dan Walsh)
        vlock (Harry Ciao)

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
