Subject: Re: load_policy with latest strict policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200504142040.48997.russell@coker.com.au>
References: <200504142040.48997.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 08:39:25 -0400
Message-Id: <1113482365.373.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-14 at 20:40 +1000, Russell Coker wrote:
> The attached patch is needed to allow load_policy to detect SE Linux.  Without 
> this access it claims to be running on a non-SE system and refuses to do 
> anything.

The patch to load_policy has been reverted, as it was a bad idea in the
first place (it prevents using load_policy to perform an initial policy
load in the case where this has not occurred already, e.g. from anaconda
during install).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
