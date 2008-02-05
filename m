Subject: Re: matchpathcon flags
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1202241756.7533.78.camel@gorn>
References: <1202241756.7533.78.camel@gorn>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 15:36:16 -0500
Message-Id: <1202243776.27371.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-02-05 at 15:02 -0500, Christopher J. PeBenito wrote:
> I was trying to disable matchpathcon's validation of file contexts
> because I wanted to be able use it in a python script to match against a
> file_contexts that didn't have valid contexts on the running system
> (file_contexts were standard, system was mcs).  However, explicitly
> clearing MATCHPATHCON_VALIDATE still resulted in errors both on stable
> and trunk.  Is this the way the flag is intended to work?

The flag just controls whether all entries are validated upon
matchpathcon_init (or first call to matchpathcon) or lazily validated on
use by matchpathcon just prior to returning them.  But they always get
validated/canonicalized eventually.

It sounds like you want to do something similar to setfiles for -c
(validate against another policy), where it overrides the callback with
its own function via set_matchpathcon_canoncon() [stable] or
selinux_set_callback(SELINUX_CB_VALIDATE...).

> I've attached a modified utils/matchpathcon.c that I used for testing
> the lib (I wanted to make sure it was the lib and not the python
> wrapper).  I was trying to test fcglob matches vs the original
> matchpathcon "fcregex".  So I was doing
> 
> ./matchpathcon -f file_contexts.orig/file_contexts -V /bin/bash
> 
> with and without -V (the file_contexts is in the fcglob refpolicy
> branch).  On stable it always reports invalid context (and invalid
> argument) and on trunk it always reports invalid argument.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
