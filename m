Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA11140
	for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 10:53:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA26267
	for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 14:52:28 GMT
Received: from c001.snv.cp.net (h000.c001.snv.cp.net [209.228.32.114])
        by jazzband.ncsc.mil  with SMTP id OAA26263 for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 14:52:28 GMT
From: "Leslie J. French" <ljf@semandex.net>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: RE: auditing etc
Date: Sun, 9 Jun 2002 10:53:56 -0400
Message-ID: <BFEMIIHKHLALNELLMPOMCEGCCBAA.ljf@semandex.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020609085923.59B6E466@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I would like to put in a plea to separate auditing from logging, or at least
to provide a separate interface for audit events.  Specifically:

1.  Have a separate audit log/logs, not the system log, that can be used for
security-related failures and other system security related events.

2.  Put the audit information in its own domain, so that only the audit
administrator can access/modify the contents (i.e. a separate role).

3.  Allow programmatic access to the auditing events, so that a monitor
program can generate events (like paging a system administrator) or forward
critical messages to a separate machine.

Basically, the smaller the auditing component is, the easier it should be to
demonstrate its correct operation under threats such as T.ADMIN_ROGUE.  Is
there currently any notion of an interface to SE Linux to support an IDS?

Leslie French
ljf@semandex.net


-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Russell Coker
Sent: Sunday, June 09, 2002 4:59 AM
To: SE Linux
Subject: auditing etc


What are the future plans for auditing on SE Linux?

I was just speaking to a HP representative about their Linux security
solution (which has GPL kernel code and expensive user-space tools).  The
access control sounds less capable than SE Linux (EG it only controls
read/write/append for files instead of all the operations SE controls).  But
the auditing seems much more capable.  Maybe if SE auditing worked with the
new IBM logging (which complies with the appropriate specs from POSIX for
logging) and logged more data it would address this.

Also would it be possible to have an option in the debugging kernel build to
send a signal 11 to a process that violates the security policy?  It would
make it much easier to find out why it chose to do what I don't want...

--
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
