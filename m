Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, SELinux@tycho.nsa.gov
Subject: Re: default_context file
Date: Thu, 7 Nov 2002 22:52:08 +0100
References: <200211072021.PAA07355@moss-shockers.ncsc.mil>
In-Reply-To: <200211072021.PAA07355@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200211072252.08296.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Nov 2002 21:21, Stephen D. Smalley wrote:
> I'm not sure I follow you.  crond still performs a check between the user
> context that will be used for the cron job process [obtained by asking the

After further consideration I agree with you that this is OK.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
