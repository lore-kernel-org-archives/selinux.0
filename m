From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: policy patch
Date: Fri, 26 Nov 2004 06:05:09 +1100
Cc: SELinux List <SELinux@tycho.nsa.gov>
References: <200411260027.41899.russell@coker.com.au> <20041125163232.GA26737@lkcl.net>
In-Reply-To: <20041125163232.GA26737@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411260605.12580.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 26 November 2004 03:32, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
wrote:
> On Fri, Nov 26, 2004 at 12:27:39AM +1100, Russell Coker wrote:
> > The attached patch makes some trivial policy changes.
> >
> > Allows Debian systems to touch /etc from an init script.
>
>  i fixed the /etc/init.d script which does the /etc touching,
>  sent a patch to the maintainer of initscripts.

Great!  Now when will that patch go into Debian/main?

>  afaik, this is the only reason for allowing debian init
>  scripts to write to /etc and it's not a very good one!

I agree.  But until the script gets fixed I think I have to do this to stop 
systems failing to correctly boot.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
