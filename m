Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: carstengrohmann@gmx.de
Subject: Re: default_context file
Date: Mon, 4 Nov 2002 09:55:56 +0100
Cc: SELinux@tycho.nsa.gov
References: <200211040048.50097.russell@coker.com.au> <29857.1036399709@www54.gmx.net>
In-Reply-To: <29857.1036399709@www54.gmx.net>
MIME-Version: 1.0
Message-Id: <200211040955.56039.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 4 Nov 2002 09:48, carstengrohmann@gmx.de wrote:
> That's clear, but I give the crond two partial context. But I don't
> understand who select crond the right context for the acutell user. Try
> crond the first partial context for the user and after it failed the next
> and so on?

The type of the file used to store the user's crontab will be uniquely 
determined by the domain that they are using when they run the "crontab -e" 
command.  There should be only one context that will match that file type 
defined in the policy database.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
