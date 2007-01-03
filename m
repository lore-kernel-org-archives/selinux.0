Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l03LbLCZ012490
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 16:37:22 -0500
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l03Lc6V2027719
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 21:38:07 GMT
Date: Wed, 3 Jan 2007 15:37:09 -0600
From: Klaus Weidner <klaus@atsec.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
Message-ID: <20070103213709.GA21450@w-m-p.com>
References: <459BDFD4.7080903@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <459BDFD4.7080903@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 03, 2007 at 11:54:44AM -0500, Daniel J Walsh wrote:
> After one hell of a merge.  :^(
[...]
> The MLS constraints are really screwed up.  Need to come to some kind of 
> agreement between you, klaus and tcs.

I'm not sure what the areas of disagreement are - I didn't see any
opposing opinions after posting the proposed patches (subject "stricter
MLS policy constraints" on this list).

The old "ranged object" constraints violate LSPP requirements, that's why
the change is necessary for compliance. Any trusted apps that need the
old behavior can get it back by using appropriate overrides. If there are
more general problems with the stricter constraints please let me know.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
