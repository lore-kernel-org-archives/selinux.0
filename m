Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11CLD53014706
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 07:21:13 -0500 (EST)
Subject: Re: Policy format: apostrophe in comments
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1107210569.1928.8.camel@cobra.ivg2.net>
References: <1107210569.1928.8.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1107260084.26936.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Feb 2005 07:14:44 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-31 at 17:29, Ivan Gyurdiev wrote:
> What about this bug? It complains about not being able to use
> apostrophe in the policy config. Any chance this will be fixed,
> or should I leave it alone? I ask because I was confused
> what was wrong with my policy when adding apostr. comments. 
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=146553

Yes, that has bothered me as well; it is a curious property of m4 that
it interprets quotes even within comments.  An option would be to use
the m4 changequote builtin to change the start-quote and end-quote
delimiters, but that would require rewriting all actual uses of the
existing quote characters in the existing policy to use the new
delimiters.  Obviously not my highest priority, but I'd be willing to
consider patches that make such a change.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
