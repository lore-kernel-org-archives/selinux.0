Subject: Re: user guide drafts: "Linux Permissions" and "Manual Pages for
	Services"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
        Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>
In-Reply-To: <491A3631.8080806@redhat.com>
References: <491A3631.8080806@redhat.com>
Content-Type: text/plain
Date: Wed, 12 Nov 2008 10:31:41 -0500
Message-Id: <1226503901.21407.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-11-12 at 11:49 +1000, Murray McAllister wrote:
> Hi,
> 
> The following are drafts for the "Fixing Problems"[1] section. Any 
> comments and corrections are appreciated.
> 
> Linux Permissions
> 
> When access is denied, check standard Linux permissions. As mentioned in 
> Chapter 2, Introduction, most operating systems use a Discretionary 
> Access Control (DAC) system to control access, allowing users to control 
> the permissions of files that they own. SELinux policy rules are checked 
> after DAC rules. SELinux policy rules are not used if DAC rules deny 
> access first.
> 
> If access is denied and no SELinux denials are logged,

Logically you would also mention the dontaudit case here, and how to
check for denials hidden by dontaudit rules.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
