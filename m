Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7E0TfHa026731
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2003 20:29:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7E0SLOD027510
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 00:28:21 GMT
Received: from unthought.net ([212.97.129.24])
	by jazzswing.ncsc.mil  with ESMTP id h7E0SKKO027395
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 00:28:21 GMT
Date: Thu, 14 Aug 2003 02:28:16 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: russell@coker.com.au, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fwd: [JS] Suse on IBM eServer achieves EAL2+ security
Message-ID: <20030814002816.GB11586@unthought.net>
References: <200308061046.16095.russell@coker.com.au> <87oez2n612.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <87oez2n612.fsf@deneb.enyo.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 06, 2003 at 05:46:01PM +0200, Florian Weimer wrote:
> Russell Coker <russell@coker.com.au> writes:
> 
> > Of course Linux didn't get the highest rating possible, it seems
> > that Reuters made a mistake in this regard.  EAL2 is not the highest
> > rating,
> 
> Isn't it the highest rating possible with the current feature set
> (that is, no ACLs on anything)?

Note:
I state the following simply as someone who's been attempting to grasp
the common criteria - I may be wrong, although I don't think so, but I
would appreciate corrections.


First of all, SuSE does have POSIX ACLs.

They were certified EAL2+, but not against any particular protection
profile - which basically means they are "somewhat confident" that their
system performs some - by SuSE - specified security functions reliably.

(I don't mean to sound like the certification doesn't matter - I think
it's a good thing - it's a step in the right direction)

Usually, for a better measure of the actual feature set of the security
functions in a system, one would certify it against a pre-defined
protection profile.

For example, the CAPP (which sort-of corresponds to the old C2
certification from TCSEC).  Or the LSPP (which sort-of corresponds to
the old B1 certification from TCSEC).

They did not do that. In the introduction in their "security target"
document, they state why they did not go after the CAPP (too many
changes would be needed).

By the way, you do not need ACLs to be certified against CAPP.
Traditional "UNIX" permissions (user/group/owner) are sufficient.

In order to get an idea about why this all matters, you might want to
look at Windows 2000 versus Solaris 8 versus Trusted Solaris 8.

All three systems have EAL4.  So, on the surface, there is no
difference.  Hmm....  Yep, there is a caveat:  Win2k and Sol8 are both
certified EAL4 against CAPP.  Trusted Solaris 8 is certified EAL4
against the LSPP.

The EAL matters. But the PP matters too.

Reporters don't know this   :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
