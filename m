Date: Tue, 17 Dec 2002 10:48:54 -0500
From: forrest whitcher <fw@fwsystems.com>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Domain transition -- enabling user_r in eklogin
Message-Id: <20021217104854.6c11dc36.fw@fwsystems.com>
In-Reply-To: <200212171431.52724.russell@coker.com.au>
References: <200212162125.QAA00730@moss-shockers.ncsc.mil>
	<200212171019.27323.russell@coker.com.au>
	<20021217114203.GB5969@snoopy.apana.org.au>
	<200212171431.52724.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Dec 2002 14:31:52 +0100 
Russell Coker <russell@coker.com.au> did inscribe thusly:

> Redirecting a port 23 connection to one on the local machine and then 
> establishing a new connection to the server is quite easy if you control a 
> router.  Going from that to taking over an idle session is quite easy.
> 

Which is a good reason to use eklogin / 3des encription over kerberized
rlogin. 


For which I've been having problems getting an appropriate transition working.
(the following may have some typos I don't have either box running just now
to refer to)

The remote_login domain was clearly designed with telnet in mind, there is
no transtion to user_u:user_r.

Looking this over I moved login.krb5 into the same SID as /bin/login, using
login.te as an example, however once the user's successfully authenticated
the domain remains system_u:system_r and 'newrole(1)' is not available.

I'm going somewhat from memory so there may be some missed details, however
I've tried re-configuring several times without much luck.

Also this test is being done on a slackware setup, because I was able to
get telnetd working in a redhat system more easily there may be some system 
layout issues causing problems, not sure yet.

forrest

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
