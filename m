Date: Tue, 17 Dec 2002 22:42:03 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Domain transition
Message-ID: <20021217114203.GB5969@snoopy.apana.org.au>
References: <200212162125.QAA00730@moss-shockers.ncsc.mil> <200212162307.52976.russell@coker.com.au> <20021216231110.GF15678@snoopy.apana.org.au> <200212171019.27323.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212171019.27323.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 17, 2002 at 10:19:27AM +0100, Russell Coker wrote:
> > (and yes, you can use Kerberos Telnet or SSL-Telnet too, so telnet
> > doesn't always have to mean insecure; with these protocols you need to
> > be authenticated though before login is run).
> 
> SSL-Telnet would be OK apart from it's history of security holes.

Yes. At one stage a group of Debian developers looked at 2 to 4
different implementations of SSL-Telnet, trying to work out which
was the best one.

The conclusion, IIRC, was that all of them were pretty awful,
just some had more features then others.

> Kerberos still isn't safe, proxying the telnet protocol and hijacking it is 
> not overly difficult...

Do you have a reference?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
