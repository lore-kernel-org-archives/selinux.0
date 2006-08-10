Subject: Re: does mv need a --context=CTX (-Z) option, too?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <87hd0kc308.fsf@rho.meyering.net>
References: <87hd0kc308.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 09:54:18 -0400
Message-Id: <1155218058.1123.301.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-10 at 12:13 +0200, Jim Meyering wrote:
> It might make sense to add a --context=CTX (-Z) option to mv.  Currently,
> cp, install, mkdir, mknod, mkfifo all have that option, but not mv.
> Most of the time, mv would have no need, since it simply calls rename.
> But when that fails, it reverts to using the very same copying code
> (copy.c) that cp uses.  It is trivial to add this option to mv, with the
> understanding that it'd take effect solely for e.g., cross-device moves.
> I.e., if you want to simulate a cross device move, you'd have to use
> cp -pr and rm -rf, so if it makes sense for cp to have the --context=CTX
> (-Z) option, then it follows that mv must accept it as well.

mv should just preserve the context of the original in all cases,
whether it is just doing a rename(2) or copying the file.  

> This brings up another minor inconsistency: should the other
> named-file-creation programs (dd, ln, link, touch) in coreutils also
> accept the --context=CTX (-Z) option?

ln/link likewise wouldn't need it, as it is the inodes that are labeled,
not the links.  Unless you mean for ln -s, where the symlink itself has
a label.

> With that only partly rhetorical question, you should see why I'd like
> an selinux/kernel hook that'd let me set the default fscreate context
> for the upcoming execve.  Then I could simply add one option to runcon
> and forget about all of these "-Z CTX" options.  IMHO, requiring all of
> these tools to add an option like "-Z CTX" to perform the same simple
> function is almost prohibitively onerous.

It's consistent with the idea of MAC being a first class citizen of
Linux, just like file owner/mode/ACL.

Now, as far as preserving fscreate across execve goes, doing that in the
case where there is no change in the current context of the task is
conceivable (so no implications for letting the caller influence the
program), although it would be a change in behavior that has been
present for quite some time (and seems rather late to make it into e.g.
RHEL5 or FC6).  I have no strong opinion on that, but it could introduce
unexpected behaviors; some programs today might be setting fscreate and
exec'ing helpers while not expecting the helpers to pick up that
fscreate context.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
