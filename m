Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFDXpIi022671
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 08:33:51 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFDXsuA002514
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 13:33:54 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041115015749.GS5031@lkcl.net>
References: <20041115015749.GS5031@lkcl.net>
Content-Type: text/plain
Message-Id: <1100525392.31773.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 15 Nov 2004 08:29:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-11-14 at 20:57, Luke Kenneth Casson Leighton wrote:
> i have what i believe to be an important question about how dynamic
> context transitions should partition resources:
> 
> is it the case that:
> 
> - when a single process transitions (dynamically) to a new context,
>   any resources it presently has opened (file handles etc.) will
>   still be available and accessible in the new context.
> 
> or is it the case that:
> 
> - when a single process transitions (dynamically) to a new context,
>   any resources it presently has opened (file handles etc.) will
>   NOT be accessible in the new context, but that, should the process
>   (dynamically) transition BACK to the new context, those resources
>   become accessible again.
> 
> the former is a trivial implementation, i presume [by comparison to...]
> 
> the latter requires that every resource accessible by a process
> has a context handle associated with it (eek!)
> 
> the distinction is critical because the latter is more like the exec()
> model and the former is more seteuid-like.
> 
> i wouldn't want to be explaining and advocating something that was
> misunderstood!

As proposed, all state is inherited across a setcon().  However, since
SELinux revalidates permission upon access to files, attempts to
read/write already opened descriptors may fail after the setcon() if the
new context is not allowed the necessary permissions.  It becomes a
policy issue whether or not you choose to allow the new context to
access any descriptors opened under the old context.  Regardless of what
you do, it is always true that the entire application has to be trusted
to maintain any desired separation between the two security contexts
upon a setcon() operation, unlike exec-based transitions.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
