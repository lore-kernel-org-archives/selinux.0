Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBBL0URb005705
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 16:00:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBBKxilU027538
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 20:59:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hBBKxiSX027535
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 20:59:44 GMT
Subject: Re: Information flow models
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "John D. Ramsdell" <ramsdell@mitre.org>, SE Linux <selinux@tycho.nsa.gov>,
   Joshua Guttman <guttman@mitre.org>
In-Reply-To: <1071175582.6729.227.camel@colossus.columbia.tresys.com>
References: <ogtfzfzqa3g.fsf@divan.mitre.org>
	 <1070906232.6729.53.camel@colossus.columbia.tresys.com>
	 <1071174228.11140.127.camel@moss-spartans.epoch.ncsc.mil>
	 <1071175582.6729.227.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1071176422.11140.165.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 11 Dec 2003 16:00:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-12-11 at 15:46, Karl MacMillan wrote:
> Interesting. This seems like a special case to me - "implicit
> relationship" seems to mean that the information is flowing to that proc
> file outside of the control of the policy. Just to make certain that I
> understand, am I correct that information can only flow to proc files in
> this example? In other words, if there was a plain text file labeled b_t
> no information could flow through it from c_t to a_t without another
> rule:
> 
> allow b_t b_t : file write;

Correct.

> Are there any implicit relationships like this?

Offhand, no, although I may be forgetting something.  Sockets
and System V IPC objects do inherit the type of the creating
process by default, but there are explicit allow rules authorizing the
creation and subsequent access.  devpts nodes are dynamically created by
the kernel in response to access to /dev/ptmx, so you never see an
explicit allow rule for the creation, but they do require explicit allow
rules for accessing them.

> I agree that this isn't a likely situation (we have yet to see this
> false positive in a real policy), but one of the goals of automated
> tools is to detect poorly written policies. However, both of these
> strategies help prevent a false positive where it can appear that
> information flows between 2 objects without a subject, which is a likely
> situation.

I'd view it as a bug in the policy if someone is trying to separate
based on the class (vs. using separate types).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
