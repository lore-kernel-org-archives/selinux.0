Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, Dale Amon <amon@vnl.com>
Subject: Re: db conflict ?
Date: Thu, 18 Apr 2002 17:42:10 +0200
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>, <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204181045360.5560-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204181045360.5560-100000@raven>
MIME-Version: 1.0
Message-Id: <20020418154333.B804444D90@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Apr 2002 16:54, Stephen Smalley wrote:
> distribution, I have a few questions and concerns aside from the
> location in the filesystem hierarchy:

Incidentally I've been running with /usr/share/selinux/policy/default and 
/usr/share/selinux/policy/current for a few days now.  It seems that the 
directory is inconveniantly long (why not "/usr/share/selinux" instead of 
"/usr/share/selinux/policy"?).  Also I am going to create a symlink 
/etc/selinux that points to the policy.

> 1) When installing the policy and file contexts sources, do we want to
> keep them in separate directories as in the distribution (policy,
> setfiles), or do we want to merge them together as in Russell Coker's
> Debian selinux package?  I'd prefer to keep them separate, especially
> since we have now partitioned file contexts into many files as well.
> They can live under a common top-level directory, but I'd like to keep
> each within its own subdirectory.  Does that seem reasonable?

Why not just have a file_contexts directory under the main policy directory?

I think that having a single Makefile do them both is the best way to do it.  
In my current code base it will compile the policy before doing a relabel.

Also with the new file_contexts scheme of separate files then the same 
Makefile needs to be used so it can determine which .fc files to use 
something like the following:
FC_FILES=$(pathsubst domains/program/%.te,file_contexts/%.fc, $(wildcard 
domains/program/*.te))

Then I was thinking of having a rule to compile the set of fc files to use 
into one file and compare it to the previous version - then if there's a 
change it does a "make relabel", otherwise nothing.

> runs an installed setfiles program on them.  This will require something
> other than just copying the setfiles directory (i.e. omit the setfiles
> program source files and replace the Makefile with a different one),
> unless we restructure it within our own distribution to isolate the
> program from the configuration (e.g. have separate setfiles and
> file_contexts directories, 'make install' in setfiles will build and
> install the setfiles program, 'make relabel' in file_contexts will build
> the file contexts configuration and run the installed setfiles program on
> it). Does the latter change seem reasonable?

Sounds fine to me.

> 3) At present, our installation procedure always builds and installs the
> distribution policy and file contexts configurations.  Howard mentioned
> always building and installing the local policy, which might be a link
> to the example policy or might be a locally-customized policy.  However,
> I think we typically want people to merge any customizations into the
> distribution policy and install it when upgrading SELinux from the
> upstream distribution, as there may be incompatible changes.  At present,
> almost everyone uses some kind of locally-customized policy at least to
> set up policy/users (and often to enable X support or add new domains), so
> if we merely check to see whether they have made _any_ local
> customizations, we will almost always use their local policy, which may
> not be a good thing.

I agree.

I think we need some perl programs to manage this.  At the install time (or 
at any time afterwards) the user should be able to delete policy files from 
the current tree and not have them reappear.

Once the .te file has been deleted the matching .fc file must be disregarded 
ar relabel time.

An upgrade should list files that have changed and allow a choice of 
wholesale change application or applying/rejecting changes on a per-file 
basis after seeing a "diff -u" of the changes.

If the upstream file has not changed (IE if I'm reinstalling the same version 
of the upstream code that I already had) then it must not prompt me to change 
things where the files I'm using are different from the distribution files.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
