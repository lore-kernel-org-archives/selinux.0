From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: rules uptimed
Date: Fri, 20 Jun 2003 11:31:56 +1000
References: <200306182130.11056.carstengrohmann@gmx.de> <200306191056.29941.russell@coker.com.au> <200306192133.00539.carstengrohmann@gmx.de>
In-Reply-To: <200306192133.00539.carstengrohmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306201131.56608.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Jun 2003 05:33, Carsten Grohmann wrote:
> Am Donnerstag, 19. Juni 2003 02:56 schrieb Russell Coker:
> > On Thu, 19 Jun 2003 05:34, Carsten Grohmann wrote:
> > > I use the uptimed from unixcode.org/uptimed/ since a few
> > > months. I wrote the rules last days. Feel free to use it....
> >
> > I've attached a version with a few minor changes.
>
> Thank you!
>
> You could also replace readable_t with locale_t. The new policy from
> the CVS used it to label /etc/localtime.

I've changed that to:
r_dir_file(uptimed_t, locale_t)
There are directories and sym-links with the same type...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
