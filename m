Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89CxBrT011295
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 08:59:11 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89CwIo3028163
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 12:58:18 GMT
Date: Thu, 9 Sep 2004 14:10:20 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: at last: info regarding boot problems on multiple partitions
Message-ID: <20040909131019.GB1461@lkcl.net>
References: <20040908224949.GK7717@lkcl.net> <1094732553.22014.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094732553.22014.23.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 09, 2004 at 08:22:33AM -0400, Stephen Smalley wrote:
> On Wed, 2004-09-08 at 18:49, Luke Kenneth Casson Leighton wrote:

> > my question is:
> > 
> > 	how do i restore the context of a mount-point....
> > 	whilst it's actually mounted!
> 
> You can't.  And you should't need to do so, as nothing should require
> access to the empty mount point directory except for mount itself, which
> has access to search and mounton file_t.  What good would it do to allow
> login or others to search the empty mount point when it is empty
> anyway?  They will fail regardless, just a difference between errno of
> ENOENT and EACCES.

okay, it can't be that then.

_something_ is stopping /usr from being remounted (when enforcing is on)
after a shutdown remounts it as read-only just before a halt/restart.

i can't be the only person who has - or will have - this problem.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
