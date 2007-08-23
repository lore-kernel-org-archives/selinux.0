Subject: Re: [PATCH] genhomedircon: fix find() return value usage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: "Todd C. Miller" <tmiller@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <46CB32F6.3000106@manicmethod.com>
References: <200708202032.l7KKWWCY009001@tex.courtesan.com>
	 <46CB32F6.3000106@manicmethod.com>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 09:40:20 -0400
Message-Id: <1187876420.1451.482.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-21 at 14:46 -0400, Joshua Brindle wrote:
> Todd C. Miller wrote:
> > This patch fixes a bug in the genhomedircon python script that would
> > ignore valid entries such as:
> >
> > /tmp/\.exchange-USER(/.*)?  system_u:object_r:ROLE_evolution_exchange_tmp_t:s0
> >
> > With this fix the python genhomedircon and the C replacement produce
> > equivalent output.
> >
> >   
> Note that this is for the stable branch only, since it conflicts with 
> the pending genhomedircon replacement patch for trunk. Does anyone 
> object to this going into stable?

I'll actually merge it to both trunk and stable - we should have a fixed
version on both prior to merging the new functionality (if it ever
works).

> 
> > Signed-Off-By: Todd Miller <tmiller@tresys.com>
> >
> > Index: policycoreutils/scripts/genhomedircon
> > ===================================================================
> > --- policycoreutils/scripts/genhomedircon	(revision 2519)
> > +++ policycoreutils/scripts/genhomedircon	(working copy)
> > @@ -272,7 +272,7 @@
> >  		ret = ""
> >  		fd = open(self.getHomeDirTemplate(), 'r')
> >  		for i in  fd.readlines():
> > -			if i.find("USER") == 1:
> > +			if i.find("USER") >= 0:
> >  				i = i.replace("USER", user)
> >  				i = i.replace("ROLE", prefix)
> >  				i = i.replace("system_u", sel_user)
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> >   
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
