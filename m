Message-Id: <200208021050.KAA06618@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: system_r and apm_t
Date: Fri, 2 Aug 2002 12:49:37 +0200
References: <200208020910.JAA06405@jazzband.ncsc.mil> <20020802095109.3403F7FB9@lyta.coker.com.au>
In-Reply-To: <20020802095109.3403F7FB9@lyta.coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This time I write rules to adapt SuSE on the original SELinux rules. I 
don't want rewrite SuSE to become it more secure. 

In this case I need for a cronjob access to apm_t via domain_auto_trans.

Your policy and the nsa policy are different. Do you merge you policy to 
the nsa policy periodical? 

Carsten

Am Freitag, 2. August 2002 11:51 schrieb Russell Coker:
> On Fri, 2 Aug 2002 11:11, Carsten Grohmann wrote:
> > Hi!
> >
> > I think we should give the system_r access to apm_t
> > with
> > role system_r types apm_t;
> > After this some system scripts can use the apm_t domain.
>
> Makes sense to me.  I've added that to my tree and also made the apm_t
> domain have enough access to run "apm -s" (which had somehow got lost
> along the way).
>
> It's on http://www.coker.com.au/selinux/policy.tgz
>
> Also what domain do you want to transition to apm_t?  Do you need an
> auto_trans rule from initrc_t?

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
