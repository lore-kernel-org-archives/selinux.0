Subject: audit2allow --tefile/--fcfile support, genhomedircon bug fix,
	semodule* man pages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux-dev@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <438DF679.1060007@redhat.com>
References: <1133215231.19778.28.camel@www.lutty.net>
	 <438C82A9.3060804@redhat.com>
	 <1133364595.26593.320.camel@moss-spartans.epoch.ncsc.mil>
	 <438DF679.1060007@redhat.com>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 10:21:37 -0500
Message-Id: <1133450497.26593.448.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-30 at 13:59 -0500, Daniel J Walsh wrote:
> Updated previous patch to add --fcfile and --tefile to  auditallow.
> 
> Basically allows you to  generate a reference policy te file from an old 
> te file.  Also allows you to specify a fcfile to create a complete 
> module package.
> 
> genhomedircon has a bug in it where /sbin/nologin is a valid shell.
> 
> Previous man pages also included.

Merged into policycoreutils 1.27.33, with some editing of the semodule*
man pages.  Note that we still need a man page for checkmodule, the
program to compile a policy module source file to a policy module binary
suitable for packaging by semodule_package.  

We should likely pull some of the text from selinux-doc/README.MODULES
into the relevant man pages as examples, similar to the example section
for audit2allow.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
