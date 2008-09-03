Subject: Re: user guide draft: "SELinux Contexts and Attributes" review
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48BE28D5.1080902@redhat.com>
References: <48B4FA3E.3000602@redhat.com>
	 <1219844836.5708.92.camel@moss-spartans.epoch.ncsc.mil>
	 <48BB93D2.8090909@redhat.com>  <48BCB564.4010404@redhat.com>
	 <1220360985.26711.43.camel@moss-spartans.epoch.ncsc.mil>
	 <48BE28D5.1080902@redhat.com>
Content-Type: text/plain
Date: Wed, 03 Sep 2008 09:01:26 -0400
Message-Id: <1220446886.6034.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-09-03 at 16:04 +1000, Murray McAllister wrote:
> How about:
> 
> The level is an attribute of MLS and Multi-Category Security (MCS). The 
> first part of the level, s0-s0, is the sensitivity.

Actually, s0-s0 is a MLS range where the low level has sensitivity s0
and no categories and the high level has sensitivity s0 and no
categories.

>  The s0 sensitivity 
> is the only sensitivity used for MCS. Since the format of the level is 
> the same for MLS and MCS, and MLS supports ranges of sensitivities, a 
> sensitivity such as s0-s0 is the same as s0 when using MCS.

No, s0-s0 is always the same as just s0, regardless of MCS or MLS.  Just
like s1-s1 is the same as just s1.  Versus a non-trivial range like
s0-s1 or s0-s3.

>  Optionally, 
> the level can have a list of categories.

Each level in the range can have a list of categories, so you can have:
	s0:c0,c2-s3:c0,c1,c2
The only requirement is that the high level (s3:c0,c1,c2) must dominate
the low level (s0:c0,c2), i.e. s3 >= s0 and {c0, c1, c2} is a superset
of {c0, c2}.

Somewhere you should likely explain the notation:
sN represents a sensitivity with value N, where sN dominates sM if N >=
M.
cN represents category N, where a category set dominates another if it
is a superset of it.
The sN and cN values can then be mapped to human-readable labels using
setrans.conf.

>  Categories are used to 
> categorize data and add an extra level of security. Fedora 10 supports 
> 1024 different categories: c0 through to c1023. If a user is not 
> authorized for all of the categories of an object, and DAC and SELinux 
> rules allow access, access is denied.

That would be DAC and type enforcement rules.  SELinux rules include TE
rules, RBAC rules, and constraints (including MLS/MCS).

>  For example, if a user is only 
> authorized for the c0 category, and an object is labeled with the c0 and 
> c1 categories, access is denied. If a user is authorized for the c0 and 
> c1 categories, and an object is only labeled with the c0 category, 
> access is allowed. Levels can be translated to an easier-to-read form, 
> such as CompanyConfidential.  For an example list of levels and their 
> translations, refer to the /etc/selinux/targeted/setrans.conf file.
> 
> MLS allows ranges of sensitivities, not just s0. MLS enforces the 
> Bell-LaPadula Mandatory Access Model, and is used in Labeled Security 
> Protection Profile (LSPP) environments. To use MLS restrictions, install 
> the selinux-policy-mls package, and configure MLS to be the default 
> SELinux policy. The MLS policy shipped with Fedora omits many program 
> domains that were not part of the evaluated configuration, and 
> therefore, MLS on a desktop workstation is unusable (no support for the 
> X Window System); however, an MLS policy from the upstream SELinux 
> reference policy[1] can be built that includes all program domains.
> 
> I left out details to try to limit mistakes...
> 
> [1] http://oss.tresys.com/projects/refpolicy
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
