Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KEgTRb019200
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 10:42:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KEe2B2001204
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:40:02 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4KEe2wi001201
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:40:02 GMT
Subject: Re: FAM uses seteuid and setegid
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040520135553.GD8810@lkcl.net>
References: <20040520121538.GA8810@lkcl.net>
	 <1085056946.521.65.camel@moss-spartans.epoch.ncsc.mil>
	 <20040520135553.GD8810@lkcl.net>
Content-Type: text/plain
Message-Id: <1085064119.521.133.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 May 2004 10:41:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-20 at 09:55, Luke Kenneth Casson Leighton wrote:
>  the question becomes (and assuming that avc_has_perm can do
>  directory stuff, which yeh it would be :) is it only necessary
>  to do an avc_has_perm on each opendir(), as opposed to doing
>  an avc_has_perm on each readdir()?
> 
>  or, should i be doing an avc_has_perm( ... READ_PERM ... )
>  on every opendir() and then ... say...
>  an avc_has_perm ( ... EXECUTE_PERM ... ) on every entry in the
>  readdir()?

I haven't looked at the famd code.  But the man page says that it only
gives out the names of monitored files, and it only monitors files that
the client can stat().  Hence, the client only needs search permission
to every directory in the path leading to the file, and getattr
permission to the file itself.  If famd is opening each directory
component with opendir(), then you can use dirfd() to get the descriptor
for the directory component, then apply fgetfilecon() to gets its
security context, and check search permission from the client to that
directory context.  Then you need to check getattr permission to the
final component, and try to minimize the likelihood of a race (but note
that you cannot open the final component, as that would violate the
model).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
