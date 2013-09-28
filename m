Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8S9UIBb004868
	for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2013 05:30:18 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 7FE4C1A228
	for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2013 11:30:13 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FnV6VFhEYM4U for <selinux@tycho.nsa.gov>;
	Sat, 28 Sep 2013 11:30:11 +0200 (CEST)
Received: from fornost.bigon.be (unknown [IPv6:2a02:578:85fc:1:226:18ff:fe08:6073])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 3B8C61A055
	for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2013 11:30:11 +0200 (CEST)
Date: Sat, 28 Sep 2013 11:29:45 +0200
From: Laurent Bigonville <bigon@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: File context not applied due to regex ordering
Message-ID: <20130928112945.02687778@fornost.bigon.be>
In-Reply-To: <20130402114105.1356b034@soldur.bigon.be>
References: <20130321123256.198ba5b6@soldur.bigon.be>
	<5159AEA8.2090004@tresys.com>
	<20130401185508.3d15476e@fornost.bigon.be>
	<CACLa4psh+Litc-ko0g7NhQ3BDYRX7_BX1TZqzg4uxYVhZ3VQzw@mail.gmail.com>
	<20130402114105.1356b034@soldur.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Did anybody had the time to look at this? Dominick and I have observed
this with other file contexts as well.

Cheers

Laurent Bigonville

Le Tue, 2 Apr 2013 11:41:05 +0200,
Laurent Bigonville <bigon@debian.org> a écrit :

> Le Mon, 1 Apr 2013 13:40:46 -0400,
> Eric Paris <eparis@parisplace.org> a écrit :
> 
> > I feel like we talked about it...  Regex ordering is a bit tricky.
> > I think I hacked up a patch which added an additional tie breaker
> > step with the total number of 'non-regex' type characters being
> > used.  It's been long lost though...
> > 
> > Do you still have that hack around?  Maybe we can see what others
> > think?
> 
> I definitely have a bad memory...
> 
> I grepped my IRC logs and found this patch[0] from you at the date of
> the 28th of Sept 2012.
> 
> Cheers
> 
> Laurent Bigonville
> 
> [0] http://fpaste.org/p48W/



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
