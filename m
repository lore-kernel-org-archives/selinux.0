Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJDmRIi020435
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 08:48:27 -0500 (EST)
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Amy L Herzog <aherzog@mitre.org>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   guttman@mitre.org (Joshua D. Guttman)
Subject: Re: dynamic context transitions
Reply-To: guttman@mitre.org (Joshua D. Guttman disp: slinux)
References: <4182959B.4080503@trustedcs.com>
	<1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
	<20041112184232.GK15243@golconda.mitre.org>
	<1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>
From: guttman@mitre.org (Joshua D. Guttman)
Date: 19 Nov 2004 08:48:25 -0500
In-Reply-To: <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <nhau0rm54ra.fsf@malabar.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>   I think it will have to be a "read write" flow, i.e. equivalence
>   required, particularly given the possibility of per-thread
>   contexts introduced by this change (one thread may switch to a
>   different context while another is still running in the old one) 

Are you sure that this is a good idea?  If different threads can have
different contexts within the same process, what are you really buying
in security protection?

Wouldn't you really need to know a lot about the possible behavior of
a program in order to know that the threads executing with lower
privileges really can't do harm?  I mean, whatever harm you were
worried about that made you want to give them lower privileges in the
first place?  

Much more complexity isn't worth it (in my opinion), unless you can
really say what  ability you gain to prevent something from going
wrong.  What harm can you really prevent?  

        Joshua 


Stephen Smalley <sds@epoch.ncsc.mil> writes:

>   On Fri, 2004-11-12 at 13:42, Amy L Herzog wrote:
>   > Sorry to jump in a bit late on this. For our information flow analysis
>   > tools, our instinct is to simply expand the LTS we build from the
>   > policy to include the 'process dyntransition' permission (with a
>   > write-like flow, just like the current 'process transition'
>   > permission). Although it would be fairly easy to collapse domains that
>   > have full dynamic transition permissions to one another, doing so
>   > wouldn't affect the truth of any information flow assertions
>   > (i.e. system security goals) in the system.
>   
>   Hmm...I think it will have to be a "read write" flow, i.e. equivalence
>   required, particularly given the possibility of per-thread contexts
>   introduced by this change (one thread may switch to a different context
>   while another is still running in the old one).

-- 
	Joshua D. Guttman		<guttman@mitre.org>
	MITRE, Mail Stop S119		Office:	+1 781 271 2654
	202 Burlington Rd.		Fax:	+1 781 271 8953
	Bedford, MA 01730-1420 USA	Cell:	+1 781 526 5713


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
