Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA8Gv3Ii017168
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 11:57:03 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA8GtaC6017828
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 16:55:40 GMT
Date: Mon, 8 Nov 2004 17:07:42 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: filesystems and selinux
Message-ID: <20041108170741.GB5439@lkcl.net>
References: <20041108105414.GD31026@lkcl.net> <1099921041.3215.18.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099921041.3215.18.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 08, 2004 at 08:37:21AM -0500, James Carter wrote:

> > ... or is that what the selinux-nfs patches do, already?
> 
> There are no differences in the policy used for selinux-nfs.  There is
> an assumption that the client and server have the same policy (At least
> to the extent that the client and server agree on what accesses to
> allow.)  

thanks for clarifying, james.

with the issues surrounding NFS (no on-wire security) and
samba (selinux not ready yet), i'm seriously thinking about
banning file servers and using subversion _as_ the file server,
instead!!!

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
