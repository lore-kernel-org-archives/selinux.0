Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAIGCSMA022127
	for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2005 11:12:28 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAIGCPoG015110
	for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2005 16:12:26 GMT
Subject: Re: Current Reference Policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <437DED16.4090506@redhat.com>
References: <437CA7D7.6090308@redhat.com>
	 <1132254164.7259.61.camel@sgc.columbia.tresys.com>
	 <437DED16.4090506@redhat.com>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 11:12:27 -0500
Message-Id: <1132330347.7259.92.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-18 at 10:02 -0500, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Thu, 2005-11-17 at 10:55 -0500, Daniel J Walsh wrote:
> >   
> >> Need to turn on rpm and not alias to unconfined_t, because the rule
> >>
> >> rpm_t->shell_exec_t->rpm_script_t was causing all terminal windows to 
> >> run in rpm_script_t in targeted.     
> >
> > Yesterday I disabled that transition in targeted (it was the one causing
> > the xdm logins to go to rpm_script_t), so do you still want to rpm_t as
> > non-aliased?
> >   
> Yes.  Lets move that way and see how it works.

Ok, I've committed this part and re-enabled the transition to
rpm_script_t.

> >> Allow users to su to root and then suspend the session.

Did you really intend to add these to only the targeted policy?

> >> Pegasus policy was too loose.
> >> /bin/ksh should be sheel_exec_t
> >> (.*)?  is the same as .* and causes python to blow up.

merged.  I didn't merge the hunks that hard-coded the role in the file
contexts, as the hunks were not used in the targeted policy.  We need to
have a fixed genhomedircon for strict to be usable again anyway, since
not all home dirs are user_home(_dir)?_t.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
