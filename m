Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
In-Reply-To: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 09:09:10 -0500
Message-Id: <1137766150.3648.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-19 at 16:45 -0500, Joshua Brindle wrote:
> - add semanage_can_write to libsemanage which does a silent check for
> access on the active store, modules directory and binary policy
> directory
> - chance semanage_is_managed to use can_write instead of create_store
> for access check
> - add access check to seobject.py, in semanageRecord init

Also, how do you envision implementing this interface for the policy
server backend?  Same question exists for semanage_is_managed I suppose,
but that interface seems a little more general in concept.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
