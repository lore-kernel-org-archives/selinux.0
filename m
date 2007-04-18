Subject: RE: using cron in selinux policy
From: Karl MacMillan <kmacmill@redhat.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Michael C Thompson <thompsmc@us.ibm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588A715EF@exchange.columbia.tresys.com>
References: <46253DA7.40003@us.ibm.com>  <4626175D.7030808@redhat.com>
	 <1176907667.11469.1.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588A715EF@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 18 Apr 2007 11:04:10 -0400
Message-Id: <1176908650.11469.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-18 at 10:57 -0400, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmill@redhat.com] 
> > 
> > > 
> > > Causes the same problem.  I also got this to happen with 
> > > ethereal_per_role_template.  Compiler says that the type is defined 
> > > twice, even though I only see it once.  However there is a 
> > > gen_requires of the type before the declaration which might 
> > be causing the problem.
> > > 
> > 
> > That's what is causing the problem - can you just remove the requires?
> > Josh - I thought we were going to do promotion of requires at 
> > one point.
> > Did you decide against that?
> > 
> 
> 
> We fixed declare-then-require but for some reason which I can't think of
> right now did not add promotion of requires. We could fix this now or
> wait for the new parser that won't care, how important is this?

Seems like there was a good reason not to but I can't think of it right
now. I think it is a policy bug - so let's punt.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
