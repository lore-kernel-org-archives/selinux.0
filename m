Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA06785
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 08:07:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA23956
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 12:06:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA23948 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 12:06:01 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: psidfiles_init errors
Date: Mon, 19 Aug 2002 14:07:27 +0200
References: <20020819115124.62299.qmail@web40008.mail.yahoo.com>
In-Reply-To: <20020819115124.62299.qmail@web40008.mail.yahoo.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020819120728.0A026846C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Aug 2002 13:51, you wrote:
> > These are file types that existed in old versions of the policy but which
> > don't exist any more.  They still have entries in the ...security
> > database because there's no code to clean them up (IMHO they should be
> > removed when there are no files of that context on the file system any
> > more).
>
>          Does this functionality belong in setfiles? And if so, how hard
> would it be to figure out a method to remove the bogus ...security entries?

That's not possible on a running SE system, there is no kernel interface for 
it.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
