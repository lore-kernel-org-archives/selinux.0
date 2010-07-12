Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6CC8JEG002358
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 08:08:19 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6CC7LID028278
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 12:07:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Eric Paris <eparis@parisplace.org>
Subject: Re: clamav RWX
Date: Mon, 12 Jul 2010 22:08:12 +1000
Cc: =?iso-8859-1?q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>,
        "SE-Linux" <selinux@tycho.nsa.gov>
References: <201007121922.48247.russell@coker.com.au> <20100712140130.468b7b42@debian> <AANLkTin7CS0jgjas9otPYwMh0CSqdIaMMQ72YhQaqdmT@mail.gmail.com>
In-Reply-To: <AANLkTin7CS0jgjas9otPYwMh0CSqdIaMMQ72YhQaqdmT@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201007122208.13078.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 12 Jul 2010, Eric Paris <eparis@parisplace.org> wrote:
> > I have some plans to make the JIT work without RWX, since ClamAV has 2
> > phases:
> >  - load DB, JIT compile bytecode (should use only RW- mapping, but
> >   currently needs RWX)
> >  - execute (JIT compiled) bytecode (should change mapping to be R-X)
> 
> Just so you know that is going to require the same permissions.
> (Hopefully) The only way to get around the SELinux permissions is to
> have 2 separate mappings.  Basically in really really rough sudo-code,

According to the comments the code will fall-back to interpreting the data if 
WRITE/EXEC is denied.

Now given that freshclam doesn't do any serious work with the data, is 
interpreting it going to cause any problem that we will care about?  If we are 
talking about 1 hour of CPU time vs 2 hours for jit vs interpreted for run-
time stuff then it makes a difference, but if we are talking about 1 second vs 
2 seconds for freshclam then maybe there's not much point.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
