Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: $1_cupsd_spool_t in lpr_macros.te
Date: Sun, 29 Sep 2002 18:59:41 +0200
References: <200209291121.LAA25284@jazzband.ncsc.mil> <200209291343.46606.russell@coker.com.au> <20020929161517.BDCF3BEE1@sat.sws.net.au>
In-Reply-To: <20020929161517.BDCF3BEE1@sat.sws.net.au>
MIME-Version: 1.0
Message-Id: <200209291859.41395.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 29 Sep 2002 18:07, Carsten Grohmann wrote:
> Am Sonntag, 29. September 2002 13:43 schrieb Russell Coker:
> > On Sun, 29 Sep 2002 12:29, Carsten Grohmann wrote:
> > > the attached patch add cups support in lpr_domain. You can pipe some
> > > data to lpr with this additional rules.
> >
> > Won't you also need something like the following?
> > allow cupsd_t $1_cupsd_spool_t:file { r_file_perms unlink };
>
> No. I try the new rules and it runs fine.

So how does $1_cupsd_spool_t get accessed by the print server?  What is done 
with the $1_cupsd_spool_t?  Is it just a temporary file that the lpr just 
writes and then reads back?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
