Date: Thu, 12 Apr 2007 00:29:11 +0900
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
To: Joshua Brindle <method@manicmethod.com>
Cc: himainu-ynakam@miomio.jp, kmacmillan@mentalrootkit.com, sds@tycho.nsa.gov,
        ynakam@hitachisoft.jp, selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        eparis@parisplace.org
Subject: Re: [patch] reducing size of libselnux/libsepol for embedded
Message-Id: <20070412002911.cebe101a.himainu-ynakam@miomio.jp>
In-Reply-To: <461C2A33.6060707@manicmethod.com>
References: <20070409135030.d27a3177.ynakam@hitachisoft.jp>
	<461A32E0.6020102@manicmethod.com>
	<1176129881.15415.95.camel@moss-spartans.epoch.ncsc.mil>
	<20070410100921.2c4400a6.ynakam@hitachisoft.jp>
	<461BACF8.7000407@manicmethod.com>
	<1176223845.15415.204.camel@moss-spartans.epoch.ncsc.mil>
	<1176233494.15415.213.camel@moss-spartans.epoch.ncsc.mil>
	<1176234465.32661.1.camel@localhost.localdomain>
	<461C2A33.6060707@manicmethod.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 10 Apr 2007 20:22:11 -0400
Joshua Brindle  wrote:
> For example, even on a managed device there may be no need for the 
> security server code. One thing that worries me about having so many 
> configurations of the library is that when bug reports come in it may be 
> difficult to find out how the library was built. Perhaps we should add 
> build information into the library that can be printed out with sestatus?
I see, new function such as libselinux_buildinfo will be prepared in libselinux, 
and sestatus will use that.
I will try to add that one in next patch.

> >> Another option would be to "fix" the kernel to preserve booleans
> >> atomically across policy reloads.  Which would eliminate the need for
> >> sepol_genbools_array altogether at policy load, and solve some other
> >> problems, e.g. try running load_policy in a loop and then start another
> >> loop that also runs load_policy, and they'll collide pretty fast (one of
> >> them will end up trying to read an invalidated /selinux/booleans node
> >> from the other's reload).
> > I like this idea. Of course, it would mean that permanent boolean
> > changes would either require managed policy or a policy recompile, which
> > is likely acceptable.
> I like it too. Permanent boolean changes already require managed policy 
> or a policy recompile in trunk (due to removal of setlocaldefs support) 
> so there is a good chance that noone will notice :)
Me too.

I wanted only sepol_genbools_array in libsepol, 
but it was hard to pick up least set of functions, 
so many files were remaining.

> Also, AFAIK libselinux only depends on libsepol for the boolean stuff so 
> libsepol will no longer be necessary on unmanaged machines with no 
> policy compiler, this is good.
Sounds fine.
I will prepare patch for only libselinux next time.
#Please wait for updated patch..

Regards,
Yuichi Nakamura


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
