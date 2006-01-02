Message-ID: <43B97823.3080201@tresys.com>
Date: Mon, 02 Jan 2006 13:59:47 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
   dwalsh@redhat.com
Subject: Re: [SEMANAGE][SEPOL] Enable ports
References: <43ACADB3.7070509@cornell.edu>
In-Reply-To: <43ACADB3.7070509@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Ok, I've tried get ports working enough times now, that I think my 
> approach is making it too difficult. I've been trying to put too much 
> logic into the port key - for example, I wanted the add() function to 
> detect overlapping ranges, and complain about it (the range key 
> represents all ports from low to high). I wanted the query function to 
> match inexactly (if you query port 80, 10-1024 to match...)
> I wanted del() to match a range, and clear only the specified sub-range. 
> But... this is too difficult to do, and adds lots of extra complexity, 
> and we need to get ports working.
> 
> So, this patch takes the simplest possible approach - a key matches if 
> low = low2, high = high2, and proto = proto2. This means that at the key 
> level, ranges 10-20, and 15-30 are completely different, even though 
> they overlap and represent the same ports. Two ranges with matching 
> bounds and protocol are not allowed, but they can overlap inexactly. In 
> that case, the one added later takes precedence, and is written at the 
> end of the file (and pushed at the beginning of the list in the 
> policydb). If additional overlap checks are needed, they should be 
> implemented at the libsemanage client.
> 
> This brings up an interesting point - if ordering of records matters, 
> then some thought should go into which way iterate() loops over the 
> records... (and what order list() returns). Currently for files, the 
> ordering is backwards to what appears in the file (not sure what 
> policydb does).
> 

This should be fixed. the policy parser (policy_parse.y) currently 
preserves the order exactly as specified, with errors in the case of 
duplicate or shadowed entries.

I think a good workaround for now is to only expose exact port labeling 
via libsemanage, that way you can prepend them to the policydb list and 
not worry about sorting, etc. If the user needs to set multiple ports 
the client can expose that functionality, and limited intelligence can 
be added there (error checking and such). the policydb portcons would 
still have ranges so the fallbacks (1-1024, etc) would still be there.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
