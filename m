Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: route
Date: Thu, 5 Sep 2002 14:47:59 +0200
References: <200209041730.RAA29245@jazzswing.ncsc.mil>
In-Reply-To: <200209041730.RAA29245@jazzswing.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200209051447.59613.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Sep 2002 19:27, Carsten Grohmann wrote:
> attached is the rule set for the route_t domain.
> I am glad if anybody use it.

What problem does this solve?  Why is it that route can't just be run in the 
context of the program that called it?

The kernel source comments suggest that net_admin capability is needed for 
changing routes, but sysadm_t doesn't have that and can still change routes.  
It seems that you're not giving route_t any other access than net_admin...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
