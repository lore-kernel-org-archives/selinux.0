From: "Roberts, William C" <william.c.roberts@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [RFC] [PATCH] kernfs: hook inode initialization for LSMs
Date: Tue, 26 May 2015 18:23:04 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5601018543@ORSMSX103.amr.corp.intel.com>
References: <1432319136-160378-1-git-send-email-william.c.roberts@intel.com>
 <20150523151158.GC11783@kroah.com>
In-Reply-To: <20150523151158.GC11783@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Saturday, May 23, 2015 8:12 AM
> To: Roberts, William C
> Cc: selinux@tycho.nsa.gov; linux-security-module@vger.kernel.org;
> sds@tycho.nsa.gov
> Subject: Re: [RFC] [PATCH] kernfs: hook inode initialization for LSMs
> 
> On Fri, May 22, 2015 at 11:25:35AM -0700, william.c.roberts@intel.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > On the Android side of the house, were required to label each and
> > every sysfs file with a specific label.
> 
> "required"?
> 
> And what label are you having to use?

Yes, required by CTS. A check occurs on submission of the platform to google
To ensure some basic sanity, this is the CTS tests. Part of this test is to ensure
that domains are not given write access to all of sysfs. In Android, we define
a specific label to each sysfs node, and grant access to that for that specific
domain.

> 
> > sysfs often has transient
> > files, and this uncovered a limitation in SELinux. In most filesystems
> > the new inode inherits from the parents label, but in sysfs, this was
> > not the case. The new inode would inherit the syfs wide "default"
> > label.
> 
> Do you really want to build up a list of SELinux policies for sysfs
> files/directories, only to see them need to be redone when the tree moves
> things around in the future?

That's not really an issue for us. We have only a handful of rules, and the sysfs nodes
change from device to device. Our intent is not to label all of sysfs independently, just
the few nodes that we need write access too. As an  example, on the Nexus 7 or
"hammerhead" device we have 13 distinctly separately labeled sysfs file entries including
the global sysfs label. 

> 
> What type of "rules" are you using here for sysfs to handle the dynamic-ness
> of the tree properly?

I may not understand what you're asking here properly. In the case of a dynamic sysfs
file, we may have labeled its parent directory a specific label and allowed access to that
label type, however, when the child is created dynamically, it doesn't get that label and
defaults to the sysfs wide one.

> 
> thanks,
> 
> greg k-h
