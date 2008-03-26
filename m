Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2QHDMhP025606
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 13:13:22 -0400
Received: from rn-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2QHDK15016790
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 17:13:20 GMT
Received: by rn-out-0910.google.com with SMTP id e24so2673684rng.8
        for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 10:13:16 -0700 (PDT)
Message-ID: <150846cc0803261013v4a533aa6o2ffdbc3d74241500@mail.gmail.com>
Date: Wed, 26 Mar 2008 13:13:16 -0400
From: "Caleb Case" <ccase@tresys.com>
To: selinux@tycho.nsa.gov,
        "Ubuntu Linux Proactive Security deployment and development" <ubuntu-hardened@lists.ubuntu.com>,
        ubuntu-server@lists.ubuntu.com
Subject: Testing SELinux in Ubuntu (Hardy Heron)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SELinux support is available in Ubuntu Hardy Heron and can be
installed without adding any additional repositories to the default
installation:

# apt-get install selinux

Any feedback, bugs, comments, experiences, complaints, etc are very appreciated!

Please post bugs to the appropriate source packages on Launchpad and
Ubuntu related comments to the ubuntu-hardened@lists.ubuntu.com list.

More information about SELinux support for Ubuntu can be found on the
Ubuntu wiki:

https://wiki.ubuntu.com/HardySELinux
https://wiki.ubuntu.com/SELinux

Thanks,

Caleb

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
