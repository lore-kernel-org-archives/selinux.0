Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h974q5Wt009777
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 00:52:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h974q40p003204
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 04:52:04 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	by jazzswing.ncsc.mil  with ESMTP id h974q3r7003201
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 04:52:03 GMT
Date: Tue, 7 Oct 2003 06:50:19 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: libselinux-1.2 and const usage
Message-ID: <20031007045019.GA25435@suse.de>
References: <20031003063614.GA20539@suse.de> <1065205090.4080.177.camel@moss-spartans.epoch.ncsc.mil> <20031006073312.GA3261@suse.de> <200310071224.45294.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310071224.45294.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 07, Russell Coker wrote:

> On Mon, 6 Oct 2003 17:33, Thorsten Kukuk wrote:
> > I try to add SELinux support to pam_login
> 
> Are you working from Dan's PAM patch or doing it differently?

pam_login is a login program, for which I use the util-linux/login
patch as base.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
