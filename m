Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dale Amon <amon@vnl.com>
Subject: Re: have you seen spfx2.c?
Date: Wed, 5 Dec 2001 12:44:59 +0100
Cc: SELinux@tycho.nsa.gov
References: <E16ALyE-000BX7-00@f6.mail.ru> <Pine.BSO.4.33.0112021406500.3173-100000@ausmac.net> <20011203151621.A7873@vnl.com>
In-Reply-To: <20011203151621.A7873@vnl.com>
MIME-Version: 1.0
Message-Id: <20011205174017.6F8B933165F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 3 Dec 2001 16:16, Dale Amon wrote:
> The logic fails in real life. There is one kernel,
> written by experts. There are tens if not hundreds of
> thousands of apps, written by novices, experts, people
> who listen, people who don't listen, supported,
> unsupported...

This thread shouldn't be dragging on, but I feel that there are a couple of 
crucial points that are being missed.

Firstly there is the issue of multiple levels of protection.  I have three 
locked doors leading to my apartment which I believe gives me significant 
benefits over having only a single locked door.  When I setup co-located 
servers I run packet filters on the servers and also get the ISP to put a 
firewall in place.  Similarly I expect that having two sub-systems trying to 
achieve the same security result by different methods (daemons that don't 
have security holes and a kernel to limit the access the daemons get) is 
worth-while.

The next issue is that even good programmers make mistakes occasionally.  I 
consider the author of Postfix to be one of the best programmers in the 
world, he really knows how to code and really knows security.  In spite of 
this I plan to limit the access Postfix gets to my system, even the best 
programmers can make mistakes occasionally, and besides the person who 
compiled it could have done something wrong.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
