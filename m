Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i39FrrRb025763
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 11:53:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i39FpnUZ007223
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 15:51:49 GMT
Received: from texas.rec.uniba.sk (texas.rec.uniba.sk [158.195.34.3])
	by jazzswing.ncsc.mil  with ESMTP id i39FplmT007209
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 15:51:48 GMT
Date: Fri, 9 Apr 2004 17:53:28 +0200
From: Tomas Hoger <thoger@pobox.sk>
To: Peter Gervai <grin@tolna.net>
Cc: selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
Message-ID: <20040409155328.GA4748@moche.atriaky.sk>
References: <401FF280.8070301@treblig.org> <88042458.1081270777@[192.168.0.3]> <20040407075519.GX539@narya.grin.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040407075519.GX539@narya.grin.hu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 07, 2004 at 09:55:19AM +0200, Peter Gervai wrote:
> On Tue, Apr 06, 2004 at 04:59:37PM -0700, Bill McCarty wrote:
> 
> > However, I'm having difficulty with the Selinux-policy-default package, 
> > which Dselect complains is not compatible with Policycoreutils. I plan to 
> > start over with a very minimal Debian installation on the hypothesis that 
> > one or more of the SELinux package versions has been obsoleted by a 
> > non-SELinux package. Can anyone offer other suggestions for installing 
> > SELinux under Debian, whether stable or unstable?
> 
> Use sid and add to apt/sources.list to the bottom:
> deb http://www.coker.com.au/newselinux ./
> 
> Check whether every essentials (ssh, login, pam) are selinux versions and
> not the plain ones. Sometimes they're a little behind, and debian standard
> versions rush in and "upgrade" 'em. :)

If you put this:

Package: *
Pin: release o=etbe
Pin-Priority: 1001

into /etc/apt/preferences, apt will keep Russell's packages and will never
replace them with newer ones from main Debian archive (actually, if you
already have newer version installed, apt will downgrade those packages to
version available from Russell's repository ;).  See 'man apt_preferences'
for more info.

th.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
