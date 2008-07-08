Subject: Re: releasibility in mcstransd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: Joshua Brindle <method@manicmethod.com>, Paul Moore <paul.moore@hp.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chad Hanson <chanson@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <90C62997-D6C9-4E64-A89F-A5569943DE67@nall.com>
References: <484D91BB.3080904@manicmethod.com> <4864D44E.8010505@redhat.com>
	 <4864EE58.2090108@manicmethod.com> <200806271441.01625.paul.moore@hp.com>
	 <486537FA.2010307@manicmethod.com>
	 <90C62997-D6C9-4E64-A89F-A5569943DE67@nall.com>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 13:11:51 -0400
Message-Id: <1215537111.27975.303.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-07-08 at 10:54 -0500, Joe Nall wrote:
> On Jun 27, 2008, at 1:56 PM, Joshua Brindle wrote:
> 
> > Paul Moore wrote:
> >> On Friday 27 June 2008 9:42:48 am Joshua Brindle wrote:
> >>> I think for the time being we should not be importing the updated
> >>> mcstrans into fedora. There are still some unanswered questions  
> >>> about
> >>> the implementation. We are talking about some of these offline.
> >>
> >> Any particular reason why the discussion isn't online?  Granted I'm  
> >> not
> >> sure I would have much useful to contribute but I do like hearing  
> >> about
> >> what is going on and the discussion behind the decisions ...
> >>
> >
> > Oops, I misspoke. The unanswered questions were on list, how to deal  
> > with the use of private libsepol types, duplicated functions and  
> > missing ebitmap functionality in the library.
> 
> Any progress or thoughts on this?

I think the best way to proceed would likely be to start proposing what
set of interfaces you need from libsepol in order to implement your
functionality w/o binding mcstrans too tightly to the internal policy
representation (such that if we later change the policy internal
representation of a mls range/level, it doesn't break mcstrans at all).
Patches demonstrating such interfaces would be fine too.  We may need
some intermediate data structures that are a little bit abstracted from
the raw policy structures.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
