Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UM4KDo019576
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 17:04:20 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2UM0Qph014613
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 22:00:27 GMT
Date: Wed, 30 Mar 2005 23:12:46 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Tom <tom@lemuria.org>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Casey Schaufler <casey@schaufler-ca.com>,
   selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050330221246.GC9752@lkcl.net>
References: <20050330155207.58846.qmail@web31601.mail.mud.yahoo.com> <1112199204.8592.13.camel@cobra.ivg2.net> <20050330235010.B622@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050330235010.B622@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 30, 2005 at 11:50:11PM +0200, Tom wrote:
> On Wed, Mar 30, 2005 at 11:13:24AM -0500, Ivan Gyurdiev wrote:
> > ... or am I missing something fundamental here? 
> 
> Yes.
> 
> _my_ directory structure will certainly look differently. Jack has yet
> another one, Joe a third and Mary a fourth.
 
 not when you recompile KDE [3.2.2 / 3.3] with the kdbfs
 patches, there ain't.

 kdbfs "flattens" the directory structures and forces applications,
 via patches to the file save and file open dialogs, to ONLY be able
 to save documents in certain subdirectories, ~/Documents, ~/Music ...
 etc.

 kdbfs then provides you with an "alternative" to the concept
 of a directory structure, with a much more comprehensive file
 open dialog box, which has exactly the same sort of search
 capabilities built-in that MAC OS/X has given people for
 several years now.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
