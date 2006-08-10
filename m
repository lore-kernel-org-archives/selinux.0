Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7AG1UJs008310
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 12:01:30 -0400
Received: from web36611.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7AG1DuR007557
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 16:01:13 GMT
Message-ID: <20060810160129.77778.qmail@web36611.mail.mud.yahoo.com>
Date: Thu, 10 Aug 2006 09:01:29 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: does mv need a --context=CTX (-Z) option, too?
To: Daniel J Walsh <dwalsh@redhat.com>, casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <44DB5696.5000102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Daniel J Walsh <dwalsh@redhat.com> wrote:


> I am saying cp should not have a qualified where you
> specify the 
> context.  It should either default to the ordinary
> system behaviour or 
> if preserve is set try to maintain the file context.

Sound reasoning.

> Since cp does not have a -mode= or -owner= it
> probably should not have a 
> -context=

Those who advocate commands with lots of
options would say there should be -mode=
and -owner= as well. There is some logic
based on the value of atomic operations to
support that stand, and context is something
that really ought to be set correctly at all
times. I'm good with classic behavior.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
