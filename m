Subject: Re: libselinux patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB0624.5060907@redhat.com>
References: <45DB0624.5060907@redhat.com>
Content-Type: text/plain
Date: Wed, 21 Feb 2007 12:21:07 -0500
Message-Id: <1172078467.14363.281.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 09:31 -0500, Daniel J Walsh wrote:
> This patch initializes all swig parameters to prevent possible crashes 
> in python.

I merged this part.

> Also changes is_selinux_enabled to work even if  signaled and not have 
> short reads.

But not this one.  Still working out the best solution for
is_selinux_enabled, as per the ongoing discussion on the list.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
