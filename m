Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA27464
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 17:17:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA17522
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 21:17:01 GMT
Received: from crisium.vnl.com ([194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id VAA17518
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 21:17:00 GMT
Date: Fri, 12 Jul 2002 22:21:19 +0100
From: Dale Amon <amon@vnl.com>
To: selinux@tycho.nsa.gov
Subject: Re: revising the su decision
Message-ID: <20020712212119.GB5982@vnl.com>
References: <20020712111941.30466.qmail@web40009.mail.yahoo.com> <63597.137.246.8.231.1026493819.squirrel@austin.bmh.com> <20020712200607.C26001@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020712200607.C26001@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 12, 2002 at 08:06:08PM +0200, Tom wrote:

> b) so, what you need is a trusted process ON the machines. ideally,
> with a policy crafted specifically for it. I'll call this process
> instwa, the "install watcher". it could be as simple as a cronjob
> called every 5 minutes that essentially does:
> 
> if ( any file in /var/install ) then ( rpm/dpkg/whatever -i $file )
> 
> c) give your remote/install user write priviledges for /var/install
> 
> d) voila. you can push software unto the machines and the instwa will
> take care of the installation.

Try cfengine2. That's what I use. (Not on selinux systems yet, but
I don't see why not)

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
