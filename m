Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i88KGTrT007201
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 16:16:29 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i88KFaR0029587
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 20:15:37 GMT
Subject: Re: domains/local/*.te file_contexts/local/*.fc
From: Erich Schubert <erich@debian.org>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200409082329.56168.russell@coker.com.au>
References: <1094489141.3973.40.camel@wintermute.xmldesign.de>
	 <200409072209.43296.russell@coker.com.au>
	 <1094561496.23173.1.camel@wintermute.xmldesign.de>
	 <200409082329.56168.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 08 Sep 2004 22:16:21 +0200
Message-Id: <1094674581.4181.6.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> OK, maybe we should just change that to have file_contexts/misc/* included 
> last.  What do you think?

Basically yes. but be careful: I havn't checked the contents of the misc
files, but somewhere default contexts such as /bin, /usr/bin etc. need
to be defined. So we need something to be listed first, too.
Where is this done currently, i havn't checked.

Maybe we should name them appropriately: first and last, or "defaults"
and "overrides"?

Greetings,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
   There was never a good war or a bad peace. - Benjamin Franklin   //\
         Humor sollte immmer dabeisein, auch bei Problemen.         V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
