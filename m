Date: Wed, 24 May 2006 14:34:13 -0700
Subject: Re: Fedora Core 5 Tomcat 4 problems
From: "Michael K. Smith" <mksmith@adhost.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, <SELinux@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-ID: <C09A1F65.25256%mksmith@adhost.com>
In-Reply-To: <1148495910.24463.513.camel@moss-spartans.epoch.ncsc.mil>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov




On 5/24/06 11:38 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> On Wed, 2006-05-24 at 11:26 -0700, Michael K. Smith wrote:
>> Hi Again:
>> 
>> I'm not seeing any execmod messages in any log.  Have I missed a config
>> parameter that would enable those messages?
> 
> In your original posting to the list, you listed your local policy
> module, and it contained this rule (among others):
> allow initrc_t user_home_t:file execmod;
> 
> Assuming you used audit2allow to generate that policy module, that means
> that audit2allow found an avc message in your log (messages* if not
> running auditd, audit.log* if running auditd) that indicated an execmod
> denial (i.e. a text relocation in a shared library).
> 
> Now, possibly this was not related to the actual problem in su you
> reported and was just leftover in your log from something else.   Ditto
> for the hald_t rule, the pam_console_t rule, and the semanage_t rule.
> In which case only the two rules for initrc_su_t are relevant here, and
> one of those is due to usr_t being on that symlink and home directory.
> The other one (compute_av failure) should likely be allowed in the
> upstream policy, as su -> pam_rootok does need to check a permission to
> see whether the caller is allowed to skip normal password authentication
> (yes if uid 0 and in an authorized domain, no otherwise).

Back on list.  I have downloaded and installed the reference policy from
Sourceforge and now have a policy.conf file that I can use.  What would the
appropriate rule be for addressing the compute_av failure?

May 27 08:49:31 bmedia kernel: audit(1117208968.030:5): avc:  denied  {
compute_av } for  pid=1815 comm="su"
scontext=system_u:system_r:initrc_su_t:s0
tcontext=system_u:object_r:security_t:s0 tclass=security


Thanks,

Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
