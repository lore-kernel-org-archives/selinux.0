Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o44FcnMW009436
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2010 11:38:49 -0400
Received: from g6t0186.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o44FdZKc018357
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2010 15:39:35 GMT
From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC PATCH v1 5/6] selinux: Convert socket related access controls to use socket labels
Date: Tue, 4 May 2010 11:38:17 -0400
Cc: selinux@tycho.nsa.gov
References: <20100503220455.8177.91177.stgit@flek.lan> <20100503221146.8177.84024.stgit@flek.lan> <z2z7e0fb38c1005040730i9918785n488181e55eafa994@mail.gmail.com>
In-Reply-To: <z2z7e0fb38c1005040730i9918785n488181e55eafa994@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005041138.17454.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 04 May 2010 10:30:05 am Eric Paris wrote:
> On Mon, May 3, 2010 at 6:11 PM, Paul Moore <paul.moore@hp.com> wrote:
> > At present, the socket related access controls use a mix of inode and
> > socket labels; while there should be no practical difference (they
> > _should_ always be the same), it makes the code more confusing.  This
> > patch attempts to convert all of the socket related access control
> > points (with the exception of some of the inode/fd based controls) to
> > use the socket's own label.  In the process, I also converted the
> > socket_has_perm() function to take a 'sock' argument instead of a
> > 'socket' since that was adding a bit more overhead in some cases.
> 
> Should it be renamed to sock_has_perm() then?

BTW, thanks for the review too ...

Yeah, I can change the name, in fact, I'll do that right now ...

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
