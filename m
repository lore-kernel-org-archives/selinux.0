Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6CCjLRT006340
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 08:45:33 -0400
Received: from mail-bw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6CClSjj006707
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 12:47:28 GMT
Received: by bwz6 with SMTP id 6so2559735bwz.12
        for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 05:45:31 -0700 (PDT)
Date: Mon, 12 Jul 2010 15:45:28 +0300
From: =?UTF-8?B?VMO2csO2aw==?= Edwin <edwintorok@gmail.com>
To: russell@coker.com.au
Cc: Eric Paris <eparis@parisplace.org>, "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: clamav RWX
Message-ID: <20100712154528.47864541@debian>
In-Reply-To: <201007122208.13078.russell@coker.com.au>
References: <201007121922.48247.russell@coker.com.au>
	<20100712140130.468b7b42@debian>
	<AANLkTin7CS0jgjas9otPYwMh0CSqdIaMMQ72YhQaqdmT@mail.gmail.com>
	<201007122208.13078.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 12 Jul 2010 22:08:12 +1000
Russell Coker <russell@coker.com.au> wrote:

> On Mon, 12 Jul 2010, Eric Paris <eparis@parisplace.org> wrote:
> > > I have some plans to make the JIT work without RWX, since ClamAV
> > > has 2 phases:
> > >  - load DB, JIT compile bytecode (should use only RW- mapping, but
> > >   currently needs RWX)
> > >  - execute (JIT compiled) bytecode (should change mapping to be
> > > R-X)
> > 
> > Just so you know that is going to require the same permissions.
> > (Hopefully) The only way to get around the SELinux permissions is to
> > have 2 separate mappings.  Basically in really really rough
> > sudo-code,
> 
> According to the comments the code will fall-back to interpreting the
> data if WRITE/EXEC is denied.
> 
> Now given that freshclam doesn't do any serious work with the data,
> is interpreting it going to cause any problem that we will care
> about?  If we are talking about 1 hour of CPU time vs 2 hours for jit
> vs interpreted for run- time stuff then it makes a difference, but if
> we are talking about 1 second vs 2 seconds for freshclam then maybe
> there's not much point.
> 

Well the purpose of loading the database with freshclam is to avoid
causing problems to clamd. So it is important that they are either both
JIT, or both non-JIT.

If for example freshclam would crash when running the JITed code, then
it would prevent loading a faulty DB into clamd. clamd would keep
running with the last DB that worked.
If freshclam falls back to nonJIT mode, and clamd doesn't, then it
could accept the database and clamd may crash.

Best regards,
--Edwin

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
