Subject: openssh
From: Timothy Wood <timothy@hallcomp.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 26 Aug 2002 09:17:10 -0400
Message-Id: <1030367830.29149.25.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After installing the version of ssh that comes with SELinux I am unable
to connect to the machine.  I've followed the instructions in the
README.privsep to make sure everything is setup and still nothing.  I
tried a make install to reinstall it and I noticed that the install
reports that the sshd user is not setup despite the fact that it does
output the user id information for the sshd user when it calls id sshd
from the script.  There are no avc or log messages generated (other than
the normal ssh connect failed message) in enforcing or permissive mode. 
I'd assume that this is a problem installing ssh since it doesn't even
work in permissive mode.  Any ideas as to what I've done wrong?

Timothy,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
