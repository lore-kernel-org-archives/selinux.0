Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: $1_cupsd_spool_t in lpr_macros.te
Date: Sat, 12 Oct 2002 19:42:30 +0200
References: <200209291121.LAA25284@jazzband.ncsc.mil> <200209302209.18919.russell@coker.com.au> <20021011140352.2763BBF22@sat.sws.net.au>
In-Reply-To: <20021011140352.2763BBF22@sat.sws.net.au>
MIME-Version: 1.0
Message-Id: <200210121942.30718.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 11 Oct 2002 16:03, Carsten Grohmann wrote:
> Am Montag, 30. September 2002 22:09 schrieb Russell Coker:
> > > I am not sure. I my opinion is a serparate type per domain the better
> > > solution. It is more clear in contrast to domains which use other
> > > domains types special _tmp_t and spool_t types.
> > > But we could use an generic type like print_spool_t instead of
> > > lpd_spool_t and cupsd_spool_t.
> >
> > Sounds like a good idea to me!
> >
> > Also maybe we should make even more integration between CUPS policy and
> > lpd policy.
> >
> > I look forward to further patches from you in this regard.
>
> The attached patch is again the actuell CVS state. It change lpd_spool_t
> and cupsd_spool_t to print_spool_t.
>
> I think it is better to rename printer_port_t in lpd.te to lpd_port_t --
> it's more intuitive. Or?

I think your patch is great, I've added it to my tree.

I'm about to release a new version.  After this I don't anticipate doing any 
more serious policy work for a while (I've got to port the SE patches to the 
latest versions of all the utils and I've got a few other things to work on).

Anyway I hope that from now on I won't need to be so seriously involved in 
writing policy, I think that you, Brian, and Tom should have it under 
control.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
