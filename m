Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6I43r9Y002605
	for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2006 00:03:53 -0400
Received: from web36614.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k6I43qVm011225
	for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2006 04:03:52 GMT
Message-ID: <20060718040351.72079.qmail@web36614.mail.mud.yahoo.com>
Date: Mon, 17 Jul 2006 21:03:51 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 0/6] netfilter integration
To: Joshua Brindle <jbrindle@tresys.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <44BC28BB.1080701@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Joshua Brindle <jbrindle@tresys.com> wrote:

> in reality probably 3 priorities would be
> sufficient. Specific port, 
> port range and fallback. Its very doubtful that
> anything else would be 
> necessary, especially in modules where the priority
> is much more 
> important than in base. A module will very rarely
> have something more 
> specific than ports, and since ports are
> non-overlapping it doesn't 
> matter what order they are in (within a single
> priority)

OKay.

> > Speaking of dependencies, wouldn't a
> > mechanism to declare dependencies a'la
> > make be more precise? Just a thought.
> > 
> > 
> eh? Policy modules already declare symbol
> dependencies explicitly (eg., 
> which types, roles, etc this module uses)

I was thinking it terms of explict ordering
of priorities rather than definition, but
it seems you have it well in hand.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
