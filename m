Subject: Re: Multiple contexts
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 13:11:27 -0700
Message-Id: <1105560687.11135.26.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

And of course I forgot to cc list.
Sorry about the multiple mails.

> > I have to edit the cryptic m4 policy file to add a type that's
> > accessible by both. Why is this necessary? Why can't selinux
> > either
> > 	(1) Label the file with both contexts, and permit
> > 	the operation if any context permits it
> 
> Because then policy would be encoded in the file attributes, not in a
> centralized security policy.  Hence, one would be unable to analyze
> information flow in the system based solely on the policy and would have
> to also analyze the complete filesystem state, and that state is much
> more subject to change at runtime than the policy itself (one would
> hope).

Please explain this some more - Luke also seems confused about this
(unless I misunderstand). I don't understand how the change from one
context to multiple contexts stored per file translates into policy
being encoded in the file attributes.

It seems to me that this change would simply allow more accurate
association of the files with the proper security data.

It is still a centralized policy which decides whether to allow an
action or not - it just takes into consideration multiple contexts.
I am merely suggesting that when a security decision is necessary for
a file, all the contexts it is labeled with are provided by the
filesystem, and the security server makes a decision based on 
whether an access path (not sure of terminology here) exists
between the subject context and any object context. 

Your httpd policy describes what contexts httpd has access to.
Your samba policy describes what contexts smbd has access to.
This information is not stored in the filesystem somewhere - it's 
in the binary policy. Multiple contexts will simply allow
the user to more accurately specify the class of the object 
that you have to work with, with minimal interaction - it 
is fundamentally not a samba share, or httpd content, it is both,
and it seems the only sane thing to do is label it with both,
or something that's a mix of the two. I am interested in 
the easiest possible way to do this without playing with the policy.
Why should I be changing the policy? I should
only need to do that when I want to describe changes in 
security classes and relationships between them. What I want to do 
is simply mark data as belong to more than one existing class,
without changing either one.

So, it seems to me that userspace tools should provide
an easy way to mark a file for contexts it belongs to,
and internally selinux could still map this information
to a unique sid somehow. Is this possible?

I can imagine multiple contexts for processes would be useful
as well, although I can't come up with examples right now...

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
