Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Richard Mayo" <rmayo@caci.com>, SELinux@tycho.nsa.gov
Subject: Re: Basic Question
Date: Mon, 9 Dec 2002 19:24:50 +0100
References: <OF86B3B9F3.740529F3-ON85256C8A.0058C879@caci.com>
In-Reply-To: <OF86B3B9F3.740529F3-ON85256C8A.0058C879@caci.com>
MIME-Version: 1.0
Message-Id: <200212091924.50565.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Dec 2002 17:14, Richard Mayo wrote:
> I have a basic question -- it's something I've assumed, but never
> explicitly checked:
>
> When SELinux is running in permissive mode and an action is attempted that
> violates the security settings, the system logs this event.
> Obviously, if SELinux were running in enforcing mode this action would have
> been denied, but would an entry STILL have been made in the log file?

When a domain_auto_trans causes an attempt to use a domain that is not 
permitted for the role then nothing is logged in enforcing mode - the 
execution just silently fails.  In permissive mode it is allowed and a 
message is logged about an invalid context being generated (and when you 
switch back to enforcing mode the context in question is mapped to 
unlabelled_t from memory).

In all other cases of access being denied the message will be logged in 
enforcing mode (subject to the usual rate limit).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
