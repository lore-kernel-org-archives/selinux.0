Date: Tue, 9 Jul 2002 09:41:30 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200207091441.JAA10062@tomcat.admin.navo.hpc.mil>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: comparison between SELinux and chroot
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dale Amon <amon@vnl.com>
> On Tue, Jul 09, 2002 at 12:00:44PM +0200, Carsten Grohmann wrote:
> > I am looking for a paper with an comparison between SELinux and chroot.
> > Why should I install and use SELinux, if I could use a chroot call, who is 
> > possible simplier.
> > 
> 
> That's sort of like comparing apples and rabbits. A chroot
> is a way of setting up an environment for testing or for
> a chroot jail... which can probably be broken out of, although
> you can improve this greatly with the grsec patches.
> 
> Selinux is security from the base up, built into the very
> operation of the system. It is MAC in the soul of the machine.
> 
> There simply *isn't* any real comparison.

Yes and no... :-)

A chroot jail, if properly implemented (hypotheticly) is like a fully
standalone workstation, without a network, without external storage, without...

The SELinux system is more like a timesharing system where authorized
users can access authorized data. There are multiple users that may communicate
if the security policy permits such communication. Any user that is not
authorized access to the data will be unable to access that data, even if
the owner of that data wants to give away access. This is part of the
mandatory access control that provides that separation. The other part is
referencing the security policy to determine what is being separated.

In good implementations, even if a breakin occured - that rogue process/user
would already be isolated from sensitive data. Chroot environments do
not even have the capability of such isolation except for some special purpose
processes such as DNS, where users are strictly indirect. Even in DNS, a
breakin to DNS allows full access to all data that belongs to the server.
Actual ownership could be separated, but nothing prevents a complete
substitution of the data.

Chroot environments do not handle data sharing very well. Yes, you can direct
multiple users into the same chroot jail, but you then can't isolate some of
the data from some of those same users. And you can't enforce the separation
at a management level.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
