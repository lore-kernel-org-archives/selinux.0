Message-ID: <69230B2D239ED311BEC700C00D01199D1A619B@nt-server>
From: "Marting, Steve" <Steve.Marting@progeny.net>
To: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: Transition from RBAC to MLS
Date: Fri, 23 Mar 2001 15:09:34 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello!

We have a system we set up with the default configuration files, which use
only RBAC.  I'm now trying to rebuild the kernel with MLS enabled, but I'm
running into a problem.  I hope someone here can help.  (If it matters, this
was built on top of Red Hat 6.1.)

First, I edited policy/mls and created policy/fs_contexts.mls,
initial_sid_contexts.mls, net_contexts.mls, and users.mls with some default
values.  Then (going from the directions in
http://www.nsa.gov/selinux/doc/install.html) I ran the scripts in the tools
directory (enabling MLS in the security options menu) and removed all the
...security directories.  When I rebooted, the kernel panicked because
/ss_policy did not have MLS but the kernel did.  I also tried booting
without any /ss_policy file (figuring I could build it later, like the
...security directories), but that caused a panic, as well.

After doing some digging, I tried to create an MLS /ss_policy file by
editing policy/Makefile and setting "CONFIG_FLASK_MLS" to "y."  Then I ran
"make install" from that directory, but checkpolicy complained that it found
MLS definitions in the policy.conf file!  This is where I got confused -
shouldn't checkpolicy have been compiled with MLS support when I built the
kernel and apps before those reboots?

Has anyone else ever taken a RBAC build and transitioned it to MLS?  Am I
missing something simple?

Thanks for any help,
-Steve

--
Steve Marting, Senior Associate Software Engineer
Progeny Systems Corp., Manassas, VA (World HQ)
703-368-6107 x162 -=#=- smarting@progeny.net


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
