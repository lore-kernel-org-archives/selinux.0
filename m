Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i684farT010868
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 00:41:37 -0400 (EDT)
Date: Wed, 7 Jul 2004 20:28:48 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: cifs_t
Message-ID: <20040707202848.GC12112@lkcl.net>
References: <200407052352.53439.russell@coker.com.au> <1089224292.1774.160.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1089224292.1774.160.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 07, 2004 at 02:18:12PM -0400, Stephen Smalley wrote:
> On Mon, 2004-07-05 at 09:52, Russell Coker wrote:
> > typealias sambafs_t alias cifs_t;
> > 
> > What is the benefit of the above?
> > 
> > If we are going to make cifs_t the new name for what is currently sambafs_t 
> > then surely the correct thing to do is to change the declaration of sambafs_t 
> > to cifs_t and use the following typealias:
> > 
> > typealias cifs_t alias sambafs_t;
> 
> Looking at the CVS tree, it appears that it was changed from cifs_t to
> sambafs_t on 5/4/2004, as part of a merge of a policy diff from Fedora. 
> cifs_t was retained as an alias for compatibility, IIRC.
 
 i understand from russell that cifs_t (sambafs_t) is for client-side
 access auditing (not from server-side stuff as i originally assumed).

 ... what happens when wine, which is in the process of implementing its
 own [entire] smb client access method, due to license incompatibility
 [and intransigence] of samba [team], provides an alternative
 non-samba-based SMB access system?

 ... or is that something to worry about for another day, as-and-when?

 l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
