Subject: Vanilla unix policy
From: "Justin R. Smith" <jsmith@mcs.drexel.edu>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: 10 Oct 2001 12:50:44 -0400
Message-Id: <1002732644.4547.11.camel@vorpal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Some thoughts:

1. SeLinux implements a very nice GENERAL scripting language for
security policies.

2. Is there a simple policy that merely duplicates the one that
implicitly exists in Linux already (i.e., user, group ownership and
permissions)?  

My thoughts are that one could begin with this and tighten it up one
step at a time. This might be easier than trying to create a very
fine-grained security policy from the outset.
-- 




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
