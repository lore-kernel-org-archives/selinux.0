Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: $1_cupsd_spool_t in lpr_macros.te
Date: Mon, 30 Sep 2002 22:09:18 +0200
References: <200209291121.LAA25284@jazzband.ncsc.mil> <200209301021.48501.russell@coker.com.au> <200209301811.SAA29102@jazzband.ncsc.mil>
In-Reply-To: <200209301811.SAA29102@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200209302209.18919.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Sep 2002 20:04, Carsten Grohmann wrote:
> Am Montag, 30. September 2002 10:21 schrieb Russell Coker:
> > I've added such a change to my tree to make it use $1_lpr_spool_t.
> > Although it has occurred to me that perhaps the best thing to do is to
> > remove cupsd_spool_t and replace it with lpd_spool_t instead.  What do
> > you think?
>
> I am not sure. I my opinion is a serparate type per domain the better
> solution. It is more clear in contrast to domains which use other domains
> types special _tmp_t and spool_t types.
> But we could use an generic type like print_spool_t instead of lpd_spool_t
> and cupsd_spool_t.

Sounds like a good idea to me!

Also maybe we should make even more integration between CUPS policy and lpd 
policy.

I look forward to further patches from you in this regard.

I've just put a new policy archive online at 
http://www.coker.com.au/selinux/policy.tgz , you may want to use that to base 
your work on as it's got all the necessary patches for home_root_t, xauth, 
etc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
