Subject: Re: [RFC]{Patch 0/5] Polyinstantation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Chad Sellers <cdselle@tycho.nsa.gov>, selinux@tycho.nsa.gov,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200505131440.42410.russell@coker.com.au>
References: <1115825335.28084.27.camel@moss-huskies.epoch.ncsc.mil>
	 <1115896944.32202.22.camel@moss-spartans.epoch.ncsc.mil>
	 <1115904167.30162.7.camel@moss-huskies.epoch.ncsc.mil>
	 <200505131440.42410.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 13 May 2005 07:30:13 -0400
Message-Id: <1115983813.3576.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-05-13 at 14:40 +1000, Russell Coker wrote:
> Per user /tmp directories break the typical uses of Unix systems.  On Unix 
> multi-user systems it's expected that you can copy a file to /tmp and give it 
> mode 0644 to share it with other people.  Failing that the ways of giving 
> files to other users on the same machine will be email and web.  Email gives 
> delays and sharing via the web can lead to unintended consequences (IE data 
> may not need to be kept secret from other local users but may need to be kept 
> secret from the global Internet).

Hmmm....then I'm a little worried about Chad incorporating per-user
polyinstantiation into his existing implementation of context-based
polyinstantiation.  He was going to make it part of the configuration
file (i.e. for a given directory like /tmp, one could specify per-user,
per-context, or both for polyinstantiation), but that wouldn't let you
express concepts like "I want user A and B to share the same /tmp but
user C to have a separate one."  Note that we can express such concepts
for the context-based polyinstantiation via the type_member rules, e.g.
type_member A tmp_t:dir A_tmp_t; type_member B tmp_t:dir A_tmp_t;
type_member C tmp_t:dir C_tmp_t;, but we would have to invent a similar
language and engine for user-based polyinstantiation and that really
isn't a goal for SELinux.

> Then there's the issue of globally visible mounts.  If I am administering a 
> multi-user system then I will need to be able to login remotely and 
> mount/umount file systems.  If the shell for my login session uses the NEWNS 
> option for clone then I can't do this (any mounts I do won't be visible to 
> system processes or new user logins).  To alleviate this we want to allow 
> logins by administrators without NEWNS.
> 
> If an administrator umounts a file system then any currently running user 
> sessions created with NEWNS will still see it.  How do we solve this?

There is already ongoing work to allow shared subtrees, see the
discussions on linux-fsdevel and linux-kernel.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
