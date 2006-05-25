Subject: Re: Fedora Core 5 Tomcat 4 problems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Michael K. Smith" <mksmith@adhost.com>
Cc: SELinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <C09A1F65.25256%mksmith@adhost.com>
References: <C09A1F65.25256%mksmith@adhost.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 07:34:53 -0400
Message-Id: <1148556893.20976.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-24 at 14:34 -0700, Michael K. Smith wrote:
> Back on list.  I have downloaded and installed the reference policy from
> Sourceforge and now have a policy.conf file that I can use.  What would the
> appropriate rule be for addressing the compute_av failure?
> 
> May 27 08:49:31 bmedia kernel: audit(1117208968.030:5): avc:  denied  {
> compute_av } for  pid=1815 comm="su"
> scontext=system_u:system_r:initrc_su_t:s0
> tcontext=system_u:object_r:security_t:s0 tclass=security

You already added this rule via your local module, i.e.
	allow initrc_su_t security_t:security { compute_av };

audit2allow converts audit messages to allow rules for you.

No need to build a custom policy for that purpose.  I mentioned the
upstream policy because while you can fix this via your local module in
the short term, it should be fixed by the upstream policy for everyone
going forward.   Then you can later drop the rule from your local module
when you update to a version that includes it already.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
