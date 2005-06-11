Message-ID: <20050611184522.51251.qmail@web51505.mail.yahoo.com>
Date: Sat, 11 Jun 2005 11:45:22 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Question about integration of IPsec with SELinux?
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050611172750.41238.qmail@web31601.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 11 Jun 2005 at 10:27, Casey Schaufler wrote:

> IPSEC is the forward looking mechanism for
> passing process attributes between machines.

What is the meaning of "forward looking mechanism"?
Why it it called so? 

> Without it (or one of the protocols that
> preceeded it but have fallen from favor)
> there is no way to make access control decisions
> on network based communications. 

Do you mean that we can't make access control
decisions if we do not use IPsec?

> You can't
> do an MLS cluster, for example, without passing
> sensitivity and clearance information among
> the machines involved. There are plans afoot
> to produce an SELinux based MLS system, and
> without networking capabilties the market
> opportunity is too small to consider.

What does "networking capabilities" mean here?


Thank you




Best Regards,
Park Lee


		
__________________________________ 
Discover Yahoo! 
Get on-the-go sports scores, stock quotes, news and more. Check it out! 
http://discover.yahoo.com/mobile.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
