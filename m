Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h765oNHa024934
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 01:50:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h765n8FB007017
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 05:49:09 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h765n8GD007014
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 05:49:08 GMT
Subject: Re: oops on policy load (PPC)
From: Chris PeBenito <pebenito@gentoo.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1060086871.3770.34.camel@moss-spartans.epoch.ncsc.mil>
References: <1060029193.2997.206.camel@chris.pebenito.net>
	 <1060086871.3770.34.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1060145894.1903.2.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 05 Aug 2003 23:58:15 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I get the oops the first time policy is loaded any way its loaded, from
the initrd, or otherwise.

On Tue, 2003-08-05 at 07:34, Stephen Smalley wrote:
> On Mon, 2003-08-04 at 16:33, Chris PeBenito wrote:
> > I get this oops on the first time the policy is loaded (2.6.0-test2-bk3
> > on PPC):
> 
> Did you perform the initial policy load from an initrd before the real
> root filesystem is mounted, as described in the selinux-doc README?  You
> still shouldn't encounter an Oops, but you do need to perform the
> initial policy load early in order for the system to operate properly,
> e.g. initial domain transitions upon executing init.
-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
