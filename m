Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87CPkrT025673
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 08:25:46 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87COqxo019066
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 12:24:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: debian-devel@lists.debian.org
Subject: Re: dpkg and selinux
Date: Tue, 7 Sep 2004 22:25:41 +1000
Cc: Scott James Remnant <scott@netsplit.com>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>,
   Dpkg Development <debian-dpkg@lists.debian.org>
References: <20040831234115.GZ4375@lkcl.net> <20040901101921.GC5882@lkcl.net> <1094045403.6901.112.camel@descent.netsplit.com>
In-Reply-To: <1094045403.6901.112.camel@descent.netsplit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409072225.41258.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Sep 2004 23:30, Scott James Remnant <scott@netsplit.com> wrote:
> It's an interesting one, certainly I'd suggest the right solution would
> be to do such commands in postinst until such time as it was the default
> and the tar format could carry this information.  It would then become
> policy that it would be carried inside the tar file, just as chmod/
> chgrp/chown are carried today.

The problem with that idea is that there are many possible policies.  Fedora 
currently has two significantly different policies which require different 
file labels on disk.  Storing the data in the package for such things is not 
going to work (and would require that all DDs have some SE Linux files 
installed on their systems).

The right solution is to apply the regex set at install time.

> The thing that worries me about this file is that it contains policy for
> things I don't have installed on my system; and doesn't seem to cope
> well with differing policy for (e.g.) two binaries called 'ssh' which
> may have different requirements.

Only one binary can have the full path /usr/bin/ssh which is what matters.

> However I'm loath to embed specific selinux support into dpkg if it
> introduces extra dependencies, or causes problems for those not using
> it.

Getting it to work in Debian should not be difficult.  Having a shared object 
interface to make the SE Linux library a plug-in and thus support RSBAC etc 
also shouldn't be too difficult.

> > i think only stephen, russell, dan or colin are in a position to
> > answer that.
>
> Sadly they've stopped answering my calls <g>

No, I've just been busy recently.  I've got about 1600 messages to catch up on 
at the moment...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
