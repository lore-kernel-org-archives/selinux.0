Message-ID: <433AB4E7.4080808@cornell.edu>
Date: Wed, 28 Sep 2005 11:21:11 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: Re: [PATCH] semanage-functionality 4/17
References: <200509271246.j8RCkcYs026042@gotham.columbia.tresys.com> <1127919144.25945.74.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1127919144.25945.74.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>+/* All accesses with semanage is through a "semanage_handle".  This
>+ * handler may be with the monolithic policy, directly to a module
>+ * store, or with a policy management server.  The handler represents
>+ * a persistent connection to that policy manager.  It is created
>+ * through a semanage_connect() call and must be afterwards
>+ * deallocated with semanage_handle_destroy(). */
>+typedef struct semanage_handle semanage_handle_t;
>
>It seems cleaner to separate create from connect, to parallel the
>separation of disconnect from destroy.  Further, the implementation
>already makes this easy to do; just need to make the
>semanage_handle_create function exported and change connect to take an
>already created handle rather than creating one of its own.  Barring
>objections, I will do this.
>  
>
Yes! I was trying to write a sample session with libsemanage yesterday, 
to imagine how it would work. I think we should allow queries on local 
files with disconnected handles (there's no reason to connect to any 
policy server (or create a policydb object), just to enumerate all local 
users or booleans (not base), for example).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
