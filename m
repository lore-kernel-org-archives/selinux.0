Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBHFEpIi002407
	for <selinux@tycho.nsa.gov>; Fri, 17 Dec 2004 10:14:52 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBHFD8Fj013899
	for <selinux@tycho.nsa.gov>; Fri, 17 Dec 2004 15:13:09 GMT
Subject: Re: Tomcat policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick Gray <nick-lists@austin.rr.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <1103295405.32688.80.camel@hawaii.grays-systems.com>
References: <1103224127.32688.49.camel@hawaii.grays-systems.com>
	 <1103229973.1463.145.camel@moss-spartans.epoch.ncsc.mil>
	 <1103295405.32688.80.camel@hawaii.grays-systems.com>
Content-Type: text/plain
Message-Id: <1103296185.3437.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 17 Dec 2004 10:09:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-12-17 at 09:56, Nick Gray wrote:
> tomcat_exec_t would be for the actual executable binaries right. I am
> talking about a default label for the entire directory structure
> starting with /usr/local/tomcat/. That in the strict policy would keep
> all other users out of this subdirectory.

Ok, so you need a different type for that purpose, e.g. 
type tomcat_files_t, file_type, sysadmfile;

> So basically, your saying I haven't even done what I thought I did. That
> if I create a user, by default he will be unconfined and can get into
> the labeled tomcat directories depending on the unix permissions?

Targeted policy doesn't confine user sessions, just particular daemons. 
Strict policy confines user sessions, user programs, and daemons.

> Sounds like you are telling me that the tomcat daemon can't access types
> outside its domain such as unconfined_t.

Right, or any file types that it isn't explicitly allowed to access in
your tomcat policy.

> This isn't a very robust solution since this is one case in point. It
> seems to (I'm sure you'll correct me on this point) that the optimum
> solution is to add the tomcat user to the user.te file with a role like
> user_r and or creating a tomcat_r and giving it access only to the
> tomcat domain.

I don't understand why the isolation provided by the domain isn't
sufficient.  SELinux users and roles are for real users, not daemons.

> By doing the above, would'nt we have accomplished (in the most efficient
> manner) the securing of the tomcat daemon. If a buffer overflow happens
> which gives the tomcat user (by virtue of the user that the daemon is
> running as) root access, the tomcat user is restricted to the tomcat
> domain and prevent from doing much more than creating logs
> in /usr/local/tomcat/.../logs, as per the policy!

If you start the daemon in tomcat_t, then it can't transition to any
other domains other than what you allow in the policy via
domain_auto_trans rules.  And it cannot access any types other than what
you allow in the policy.  So it is already bounded in its potential
privilege escalation to what you define, without introducing fake users
into the equation.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
