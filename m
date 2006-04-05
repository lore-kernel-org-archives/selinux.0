Subject: Re: rsync resetting contexts in /var/www
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: "J. Simonetti" <jsimonetti@denit.net>
Cc: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
In-Reply-To: <1144234218.7521.70.camel@jeroen.office.denit.net>
References: <1144234218.7521.70.camel@jeroen.office.denit.net>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 13:56:13 -0400
Message-Id: <1144259773.25790.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-04-05 at 12:50 +0200, J. Simonetti wrote:
> Hello list,
> 
> I'm running into a problem with selinux on FC4
> (selinux-policy-targeted-1.27.1-2.22).
> 
> I'm using rsync to build a local fedora mirror. I'm rsyncing
> to /var/www/mirror with has a context of
> root:object_r:httpd_sys_content_t
> 
> However rsync seems to insist on writing the files synched in this
> directory as root:object_r:var_t.
> This results in a 403 error when trying to access the files via the web
> because apache can't read the files.
> 
> Is there a way for me to force rsync to create files in a certain
> context other then running chcon -R everytime rsync finishes?

rsync -X should preserve extended attributes, including the SELinux
attribute, from the original files.  Not sure if that addresses your
issue or not.  In the absence of -X, rsync should just be creating the
new files with the default behavior, i.e. they should just inherit from
the parent directory.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
