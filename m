Subject: Re: Getting the real task name in avc messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: James Morris <jmorris@redhat.com>, Steve G <linux_4ever@yahoo.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <424C1562.5060108@trustedcs.com>
References: 
	 <Xine.LNX.4.44.0503301704130.15296-100000@thoron.boston.redhat.com>
	 <424B27BA.8060706@trustedcs.com>
	 <1112272239.11216.9.camel@moss-spartans.epoch.ncsc.mil>
	 <424C1562.5060108@trustedcs.com>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 10:20:02 -0500
Message-Id: <1112282402.11216.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-31 at 09:21 -0600, Darrel Goeddel wrote:
> I didn't not think so, but I wasn't 100% sure.  I only did a quick glance before 
> and thought it best to be safe.  Upon further investigation, it sure looks to be 
> fine without holding the task lock.

Yes, AFAICS you only need to use the helper/lock when getting the comm
of another task, not your own, as only you can change your own comm.
But for some reason the core code has been rewritten to use this helper
always (e.g. see sys_prctl), possibly they expect this to change in the
future, i.e. allow another task to set your comm?

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
