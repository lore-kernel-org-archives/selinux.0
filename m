Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAKLOIi023209
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 15:21:24 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAKLRR8011215
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 20:21:27 GMT
Subject: Re: can_network patch.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20041210191107.GA5059@jmh.mhn.de>
References: <41741A2C.8040408@redhat.com>
	 <1102698638.1628.148.camel@moss-spartans.epoch.ncsc.mil>
	 <41B9E48A.8010204@redhat.com> <200412110511.12960.russell@coker.com.au>
	 <20041210191107.GA5059@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1102710212.5654.51.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 15:23:32 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For now I removed the user_helper stuff in mozilla_macros.te.  It causes
a compile error if the user_canbe_sysadm tunable is not defined right
now anyway.

On Fri, 2004-12-10 at 14:11, Thomas Bleher wrote:
> * Russell Coker <russell@coker.com.au> [2004-12-10 20:04]:
> > On Saturday 11 December 2004 05:01, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > > Stephen Smalley wrote:
> > > >On Fri, 2004-12-10 at 12:06, Daniel J Walsh wrote:
> > > >>When installing a package within firefox, it attemps to exec
> > > >>system-config-packages which blows up because
> > > >>*-mozilla-t can not run userhelper apps.
> > > >
> > > >Installing a package within firefox?  If you are talking about something
> > > >firefox downloaded, then why does it use system-config-packages?  And I
> > > >would expect that you would end up installing any such packages local to
> > > >the user's home directory at most (and even then only if policy allows
> > > >writing to it), not on a system-wide basis.
> > >
> > > You can trigger it by executing
> > >  firefox selinux-policy-strict-1.19.12-1.src.rpm
> > 
> > We have mozilla running in it's own domain to limit the risk of exploits of 
> > mozilla taking over the rest of the system.  Allowing mozilla to install 
> > packages seems to directly contradict this aim.
> > 
> > Maybe we should just remove the mozilla policy?
> 
> Or add a boolean to control the transition from the userdomain to
> mozilla. Then we can have a locked down policy for people who just want
> to securely browse the web. People who want all the bells and whistles
> can turn the transition off at the cost of higher exposure.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
