Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: route
Date: Fri, 6 Sep 2002 11:50:49 +0200
References: <200209041730.RAA29245@jazzswing.ncsc.mil> <200209051447.59613.russell@coker.com.au> <200209051913.TAA13083@jazzband.ncsc.mil>
In-Reply-To: <200209051913.TAA13083@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200209061150.49622.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 5 Sep 2002 21:13, Carsten Grohmann wrote:
> Am Donnerstag, 5. September 2002 14:47 schrieb Russell Coker:
> > On Wed, 4 Sep 2002 19:27, Carsten Grohmann wrote:
> > > attached is the rule set for the route_t domain.
> > > I am glad if anybody use it.
> >
> > What problem does this solve?  Why is it that route can't just be run in
> > the context of the program that called it?
>
> I use it in the rules for the ipppd_t domain. Through ipppd_t don't need
> access to execute all sbin_t programms.
> Or do you think this is not neseccary?

Why do you need a separate ipppd_t domain?  Surely the best thing would be to 
just give pppd_t access to the ISDN devices...

pppd_t can execute sbin_t binaries, this is needed for ip-up scripts...

I think it would be a better solution to have ipppd run in the pppd_t domain 
and to allow it to run /sbin/route in the pppd_t domain as well.

One problem with creating lots of domains is that it makes the policy more 
complex, more difficult to audit, and more difficult for new users to manage 
(which will decrease the popularity of SE Linux).  I try and avoid creating a 
new domain unless there is a clear well defined security benefit.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
