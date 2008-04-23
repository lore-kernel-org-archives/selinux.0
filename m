Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3NDxhAu003370
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2008 09:59:43 -0400
Received: from ladon.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3NDxff3007515
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2008 13:59:41 GMT
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Cc: selinux-devel@lists.alioth.debian.org
Subject: Re: open_init_pty: eats much of the CPU time
References: <20080415135909.GA10016@bobek.pm.i.cz>
Date: Wed, 23 Apr 2008 08:50:39 -0500
In-Reply-To: <20080415135909.GA10016@bobek.pm.i.cz> (=?iso-8859-1?Q?=22V?=
 =?iso-8859-1?Q?=E1clav_Ovs=EDk=22's?= message
	of "Tue, 15 Apr 2008 15:59:09 +0200")
Message-ID: <87od80he8g.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        A status update:

On Tue, 15 Apr 2008 15:59:09 +0200, Václav Ovsík <vaclav.ovsik@i.cz> said: 

> Hi, FYI: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=474956Maybe
> Manoj is busy and someone wants to review the code and include it
> upstream...  Regards -- Zito

        I finally managed to get my development SCM converted over to
 git, and am beginning to look over the patch (and zito  has just sent
 in an update to the bug report).

        In the meanwhile, The Debian development trees for SELinux
 packages have started migrating to public git repositories; the first
 few can be seen at:
  http://git.debian.org/git/users/srivasta/debian/libselinux.git
  http://git.debian.org/git/users/srivasta/debian/setools.git
  http://git.debian.org/git/users/srivasta/debian/policycoreutils.git
  http://git.debian.org/git/users/srivasta/debian/refpolicy.git

        manoj
-- 
In this world some people are going to like me and some are not.  So, I
may as well be me.  Then I know if someone likes me, they like me.
Manoj Srivastava <manoj.srivastava@stdc.com> <srivasta@acm.org>        
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
