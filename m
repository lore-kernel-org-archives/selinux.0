Message-Id: <200209051913.TAA13083@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: route
Date: Thu, 5 Sep 2002 21:13:37 +0200
References: <200209041730.RAA29245@jazzswing.ncsc.mil> <200209051447.59613.russell@coker.com.au>
In-Reply-To: <200209051447.59613.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Donnerstag, 5. September 2002 14:47 schrieb Russell Coker:
> On Wed, 4 Sep 2002 19:27, Carsten Grohmann wrote:
> > attached is the rule set for the route_t domain.
> > I am glad if anybody use it.
>
> What problem does this solve?  Why is it that route can't just be run in
> the context of the program that called it?

I use it in the rules for the ipppd_t domain. Through ipppd_t don't need 
access to execute all sbin_t programms. 
Or do you think this is not neseccary?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
