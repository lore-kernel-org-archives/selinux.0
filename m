Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9GEE1Wt002840
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 10:14:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9GEE1mR027047
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 14:14:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9GEE0jp027044 for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 14:14:00 GMT
Subject: Re: selinux documentation
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos Anisio Monteiro <monteiro@ipen.br>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3F8E7BCB.2020107@ipen.br>
References: <3F8E7BCB.2020107@ipen.br>
Content-Type: text/plain
Message-Id: <1066313633.25279.0.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 Oct 2003 10:13:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-10-16 at 07:06, Carlos Anisio Monteiro wrote:
> Hi.
> 
> Please, where can I find a documentation/guide about "wildcards" (p.ex. 
> '\.', '.*', '^'), explain the meaning.
> I woud like to know the aplication them in the file contexts.

The file contexts configuration uses pathname regular expressions.  man
7 regex

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
