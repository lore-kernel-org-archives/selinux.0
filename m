Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i377thRb007828
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 03:55:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i377tgmw008028
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 07:55:42 GMT
Received: from narya.grin.hu (Narya.grin.hu [195.38.113.130])
        by jazzband.ncsc.mil  with ESMTP id i377tf4w008025 for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 07:55:41 GMT
Date: Wed, 7 Apr 2004 09:55:19 +0200
From: Peter Gervai <grin@tolna.net>
To: Bill McCarty <bmccarty@pt-net.net>
Cc: selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
Message-ID: <20040407075519.GX539@narya.grin.hu>
References: <401FF280.8070301@treblig.org> <88042458.1081270777@[192.168.0.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <88042458.1081270777@[192.168.0.3]>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Apr 06, 2004 at 04:59:37PM -0700, Bill McCarty wrote:

> However, I'm having difficulty with the Selinux-policy-default package, 
> which Dselect complains is not compatible with Policycoreutils. I plan to 
> start over with a very minimal Debian installation on the hypothesis that 
> one or more of the SELinux package versions has been obsoleted by a 
> non-SELinux package. Can anyone offer other suggestions for installing 
> SELinux under Debian, whether stable or unstable?

Use sid and add to apt/sources.list to the bottom:
deb http://www.coker.com.au/newselinux ./

Check whether every essentials (ssh, login, pam) are selinux versions and
not the plain ones. Sometimes they're a little behind, and debian standard
versions rush in and "upgrade" 'em. :)

Works here.

Peter

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
