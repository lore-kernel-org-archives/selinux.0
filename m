From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Akshay Gangam <gvakshay@yahoo.com>
Subject: Re: Hello !
Date: Mon, 14 Apr 2003 11:16:02 +1000
Cc: SELinux@tycho.nsa.gov
References: <20030413040819.61929.qmail@web20809.mail.yahoo.com>
In-Reply-To: <20030413040819.61929.qmail@web20809.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304141116.02696.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 13 Apr 2003 14:08, Akshay Gangam wrote:
> At present I have a pc with Redhat 7.3 and selinux
> version Rel: 2003011510 on my school machine
> and Redhat 8.0 at home.
>
> Is it better to work on the new releases and the great
> tools, that come with them ? Were does one start from
> ... ?

I recommend using the latest release.  Most people on the list are focussed on 
the new release and you will probably get faster answers to your questions if 
they concern the latest version.

When you have a suitable development machine running SE Linux in enforcing 
mode the first learning task would be to try writing some new security policy 
for a new daemon, or fixing some problems that are in the current policy.
It's likely that some reasonable task you want to do is being prevented by 
policy, so fixing that and sending the change to the list (if it's something 
that's generally useful) would be a good first step.

Apart from that, what you do depends on what your skills and interests are.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
