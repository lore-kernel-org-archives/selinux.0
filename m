Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j33NfGDo025507
	for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2005 19:41:16 -0400 (EDT)
Received: from web31611.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j33NaduF009696
	for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2005 23:36:40 GMT
Message-ID: <20050403233923.94400.qmail@web31611.mail.mud.yahoo.com>
Date: Sun, 3 Apr 2005 16:39:23 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Desktop apps interoperability
To: Stephen Smalley <sds@tycho.nsa.gov>,
   Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2005-03-31 at 08:51 -0800, Casey Schaufler
> wrote:
> > Existing MLS systems allow unprivileged
> > applications to run unmodified. In at least
> > one case that included an unmodified X server.
> > You have to do at least as well as the unix MLS
> > systems to be credible. You think that's a
> > low bar, so you shouldn't have any trouble,
> > right?
> 
> You can certainly allow applications to run
> unmodified on SELinux today.

This is critically important to the possibility
of widespread acceptance of the system.

> But there can be benefit from modifying applications
> to provide stronger
> isolation and true least privilege in the future.

To be sure. An application that is written with
understanding of the environment in which it runs
will always have the advantage over the one that
is not.
 
> And users do care
> about these "unprivileged" applications corrupting
> or leaking their
> data.

True enough. Nonetheless, the operating
system developer must have enough confidence
in the policies and mechanisms of the OS to
let the application developer do arbitrary
unprivileged things. Only a truely closed
system can control everything, which is why
the clear definition of system policies is
so important in an open or open source system.


Casey Schaufler
casey@schaufler-ca.com


	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
