Subject: Re: A couple of patches to setfiles.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <4162ED4F.6000208@redhat.com>
References: <415E9107.4030900@redhat.com>
	 <1097000679.3878.132.camel@moss-spartans.epoch.ncsc.mil>
	 <1097001163.3878.134.camel@moss-spartans.epoch.ncsc.mil>
	 <4162ED4F.6000208@redhat.com>
Content-Type: text/plain
Message-Id: <1097003708.3878.155.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 05 Oct 2004 15:15:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-05 at 14:51, Daniel J Walsh wrote:
> Steve Grub has pointed out that the way we are doing setfiles is all 
> wrong, and that we should be logging
> to syslog.  That way a management infrastructure could monitor and 
> manage the environment.  Writing
> temporary or log files in arbitrary places is wrong.  Tools like 
> logrotate are going to clean them up.  ETC.
> So the -o flag should go and we should use syslog.

Shrug.  For now, I've added a -l option to enable logging via syslog,
and only doing so if !only_changed_user, as with the existing -v and -o
options.  Also merged -R option for restorecon and -e option for
setfiles, and removed tee'ing of output from fixfiles.  But you still
need to change fixfiles to use -l if that is what you want, and you have
the same issue for restorecon.

> I think we need a mechanism to tell us when a file actually has the 
> wrong context versus one that just does not
> match the context in the file_context file.  Russell pointed out that 
> the contents of the homedirectory should
> not have an automatic tool looking at their context because it might 
> open up a security hole if you were to
> arbitrarily clean up the false positives.

setfiles likely shouldn't be applied to /home at all after initial
labeling.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
