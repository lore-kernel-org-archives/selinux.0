Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7AFlQ7T007795
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 11:47:26 -0400
Received: from web36608.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7AFl9uR005427
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 15:47:09 GMT
Message-ID: <20060810154720.5951.qmail@web36608.mail.mud.yahoo.com>
Date: Thu, 10 Aug 2006 08:47:20 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: does mv need a --context=CTX (-Z) option, too?
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <44DB4585.3070500@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Daniel J Walsh <dwalsh@redhat.com> wrote:


> I agree cp should not need this qualifier.  It
> should either be preserve 
> or get the new default context.

Classic Unix philosophy is that mv maintains
attributes (moves an object) while cp does
not (creates a new object) except as explicitly
requested. Hence, it's OK for cp to have this
option but not mv. If anything, mv might have
an option that only allows the move if all
attributes can be maintained.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
