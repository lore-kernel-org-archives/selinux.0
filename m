Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IFDuRb002322
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 11:13:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IFDrAT026827
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 15:13:54 GMT
Date: Tue, 18 May 2004 15:11:12 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Message-ID: <20040518151112.GF24917@lkcl.net>
References: <20040518104026.GC24333@lkcl.net> <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil> <20040518130244.GB24917@lkcl.net> <1084886403.28966.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084886403.28966.76.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 09:20:03AM -0400, Stephen Smalley wrote:
> On Tue, 2004-05-18 at 09:02, Luke Kenneth Casson Leighton wrote:
> >  given the number of errors i am seeing, and given that they won't
> >  go away, perhaps there is some breakdown in communication between
> >  the rules being in the policy.conf file and their application to
> >  packages.
> 
> They aren't applied until you compile that policy.conf via checkpolicy
> and load the resulting binary policy into the kernel.  make load in the
> policy directory will do that for you.
 
 okay, yes, done that.

> >  for example, should i be doing a make relabel every time i add
> >  some new rules?
> 
> No.  You only have to relabel if you have altered the file contexts
> configuration in some manner (but note that this is true if you enable
> additional .te files, as that automatically requires their .fc files).

 okay, so i... didn't add anything to file_contexts, i only
 created a domain/program/localstuff.te and ... hm, well i
 _did_ create a blank file_contexts/programs/localstuff.fc,
 so i'm doing a make relabel anyway, just in case.

 as i understand it, the domains define what is allowed, and the
 file_contexts define if you will... the starting points of those
 "allowances" [ i know that's clumsily put ].

 e.g. file_contexts/program/xdm.fc has as its first line:

 /usr/bin/[xgkw]dm       -- system_u:object_r:xdm_exec_t

 therefore, the programs gdm, xdm, kdm and wdm all have type xdm_exec_t
 therefore, according to line 24 of domains/programs/xdm.te, gdm,
 xdm, kdm and wdm are all allowed to automatically transition from
 the initialisation context into a new context named xdm_t.

 therefore, the programs gdm, xdm, kdm and wdm are all allowed to do
 the things that are mentioned as allow xdm_t etc.

 ... so why, if i [appear to be] doing things correctly, do i still
 get errors, for example, when i have explicitly added:

 allow xdm_xserver_t var_lib_t:file { getattr read };

 okay, just a guess: when you declare an allow, are the relevant
 permissions added or replaced if there already exists, say,
 allow xdm_xserver_t var_lib_t:file { read };

 and i then add, in a following line to policy.conf : 
 allow xdm_xserver_t var_lib_t:file { getattr };

 do i end up with _only_ getattr permissions or do i end up
 with both read _and_ getattr?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
