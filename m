Subject: Re: Desktop apps interoperability
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>,
   "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1111985855.1514.70.camel@cobra.ivg2.net>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 08:43:39 -0500
Message-Id: <1112017419.2914.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-03-27 at 23:57 -0500, Ivan Gyurdiev wrote:
> Fundamentally, what I want to know is:
> 
> 1) Do desktop apps need to be confined? Is it a good idea to confine
> them?

Yes.

> 2) If so, a shared data type is needed for interoperability. 
> Is ROLE_home_t acceptable for that purpose.

A shared data type may be fine, but ROLE_home_t isn't what you want to
use.  And yes, separating settings from data is useful, and yes,
littering user's top-level home directories with application settings
considered harmful. 

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
