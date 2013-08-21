Message-ID: <1377100700.25761.26.camel@d30>
Subject: Re: Programmatic domain change to unprivileged role
From: Dominick Grift <dominick.grift@gmail.com>
To: Dan Pou <danielp@sgi.com>
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>
Date: Wed, 21 Aug 2013 17:58:20 +0200
In-Reply-To: <20130821140533.GM28332@localhost>
References: <20130805190732.GT18909@localhost>
	 <52015950.9010906@tycho.nsa.gov> <20130806203751.GA14875@localhost>
	 <52023D7D.7040409@tycho.nsa.gov> <52024071.4000206@tycho.nsa.gov>
	 <20130808195857.GB23152@localhost> <5204E5C5.1050802@tycho.nsa.gov>
	 <20130820200546.GL28332@localhost> <1377071660.21409.15.camel@d30>
	 <20130821140533.GM28332@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2013-08-21 at 09:05 -0500, Dan Pou wrote:

> > Some things ( but i am not sure ):
> > 
> > The target role needs to be associated to the identity (probably already
> > done)
> > The target role needs to be associated to the target domain (probably
> > already done)
> > The source role needs to be allowed to manually change to the target
> > role (probably already done)
> > 
> > The source domain needs various permissions to change identity, role,
> > and set mls range (policy constraints: mlsprocsetsl
> > can_change_process_identity can_change_process_role )
> > The target security level must be within range of the selinux identity
> > associated level, range)
> > 
> > You probably need to specify the entrypoint to the target domain
> > You probably need to allow the actual transition permission from source
> > domain to target domain (allow my_daemon_t user_t:process transition)
> 
> Wouldn't these settings be associated with AVC denials?  I am running
> Permissive and have no denials showing up.
> 

I am not sure but here is what i think:

The function uses the policy to see if theres a valid path to the target
context by querying the policy used for calculation

So if the policy does not define a path the function will fail/abort,
thus it wont try it because it already determined that it wouldnt work
anyways. So you wont see ant avc denials because it didnt even try it

> > 
> > As far as i know, the function calculates if what you specified is valid
> > first
> > 
> > I do not think you need a automatic role transition rule (it changes
> > manually instead i believe)
> 
> I thought you still needed to specify a transition with setexeccon. Is
> this not true?

I am not sure, but again, i believe that no automatic role transition is
needed


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
