Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: system_r and apm_t
Date: Fri, 2 Aug 2002 11:51:08 +0200
References: <200208020910.JAA06405@jazzband.ncsc.mil>
In-Reply-To: <200208020910.JAA06405@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <20020802095109.3403F7FB9@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2 Aug 2002 11:11, Carsten Grohmann wrote:
> Hi!
>
> I think we should give the system_r access to apm_t
> with
> role system_r types apm_t;
> After this some system scripts can use the apm_t domain.

Makes sense to me.  I've added that to my tree and also made the apm_t domain 
have enough access to run "apm -s" (which had somehow got lost along the way).

It's on http://www.coker.com.au/selinux/policy.tgz

Also what domain do you want to transition to apm_t?  Do you need an 
auto_trans rule from initrc_t?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
