From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: 2.6.0-test3
Date: Sat, 23 Aug 2003 00:24:01 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <1061468940.1665.16.camel@kusturica> <200308222321.21113.russell@coker.com.au> <1061561820.28086.147.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1061561820.28086.147.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308230024.01041.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 23 Aug 2003 00:17, Stephen Smalley wrote:
> On Fri, 2003-08-22 at 09:21, Russell Coker wrote:
> > I get the impression that no-one at the NSA has the time to spare for
> > back-porting the xattr handler, and it seems that everyone else who could
> > do it is also focussed on 2.6.0.  So it looks like this isn't going to
> > happen.
>
> It really wouldn't be difficult to do, and certainly doesn't require any
> deep SELinux or xattr knowledge.  Just copy fs/ext3/xattr_security.c and
> the related changes to fs/ext3/{Makefile,super.c} and fs/Config.in from
> the new 2.4-based SELinux to the old 2.4-based SELinux.  Of course, you
> do need to merge the EA patch from acl.bestbits.at as well, but that
> also shouldn't be too difficult.

That sounds positive.  I've already merged the EA patch, so I'll probably give 
it a go next week.

> > Also just writing the xattr handler would not be enough, you would need a
> > program that can read SIDs and then write equivalent xattrs, it shouldn't
> > be difficult but it's another thing that has to be done.
>
> If you simply want to set the xattrs from the file contexts
> configuration, you can just run the new setfiles program.  If you want
> to set the xattrs from the persistent label mapping, then you would need
> to restore the psid code to the new setfiles program and adjust it to
> get the value from the mapping and set the xattr from it.  Not
> difficult, but a little bit of work.

True.  Actually I was thinking of writing a custom utility that gets the 
context using the old API and writes it as xattrs.

> > Finally you would need wrapper programs for login, sshd, etc that check
> > which version of SE Linux is running and execute the correct version of
> > the program to match (but this is easy to do).
>
> Not clear if this is necessary, unless you want to be able to switch
> back and forth.  If you just want to upgrade, you should be able to just
> install the new versions while running the old kernel (since this won't
> affect already running instances) and then immediately boot the new
> kernel.

The problem here is that upgrades don't always work correctly.  I really don't 
want to go into an upgrade without without an escape route!

> > SUSE developed the ReiserFS xattr patches.  However they will not be
> > merged into the main ReiserFS tree, Hans recommends waiting for ReiserFS
> > v4 for xattr support.  :-#
>
> I'm not sure about this guidance, as reiser4 isn't in mainline yet, and
> last I looked at the reiser4 code, it did NOT include any xattr support
> or handlers.  Using the SuSE xattr patches for reiser seems to be the
> only real option for current reiser users.

Your comments make sense to me.  However Hans' opinions on this matter are 
authoritative, and leave us with a choice of maintaining yet another kernel 
patch (ACL, LSM, and a ReiserFS patch) in our trees which is more work and 
more risk of bugs, or of not using ReiserFS in this way.

I feel that for my machines my best option is to cease using ReiserFS.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
