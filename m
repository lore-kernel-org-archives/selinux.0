Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7QCTiLa001790
	for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2003 08:29:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7QCTafF012344
	for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2003 12:29:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h7QCTYHd012334 for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2003 12:29:34 GMT
Subject: Re: SElinux vs. Grsecruity vs. RSBAC
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bennett Todd <bet@rahul.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20030825170259.GB4409@rahul.net>
References: <FAB2059733EB46409AD28AC957F663F70BEE5C@pusmde04.mt.pweh.com>
	 <20030825170259.GB4409@rahul.net>
Content-Type: text/plain
Message-Id: <1061900971.23880.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 26 Aug 2003 08:29:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-08-25 at 13:02, Bennett Todd wrote:
> I'd be interested in that too. And if anybody wanted to include
> RSBAC in the overview that'd be neat.

There was a lengthy thread comparing SELinux and RSBAC a long time ago
on this mailing list, and author of RSBAC was involved in that
discussion.  The thread begins at
http://marc.theaimsgroup.com/?l=selinux&m=98618795624462&w=2.
We also provided a brief summary of differences (from our perspective)
in the related work section of our paper published at Freenix '01,
available from http://www.nsa.gov/selinux/docs.html.

We haven't done a detailed comparison with grsecurity.  At the time
SELinux was developed and released, I don't think that grsecurity
included any notion of mandatory access controls, which are the focus of
SELinux.  I see that the grsecurity features page now claims to provide
role based access control and mandatory access control, but it isn't
clear what their access control model is.  

See http://www.nsa.gov/selinux/faq.html#I18 for a general statement of
some of the distinctives of SELinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
