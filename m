Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76G32rT013187
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 12:03:02 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76G2STZ009412
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 16:02:28 GMT
Message-ID: <002201c47bce$22783840$0102a8c0@DESKTOP>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>, <selinux@tycho.nsa.gov>
Cc: "Russell Coker" <russell@coker.com.au>,
   "Daniel J Walsh" <dwalsh@redhat.com>, <selinux-dev@tresys.com>
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com> <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil> <1091709011.11061.44.camel@moss-spartans.epoch.ncsc.mil> <1091709228.11061.47.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: Now that SELinux supports booleans should we replace tunableswith booleans?
Date: Fri, 6 Aug 2004 11:57:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


----- Original Message ----- 
From: "Stephen Smalley" <sds@epoch.ncsc.mil>
To: <selinux@tycho.nsa.gov>
Cc: "Russell Coker" <russell@coker.com.au>; "Daniel J Walsh"
<dwalsh@redhat.com>; <selinux-dev@tresys.com>
Sent: Thursday, August 05, 2004 8:33 AM
Subject: RE: Now that SELinux supports booleans should we replace
tunableswith booleans?


> On Thu, 2004-08-05 at 08:30, Stephen Smalley wrote:
> > Dan has raised the issue of how to handle policy reloads when using
> > booleans, as a policy reload will reset the boolean values to the
> > compile-time default settings.  We could certainly extend load_policy to
> > also set the booleans based on the same configuration file used at boot
> > time, but that will leave open a window between the policy reload and
> > the setting of the booleans where the active policy will fall back to
> > the compile-time defaults.  That could break running processes or create
> > a window of vulnerability, depending on whether the compile-time
> > defaults are more secure or less secure than the configuration file
> > settings.  We could have the policy Makefile patch the boolean default
> > settings based on the configuration file, so that a policy rebuild would
> > change the compile-time defaults to match the desired settings, but that
> > requires policy sources, which may not be available (e.g. the policy
> > reload may have been triggered by a binary policy update, and the end
> > system may not have policy sources installed).  Thoughts?
>
> Actually, it would be easy to create a simple utility that patches a
> binary policy to change the boolean default values, so that would be a
> possibility.
>

Just changing the booleans isn't enough - you would also need to evaluate
all of the expressions and set rules to active/inactive. If you were
planning to take the same approach as the user management tool that you just
did, this should be trivial. The other option is that the reading code could
be changed to evaluate all of the expressions after loading a policy so that
changes to the booleans would become active, but that would obviously
require kernel changes.

For the reload case, the only other idea that I can think of is to have
security_load_policy copy the current boolean states to the newly loaded
policy for booleans that are shared between the policies. I'm not certain
this is a good idea - and you probably want to have a way to disable the
behavior - but the advantage is that it allows booleans to be persistent
while a machine is running without requiring them to be persistent across
reboots. It seems to me that persistance across reboots is actually a
separate case and I am concerned about administrator confusion about when a
change to a boolean is temporary and when it is persistent. I agree,
however, that it is important to have some safe mechanisms for making the
boolean states stay during reload and reboots.

Karl

> -- 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
