Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lACGf5MB022289
	for <selinux@tycho.nsa.gov>; Mon, 12 Nov 2007 11:41:05 -0500
Received: from palrel13.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lACGf4uD026588
	for <selinux@tycho.nsa.gov>; Mon, 12 Nov 2007 16:41:04 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v6 09/13] SELinux: Better integration between peer labeling subsystems
Date: Mon, 12 Nov 2007 11:40:59 -0500
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
References: <20071109205331.31738.75266.stgit@flek.americas.hpqcorp.net> <20071109212439.31738.39168.stgit@flek.americas.hpqcorp.net> <Xine.LNX.4.64.0711120932370.7114@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0711120932370.7114@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711121140.59611.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 11 November 2007 5:34:27 pm James Morris wrote:
> On Fri, 9 Nov 2007, Paul Moore wrote:
> > +	/* Between selinux_compat_net and selinux_policycap_netpeer this is
> > +	 * starting to get a bit messy - we need to setup a timetable for
> > +	 * deprecating some of this old/obsolete functionality so we can
> > +	 * reclaim some level of sanity in this function. */
>
> I don't think we can do anything which could potentially break userspace
> now.

Yeah, I've already had one very long day as a result of that, I'm not in any 
hurry to do that again :)

On a serious note, I thought we could remove specific features after a certain 
period of time, i.e. Documentation/feature-removal-schedule.txt?  My thought 
is that eventually we can at least remove compat_net, or is that too drastic?

> So, this one really needs to be right :-)

Yeah, this is the one thing that still worries me and one of the main reasons 
I keep pushing RFC patches so often.

Personally, I'm still a little frustrated at how ugly that function looks.  
I'm debating putting a check near the top to see if any of 
the "compatibility" flags are set, meaning an older policy, and if it is just 
handing off control to a compat function which handles all the ugliness.  
There might be some duplication of code but the sock_rcv_skb() function would 
be _much_ cleaner and faster in the "current policy" case.

Actually, I think I just talked myself into it ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
