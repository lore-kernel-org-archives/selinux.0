Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Richard Mayo" <rmayo@caci.com>, SELinux@tycho.nsa.gov
Subject: Re: Another Question
Date: Mon, 9 Dec 2002 19:38:19 +0100
References: <OFAAAC925F.D0402904-ON85256C8A.0062154E@caci.com>
In-Reply-To: <OFAAAC925F.D0402904-ON85256C8A.0062154E@caci.com>
MIME-Version: 1.0
Message-Id: <200212091938.19290.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Dec 2002 18:53, Richard Mayo wrote:
> While running in enforcing mode, is it possible to allow certain actions,
> but still to audit their occurences?

auditallow.

> (perhaps with some command working the opposite of "neveraudit")

dontaudit.


These are used in the sample policy.  dontaudit is a newer addition so it's 
not in the earlier documents, but it should be in the latest doco, auditallow 
is well documented.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
