Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA10721
	for <selinux@tycho.nsa.gov>; Thu, 27 Feb 2003 09:02:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA26132
	for <selinux@tycho.nsa.gov>; Thu, 27 Feb 2003 13:59:21 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id NAA26128
	for <selinux@tycho.nsa.gov>; Thu, 27 Feb 2003 13:59:21 GMT
Message-Id: <200302271410.JAA16152@moss-shockers.ncsc.mil>
Date: Thu, 27 Feb 2003 09:10:04 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: about the configuration language grammar
To: selinux@tycho.nsa.gov, giorgio.zanin@inwind.it
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Giorgio Zanin wrote:
> The former grammar is more difficult but more powerful. The latter is 
> more natural and it seems to me to be enough. Why is it possible to 
> express something like
> 
> role admin types { me { you { him } } }
> 
> and what's the meaning?
> 
> I'm working on a tool for configuration analisys. Am I safe if I change 
> the grammar as in (*)?

The change to the checkpolicy grammar (which hasn't been reflected in
the Configuring the SELinux Policy report, as you noted) was at the request
of users who wanted to be able to use macro names in the same manner
as individual names, e.g. intermingling macro names and individual names
in sets to specify their union, defining nested macros, etc.  This is
typically only used for permission sets in allow rules, e.g.

allow foo_t bar_t:file { r_file_perms create link_file_perms };

However, the grammar allows it in the general case.  The compiler simply
takes the union, so your example above is equivalent to:

role admin types { me you him };

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
