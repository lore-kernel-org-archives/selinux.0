Message-Id: <200209301811.SAA29102@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: $1_cupsd_spool_t in lpr_macros.te
Date: Mon, 30 Sep 2002 20:04:39 +0200
References: <200209291121.LAA25284@jazzband.ncsc.mil> <20020930064925.7A616BF1B@sat.sws.net.au> <200209301021.48501.russell@coker.com.au>
In-Reply-To: <200209301021.48501.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Montag, 30. September 2002 10:21 schrieb Russell Coker:
> I've added such a change to my tree to make it use $1_lpr_spool_t. 
> Although it has occurred to me that perhaps the best thing to do is to
> remove cupsd_spool_t and replace it with lpd_spool_t instead.  What do
> you think?

I am not sure. I my opinion is a serparate type per domain the better 
solution. It is more clear in contrast to domains which use other domains 
types special _tmp_t and spool_t types.
But we could use an generic type like print_spool_t instead of lpd_spool_t 
and cupsd_spool_t.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
