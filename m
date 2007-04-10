Subject: Re: [patch] reducing size of libselnux/libsepol for embedded
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <1176223845.15415.204.camel@moss-spartans.epoch.ncsc.mil>
References: <20070409135030.d27a3177.ynakam@hitachisoft.jp>
	 <461A32E0.6020102@manicmethod.com>
	 <1176129881.15415.95.camel@moss-spartans.epoch.ncsc.mil>
	 <20070410100921.2c4400a6.ynakam@hitachisoft.jp>
	 <461BACF8.7000407@manicmethod.com>
	 <1176223845.15415.204.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 15:31:34 -0400
Message-Id: <1176233494.15415.213.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-10 at 12:50 -0400, Stephen Smalley wrote:
> On Tue, 2007-04-10 at 11:27 -0400, Joshua Brindle wrote:
> > Looking in the patch the libsepol unused sources has this:
> > 
> > +UNUSED_SRCS=link.c nodes.c roles.c iface_record.c module.c 
> > port_record.c user_record.c interfaces.c  node_record.c
> >  ports.c users.c
> > 
> > Why is link.c unused but not expand.c? Note that this will build a 
> > libsepol that checkpolicy cannot link against which is fine for an 
> > embedded environment but it needs to be explicitly stated I think. The 
> > options are basically going to be to turn off module support, boolean 
> > support, compiler support. The security server (services.c) can be 
> > removed also. If compiler and persistent boolean support isn't necessary 
> > anymore then write.c and read.c won't be necessary either.
> > 
> > After all that is removed I feel like libsepol won't actually exist, I'm 
> > not sure what the use case is right now, what are you trying to get out 
> > of libsepol and how fine grained can we get on taking out support.
> 
> Possibly the patch should selectively filter out objects from LOBJS
> (i.e. the shared library) while leaving them all in OBJS (i.e. the
> static library).  Then you could build a smaller shared libsepol.so
> library for installation on the embedded device that would only be used
> for e.g. boolean preservation, while still having the full static
> libsepol.a library on the build host for compiling checkpolicy and other
> users of the static library.  I think they are just trying to allow for
> boolean preservation without pulling in all of libsepol.

Another option would be to "fix" the kernel to preserve booleans
atomically across policy reloads.  Which would eliminate the need for
sepol_genbools_array altogether at policy load, and solve some other
problems, e.g. try running load_policy in a loop and then start another
loop that also runs load_policy, and they'll collide pretty fast (one of
them will end up trying to read an invalidated /selinux/booleans node
from the other's reload).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
