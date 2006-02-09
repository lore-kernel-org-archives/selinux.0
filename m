Subject: Re: [RFC][PATCH] collect security labels on user processes
	generating audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: James Morris <jmorris@redhat.com>,
   "Timothy R. Chavez" <tinytim@us.ibm.com>, selinux@tycho.nsa.gov,
   Linux Audit Discussion <linux-audit@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0602091013450.388@excalibur.intercode>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <Pine.LNX.4.64.0602091013450.388@excalibur.intercode>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 12:43:55 -0500
Message-Id: <1139507035.2872.214.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-09 at 10:15 -0500, James Morris wrote:
> On Thu, 9 Feb 2006, James Morris wrote:
> 
> > You also need to verify the policy serial number.
> > 
> > I wonder if it might be better to use the security context directly.
> 
> Also consider adding a security field to netlink messages, to managed by 
> the LSM.

A generic security blob would require full lifecycle maintenance,
including the old sk hooks that were rejected for 2.5.  I also think it
is a mistake to generalize the audit system's use of SELinux, as I don't
think that any other LSM is likely to provide LSPP functionality, so we
might as well just convert all of these audit-SELinux interfaces into
direct SELinux calls IMHO.  At least in the long term if not
immediately.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
