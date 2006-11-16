MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 0/5] libselinux: labeling API for userspace objectmanagers
Date: Thu, 16 Nov 2006 14:06:31 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885C7A45@exchange.columbia.tresys.com>
In-Reply-To: <1163702987.15225.115.camel@moss-huskies.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <ewalsh@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Eamon Walsh [mailto:ewalsh@tycho.nsa.gov] 
> 
> On Thu, 2006-11-16 at 09:10 -0500, Joshua Brindle wrote:
> > I didn't think this was a solved problem. I still think labeling is 
> > part of the object manager, not part of the policy. What are the 
> > advantages of doing it this way over letting the object managers 
> > manage their own labels?
> 
> I discussed this in an earlier message, the one with the "N 
> different things" bullet points, but to recap,

Yes, I read those when you sent them the first time and I still think
labeling is part of the object manager.

> - Role separation between security admin and app admins

Not necessarilly, it just depends on the policy that governs the label
files and the app files. Clearly an app admin can be disallowed from
modifying labeling files of apps.

> - Less impact on upstream projects

Not really, we've had this idea that 3rd party apps could include their
policies with the app for a long time, this was part of the motivation
behind the module infrastructure, clearly labeling would accompany the
policy. Additionally, user object manager policy need not be dependant
on the system policy, the types used for userspace object will probably
be specific to the user object manager, the only thing necessary from
the system policy will be user domains (or whatever interacts with the
manager). Once there are interfaces in the language it will be far
easier to have a single policy/label file for an object manager that
works with any policy. If the upstream makes object model changes, new
permission checks, etc it would be easier for them to reflect that in
policy (and labeling) if they own it. 

> - Easier to manage and distribute policy
> 

Perhaps but I'm not compelled by this, how many policies are there going
to be for user object classes that wouldn't be included with the app
itself? 

> > 
> > about this implementation though, how are you planning to 
> get contexts 
> > to the policy directory? As part of a package? any libsemanage 
> > interface? Will it be part of this patch set?
> 
> As part of the package is my current thought.  I described an 
> example file layout in my last message of the previous thread, see:
> http://marc.theaimsgroup.com/?l=selinux&m=116233649828195&w=2
> I won't be submitting any libsemanage interfaces, but that 
> could certainly be done in the future.  Or backends could be 
> written that draw from some exotic place like LDAP instead of 
> files, who knows.
> 
> > 
> > Did you need a special backend for file_contexts because it has 
> > overlapping object class specifications?
> 
> Special backend needed because of the inode tracking done by 
> setfiles, the "mode" argument and regexps in the files, the 
> "homedirs" override, and other specific behaviors.  
> 
> The "simple" backend at the moment only supports simple 
> string->context mappings.
> 
> > How do you 'register' an object
> > class or set of object classes to a particular backend? 
> 
> There's a hardcoded table in label.c, near the top, that maps 
> classes to backends.  Look for SECCLASS_XEXTENSION in the 
> second patch.  I'm sure this could be done with DSO modules 
> or something in the future.
> 
> > I know with X
> > you are going to have 1 file with many object classes, will 
> it need a 
> > special backend?
> 
> There won't be one file anymore, it will be split up by object class.
> The simple backend may be used, nothing special required.
> 
> X itself is no longer going to care how it's stored, X is 
> just going to call label_lookup().  
> 

So 15 files with 1 line each? 

> > If every single object manager needs a special backend what are we 
> > buying with this interface?
> 
> I believe that most object managers will only need the simple 
> backend, maybe with some pattern matching support added in.  
> But even not considering that, you buy the benefits described 
> above.  It's better configuration management than storing in 
> the config files of each app.
> 

Policy server at least needs some sort of pattern matching, basically a
'longest match wins' system very similar to genfscon.

> > 
> > I assume this is for RFC and not for merging until the rest of the 
> > patches are out, right? If you could make the patches apply 
> from the 
> > top of the repository with -p0 or -p1 (don't have a 
> preference which) 
> > that would be really helpful.
> 
> Yes, it's just for RFC.  After all the patches are out I'll 
> send one out that applies properly from the top.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
