From: "david caplan" <dac@tresys.com>
To: <SELinux@tycho.nsa.gov>
Subject: RE: Help for setools 0.8
Date: Wed, 23 Apr 2003 11:19:09 -0400
Message-ID: <GBEAJBKHFOBIBBJBCGAGMECICMAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.44.0304161011360.24461-100000@boreas.ecs.syr.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In case others have had similar problems, the Bwidgets package that comes
with Debian (at least in this case) was 1.3.1.  We've been using a newer
version (1.4.1 off of the sourceforge site,
http://sourceforge.net/projects/tcllib), and apparently there are some
incompatabilities with the older version.  We'll make sure to note this in
our README file.

Thanks to Keisuke Inoue for figuring this out.

David

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Keisuke Inoue
> Sent: Wednesday, April 16, 2003 10:18 AM
> To: david caplan
> Cc: 'SELinux'
> Subject: RE: Help for setools 0.8
>
>
> Thank you for the responce.
>
> > Is apol.tcl in /usr/local/lib/apol?  That is the default installation
>
> Yes.
> Is it that the error occurs when apol.tcl is executed (with awin)?
>
> Keisuke Inoue
>
> On Wed, 16 Apr 2003, david caplan wrote:
>
> > Hi.
> >
> > Is apol.tcl in /usr/local/lib/apol?  That is the default installation
> > location for the tcl/tk front end script.  The apol application
> expects the
> > script to be there unless you've set the APOL_INSTALL_DIR environment
> > variable.
> >
> > David
> >
> > > -----Original Message-----
> > > From: owner-selinux@tycho.nsa.gov
> [mailto:owner-selinux@tycho.nsa.gov]On
> > > Behalf Of Keisuke Inoue
> > > Sent: Tuesday, April 15, 2003 11:49 AM
> > > To: 'SELinux'
> > > Subject: Help for setools 0.8
> > >
> > >
> > > Hello,
> > >
> > > I am Keisuke Inoue, a student in Syracuse University, NY.
> > > I am trying to use the setools 0.8, and cannot figure out
> what is wrong:
> > >
> > >      # apol
> > >      Error in StartScript (/usr/local/lib/apol//apol.tcl):
> > >
> > >      If APOL_INSTALL_DIR is set, make sure directory is correct
> > >
> > > I am using 2.4 LSM based kernel, Debian unstable, with Russell Coker's
> > > SELinux packages. Makefile was changed accordingly, but I haven't done
> > > anything else.
> > >
> > >     TCL_INCLUDE	= -I/usr/include/tcl8.3
> > >     TCL_LIBINC	= -L/usr/lib/tcl8.3
> > >     YACC	= bison-1.35 -y
> > >
> > >     POLICY_SRC_DIR  = /etc/selinux
> > >
> > > Thank you very much,
> > >
> > > K
> > >
> > >
> > >
> > > --
> > > This message was distributed to subscribers of the selinux
> mailing list.
> > > If you no longer wish to subscribe, send mail to
> > > majordomo@tycho.nsa.gov with
> > > the words "unsubscribe selinux" without quotes as the message.
> >
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
