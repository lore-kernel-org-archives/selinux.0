Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Domain transition
Date: Tue, 17 Dec 2002 14:31:52 +0100
Cc: SELinux@tycho.nsa.gov
References: <200212162125.QAA00730@moss-shockers.ncsc.mil> <200212171019.27323.russell@coker.com.au> <20021217114203.GB5969@snoopy.apana.org.au>
In-Reply-To: <20021217114203.GB5969@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200212171431.52724.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Dec 2002 12:42, Brian May wrote:
> > Kerberos still isn't safe, proxying the telnet protocol and hijacking it
> > is not overly difficult...
>
> Do you have a reference?

Is one really needed?

Redirecting a port 23 connection to one on the local machine and then 
establishing a new connection to the server is quite easy if you control a 
router.  Going from that to taking over an idle session is quite easy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
