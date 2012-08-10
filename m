From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: A filename to label translation daemon
Date: Fri, 10 Aug 2012 23:35:40 +1000
Cc: Colin Walters <walters@verbum.org>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov, lennart@poettering.net, sds@tycho.nsa.gov
References: <1344454290.25533.12.camel@localhost> <201208101228.11637.russell@coker.com.au> <502500ED.5050502@redhat.com>
In-Reply-To: <502500ED.5050502@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201208102335.40545.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Aug 2012, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > What is kerberos doing under /tmp and why is it being done repeatedly by
> > different processes?
> 
> Actually /var/tmp/HOST_0 /var/tmp/HTTP_23 ...  Kerberos Replay Cache.  
> Every time someone contacts an apache server using kerberos it needs to
> update this file, it does this via mktemp (/tmpHTTPD_23XXXX), rename.

When replacing an existing file wouldn't it be better to just copy the context 
of the existing file when creating the replacement?  If there was some good 
reason for running chcon on such a file (and I can't imagine a reason but it's 
best to leave the options open IMHO) then having the context change back the 
next time someone connects seems like a bug.

> >> Running make install has caused a huge hit if you are running thousands
> >> of install commands which caused the remove of labeling from the install
> >> command.
> > 
> > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=638304
> > 
> > I believe that is a design bug in the SE Linux code in install, I've
> > filed the above Debian bug report about it.
> > 
> > I think that correct design of install wouldn't have a "make install"
> > performed as part of a dpkg or rpm build do any SE Linux checks.  That
> > would be faster than any other option.
> 
> Programmers and testers regularly run make install and this ends up badly
> mislabling files all over the place, telling everyone they have to use rpm
> or dpkg is not going to fly.

The current behavior of dpkg-buildpackage (and presumably a similar RPM build) 
producing lots of warning messages from install (depending on where you build 
it) isn't great either.

Would it be possible to have dpkg-buildpackage (and other relevant programs) 
set an environment variable to modify the behavior of install in such 
situations?

Also note that as install doesn't apply such contexts when creating 
directories the problem of testers running "make install" isn't properly 
solved with the current code.

> >> Systemd has been is executing the load load many many times and is
> >> showing up to 1 second slow down on startup.  If the startup is 10
> >> seconds, it is kind of hard to justify 10% slowdown on boot.
> > 
> > Wow, who's got a 10 second boot?
> > 
> > Is systemd loading the file contexts 100 times?  If not then why is it
> > taking a second?
> 
> 10 second boot is available with solid state machines.  Systemd has not
> seen the kind of performance that you are and obviously this is sensitive
> to the speed of the CPU/Memory.

Why isn't systemd seeing the same performance?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
