Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8DLDr3Y011034
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 17:13:53 -0400
Subject: Re: [PATCH] refpolicy: add X object classes to unconfined_t
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1158155277.26420.70.camel@sgc>
References: <1158088282.7554.95.camel@moss-huskies.epoch.ncsc.mil>
	 <1158155277.26420.70.camel@sgc>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 17:13:52 -0400
Message-Id: <1158182032.7554.190.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-13 at 09:47 -0400, Christopher J. PeBenito wrote:
> On Tue, 2006-09-12 at 15:11 -0400, Eamon Walsh wrote:
> > I'm working on the XSELinux code, which has just been brought up to date
> > with the current X.org code base.
> 
> Is there any idea when this is going to be merged into xorg trunk?

X.org is on a 6-month cycle with the 7.2 release scheduled for November.
I'm targeting the 7.3 release, but I may be able to get the hooks layer
into 7.2.

In the meantime, the code can be checked out of the XACE-SELINUX branch
of the X.org "xserver" git repository.  It it fully up to date with the
trunk, and builds and runs fine, except that there isn't any policy
support for it yet other than what TCS has done.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
