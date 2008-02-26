Date: Tue, 26 Feb 2008 20:53:52 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH][RFC] Unify printk messgaes
Message-ID: <Xine.LNX.4.64.0802262049370.10387@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I noticed that we had a mix of "SELinux:" and "security:" prefixes in our 
kernel boot messages, so I've unified these to "SELinux:" with the patch 
below to reduce user confusion.  (It doesn't try and fix every printk, 
just the ones with "security:").

Also simplified the avtab hash message, from:

  SELinux:8192 avtab hash slots allocated. Num of rules:163922

to

  SELinux: 8192 avtab hash slots, 163922 rules.


Comments?

---
