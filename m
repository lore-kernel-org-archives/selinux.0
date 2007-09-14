Subject: Re: concept of a permissive domain
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: jwcart2@epoch.ncsc.mil, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <46EA9E7F.8080405@manicmethod.com>
References: <1189537981.3407.51.camel@localhost.localdomain>
	 <46E6FB25.5070507@redhat.com>
	 <1189545987.4823.6.camel@localhost.localdomain>
	 <1189692512.18713.61.camel@moss-spartans.epoch.ncsc.mil>
	 <1189694812.3538.20.camel@localhost.localdomain>
	 <1189695443.18713.95.camel@moss-spartans.epoch.ncsc.mil>
	 <46E98E93.40206@redhat.com>
	 <1189712298.18713.116.camel@moss-spartans.epoch.ncsc.mil>
	 <1189779337.30367.59.camel@moss-lions.epoch.ncsc.mil>
	 <46EA9E7F.8080405@manicmethod.com>
Content-Type: text/plain
Date: Fri, 14 Sep 2007 11:15:37 -0400
Message-Id: <1189782937.11407.3.camel@kmacmill-desktop>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-14 at 10:45 -0400, Joshua Brindle wrote:
> James Carter wrote:
> > On Thu, 2007-09-13 at 15:38 -0400, Stephen Smalley wrote:

[...]

> >
> > If this was called a debug domain instead of a permissive domain, would
> > it be acceptable to change the behavior of dontaudit and other things as
> > needed to assist in debugging?  
> >
> > If there were debug domains, however, it is not hard to imagine that
> > soon people would be declaring how much easier it is to just run an
> > application as a debug domain and add dontaudit rules to deny what the
> > application isn't suppose to do.  
> >
> > The problem that does need to be addressed is how to prevent certain
> > code paths from being followed in permissive/debug mode.  Maybe deny
> > rules are the best answer.
> >   
> 
> Since we moved to a avtab datum that is only 1 vector and are now 
> packing different avtab entry types into the key we could easily make a 
> new kind of entry, I suggest we call it "reallydontaudit"
> 
> Seriously though, FWIW I like Steves idea of setting permissive on a 
> domain via selinuxfs (in fact I had a similar idea on my own before he 
> posted it here). It wouldn't be appropriate to put permissive in the 
> policy and load it so why would it be to do so at a higher granularity? 

Why wouldn't it be appropriate to put permissive in the policy?

> Also this would let you easily put something into permissive 
> temporarilly without reloading the policy over and over. Nothing 
> prevents us from adding functionality to semanage and putting an init 
> script in place for boot time permissive (though doing so does have some 
> atomicity issues, just like compat_net and friends :\)
> 

Why cause all of these problems and require building all of this extra
functionality when you can just put this in the policy? I really don't
get why we want to put some data in the policy and communicate some
through other means.

Even booleans at this point - there is almost no reason to set those via
selinuxfs. I'd rather just focus on making loading policy more efficient
and communicate all of that state that way.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
