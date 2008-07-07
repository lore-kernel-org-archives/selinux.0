Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m67L7ip5021130
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 17:07:44 -0400
Received: from e33.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m67L7hmx018367
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 21:07:44 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67L7hqI026425
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 17:07:43 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m67L7gGf128832
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 15:07:42 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m67L7gd4027303
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 15:07:42 -0600
Date: Mon, 7 Jul 2008 16:07:41 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: ltp-list@lists.sourceforge.net, SELinux <selinux@tycho.nsa.gov>,
        David Howells <dhowells@redhat.com>, Andrew Morgan <morgan@kernel.org>
Subject: Re: running filecaps ltp test
Message-ID: <20080707210741.GA13042@us.ibm.com>
References: <20080707184252.GC22937@us.ibm.com> <1215456424.27975.165.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1215456424.27975.165.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> 
> On Mon, 2008-07-07 at 13:42 -0500, Serge E. Hallyn wrote:
> > It looks like unconfined_t is not granted setfcap capability.  So
> > when running ltp as unconfined_t, the file capabilities test fails.
> > I'm just wondering what the right answer is:
> > 
> > 	1. require running ltp as an administrative type
> > 	2. give ltp a custom policy module to create an ltp_t
> > 	3. give setfcap to unconfined_t
> 
> unconfined_t should have all capabilities already.
> Policy version?

Hmm yeah, I see that in the reference policy...  I've not had the chance
to test it myself.  David had found this on his Fedora 9 machine.

David, what policy version?

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
