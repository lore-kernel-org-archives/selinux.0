Date: Tue, 11 May 2010 15:28:01 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
To: SELinux@tycho.nsa.gov
Subject: Labeling as part of distribution build process?
Message-ID: <20100511152801.762ce0ac@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am working on SELinux support for our distribution. We support LiveCD
and running off a read-only image.  I have gotten xattr support for
Squashfs to work, but one question is how to do labeling of alternative
root location. One twist is that the build environment probably will
not be running with the same SELinux policy as the target.

What I want is to label a sub directory tree based on the rules
of a policy (package).  The existing tools appear to be targeted
at a self-hosted policy environment. Is there some way to label
with other tools?

Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
