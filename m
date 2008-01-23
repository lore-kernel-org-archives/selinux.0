Subject: Re: Patch to use new audit2why interface in via audit2allow
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4787DB82.70609@redhat.com>
References: <4787DB82.70609@redhat.com>
Content-Type: text/plain
Date: Wed, 23 Jan 2008 16:01:27 -0500
Message-Id: <1201122087.7025.329.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-01-11 at 16:11 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Added a --why qualifier to audit2allow, which gives the same output as
> audit2why.
> 
> Removed audit2why.c and replaced it with a script
> 
> #!/bin/sh
> /usr/bin/audit2allow -w $*
> 
> This way audit2why can take advantage of the parsing available in
> audit2allow.

Merged with some cleanups, including minor changes to the output to be
more readable and fix a typo there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
