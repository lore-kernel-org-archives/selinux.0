Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i39KjURb027545
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 16:45:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i39KhTUZ023658
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 20:43:29 GMT
Received: from dl.oss.co.yu (mps.rns-nis.co.yu [194.247.213.6])
	by jazzswing.ncsc.mil  with ESMTP id i39KhNmT023650
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 20:43:28 GMT
Date: Fri, 9 Apr 2004 22:43:56 +0200
From: "Milan P. Stanic" <mps@rns-nis.co.yu>
To: selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
Message-ID: <20040409204356.GA6027@rns-nis.co.yu>
References: <88042458.1081270777@[192.168.0.3]> <20040407075405.D19421@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040407075405.D19421@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 07, 2004 at 07:54:06AM +0200, Tom wrote:
> On Tue, Apr 06, 2004 at 04:59:37PM -0700, Bill McCarty wrote:
> > I'm trying to follow the trail for installing SELinux on Debian unstable, 
> > as helpfully documented by Dave Gilbert (see below). Thanks, Dave!
> 
> Those are for woody, not unstable. Look at my site for apt sources for
> the other distros (http://selinux.lemuria.org)

Maybe you could look at my backports from debian unstable to woody
at http://www.rns-nis.co.yu/~mps/ or with apt:
deb http://www.rns-nis.co.yu/~mps selinux/

I backported it with the help from Russell Coker, and  tested it only
under UML with 2.6.4 kernel.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
