Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6UKt1Ha029645
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 16:55:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6UKrnFB010865
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 20:53:49 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h6UKrnGD010862
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 20:53:49 GMT
Subject: Re: Question about development
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Miguel Bolanos <mike@linuxlabs.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.21.0307301533500.3255-100000@ucontrol.mobiledns.com>
References: <Pine.LNX.4.21.0307301533500.3255-100000@ucontrol.mobiledns.com>
Content-Type: text/plain
Message-Id: <1059598491.1052.130.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Jul 2003 16:54:51 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-07-30 at 15:38, Miguel Bolanos wrote:
> I'm really willing to contribute some of my time and skills to selinux,
> and this si why i wonder if someone could kindly give me some links and
> references that i can use to get more involved, ie, where to get the
> latest development tree? CVS at sourceforge doesn't seem to work.

Short answer:  There isn't really a public development tree.  We'd like
to provide one from nsa.gov eventually, but we are not able to do that
at this time.

You'll need developer access to the sourceforge project to effectively
use the sourceforge CVS tree, but it isn't likely to help you much if
you want to track the latest kernel, as we typically only update the
kernel tree there after first making an updated public release on
nsa.gov.  The sourceforge CVS tree primarily just tracks updated public
releases and interim fixes/changes that have already been published on
the selinux mailing list.  It has at times served as a useful
synchronization point for policy merging, as there has been quite a bit
of external policy development work.  People doing that have typically
maintained their own trees and submitted patches on the list against the
last public release from nsa.gov or against the sourceforge CVS tree.  

The http://www.nsa.gov/selinux/lk directory has been used to push out
kernel patches against the latest kernel for submission to lkml, as that
is faster than pushing out a full updated release.  There haven't been
any changes to the SELinux code since the last snapshot in that
directory, just a simple re-basing to 2.6.0-test2, which incorporated
the xattr-related fixes.  As the SELinux module is now in Andrew
Morton's tree, you could just use 2.6.0-test2-mm1.  In fact, this is a
good idea in general so that more people test that kernel and provide
feedback to Andrew indicating that they are using SELinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
