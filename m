Subject: Re: Ok I plead ignorance to the way MLS works.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <430CAE01.70405@redhat.com>
References: <430A33E5.1030100@redhat.com>
	 <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>
	 <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil>
	 <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>
	 <430C75B4.3020008@redhat.com>
	 <1124892792.11553.26.camel@moss-spartans.epoch.ncsc.mil>
	 <430C8944.6090306@redhat.com>  <430CA3EC.8080102@trustedcs.com>
	 <1124902596.11553.66.camel@moss-spartans.epoch.ncsc.mil>
	 <430CAE01.70405@redhat.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 13:40:49 -0400
Message-Id: <1124905249.11553.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-24 at 13:27 -0400, Daniel J Walsh wrote:
> Ok, I changed the kernel to s0, and now all domains run in s0.  Problem 
> is I want root to login as
> s0:c0.c127
> 
> I changed root default context file 
> (/etc/selinux/targeted/contexts/users/root)  to
> 
> system_u:system_r:local_login_t:s0 system_r:unconfined_t:s0:c0.c127
> 
> But when I login I get
> 
> root:system_r:unconfined_t:s0
> 
> login is running as
> system_u:system_r:local_login_t:s0 
> 
> Should it be running with a range?
> Do I need to change login policy?
> I see no errors...

Hmmm...looks like you have to transition login to a range via a
range_transition rule on login_exec_t in order for the current MLS logic
to permit the user to login at a different level.

Also, I think you want root's default level to still be s0, but his
range to be s0-s0:c0.c127, so that his clearance will be set to that
value.  You want the current/low level to be s0 so that files he creates
default to no categories, but his high/clearance level to be his
authorized set of categories so that he is allowed by the MCS
constraints to set any of those categories on files he owns.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
