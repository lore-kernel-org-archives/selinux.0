Subject: Re: Busted by constraints.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <428917F4.6030203@redhat.com>
References: <428368FF.2080603@redhat.com>
	 <1115908243.32202.114.camel@moss-spartans.epoch.ncsc.mil>
	 <42836C4C.6010301@redhat.com>
	 <1115996428.3576.47.camel@moss-spartans.epoch.ncsc.mil>
	 <1116269095.28782.102.camel@moss-spartans.epoch.ncsc.mil>
	 <428917F4.6030203@redhat.com>
Content-Type: text/plain
Date: Tue, 17 May 2005 08:05:05 -0400
Message-Id: <1116331505.917.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-05-16 at 18:00 -0400, Daniel J Walsh wrote:
> I think, this patch is needed to export symbols of newly added libsepol 
> functions. 
> 
> Also policycoreutils-rhat.patch needed to build on 64 bit platforms, 
> plus some other stuff.

Also, I specifically put it into sbin rather than bin because you need
to be able to read the policy and the audit log in order to use it
effectively, so it didn't seem overly useful to put it into bin.

Note that the output has changed somewhat with my last patch from the
sample messages I posted earlier (that you included into the man page).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
