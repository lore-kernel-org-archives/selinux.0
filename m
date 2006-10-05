Subject: Re: [RFC PATCH] newrole suid breakdown
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        jdesai@us.ibm.com
In-Reply-To: <452528C0.1050907@us.ibm.com>
References: <452432FA.1060009@us.ibm.com> <45250F35.6030204@redhat.com>
	 <452519BC.1060204@us.ibm.com> <45251C15.6020506@redhat.com>
	 <452528C0.1050907@us.ibm.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 13:56:46 -0400
Message-Id: <1160071006.2132.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-05 at 10:46 -0500, Michael C Thompson wrote:
> Daniel J Walsh wrote:
> > I think this is all you need.  Audit can handle the fact that it can't 
> > send a message by sending it to /var/log/messages.  And if You use 
> > pam_namespace.so you should fail if you are not setuid and you are not 
> > root.
> 
> True, but right now we are set to abort newrole if those actions are 
> expected to succeed (we have compiled with the respective _PRIV). Should 
> that behavior be changed?

No.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
