Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA28529
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 12:41:22 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0LHfJI19644
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 17:41:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h0LHfJf19640 for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 17:41:19 GMT
Message-Id: <200301211748.MAA02328@moss-shockers.ncsc.mil>
Date: Tue, 21 Jan 2003 12:48:49 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Cambridge Security Group talk
To: russell@coker.com.au, bam@snoopy.apana.org.au
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Which raises another interesting topic, that is 2.5.x supports attrs
> (EAs) on ext2 and ext3 (at the minimum; I don't know about reiserfs),
> maybe SE-Linux security contexts could be stored in attrs?

Yes, we're looking into the use of EAs for file security contexts.
We would still retain the persistent label mapping as a fallback if
the filesystem didn't support EAs.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
