Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA20792
	for <selinux@tycho.nsa.gov>; Sun, 19 May 2002 23:42:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA12963
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 03:41:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id DAA12959 for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 03:41:24 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>,
        Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
Subject: Re: .journal
Date: Mon, 20 May 2002 12:21:17 +1000
Cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0205131151170.21547-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0205131151170.21547-100000@raven>
MIME-Version: 1.0
Message-Id: <20020520034239.61FEF6DEC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 14 May 2002 01:58, Stephen Smalley wrote:
> On Mon, 13 May 2002, Carsten Grohmann wrote:
> > Since a few days I use the ext3 filesystem. And now I am looking the
> > correct rights for the journaling files (.journal). At this time I
> > labeled as file_t. What is your opinion? Should it use an own type or is
> > the file_t better?
>
> You should define a new type for the .journal files, and limit access to
> only a few domains.  The only reason that we haven't done so is that our
> journal files aren't visible (created via mke2fs -j with a clean
> filesystem rather than on an existing filesystem).

Maybe something like the following?

file_type_auto_trans(fsadm_t, root_t, ext3_journal_t)



-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
