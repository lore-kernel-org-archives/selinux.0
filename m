Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4FJ37I4020031
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 15:03:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4FJ2ll5023395
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 19:02:48 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h4FJ2lNc023392
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 19:02:47 GMT
Subject: Re: slow application of contexts in devfs?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Christopher J. PeBenito" <pebenito@ieee.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1053016311.20932.17.camel@chris.pebenito.net>
References: <3EC2792D.1020209@yahoo.it>
	 <200305150539.40186.russell@coker.com.au>  <3EC2C366.5060901@yahoo.it>
	 <1053003033.4729.674.camel@moss-huskers.epoch.ncsc.mil>
	 <1053016311.20932.17.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1053025378.4729.770.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 May 2003 15:02:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-05-15 at 12:31, Christopher J. PeBenito wrote:
> I'm running the 2003040709 lsm and selinux patches on a stock kernel,
> and I'm seeing some weird behavior on devfs.  When starting up, it seems
> that its taking a long time for the contexts to be correctly set on
> devfs files (in this case /dev/log).  Here's the appropriate segment of
> the kernel messages.  You can see that the policy is loaded, and devfs
> is set up using genfs_contexts.  Then shortly later after devfs is
> mounted, devfsd gets a denial writing to /dev/log, because its still
> labeled as device_t

/dev/log is a name for a Unix domain socket created by syslogd.  Until
syslogd is running and has bound a socket to /dev/log, writing to
/dev/log isn't going to work regardless of your policy.  When syslogd
binds its socket to /dev/log, then it will pick up the correct type
based on the file type transition rule, as with other file creations. 
Why does /dev/log even exist in devfs before syslogd has bound to it? 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
