Subject: Re: [PATCH 0/5] libselinux: labeling API for userspace object
	managers
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <455C713D.9050104@tresys.com>
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
	 <455C713D.9050104@tresys.com>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 13:49:47 -0500
Message-Id: <1163702987.15225.115.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-16 at 09:10 -0500, Joshua Brindle wrote:
> I didn't think this was a solved problem. I still think labeling is part 
> of the object manager, not part of the policy. What are the advantages 
> of doing it this way over letting the object managers manage their own 
> labels?

I discussed this in an earlier message, the one with the "N different
things" bullet points, but to recap,
- Role separation between security admin and app admins
- Less impact on upstream projects
- Easier to manage and distribute policy

> 
> about this implementation though, how are you planning to get contexts 
> to the policy directory? As part of a package? any libsemanage 
> interface? Will it be part of this patch set?

As part of the package is my current thought.  I described an example
file layout in my last message of the previous thread, see:
http://marc.theaimsgroup.com/?l=selinux&m=116233649828195&w=2
I won't be submitting any libsemanage interfaces, but that could
certainly be done in the future.  Or backends could be written that draw
from some exotic place like LDAP instead of files, who knows.

> 
> Did you need a special backend for file_contexts because it has 
> overlapping object class specifications? 

Special backend needed because of the inode tracking done by setfiles,
the "mode" argument and regexps in the files, the "homedirs" override,
and other specific behaviors.  

The "simple" backend at the moment only supports simple string->context
mappings.

> How do you 'register' an object 
> class or set of object classes to a particular backend? 

There's a hardcoded table in label.c, near the top, that maps classes to
backends.  Look for SECCLASS_XEXTENSION in the second patch.  I'm sure
this could be done with DSO modules or something in the future.

> I know with X 
> you are going to have 1 file with many object classes, will it need a 
> special backend? 

There won't be one file anymore, it will be split up by object class.
The simple backend may be used, nothing special required.

X itself is no longer going to care how it's stored, X is just going to
call label_lookup().  

> If every single object manager needs a special backend 
> what are we buying with this interface?

I believe that most object managers will only need the simple backend,
maybe with some pattern matching support added in.  But even not
considering that, you buy the benefits described above.  It's better
configuration management than storing in the config files of each app.

> 
> I assume this is for RFC and not for merging until the rest of the 
> patches are out, right? If you could make the patches apply from the top 
> of the repository with -p0 or -p1 (don't have a preference which) that 
> would be really helpful.

Yes, it's just for RFC.  After all the patches are out I'll send one out
that applies properly from the top.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
