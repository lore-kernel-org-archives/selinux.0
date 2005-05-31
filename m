Subject: Re: file_type_auto_trans is not sufficient
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1117546607.28924.71.camel@moss-spartans.epoch.ncsc.mil>
References: <1117249760.19257.18.camel@localhost.localdomain>
	 <1117252045.19698.16.camel@localhost.localdomain>
	 <42980072.6090701@redhat.com>
	 <1117336632.24194.8.camel@localhost.localdomain>
	 <42999EF1.3020205@redhat.com>
	 <1117388699.21505.4.camel@localhost.localdomain>
	 <1117422237.9452.15.camel@localhost.localdomain>
	 <1117440314.12101.18.camel@localhost.localdomain>
	 <1117546607.28924.71.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 31 May 2005 11:09:15 -0400
Message-Id: <1117552155.15167.36.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



>   At that time, it was
> possible to use them in multi-threaded apps because the fscreate and
> exec contexts are stored per-kernel-thread, NPTL used a 1:1 user:kernel
> threading model, and /proc/self referenced the per-thread state.  Then,
> circa 2.6.0-test6, /proc was suddenly changed such that top-level /proc
> only contains the thread group leaders and /proc/self refers to the
> thread group leader rather than the per-thread state, and you have to
> use /proc/self/task/<tid> to access the per-thread state.  Thus, at
> present, any multi-threaded app will encounter a denial upon attempting
> to use setfscreatecon(3) or setexeccon(3) from a thread other than the
> thread group  leader.  In short, the API doesn't presently allow for use
> by multiple threads, although the implementation could support it (for
> any threading library that uses a 1:1 user-to-kernel threading model).

So other threads will fail to create the desired file in enforcing mode.
This certainly seems like a bad thing...

Would you recommend I go ahead with this setfscreatecon scheme, though?

I don't see any other way to create things in the proper context when
you have two (or more) conflicting file_type_auto_trans rules.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
