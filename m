Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1PGM6Rb000859
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 11:22:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1PGM5QQ028874
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 16:22:06 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1PGM5P0028871 for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 16:22:05 GMT
Subject: Re: Suggested change to setfiles interface.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <403CBDC4.30100@redhat.com>
References: <403CBDC4.30100@redhat.com>
Content-Type: text/plain
Message-Id: <1077726119.22658.154.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 25 Feb 2004 11:21:59 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-02-25 at 10:22, Daniel J Walsh wrote:
> I find it curios that the setfiles interface works in recursive mode by 
> default.  As we have been trying to get the install to handle labeling 
> the file system, several files had to be labeled in the installer 
> including /.  The only way to do this was to pipe
> echo / | setfiles -s file_context
> 
> Looking into this I found this curious that this works differently then
> setfiles file_context  /
> 
> I would like to see these work consistantly and us add a recursive on 
> non recursive switch to setfiles. 
> 
> So
> 
> setfiles -R file_contexts /
> would implement the current behavior
> 
> setfiles file_contexts /
> would just relabel /.

Just to clarify, setfiles was designed to label entire filesystems, so
it takes a list of filesystem mount points and walks each one in turn. 
It does not cross mount points, so a 'setfiles file_contexts /' will not
descend into /boot or /var or /home (if those are separate mounts). 
Operating on an entire filesystem allows setfiles to also check for
conflicts such as cases where multiple hard links exist for an inode
that would map to different contexts.  Originally, setfiles created or
updated a persistent label mapping in each specified filesystem; now it
merely sets extended attributes on the individual files in that
filesystem.  It isn't a recursive vs. non-recursive issue so much as a
filesystem vs. file argument issue.

The -s option was added by Russell to allow setfiles to be applied to a
specified list of files (rather than filesystems) taken from stdin,
although we could likely have it take them from the command line just as
easily instead.

I don't think we want to change the default behavior of setfiles, but we
could certainly change the -s option to accept either a list of files as
command line arguments or (if none are specified) read from stdin. 
Would that address your concern?
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
