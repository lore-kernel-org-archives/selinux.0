Date: Thu, 25 Jul 2002 09:58:57 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SELinux@tycho.nsa.gov
Subject: Limited Access to Devices
Message-ID: <20020724235857.GD1127@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Somebody on debian-devel reminded me of an old problem in Unix, with no
real solution with standard Unix permissions.

When I am using my computer at the console, I want access to devices
like floppy disk, sound card, CD-ROM drive. 

However, I want to prevent remote users from accessing these devices.
For instance, anyone with access to my computer and the sound card could
spy on me via the built in microphone in my computer.

You can hack a solution with Unix and groups, but is is easy to get
around the restrictions.

Can SE-Linux help here?

I would guess if you had two seperate roles, one for local
use and one for remote use (and somehow inforced this with login,
xdm, ssh, etc) you could solve this issue.

You would also need to have a distinct domains for each role that
allow/disallow access.

Comments anyone?
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
