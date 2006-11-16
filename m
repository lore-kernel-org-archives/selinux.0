Subject: RE: [PATCH 0/5] libselinux: labeling API for userspace
	objectmanagers
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885C7A45@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C7A45@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 16:12:33 -0500
Message-Id: <1163711553.15225.131.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-16 at 14:06 -0500, Joshua Brindle wrote:
> > From: Eamon Walsh [mailto:ewalsh@tycho.nsa.gov] 

> > - Role separation between security admin and app admins
> 
> Not necessarilly, it just depends on the policy that governs the label
> files and the app files. Clearly an app admin can be disallowed from
> modifying labeling files of apps.

So you've conceded that the labels need to be kept in separate files.
Then what difference does it make if they are installed or symlinked
into /etc/selinux/targted/contexts/ and accessed through my proposed
interface?

> 
> > - Less impact on upstream projects
> 
> Not really, we've had this idea that 3rd party apps could include their
> policies with the app for a long time, this was part of the motivation
> behind the module infrastructure, clearly labeling would accompany the
> policy. Additionally, user object manager policy need not be dependant
> on the system policy, the types used for userspace object will probably
> be specific to the user object manager, the only thing necessary from
> the system policy will be user domains (or whatever interacts with the
> manager). Once there are interfaces in the language it will be far
> easier to have a single policy/label file for an object manager that
> works with any policy. If the upstream makes object model changes, new
> permission checks, etc it would be easier for them to reflect that in
> policy (and labeling) if they own it. 

I fail to see how my proposal interferes with this.


> 
> So 15 files with 1 line each? 

~3 files with many lines each.

> 
> Policy server at least needs some sort of pattern matching, basically a
> 'longest match wins' system very similar to genfscon.

Fine, that's certaintly doable.  
 
-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
