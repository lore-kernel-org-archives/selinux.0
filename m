Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Domain transition
Date: Tue, 17 Dec 2002 10:19:27 +0100
Cc: SELinux@tycho.nsa.gov
References: <200212162125.QAA00730@moss-shockers.ncsc.mil> <200212162307.52976.russell@coker.com.au> <20021216231110.GF15678@snoopy.apana.org.au>
In-Reply-To: <20021216231110.GF15678@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200212171019.27323.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Dec 2002 00:11, Brian May wrote:
> On Mon, Dec 16, 2002 at 11:07:52PM +0100, Russell Coker wrote:
> > (*)  /bin/login has had a good history in terms of security for almost 10
> > years now, unlike sshd.  Also /bin/login can't be accessed anywhere
> > nearly as
>
> Assuming you are not using telnet...

Telnet causes login to be run as remote_login_t which is distinguished from 
the main local_login_t domain for this reason.

Actually we should probably have ifdef(`rlogin.te',` around the definition of 
remote_login_t in login.te, and have a similar ifdef(`login.te', ` in 
rlogin.te.

> (and yes, you can use Kerberos Telnet or SSL-Telnet too, so telnet
> doesn't always have to mean insecure; with these protocols you need to
> be authenticated though before login is run).

SSL-Telnet would be OK apart from it's history of security holes.

Kerberos still isn't safe, proxying the telnet protocol and hijacking it is 
not overly difficult...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
