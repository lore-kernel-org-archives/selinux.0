Subject: Re: Added is_context_configurable function
From: Colin Walters <walters@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41E43DD8.5000306@redhat.com>
References: <41E2FEF4.5070604@redhat.com>
	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
	 <41E3FAF4.2060109@redhat.com>
	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
	 <41E43784.2060406@redhat.com>
	 <1105475738.20566.150.camel@moss-spartans.epoch.ncsc.mil>
	 <41E43DD8.5000306@redhat.com>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 17:25:49 -0500
Message-Id: <1105482350.4614.8.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-11 at 15:58 -0500, Daniel J Walsh wrote:

> This might be a conflict between strict and relaxed policy.  I am 
> getting bugs from users who setup the apache web servers
> with files in different locations than the preordaned.  I am looking for 
> an easy way for them to configure their system and make
> it survive a restoration of file labels. 

Now, part of this problem is that we're asking users to run "fixfiles
relabel" so often.  This is really a quite drastic measure, and we
should be solving some of these cases automatically.  For example, when
PostgreSQL was added to the targeted policy, or when we move files
around between FC3 and FC4, and users want to upgrade.  One approach
here might be to have an idea of file system label "versions".  Let's
call the contexts in the current rawhide to be version 0.  This version
is stored in /.label_version.  Then let's say we add postgres, and we
need to ensure that it's labeled correctly.  We call this version 1.
Inside the postinst, we have code like this:

# Increase this on every incompatible change to file_contexts
curver=1

fsver=$(cat /.label_version)
if test $fsver -lt 1; then
  relabel_package postgresql
fi

Then later, we move the dhcpd files around, so we just suffix this code:

if test $fsver -lt 2; then
  relabel_package dhcpd
fi

etc.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
