Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>,
        Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: $1_cupsd_spool_t in lpr_macros.te
Date: Mon, 14 Oct 2002 18:11:55 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0210141045370.25372-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0210141045370.25372-100000@raven>
MIME-Version: 1.0
Message-Id: <200210141811.55155.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 14 Oct 2002 16:46, Stephen Smalley wrote:
> On Fri, 11 Oct 2002, Carsten Grohmann wrote:
> > The attached patch is again the actuell CVS state. It change lpd_spool_t
> > and cupsd_spool_t to print_spool_t.
>
> Thanks, merged.
>
> > I think it is better to rename printer_port_t in lpd.te to lpd_port_t --
> > it's more intuitive. Or?
>
> Doesn't matter to me.

Actually it might be best if we renamed ipp_port_t to printer_port_t, I don't 
think that there's enough benefit in having two names to justify it.  
Anything that can bind to one port can probably interfere with the other in 
one way or another anyway...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
