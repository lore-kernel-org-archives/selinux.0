Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA24930
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 13:49:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA28519
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 17:48:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id RAA28515
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 17:48:17 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>
Subject: Re: busybox policy and multicall binaries
Date: Tue, 23 Jul 2002 19:48:43 +0200
Cc: selinux@tycho.nsa.gov
References: <Pine.LNX.4.44.0207240011550.277-100000@coffeesaur>
In-Reply-To: <Pine.LNX.4.44.0207240011550.277-100000@coffeesaur>
MIME-Version: 1.0
Message-Id: <20020723174843.6B6361CBE@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Jul 2002 18:14, Rogelio M. Serrano Jr. wrote:
> On Tue, 23 Jul 2002, Russell Coker wrote:
> > On Tue, 23 Jul 2002 11:55, Rogelio M. Serrano Jr. wrote:
> > > Whats the best way to handle multicall binaries like busybox? The basic
> > > problem is that the context used in permission checking is the context
> > > of
> >
> > Why do you want anything special for busybox?  Why not just have it in
> > bin_t and let it run in the same domain as the calling process?
>
> I see. And then I use special scripts that transition into the proper
> domains like getty_t for my getty substsututes.

Maybe it would be best to modify busybox to use exec_secure() to run it's 
sub-processes in the correct domain.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
