Subject: Re: Patch to add python audit2why bindings.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <479789E3.3060007@redhat.com>
References: <4787936A.8030803@redhat.com>
	 <1201098728.7025.270.camel@moss-spartans.epoch.ncsc.mil>
	 <479789E3.3060007@redhat.com>
Content-Type: text/plain
Date: Wed, 23 Jan 2008 13:47:40 -0500
Message-Id: <1201114060.7025.292.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-01-23 at 13:39 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > On Fri, 2008-01-11 at 11:03 -0500, Daniel J Walsh wrote:
> > Updated policycoreutils will be coming to take advantage of these bindings.
> > 
> > setroubleshoot will also.
> > 
> > import selinux
> > 
> > will work the way it always did, but now you can execute
> > 
> > import selinux.audit2allow as audit2allow
> > 
> > audit2allow.init()
> > 
> > for i in avc:
> > 	print audit2allow.analyze(i.scon, i,tcon, i,class, i.access)
> > 
> > audit2allow.finish()
> > 
> > And get the reason for the AVC.
> > 
> >> The Makefile changes are broken:
> >> make DESTDIR=~/obj install install-pywrap > outinstall: accessing
> >> `/home/sds/obj/usr/lib/python2.5/site-packages/selinux/__init__.py': Not
> >> a directory
> >> make[1]: *** [install-pywrap] Error 1
> >> make: *** [install-pywrap] Error 2
> > 
> Works for me?
> 
> THis directory should have been created by the Makefile?

I see the problem - you have:
+       test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d $(PYTHONLIBDIR)/site-packages/selinux

instead of:
+       test -d $(PYTHONLIBDIR)/site-packages/selinux || install -m 755 -d $(PYTHONLIBDIR)/site-packages/selinux

So if site-packages already existed but not site-packages/selinux, the
install would break.

I'll fix it up for merge.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
