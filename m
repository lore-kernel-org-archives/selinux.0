Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1105560687.11135.26.camel@cobra.ivg2.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
	 <1105560687.11135.26.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 16:47:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 15:11, Ivan Gyurdiev wrote:
> Please explain this some more - Luke also seems confused about this
> (unless I misunderstand). I don't understand how the change from one
> context to multiple contexts stored per file translates into policy
> being encoded in the file attributes.
> 
> It seems to me that this change would simply allow more accurate
> association of the files with the proper security data.
> 
> It is still a centralized policy which decides whether to allow an
> action or not - it just takes into consideration multiple contexts.
> I am merely suggesting that when a security decision is necessary for
> a file, all the contexts it is labeled with are provided by the
> filesystem, and the security server makes a decision based on 
> whether an access path (not sure of terminology here) exists
> between the subject context and any object context.

If we followed that approach, then we wouldn't be able to tell whether
information can flow from type A to type B without analyzing the
filesystem state to see what files had multiple contexts and collapsing
each such combination into a single security equivalence class (type).

> Your httpd policy describes what contexts httpd has access to.
> Your samba policy describes what contexts smbd has access to.
> This information is not stored in the filesystem somewhere - it's 
> in the binary policy. Multiple contexts will simply allow
> the user to more accurately specify the class of the object 
> that you have to work with, with minimal interaction - it 
> is fundamentally not a samba share, or httpd content, it is both,
> and it seems the only sane thing to do is label it with both,
> or something that's a mix of the two.

You can then no longer tell whether httpd and smbd (or anything that
uses them) might interact without looking at the file attributes on
disk, as a file might have both contexts.

>  I am interested in 
> the easiest possible way to do this without playing with the policy.
> Why should I be changing the policy?

Because by allowing access by multiple domains to a single object, you
_are_ changing the policy, regardless of it is hidden or not.

>  I should
> only need to do that when I want to describe changes in 
> security classes and relationships between them. 

Allowing multiple domains that could not previously interact to do so is
changing the relationship between the security classes.

> What I want to do 
> is simply mark data as belong to more than one existing class,
> without changing either one.

That is a communication channel betweeh them.

> So, it seems to me that userspace tools should provide
> an easy way to mark a file for contexts it belongs to,
> and internally selinux could still map this information
> to a unique sid somehow. Is this possible?
> 
> I can imagine multiple contexts for processes would be useful
> as well, although I can't come up with examples right now...

Not desirable.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
