Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87CpgrT025915
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 08:51:43 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87Cooxo020684
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 12:50:50 GMT
Subject: Re: domains/local/*.te file_contexts/local/*.fc
From: Erich Schubert <erich@debian.org>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200409072209.43296.russell@coker.com.au>
References: <1094489141.3973.40.camel@wintermute.xmldesign.de>
	 <200409072209.43296.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 07 Sep 2004 14:51:35 +0200
Message-Id: <1094561496.23173.1.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> > the patch below adds support for domains/local/*.te and
> > file_contexts/local/*.fc to the Makefile.
> >
> > I prefer having my local policy modifications in there, instead of
> > cluttering the "programs" part.
> 
> Why not use domains/misc and file_contexts/misc?  They do everything you seem 
> to want to do.

I used to, but they are loaded before the other rules. Which is a
problem for file contexts: for example i cannot use a different context
for something in /usr/local/sbin when i place the rule in
file_contexts/misc/local.fc - it will be overridden by the other file
contexts.

Greetings,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
       The best things in life are free: Friendship and Love.        //\
  Wer keine Zeit mehr mit echten Freunden verbringt, der wird bald   V_/_
          sein Gleichgewicht verlieren. --- Michael Levine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
