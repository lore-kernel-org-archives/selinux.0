Subject: Re: type transitioning script race condition?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Klaus Weidner <klaus@atsec.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@gentoo.org>, russell@coker.com.au,
        selinux@tycho.nsa.gov, Stephan Mueller <smueller@atsec.com>
In-Reply-To: <20060831154635.GC12307@w-m-p.com>
References: <20060830223937.GB12307@w-m-p.com>
	 <200608310918.03263.russell@coker.com.au> <44F6539E.7090800@gentoo.org>
	 <1157030632.3106.7.camel@localhost.localdomain>
	 <1157032383.24429.90.camel@twoface.columbia.tresys.com>
	 <20060831154635.GC12307@w-m-p.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 07:37:19 -0400
Message-Id: <1157110639.26621.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-31 at 10:46 -0500, Klaus Weidner wrote:
> - set up file descriptors - close extra ones, and make sure 0/1/2 are
>   open. A nasty hack is closing fd 2 (stderr) before launching the
>   trusted app. The application opens a file for writing, gets fd 2 from
>   the OS from that, and now anything it's intending to write to stderr
>   such as warning or progress messages will also go to that file.

Just FYI, glibc ensures that fd 0/1/2 are allocated for programs that
involve a uid, gid, or context transition.  So given a binary wrapper
that uses glibc, you get that part for free.

> - make sure that resource limits are reasonable. Another hack involved
>   setting the max file size to a very low value and calling passwd(1),
>   which then truncated /etc/shadow due to the limit.

The SELinux setrlimit and rlimitinh permission checks were designed to
counter that attack; the former limits what processes can change their
hard limits so that the hard limit can be used as a safe reset point for
the soft limit upon exec, and the latter controls whether the soft
limits are reset across a context transition.  In that model, you limit
the ability to set the hard limit to programs trusted for that purpose,
like login (via pam_limits).

The SELinux siginh permission check further addresses inheritance of
signal-related state across such transitions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
