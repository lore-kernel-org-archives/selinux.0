Subject: Re: user guide drafts: "Linux Permissions" and "Manual Pages for
	Services"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
        Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Dominick Grift <domg472@gmail.com>
In-Reply-To: <491BB6EE.9010909@redhat.com>
References: <491A3631.8080806@redhat.com>
	 <1226503901.21407.19.camel@moss-spartans.epoch.ncsc.mil>
	 <491BB6EE.9010909@redhat.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 13 Nov 2008 07:59:44 -0500
Message-Id: <1226581184.32412.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-11-13 at 15:11 +1000, Murray McAllister wrote:
> Stephen Smalley wrote:
> > On Wed, 2008-11-12 at 11:49 +1000, Murray McAllister wrote:
> >> Hi,
> >>
> >> The following are drafts for the "Fixing Problems"[1] section. Any 
> >> comments and corrections are appreciated.
> >>
> >> Linux Permissions
> >>
> >> When access is denied, check standard Linux permissions. As mentioned in 
> >> Chapter 2, Introduction, most operating systems use a Discretionary 
> >> Access Control (DAC) system to control access, allowing users to control 
> >> the permissions of files that they own. SELinux policy rules are checked 
> >> after DAC rules. SELinux policy rules are not used if DAC rules deny 
> >> access first.
> >>
> >> If access is denied and no SELinux denials are logged,
> > 
> > Logically you would also mention the dontaudit case here, and how to
> > check for denials hidden by dontaudit rules.
> > 
> How about (keeping in mind I have not really heard of this before):
> 
> dontaudit Rules and Linux Permissions

"Possible Causes of Silent Denials"

> Bugs in applications may cause a lot of SELinux denials, but such 
> denials may not prevent the application from running correctly.

"Applications and system library functions will often probe for access
beyond what they require in order to perform their task.  In order to
maintain least privilege without filling the audit logs with avc denials
from harmless application probing, the policy can silence avc denials
without allowing a permission by using a dontaudit rule.  Such dontaudit
rules are common in the standard policy based on experience with
applications."

>  For 
> these situations, dontaudit rules can be added to policy to prevent log 
> files being filled with denial messages. The downside of this is that, 
> although SELinux denies access, denial messages are not logged, making 
> troubleshooting hard.
> 
> To temporarily disable dontaudit rules, allowing all denials to be 
> logged, run the following command as the Linux root user:
> 
> /usr/sbin/semodule -DB
> 
> The -D option disables dontaudit rules; the -B option rebuilds policy. 
> The dontaudit rules are disabled until policy is rebuilt.

"After running semodule -DB, you can try again to exercise the
application that was encountering a permission denial and see whether
any SELinux denials are reported that are relevant to the application.
Care must be taken in deciding which of these denials should be allowed,
as some should in fact be ignored and handled via dontaudit rules."


>  To rebuild 
> policy and enable dontaudit rules, run the following command as the 
> Linux root user:
> 
> /usr/sbin/semodule -B

"This will restore the policy to its original state."

> For a full list of dontaudit rules, run the sesearch --dontaudit 
> command. Narrow down searches using the -s domain option and the grep 
> command. For example:
> 
> [output from "sesearch --dontaudit -s smbd_t | grep squid
> "]
>
> Refer to Section 7.3.5, “Raw Audit Messages” and Section 7.3.6, “sealert 
> Messages” for information about analyzing denials.
> 
> After resolving any issues found by removing dontaudit rules, or if 
> disabling these rules did not produce denials for your situation, check 
> standard Linux permissions. [rest of Linux Permissions content].
> 
> Thanks.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
