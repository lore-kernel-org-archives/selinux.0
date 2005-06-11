Message-ID: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com>
Date: Sat, 11 Jun 2005 12:49:52 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Question about integration of IPsec with SELinux? 
To: Valdis.Kletnieks@vt.edu, Park Lee <parklee_sel@yahoo.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <200506111918.j5BJIeQp015251@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Valdis.Kletnieks@vt.edu wrote:

> (I'm guessing that OpenSSH was one of the "other
> protocols" Casey mentioned -
> it's *very* useful in it's problem space, but isn't
> the best choice for *this*
> problem (building an MLS cluster)...)

The higher level the protocol the fewer system
services (e.g. NFS) that you can use it for.

> > What does "networking capabilities" mean here?
> 
> Nobody is interested in doing a single-system MLS
> that can't talk to the
> network (or at least, few enough that there's no
> market for it).  On the
> other hand, if you can deploy it across all the
> servers in the machine room,
> then it gets interesting.

Valdis has the nut of it.

Perhaps I should have said "facilities" or
"useful features". English is not always a
great language.



Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Discover Yahoo! 
Get on-the-go sports scores, stock quotes, news and more. Check it out! 
http://discover.yahoo.com/mobile.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
