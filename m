Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KCh2Rb018170
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 08:43:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KCgxAR020144
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:42:59 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4KCgxHn020141 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:42:59 GMT
Subject: Re: FAM uses seteuid and setegid
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040520121538.GA8810@lkcl.net>
References: <20040520121538.GA8810@lkcl.net>
Content-Type: text/plain
Message-Id: <1085056946.521.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 May 2004 08:42:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-20 at 08:15, Luke Kenneth Casson Leighton wrote:
> just taking a look at famd, which uses seteuid and setegid before
> going and 'avin a look at files (Cred::Implementation::become_user())
> 
> so, famd is designed to "effectively" set its user and group ids,
> such that any file access is done as these, whilst still remaining
> actually running as root.
> 
> ... so... what tricks can be done that are equivalent to this?
> 
> setfscreatecon doesn't apply because that's presumably for file
> creation, and famd does file access not file creation.
> 
> setexeccon doesn't apply because there _are_ no relevant exec
> calls that occur in famd, and the only forks() and execs()
> are to run programs (e.g. "insmod imon").

You can either a) re-architect the application to use a
fork/setexeccon/exec model or b) have the application perform access
checking itself on behalf of the user context via avc_has_perm (but note
the potential for TOCTTOU issues there, although this may be irrelevant
for fam as it only monitors files for changes; it doesn't provide access
to the files themselves).

Reasons why we don't support a setuid-like operation for security
contexts have been discussed previously on the list a number of times.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
