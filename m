Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1DNwXZ025647
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 08:23:58 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1DMbCC025189
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 13:22:37 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <20041030090603.GK8897@lkcl.net>
References: <4182959B.4080503@trustedcs.com>
	 <20041029211809.GJ8897@lkcl.net>  <20041030090603.GK8897@lkcl.net>
Content-Type: text/plain
Message-Id: <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Nov 2004 08:20:15 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-10-30 at 05:06, Luke Kenneth Casson Leighton wrote:
>  the bit that i don't like is the possibility of a process giving itself
>  an uncontrolled amount of access rights.
> 
>  what guarantees can you offer that a process can only escalate to a
>  specific alternative set of access rights?
> 
>  e.g. is your proposal a bit like the file_contexts "alternate"
>  keyword idea, where the policy contains a different context that
>  the process can flip to?

If you look at the patch, it includes an oldcontext-to-newcontext
dyntransition permission check for these dynamic context transitions, so
you can control the set of domains which can be reached via dynamic
transitions from any given domain.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
