Message-ID: <442DAA7F.9080302@cornell.edu>
Date: Fri, 31 Mar 2006 17:17:35 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: sds@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: The sort algorithm is broken by the second rule,  We	need	a	way
 to pin these rules to the top.
References: <442D41CA.8070702@redhat.com>  <442D436A.1010805@tresys.com>	 <1143817846.24555.329.camel@moss-spartans.epoch.ncsc.mil>	 <442D5A3F.9090409@cornell.edu>	 <1143831151.17469.13.camel@moss-spartans.epoch.ncsc.mil>	 <442D7CFC.8060704@cornell.edu> <1143832535.17469.29.camel@moss-spartans.epoch.ncsc.mil> <442D809D.8050105@tresys.com>
In-Reply-To: <442D809D.8050105@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> (Also, if we merge .local into the normal fc file then the .local 
> can't override .homedirs)
We also don't have the capability of expanding templates in the .local 
file, so I doubt this will be an issue.
Btw the .homedirs file can easily be merged into the big file_contexts.

I don't have a strong opinion of whether we should be merging things 
together or not. It's just that this separation in .local .homedirs 
.something_else has to do with processing work, which seems to belong at 
policy build time, not at "runtime" where matchpathcon just wants to 
look up a context.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
