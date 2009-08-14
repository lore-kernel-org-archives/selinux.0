Subject: Push mmap_min_addr changes to Linus
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 14 Aug 2009 09:01:09 -0400
Message-Id: <1250254869.2068.19.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm tired of these recent exploits and SELinux being weaker against
local user priv escalation bugs using NULL pointers.  Can we push 

7c73875e7dda627040b12c19b01db634fa7f0fd1
84336d1a77ccd2c06a730ddd38e695c2324a7386
a2551df7ec568d87793d2eea4ca744e86318f205
47d439e9fb8a81a90022cfa785bf1c36c4e2aff6

To linus?  It's fixing a clear security bug in that we are not checking
DAC before granting mmap_min_addr.  If need be I'll write another
smaller patch which just does the DAC check in the SELinux security
hook, but I'd rather see the true separation.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
