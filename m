Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA8KHtaW025817
	for <selinux@tycho.nsa.gov>; Wed, 8 Nov 2006 15:17:55 -0500
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA8KHAFh002666
	for <selinux@tycho.nsa.gov>; Wed, 8 Nov 2006 20:17:11 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.8/8.13.8/Debian-2) with ESMTP id kA8JW3FY004624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 8 Nov 2006 13:32:03 -0600
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: SELinux userland patches in Debia
In-Reply-To: <1161264297.14632.114.camel@moss-spartans.epoch.ncsc.mil>:Stephen Smalley's message of 09:24:57 Thursday,19 October 2006 
References: <1149012569.524.95.camel@moss-spartans.epoch.ncsc.mil>
	<1149259375.524.470.camel@moss-spartans.epoch.ncsc.mil>
	<1161264297.14632.114.camel@moss-spartans.epoch.ncsc.mil>
Date: Wed, 08 Nov 2006 13:32:02 -0600
Message-ID: <87irhpka4t.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        I apologize that this mail took so long to come. I was waiting
 until I was sure that the packages in question have made it into the
 release.

        The state of SELinux in Debian, heading into the freeze for
 the Etch release, is:

 1.  The tool chain is at the latest release versions
 2.  dpkg has been patched to install packages and set the initial
     file contexts correctly
 3. The Debian installer has the targeted policy install by default,
    along with the packages it depends on. These packages are now a
    part of the standard distribution.
 4. the standard kernel images have SELinux compiled in, but require
    kernel command line options in grub to turn it on. Audit support
    is also compiled in
 5. coreutils has the latest fedora patches, and is scheduled to go
    into Etch (version 5.97-5.2)
 6. sysvinit has the latest fedora patches, and is scheduled to go
    into Etch (version 2.86.ds1-34)
 7. openssh has the latest fedora patches, and is scheduled to go
    into Etch (version 1:4.3p2-5.1)
 8. PAM patches have been submitted to the maintainer, who is also a
    release manager, and he has promised that it shall go into the
    release.
 9. the policies being shipped are based on the latest released
    reference policy.

        Strict policy will not be in default install, but is one
 apt-get invocation away; I am not sure how useable it is out of the
 box on an end user system.  I run it routinely in my UML virtual
 servers, though, with some tweaks for mounting unlabeled file
 systems.

        manoj

-- 
It's easier to fight for one's principles than to live up to them.
Manoj Srivastava <manoj.srivastava@stdc.com> <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
