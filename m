Date: Tue, 17 Dec 2002 10:11:10 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, SELinux@tycho.nsa.gov,
        rmayo@caci.com
Subject: Re: Domain transition
Message-ID: <20021216231110.GF15678@snoopy.apana.org.au>
References: <200212162125.QAA00730@moss-shockers.ncsc.mil> <200212162307.52976.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212162307.52976.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 16, 2002 at 11:07:52PM +0100, Russell Coker wrote:
> (*)  /bin/login has had a good history in terms of security for almost 10 
> years now, unlike sshd.  Also /bin/login can't be accessed anywhere nearly as 

Assuming you are not using telnet...

(and yes, you can use Kerberos Telnet or SSL-Telnet too, so telnet
doesn't always have to mean insecure; with these protocols you need to
be authenticated though before login is run).
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
