Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3BAJ8Rb003479
	for <selinux@tycho.nsa.gov>; Sun, 11 Apr 2004 06:19:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3BAH6UZ009207
	for <selinux@tycho.nsa.gov>; Sun, 11 Apr 2004 10:17:06 GMT
Received: from dl.oss.co.yu (mps.rns-nis.co.yu [194.247.213.6])
	by jazzswing.ncsc.mil  with ESMTP id i3BAGmmT009204
	for <selinux@tycho.nsa.gov>; Sun, 11 Apr 2004 10:16:58 GMT
Date: Sun, 11 Apr 2004 12:18:35 +0200
From: "Milan P. Stanic" <mps@rns-nis.co.yu>
To: selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
Message-ID: <20040411101835.GC2310@rns-nis.co.yu>
References: <88042458.1081270777@[192.168.0.3]> <20040407075405.D19421@lemuria.org> <20040409204356.GA6027@rns-nis.co.yu> <36722574.1081629509@[192.168.0.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36722574.1081629509@[192.168.0.3]>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Apr 10, 2004 at 08:38:29PM -0700, Bill McCarty wrote:
> I gave it a go; but dpkg reports that libselinux1 depends on libattr1 >= 
> 2.4.4-1, which is not part of Woody. Did I take a wrong turn?

Oh, sorry. I forgot to note that it depends on libattr1 and attr which
can be downloaded from http://www.backports.org/

In my original announce to debian-security I mentioned that, but here
I made a mistake. Sorry for inconvenience.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
