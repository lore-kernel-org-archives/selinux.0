Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JKGtrT002769
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 16:16:55 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9JKFevJ015722
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 20:15:40 GMT
Date: Tue, 19 Oct 2004 21:27:49 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Adding alternate root patch to restorecon (setfiles?)
Message-ID: <20041019202749.GD19398@lkcl.net>
References: <41741A2C.8040408@redhat.com> <20041018205136.GA2536@jmh.mhn.de> <41751792.4060207@redhat.com> <20041019183646.GC19398@lkcl.net> <1098210403.29525.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098210403.29525.111.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 19, 2004 at 02:26:44PM -0400, Stephen Smalley wrote:
> On Tue, 2004-10-19 at 14:36, Luke Kenneth Casson Leighton wrote:
> > um... what happens if a user runs restorecon in a chroot environment
> > that they create?
> > 
> > as an ordinary user, can they cp /lib/* and have the context preserved
> > on their copy of libc.so.6?  just trying that now... no, it says setting
> > attribute "security.selinux" for /home/sez/libc6.so.6': permission
> > denied.
> > 
> > is there any concievable way round that?  [i hope not!]
> 
> Unprivileged user domains aren't allowed to transition to restorecon_t
> in the policy.  There is a reason for that...
  
  ... gooood :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
