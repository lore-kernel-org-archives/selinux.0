Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA25860
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 14:30:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA22409
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 19:29:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA22405 for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 19:29:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Metrix <metrix007@yahoo.com>, selinux@tycho.nsa.gov
Subject: Re:
Date: Wed, 27 Feb 2002 20:30:18 +0100
References: <20020227190209.4638.qmail@web20604.mail.yahoo.com>
In-Reply-To: <20020227190209.4638.qmail@web20604.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020227193018.63D57C8E2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 27 Feb 2002 20:02, Metrix wrote:
> with selinux is it possible to say make a file or
> directory unable to be viewed, deleted or moved, or
> even altered, the ONLY operation allowed is
> appending....is this possible to implement with
> selinux?

If you read macros.te in the policy directory you'll see all the operations 
that are controllabl.

In the rw_file_perms macro you can see that there's an "append" item to 
control appending to a file separately to writing.

The ra_dir_perms macro seems to do what you want for directories.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
