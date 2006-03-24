Subject: Re: Install several policy modules at once?
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20060324125751.GC7306@thorium.jmh.mhn.de>
References: <20060324103805.GA7306@thorium.jmh.mhn.de>
	 <20060324125751.GC7306@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 08:11:59 -0500
Message-Id: <1143205919.23788.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-24 at 13:57 +0100, Thomas Bleher wrote:
> * Thomas Bleher <bleher@informatik.uni-muenchen.de> [2006-03-24 12:06]:
> > I'm currently building a very modular policy so one compiled policy can
> > be used on many different machines. However, installing new policy is
> > very slow (This is on an otherwise idle system):
> > 
> > # time (for i in $(semodule -l | awk '{print $1}'); do semodule -i ./$i.pp; done)
> > 
> > real    1m38.796s
> > user    1m1.645s
> > sys     0m8.502s
> > # semodule -l | wc -l
> > 23
> > 
> > (I don't use -u because I want to be sure I have exactly the policy
> > loaded which I just compiled)
> > 
> > Would it improve speed if semodule could process several modules at
> > once? Currently semodule doesn't allow this and I don't know enough
> > about its internals to estimate if it would be worth the effort.
> 
> Erich just gave me the helpful tip that it IS possible to install
> several policy modules at once, you just need to say
> 	semodule -i sudo.pp -i cups.pp
> instead of
> 	semodule -i sudo.pp cups.pp
> which I tried.
> So this just needs more documentation.
> 
> It's much faster, too:
> # time semodule -b base.pp $(semodule -l | awk '{print "-i " $1 ".pp"}')
> 
> real    0m1.656s
> user    0m1.339s
> sys     0m0.287s
> 
> So consider this issue solved.

Yes, this is (somewhat obscurely) noted in the usage and man page as:
	semodule [options] MODE [MODES]...

By bundling them up into a single transaction, you only pay the overhead
of expanding and checking assertions once.  Note that you can disable
assertion checking at expand time via expand-check=0 in semanage.conf,
but that isn't recommended for production.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
