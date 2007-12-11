Subject: Re: newrole in the background
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: "Reed, Tim (US SSA)" <tim.reed@baesystems.com>, selinux@tycho.nsa.gov
In-Reply-To: <cadfc0e40712110806j5d6676f6j10a8b1dd3c557fa@mail.gmail.com>
References: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net>
	 <cadfc0e40712110806j5d6676f6j10a8b1dd3c557fa@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Dec 2007 13:17:37 -0500
Message-Id: <1197397057.28006.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-11 at 10:06 -0600, Xavier Toth wrote:
> We ended up creating a variant of newrole which doesn't require tty
> access. We did this to run some of our applications in the background
> but still get newroles ability to set the context/level of the child
> and to create a pam session for polyinstantiation. For this to work we
> had to configure our apps into our variants equivalent of
> /etc/selinux/newrole_pam.conf and provide corresponding /etc/pam.d
> files which typically look like :
> #%PAM-1.0
> auth       required     pam_permit.so
> account    required     pam_permit.so
> password   required     pam_permit.so
> session    required     pam_mkpolydir.so debug
> session    required     pam_namespace.so unmnt_remnt
> no_unmount_on_close gen_hash ignore_instance_parent_mode debug
> 
> This variant was based on a Fedora policysoreutils source rpm because
> the RHEL5 version doesn't contain the code to map applications to
> /etc/pam.d files using /etc/selinux/newrole_pam.conf.

As a workaround, you could certainly create a pty in your application
and use that for newrole - that woudl let you use newrole unmodified.

As a longer term solution, I'd suggest making a patch for newrole that
allows it to gracefully function even in the absence of a tty, and get
that upstreamed, so that you can use newrole as is.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
