Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6DFBhBQ009285
 for <selinux@tycho.nsa.gov>; Mon, 13 Jul 2015 11:11:43 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id BDC731A1D5
 for <selinux@tycho.nsa.gov>; Mon, 13 Jul 2015 17:11:13 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id zLmsolaKEPh1 for <selinux@tycho.nsa.gov>;
 Mon, 13 Jul 2015 17:11:11 +0200 (CEST)
Received: from soldur.bigon.be (unknown [193.53.238.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id B75BA1A00F
 for <selinux@tycho.nsa.gov>; Mon, 13 Jul 2015 17:11:11 +0200 (CEST)
Date: Mon, 13 Jul 2015 17:11:11 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: Re: semanage: TypeError: cannot concatenate 'str' and 'NoneType'
 objects
Message-ID: <20150713171111.75f81b55@soldur.bigon.be>
In-Reply-To: <20150713170743.2d8aac3b@soldur.bigon.be>
References: <20140518191844.2365e3ad@soldur.bigon.be>
 <20150713170743.2d8aac3b@soldur.bigon.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le Mon, 13 Jul 2015 17:07:43 +0200,
Laurent Bigonville <bigon@debian.org> a écrit :

> Hello,
> 
> Bumping a (quite) old mail.
> 
> If the audit python binding, "semanage login -m -s root root" is
> crashing with a backtrace in the logging part of the code.

If the audit python binding *is not installed*, "semanage login -m -s
root root" is crashing with a backtrace in the logging part of the code.
