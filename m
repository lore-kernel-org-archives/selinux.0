Subject: Re: Added is_context_configurable function
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
In-Reply-To: <41E3FAF4.2060109@redhat.com>
References: <41E2FEF4.5070604@redhat.com>
	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
	 <41E3FAF4.2060109@redhat.com>
Content-Type: text/plain
Message-Id: <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 11 Jan 2005 15:00:11 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-11 at 11:12, Daniel J Walsh wrote:
> I think this is more flexible, in that it allows users to specify the 
> location of these files versus policy.
> IE I create a new top level directory /rsync which I want to label 
> ftp_anon_t, I don't want to have to specify
> ftp_anon_t is an alternative to default_t.

You could certainly specify a /rsync/(/.*)? entry in file_contexts that
had both contexts listed.  Ordinary user shouldn't be able to
create/populate /rsync anyway without administrative setup.

Failing to associate the context with a location in any manner means
that setfiles/restorecon will fail to fix the label on e.g. /etc/shadow
if it happens to get one of these configurable types at some point. 
Admittedly, getting to that point requires some kind of serious error in
the first place, but running fixfiles relabel will no longer correct
such errors for you.

BTW, customizable or alternatives seems better than configurable.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
