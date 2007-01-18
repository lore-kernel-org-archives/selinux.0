Subject: Re: polyinstantiation, what should happen?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Linda Knippers <linda.knippers@hp.com>
Cc: Xavier Toth <txtoth@gmail.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <45AEB5DC.9060105@hp.com>
References: <cadfc0e40701171501j5ebbc57fn6ea9c652fbcc946b@mail.gmail.com>
	 <45AEB5DC.9060105@hp.com>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 09:55:56 -0500
Message-Id: <1169132156.22731.263.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-01-17 at 18:48 -0500, Linda Knippers wrote:
> Xavier Toth wrote:
> > I'm running the lspp.63 kernel along with the latest pam and newrole
> > off of Dan Walsh' people page.
> > 
> > I've configured polyinstantiation but it doesn't work the way I
> > thought it would so either I don't understand or I've got it
> > configured wrong. In namespace.conf I've specified that I want context
> > to be used for the polyinstantiated instance directories but I only
> > getting the user name. Shouldn't the directory name contain the entire
> > an context?
> 
> Perhaps.  I think the method field specifies when you want to polyinstantiate,
> not necessarily what the instance names are, although it makes sense that
> the directories would be named using the context and the user name.
> I use "level" instead of "context" on my system and I get directory names that
> have the full context, including level, plus the user name.  By specifying
> "level" but I only get a new instance when I change levels, not when I change
> roles.
> 
> My namespace.conf looks like this, if you want to give that a try:
> /tmp     /tmp/tmp-inst/         level      root,adm
> /var/tmp /var/tmp/tmp-inst/     level      root,adm
> $HOME    /home/home.inst/       level      root,adm

Yes, use "level" - see the earlier discussion on redhat-lspp.
Dan - should "context" trigger a warning or error until such a time as
it is correctly supported?

> > Also I'm running X so I followed the instructions on the pam_namespace
> > man page but wasn't sure whether /etc/pam.d/gdm needed unmnt_remnt as
> > su and newrole do?

It shouldn't, since there is no prior bind mount to unmount in the gdm
case.  Not sure how well gdm will play with pam_namespace though; we
couldn't use pam_selinux with gdm but instead had to patch it directly
IIRC.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
