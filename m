Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l04IQX0D016152
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 13:26:36 -0500
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l04IRHVJ019853
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 18:27:18 GMT
Subject: Re: Latest diffs
From: Erich Schubert <erich@debian.org>
To: russell@coker.com.au
Cc: casey@schaufler-ca.com, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200701050407.14369.russell@coker.com.au>
References: <150714.60836.qm@web36610.mail.mud.yahoo.com>
	 <200701050407.14369.russell@coker.com.au>
Content-Type: text/plain; charset=utf-8
Date: Thu, 04 Jan 2007 19:27:02 +0100
Message-Id: <1167935222.5129.11.camel@hepcat.vitavonni.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> Could we have a version of locate that is a little slower than usual and which 
> just calls find without telling the user?  :-#

Or have slocate trying to access the located files before printing them?
This will make slocate slower, but also removes files from the result
that were deleted in the meantime (locate can give you old results).
But it's still faster than find.

Then have a type slocate_t which is able to access the database; regular
user domains can't read the file. This should confine an information
leak to programming errors in slocate?

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
             Reality continues to ruin my life --- Calvin            //\
   Die kürzeste Verbindung zwischen zwei Menschen ist ein Lächeln.   V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
