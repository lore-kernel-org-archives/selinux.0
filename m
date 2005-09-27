Subject: Re: [owner@bugs.debian.org: Bug#249499 acknowledged by developer
	(Bug#249499: fixed in pam 0.79-1)]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050927101848.GF11050@lkcl.net>
References: <20050927101848.GF11050@lkcl.net>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 14:30:49 -0400
Message-Id: <1127845849.21671.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-27 at 11:18 +0100, Luke Kenneth Casson Leighton wrote:
> heya folks,
> 
> is this the right thing to have been done?
<snip>
>    * Patch 057: SELinux support:
>      - add support to pam_unix for copying SELinux security contexts when
>        writing out new passwd/shadow files and creating lockfiles
>      - support calling unix_chkpwd if opening /etc/shadow fails due to
>        SELinux permissions
>      - allow unix_chkpwd to authenticate for any user when in an SELinux
>        context (hurray!); we depend on SELinux policies to prevent the
>        helper's use as a brute force tool
>      - also support querying user expiration info via unix_chkpwd
>      - misc cleanup: clean up file descriptors when invoking unix_chkpwd
>        (closes: #248310)
>      - make pam_rootok check the SELinux passwd class permissions, not just
>        the uid
>      - add new pam_selinux module (closes: #249499)
<snip>

That summary looks consistent with the SELinux-related changes in the
Fedora pam package, although one would naturally need to check the code
for consistency.  Looking at the Fedora public CVS tree's pam package, I
see that the main pam selinux patch was upstreamed into pam 0.80.  But
pam-pwdbselinux.patch and pam-0.80-selinux-nofail.patch are separate
patches in the Fedora pam package that don't appear to be upstream yet.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
