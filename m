Subject: Re: user guide draft: "SELinux Contexts and Attributes" review
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48BCB564.4010404@redhat.com>
References: <48B4FA3E.3000602@redhat.com>
	 <1219844836.5708.92.camel@moss-spartans.epoch.ncsc.mil>
	 <48BB93D2.8090909@redhat.com>  <48BCB564.4010404@redhat.com>
Content-Type: text/plain
Date: Tue, 02 Sep 2008 09:09:45 -0400
Message-Id: <1220360985.26711.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-09-02 at 13:39 +1000, Murray McAllister wrote:
> How about:
> 
> The security level is an attribute of MLS and Multi-Category Security 
> (MCS). The first part of the security level is the sensitivity, for 
> example, s0 is a sensitivity. The s0 sensitivity is the only sensitivity 
> used when running the SELinux targeted policy. Optionally, the security 
> level can have a list of categories. Categories are used to categorize 
> data and add an extra level of security. If a user does not have access 
> to the same or higher categories than an object, and DAC and SELinux 
> rules allow access, access to that object is denied. For example, if a 
> user only has access to the c0 category, and an object is labeled with 
> the c1 category, access is denied. Security levels can be translated to 
> an easier-to-read form, such as CompanyConfidential. For an example list 
> of security levels and their translations, refer to the 
> /etc/selinux/targeted/setrans.conf file.
> 
> When running the SELinux MLS policy, a sensitivity and categories are 
> compulsory. MLS allows sensitivities s0 through to s9.

I think they go up to s15 in the -mls policy configuration, although it
is all defined as part of the policy configuration and there is no
implementation-defined hard limit.

>  MLS enforces the 
> Bell-LaPadula Mandatory Access Model[1], and is used in Labeled Security 
> Protection Profile (LSPP) environments. To use MLS restrictions, install 
> the selinux-policy-mls package, and configure MLS to be the default 
> SELinux policy.

Caveat:  the -mls policy as shipped by Fedora/RH intentionally omits
many program domains that were not part of the evaluated configuration,
and thus is not usable on a desktop workstation (no X support).  However
you can build a mls policy from the upstream refpolicy that includes all
program domains.

> from semanage login -l, is the range the "s0-s0" part of the MLS/MCS 
> label? And in MLS, this could be something like "s0-s3"?

Yes, s0-s0 is a MLS/MCS range where the low level and the high level are
identical.  It could just as easily be written as just "s0" since that
implies s0-s0.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
