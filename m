Subject: Shutdown issues
From: Justin Smith <jsmith@mcs.drexel.edu>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: 24 Jan 2002 09:02:07 -0500
Message-Id: <1011880927.1377.9.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am using Redhat 7.2 with the current version of SELinux (2.4.17
kernel) and have noticed some "issues" (sorry to introduce Microsoftese)
involving shutdown:

There are a number of access denied messages in shutdown that are hard
to catch because they don't appear on the message log (since the system
is shutting down).

In some cases, software (postgres and ipchains, for instance) is not
properly shut down due to these denials. 

I don't know whether this is related, but I get a kernel panic when
shutting down in enforcing mode. It's hard to note the details of this
problem because the system succeeds in shutting down anyway (so the
messages disappear from the screen). I just recall the phrase 'kernel
panic' appearing briefly. This is only a problem for my home computer
since it shut it down after every use.

In general, I solve all of these problems by using a shutdown script
that puts the system in permissive mode just before shutdown (this is
not a security problem since it's hard to hack a system that is shutting
down...)
-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
