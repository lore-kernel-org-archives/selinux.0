Message-ID: <442D809D.8050105@tresys.com>
Date: Fri, 31 Mar 2006 14:18:53 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: sds@tycho.nsa.gov
CC: Ivan Gyurdiev <ivg2@cornell.edu>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: The sort algorithm is broken by the second rule,  We	need	a	way
 to pin these rules to the top.
References: <442D41CA.8070702@redhat.com>  <442D436A.1010805@tresys.com>	 <1143817846.24555.329.camel@moss-spartans.epoch.ncsc.mil>	 <442D5A3F.9090409@cornell.edu>	 <1143831151.17469.13.camel@moss-spartans.epoch.ncsc.mil>	 <442D7CFC.8060704@cornell.edu> <1143832535.17469.29.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1143832535.17469.29.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-03-31 at 14:03 -0500, Ivan Gyurdiev wrote:
>>>   Sorting is presently only
>>> happening in the policy build process via the
>>> refpolicy/support/fc_sort.c helper program, so it is only applied to the
>>> file_context file provided by the policy itself, not to any local
>>> entries (whether created via semanage or not).
>>>   
>> My mistake, I thought sorting was moved into matchpathcon at some point...
>> In that case the patch I sent shouldn't be necessary.
> 
> Yes, Joshua had sent a patch to add the sorting logic to matchpathcon
> back in Oct '05, but I rejected it at the time because it needed to be
> coordinated with a policy update to ensure no actual change in
> filesystem labeling and because it sorted all of the file_contexts.*
> files together rather than retaining a prioritization among them.  And
> as we later agreed, it belongs in libsemanage at generation time rather
> than in libselinux.
> 
> Current libselinux matchpathcon logic only moves exact specifications
> (no regex in the pathname) to the end so that they are never overridden
> by a pathname regex; otherwise, it just uses the provided ordering
> within each file and it uses a fixed ordering among the files
> (file_contexts.local takes precedence over file_contexts.homedirs which
> takes precedence over file_contexts).
> 
> What is a little confusing right now is that there are potentially two
> "file_contexts.local" files; the one managed via semanage that only
> exists in the store and is merged to the end of the generated
> file_contexts file for installation and the one that can be manually
> created by the admin that is "merged" to the end of the in-memory table
> by matchpathcon.  I suppose we should consider the latter to be
> deprecated but libselinux will continue to look for it for legacy
> support.
> 

I think libsemanage should just put the .local file out for libselinux 
to read. There is no guarantee that none of the entries on .local won't 
be preceded by something in the normal file context if it is merged in 
libsemanage. This is the same thing we do for file_contexts.homedirs so 
why not do it with .local? (Also, if we merge .local into the normal fc 
file then the .local can't override .homedirs)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
