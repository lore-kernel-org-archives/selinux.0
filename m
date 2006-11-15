Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAF9nVJB016740
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 04:49:31 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAF9lqcB017096
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 09:47:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Latest Diffs
Date: Wed, 15 Nov 2006 20:49:36 +1100
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
References: <453E2A8C.4070207@redhat.com> <1162328409.31675.131.camel@sgc.columbia.tresys.com> <455A2304.5090709@redhat.com>
In-Reply-To: <455A2304.5090709@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611152049.38615.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 15 November 2006 07:11, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >> Redhat's Fedora Extras apd-get and apt-shell run as rpm.
> >
> > Can't add this because it causes conflicting file contexts if the dpkg
> > module is included.
>
> I think we need a rewrite of the dpkg te file so on redhat platforms
> dbkg_t is aliased to rpm_t.

I think it's best if Red Hat compiles just don't include dpkg.te.

Have apt-get and yum run in the same context in Fedora.

> >> squid wants to rw_tmpfs for diskd mode.
> >
> > I'm wondering if this is tmpfs_t because there is no squid_tmpfs_t+type
> > transition, or if it is because the machine is targeted.
>
> Not sure, this was in the old policy as well.  Never used squid.

I believe that it was a mistake in the Squid policy.

> Added boolean to allow daemons to dump core in /.

Some of the fun things this permits include:

Creating a file named /fsckoptions with "-r" or "-N" as the contents (system 
hang on boot or failure to ever do an automatic fsck).

Creating /.unconfigured (could be good for taking over an Internet terminal 
machine).

Also as daemons don't have separate types for the core files there is the 
issue of matching the core files up to the domain that generated them.

Can't you use /proc/sys/kernel/core_pattern to put the core files somewhere 
else?  Preferably somewhere in a mode 700 directory.

Also those files that are generated in the root directory are a bad idea, 
there should probably be a long term plan to move them elsewhere.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
