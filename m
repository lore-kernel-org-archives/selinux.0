Subject: Re: restorecon -R default
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <201201290001.10792.russell@coker.com.au>
References: <201201290001.10792.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 30 Jan 2012 11:11:05 -0500
Message-ID: <1327939865.23069.10.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2012-01-29 at 00:01 +1100, Russell Coker wrote:
> http://www.youtube.com/watch?v=ZThVfm3JXdM
> 
> A few years ago Paul Wayper gave an excellent introductory lecture about SE 
> Linux (see the above URL).  He notes that he habitually uses -R for restorecon 
> every time.
> 
> It seems to me that the case where -R is not desired will be extremely rare.  
> It seems most uncommon that someone will have a directory with the wrong 
> label, a subdirectory tree that is either too big to scan quickly (and which 
> is known to have the correct labels) or which has labels which by design don't 
> match the file contexts.
> 
> Therefore I think we should make the common case be the default and require 
> that anyone who doesn't want that functionality specifically request it.  
> chcon uses the -h flag for changing the context of a sym-link instead of the 
> target, that might be a reasonable option to use for consistency.

Seems like it might prove surprising to users, both given the prior
default behavior of restorecon and the default behaviors of similar Unix
commands like chown/chmod.  I don't think we can/should change it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
