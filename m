Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IHJ1Rb003614
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:19:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IHIxAR007204
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 17:18:59 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4IHIwHn007201 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 17:18:58 GMT
Subject: Re: list of permissions created by allow2audit: what do i do now?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040518151112.GF24917@lkcl.net>
References: <20040518104026.GC24333@lkcl.net>
	 <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil>
	 <20040518130244.GB24917@lkcl.net>
	 <1084886403.28966.76.camel@moss-spartans.epoch.ncsc.mil>
	 <20040518151112.GF24917@lkcl.net>
Content-Type: text/plain
Message-Id: <1084900706.28966.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 May 2004 13:18:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-05-18 at 11:11, Luke Kenneth Casson Leighton wrote:
>  okay, so i... didn't add anything to file_contexts, i only
>  created a domain/program/localstuff.te and ... hm, well i
>  _did_ create a blank file_contexts/programs/localstuff.fc,
>  so i'm doing a make relabel anyway, just in case.

Not necessary.

>  as i understand it, the domains define what is allowed, and the
>  file_contexts define if you will... the starting points of those
>  "allowances" [ i know that's clumsily put ].

We call them entrypoint executables for the domains.  Note that file
contexts includes more than just the entrypoint executables; it
specifies the file contexts for all files (ultimately, everything will
match at least one pathname regex, since the /.* entry at the beginning
of types.fc will cover anything that lacks a more specific entry).

>  e.g. file_contexts/program/xdm.fc has as its first line:
> 
>  /usr/bin/[xgkw]dm       -- system_u:object_r:xdm_exec_t
> 
>  therefore, the programs gdm, xdm, kdm and wdm all have type xdm_exec_t
>  therefore, according to line 24 of domains/programs/xdm.te, gdm,
>  xdm, kdm and wdm are all allowed to automatically transition from
>  the initialisation context into a new context named xdm_t.
> 
>  therefore, the programs gdm, xdm, kdm and wdm are all allowed to do
>  the things that are mentioned as allow xdm_t etc.

Right.

>  ... so why, if i [appear to be] doing things correctly, do i still
>  get errors, for example, when i have explicitly added:
> 
>  allow xdm_xserver_t var_lib_t:file { getattr read };
> 
>  okay, just a guess: when you declare an allow, are the relevant
>  permissions added or replaced if there already exists, say,
>  allow xdm_xserver_t var_lib_t:file { read };
> 
>  and i then add, in a following line to policy.conf : 
>  allow xdm_xserver_t var_lib_t:file { getattr };
> 
>  do i end up with _only_ getattr permissions or do i end up
>  with both read _and_ getattr?

checkpolicy takes the union of all such allow rules, so you end up with
both read and getattr.  You can check at runtime via compute_av.  So you
shouldn't still get denials, unless you aren't truly loading the new
policy into the kernel or another factor (e.g. policy/constraints) is
coming into play.  One common mistake is if your kernel isn't up-to-date
and doesn't accept the latest policy version, you may be loading an
older policy version, not the one you just compiled with your new
checkpolicy.


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
