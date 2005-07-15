Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6F4fJgA008508
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 00:41:19 -0400 (EDT)
Received: from web31613.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j6F4b4Bp010630
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 04:37:05 GMT
Message-ID: <20050715043742.85440.qmail@web31613.mail.mud.yahoo.com>
Date: Thu, 14 Jul 2005 21:37:42 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: MCS/Targeted Policy...
To: James Morris <jmorris@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0507141155320.13333-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- James Morris <jmorris@redhat.com> wrote:


> > ACLs on sockets have been done in the past,
> > you know, just as has MLS.
> 
> I'd be interested to know where was this done
> (especially a deployed 
> product).

Trusted Irix 4.0.1 through 6.2 had 'em,
and that included the B1 evaluated 4.0.5epl
release. Deployed in more places than I'm
legally allowed to know about. That system
used CIPSO (with CIPSO compliant vendor tag
types) to communicate uid, B&L sensitivity and
Biba integrity.

We dropped them in Trix 6.5 in favor of TSIG
SAMP. That turned out to be an error, it turns
out, as we did it to improve interoperability
with other vendors who had just decided that
interoperabilty was not in their best interests.
Eh, you live and learn.


> ACLs are permissive
> and assign access 
> rights directly to objects.

I'm sorry, I must to slow today. How are ACLs
permissive? An ACL is an explict statement of
who is allowed to access an object, and who is
not.


> > Imagine a system with MCS. If everything
> > and everyone used MCS, all the mode bits
> > could be 777, and you might do that so they
> > would not interfere with the desired MCS
> > activity. Bring that up without SELinux.
> 
> I don't understand this: MCS only further restricts
> secuirty policy
> implemnted via mode bits.  It cannot directly reduce
> the security of the
> system with or without SELinux enabled.

If a system runs with MCS, and the MCS notions
of "good DAC" are prefered to the "traditional
Unix DAC", the system could be run with all
files mod 777 and all DAC supplied by MCS. So
long as the system always runs with MCS you're
fine. If you ran the system with a kernel that
did not enforce MCS the consequences could be
dire. In all, I would not expect that to happen
often, but it could.

> Thanks for the input.

No problem.



Casey Schaufler
casey@schaufler-ca.com


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
