Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA07154
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 04:04:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA09113
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 08:02:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id IAA09105
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 08:02:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: /proc woes
Date: Tue, 8 Oct 2002 19:13:17 +0200
References: <20021008163245.A5508@lemuria.org> <Pine.GSO.4.33.0210081037410.25356-100000@raven> <20021008171123.A6113@lemuria.org>
In-Reply-To: <20021008171123.A6113@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210081913.17017.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 8 Oct 2002 17:11, Tom wrote:
> On Tue, Oct 08, 2002 at 10:40:30AM -0400, Stephen Smalley wrote:
> > > So instead of having a patch, I have a question: My /proc is file_t:
> > >
> > > dr-xr-xr-x  root     root     system_u:object_r:file_t         proc
> >
> > This implies that your /proc is an empty mountpoint and is thus unused.
>
> No, it was populated and in use. (mount showed it mounted, and umount
> failed with busy).
>
>
> Rebooting the machine fixed it, so this may have happened during either
> make relabel or make load (I installed a new policy today), though it's
> still a mystery to me how and I'm one of the people who believe that a
> reboot shouldn't be a valid solution. :)

If you do the following:
echo /proc | setfiles -s -v /etc/selinux/file_contexts/file_contexts
Then it will be relabelled to file_t.

The Debian package base-files "owns" /proc and therefore it will be relabelled 
in the fashion shown above if you upgrade your base-files package.

The solution to this is to add an entry to file_contexts for /proc.

In my tree I added the following as line 147 of types.fc to avoid this 
happening in future.  Steve, please include something equivalent in the CVS, 
although it's only used by Debian now, the same issue will probably be faced 
by RPM distributions when they support SE Linux (and in any case it does no 
harm).
/proc(/.*)?                     <<none>>

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
