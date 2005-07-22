Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MFp7gA006705
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:51:07 -0400 (EDT)
Received: from web34309.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j6MFjXKk010305
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:45:33 GMT
Message-ID: <20050722154606.21958.qmail@web34309.mail.mud.yahoo.com>
Date: Fri, 22 Jul 2005 08:46:06 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: RE: Iptables discussion
To: Karl MacMillan <kmacmillan@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, gyurdiev@redhat.com
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Karl MacMillan <kmacmillan@tresys.com> wrote:


> I know that this is just a motivating example, but I
> feel compelled to point out
> that 1) this problem is not really related to MLS in
> the real world and 

On the contrary, it is a commonly requested
scenario, not always with web services but
often enough. Frequently the situation is an
application written and owned by a 3rd party
that provides a "special" service of some kind.
Running two servers, one at Secret, one at
TopSecret is the mode they prefer.

> 2)
> separation based on ports is _very_ unlikely to meet
> the requirements of a
> system that will be processing data at different
> sensitivities.

It is done all the time. Yes, policy enforcing
trusted applications are better, but y'all don't
seem to have an interface for doing that, and
most users couldn't change the applications
anyway.

In Trix 4 we had polyinstantiated sockets. We
dropped them in Trix 6 to be more like the
other systems available at the time. I don't
think anyone noticed because everyone was
already doing "a server per label".




Casey Schaufler
casey@schaufler-ca.com


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
