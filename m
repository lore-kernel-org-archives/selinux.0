From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: Adding alternate root patch to restorecon (setfiles?)
Date: Tue, 26 Oct 2004 01:35:01 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <41741A2C.8040408@redhat.com> <41751792.4060207@redhat.com> <20041019183646.GC19398@lkcl.net>
In-Reply-To: <20041019183646.GC19398@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410260135.01652.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Oct 2004 04:36, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Tue, Oct 19, 2004 at 09:33:06AM -0400, Daniel J Walsh wrote:
> > Thomas Bleher wrote:
> > Good point, good thing I never put out a patched version.  We need ideas
> > on the best way to do something
> > like this.
>
> um... what happens if a user runs restorecon in a chroot environment
> that they create?

One thing to note is that running programs inside a chroot environment in the 
same domain that they may run under in a non-chroot environment is probably a 
bad idea.

If the user can do something that is path sensitive then they can do it from 
user_t which does not have chroot capability.  If they enter a chroot 
environment then they do it through a program which has appropriate privs and 
then enter a different domain.

If the user can enter arbitary domains in a chroot then you are bound to lose 
somehow.


NB  This has nothing to do with the patches to restorecon, just something to 
note for future reference.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
