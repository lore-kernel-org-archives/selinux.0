Message-Id: <200208021450.OAA20771@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: system_r and apm_t
Date: Fri, 2 Aug 2002 16:33:54 +0200
References: <200208020910.JAA06405@jazzband.ncsc.mil> <20020802105144.A01F0FA93@ivanova.coker.com.au> <20020802113727.99614181@lyta.coker.com.au>
In-Reply-To: <20020802113727.99614181@lyta.coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Freitag, 2. August 2002 13:37 schrieb Russell Coker:
> On Fri, 2 Aug 2002 12:49, Carsten Grohmann wrote:
> > This time I write rules to adapt SuSE on the original SELinux rules. I
> > don't want rewrite SuSE to become it more secure.
>
> You will probably discover that it's impossible to do that without
> compromising security in some ways.

I want link to make minimal changes.


> > In this case I need for a cronjob access to apm_t via
> > domain_auto_trans.
>
> Cronjob as sysadm_crond_t I guess?

I would use an other type, like xxx_cronjob_t. This type was create via a 
macro similar crond_domain, but without the full access to sysadm_home_t.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
