Subject: Re: Yet another question - newrole and xterm's
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Michael Reilly <michaelr@cisco.com>, SELinux@tycho.nsa.gov
In-Reply-To: <200310170216.37933.russell@coker.com.au>
References: <20031015191716.5478c74b.michaelr@cisco.com>
	 <1066307222.24561.7.camel@moss-spartans.epoch.ncsc.mil>
	 <200310170216.37933.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066321310.25279.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 Oct 2003 12:21:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-10-16 at 12:16, Russell Coker wrote:
> Yes, the idea is that you can use the same policy on old or new SE Linux.  If 
> you use it on the old SE Linux then /proc is unavailable.  If you use it on 
> the new SE Linux then can_setexec() covers it.
> 
> Michael, are you running old or new SE Linux?

I understand now - he is using the old SELinux, based on his original
posting to the selinux list (Slackware base with Russell's policy and
the old 2.4-based SELinux from the August release).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
