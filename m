Subject: Re: Adding more NSCD constants
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1121785909.22954.2.camel@celtics.boston.redhat.com>
References: <1121785909.22954.2.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 09:12:54 -0400
Message-Id: <1122383574.4470.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-07-19 at 11:11 -0400, Ivan Gyurdiev wrote:
> How hard is it to add more constants to av_permissions.h?
> This file says "automatically generated" but I'm not sure
> what it's generated from.
> 
> If we add another NSCD cache (which is the plan... for the 
> selinux_users nss service), then we need more constants for
> NSCD.

Not sure that this is still relevant, but the method for adding such
definitions is to modify policy/flask/access_vectors, run make in
policy/flask, and then copy over the generated headers to libselinux and
(if they are needed) to the SELinux kernel module.

Tresys has plans to migrate at least the userspace class/permission
definitions to a runtime registration via the userspace security server
rather than being fixed constants.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
