Date: Wed, 18 Dec 2002 09:16:41 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Domain transition
Message-ID: <20021217221641.GA3669@snoopy.apana.org.au>
References: <200212162125.QAA00730@moss-shockers.ncsc.mil> <200212171019.27323.russell@coker.com.au> <20021217114203.GB5969@snoopy.apana.org.au> <200212171431.52724.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212171431.52724.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 17, 2002 at 02:31:52PM +0100, Russell Coker wrote:
> On Tue, 17 Dec 2002 12:42, Brian May wrote:
> > > Kerberos still isn't safe, proxying the telnet protocol and hijacking it
> > > is not overly difficult...
> >
> > Do you have a reference?
> 
> Is one really needed?
> 
> Redirecting a port 23 connection to one on the local machine and then 
> establishing a new connection to the server is quite easy if you control a 
> router.  Going from that to taking over an idle session is quite easy.

Not if you have encryption enabled...
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
