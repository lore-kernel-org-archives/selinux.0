Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FIN3L9009855
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 13:23:03 -0500 (EST)
Subject: Re: sshd transition points
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050215155323.GC23765@lkcl.net>
References: <20050215155323.GC23765@lkcl.net>
Content-Type: text/plain
Message-Id: <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 15 Feb 2005 13:14:53 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 10:53, Luke Kenneth Casson Leighton wrote:
> so basically, my question boils down to this:
> 
> * _should_ sshd, after a fork, be still running in sshd_t?

I'm not sure I follow your posting.  Transitions normally only occur
upon execve.  sshd should transition upon executing the shell, of
course.  IIRC, there is an issue with regard to SELinux not being able
to fully leverage the privilege separation support in sshd since that
requires dynamic transitions.  Of course, since dynamic transition
support now exists, someone could look into changing sshd to use it for
finer-grained privilege bracketing.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
