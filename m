Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1J3JAod031865
	for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 22:19:10 -0500
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1J3KQBV000691
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 03:20:26 GMT
Date: Sun, 18 Feb 2007 21:19:51 -0600
From: Klaus Weidner <klaus@atsec.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs - Resent with additional changes.
Message-ID: <20070219031951.GA9827@w-m-p.com>
References: <45B8ACBF.8090201@redhat.com> <1171663101.20576.147.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171663101.20576.147.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Feb 16, 2007 at 04:58:21PM -0500, Christopher J. PeBenito wrote:
> On Thu, 2007-01-25 at 08:12 -0500, Daniel J Walsh wrote: 
> > The MLS constraints are really screwed up.  Need to come to some kind of
> > agreement between you, klaus and tcs.
> 
> I'm not familiar with the LSPP requirements, so its mainly up to Klaus
> and the TCS guys to iron out what makes sense.

I haven't heard back from TCS about their opinion on this. I would
suggest using the constraints as in Dan's policy (and as used in the
RHEL5 rc) since those are designed to meet LSPP requirements.

Dan, if you need to change the MLS constraints for RHEL5 to be different
from how they are now please let me know.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
