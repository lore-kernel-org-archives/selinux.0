Subject: Re: [PATCH] policy defined range transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <4213C04F.1000307@trustedcs.com>
References: <4213C04F.1000307@trustedcs.com>
Content-Type: text/plain
Message-Id: <1108655434.24494.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 17 Feb 2005 10:50:34 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-16 at 16:51, Darrel Goeddel wrote:
> Attached are patches that implement range_transition statements for the policy. 
>   The range_transitions will be used for admin users invoking certain programs. 
>   Examples include starting/stopping daemons, working with log files, etc.  This 
> allows the admin to perform tasks that need to be done at a certain MLS level 
> without the need to manually switch level before doing so.  It is the MLS 
> counterpart to type_transition and role_transition (more akin to role_transition 
> because it only deals with process transitions).  The syntax is:
> 
> range_transition "process domain" "executable type" "new range";
> 
> The mlsconstraints (for process transition) requires either that the current 
> domain has the privilege to change its level (mlsprocsetsl), or that the current 
> domain has the privilege to "use" a range_transition (privrangetrans) AND that 
> the new domain has the mlsrangetrans attribute.  The patch does not currently 
> add the privrangetrans to any domains (a likely candidate is sysadm_t).  The MLS 
> range that is transitioned to is also subject to the usual restriction of 
> falling within the user's allowed MLS range.
> 
> PLEASE NOTE:  This patch changes the binary policy format.  However, it does not 
> change the binary policy version.  The binary policy version was bumped to 19 
> for the previous mls changes and has not yet been included in an official 
> release - these changes would become a part of the version 18 to 19 update. 
> People keeping up with the latest CVS snapshot will need to recompile the 
> kernel, libsepol, checkpolicy, and the policy.

Thanks, merged into sourceforge CVS (kernel >= 2.6.10-selinux6, libsepol
>= 1.3.5, checkpolicy >= 1.21.4).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
