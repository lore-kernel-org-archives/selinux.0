Message-Id: <200209301600.QAA13076@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>
Subject: Re: $1_cupsd_spool_t in lpr_macros.te
Date: Mon, 30 Sep 2002 18:01:05 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0209300814270.15004-100000@raven> <200209301524.21731.russell@coker.com.au>
In-Reply-To: <200209301524.21731.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Montag, 30. September 2002 15:24 schrieb Russell Coker:
> On Mon, 30 Sep 2002 14:16, Stephen Smalley wrote:
> > On Mon, 30 Sep 2002, Russell Coker wrote:
> > > I've added such a change to my tree to make it use $1_lpr_spool_t.
> > > Although it has occurred to me that perhaps the best thing to do is
> > > to remove cupsd_spool_t and replace it with lpd_spool_t instead. 
> > > What do you think?
> >
> > Do you mean $1_lpd_spool_t?  There is no $1_lpr_spool_t in my policy.
>
> Yes, I put $1_lpd_spool_t in my policy tree.  Late night...

I am not sure if I understand you right. You replace cupds_spool_t trougth 
lpd_spool_t. 
And added $1_lpd_spool_t? I think this type exist already. Or?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
