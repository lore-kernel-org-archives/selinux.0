Message-Id: <sdd4dfd3.043@atlas.snu.edu>
Date: Fri, 15 Nov 2002 11:51:16 -0600
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <russell@coker.com.au>, <SELinux@tycho.nsa.gov>,
        <mark.westerman@westcam.com>
Subject: RE: Security Enhanced Linux distro
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm in the process of trying to integrate SELinux into Gentoo linux, if
you don't know anything about it it's a source based distro with a very
cool package management system. It was originally based on BSD Ports,
but has since become a very full solution. It is dependancy based etc,
has USE keywords to tell what support you want compiled in. Basically if
a user has the SELinux USE keyword it'll patch the userland utils (with
dependancy on the policy compiler and selinux kernel). This live system
upgrade you mention, what is it about? I presume you mean the problem
with having unlabeled files on the filesystem for some amount of time.
In gentoo all apps install to a temp directory where the file list is
enumerated and logged before copying to the live filesystem, is there
any way for me to label these files while in the temp directory, so that
they are labeled when they are copied to the live filesystem and this
latency between installation and labeling isn't a problem?


Joshua Brindle
UNIX Administrator
Southern Nazarene University

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
