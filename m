Subject: Re: policy patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <200411260027.41899.russell@coker.com.au>
References: <200411260027.41899.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1101756194.3219.5.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 29 Nov 2004 14:23:14 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Thu, 2004-11-25 at 08:27, Russell Coker wrote:
> The attached patch makes some trivial policy changes.
> 
> Allows Debian systems to touch /etc from an init script.
> 
> Only Red Hat needs initrc_t to be able to stat all files from an init script.
> 
> $1_login_t should not inherit a file handle from init (maybe a bug that has to 
> be fixed - it certainly needs something other than a dontaudit).
> 
> Updated policy for the latest version of asterisk and postgrey.
> 
> No domain should have both auth and auth_chkpwd attributes.  If the domain has 
> auth then it will never have a need to run unix_chkpwd.
> 
> Removed some duplicate rules and needless {}.
> 
> Allow kudzu to do everything it wants.
> 
> Mailman should not have a dontaudit for access to src_t.  Any access to src_t 
> is a bug.  The bug that caused this to be added is supposed to be fixed in 
> Fedora now.  If it turns out that /usr/src is accessed for other reasons then 
> it's more bugs we need to fix and we don't want it hidden.
> 
> Don't use a dontaudit rule for rhgb_t access to /tmp, that will cause us pain 
> later on if rhgb is changed to need such access.
> 
> Don't use the root_dir_type attribute for type tftpdir_t, it's usually not the 
> root of a file system, and there's no good reason for using it.  Maybe we can 
> do as the comment suggests and remove that attribute entirely?
> 
> Put in a dontaudit rule to stop some annoying messages on sighup.
> 
> Removed the CVS comment line from amanda.fc.  We don't seem to be using CVS in 
> a way that makes sense of that line and it just makes for needless file 
> changes on every update.  Best to be consistent with the other files and 
> remove that line.
> 
> /var/spool/mqueue is part of Sendmail.  It should not be referenced apart from 
> through the sendmail policy.
> 
> $1_tty_device_t is not a file, the attribute file_type does not belong.  Also 
> updated types/file.te to allow the terminal devices to be associated with the 
> root fs without this attribute.
> 
> mozilla should not be permitted to write to random devices (this means append 
> too).  Now that we aren't labelling a /usr/tmp sym-link as tmp_t we can 
> remove the access to tmp_t:lnk_file.
> 
> gam_server seems to run wild and want to explore every part of the file 
> system.  I put in a ifdef(`distro_redhat' as Fedora is the only distribution 
> currently relying on gam.  I think that some changes need to be made to gam.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
