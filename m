Subject: RE: Help with semanage...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1181064978.25769.73.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	 <1180633622.3534.78.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
	 <20070531204502.3a667419@maya>
	 <D06FE0A2807BC145B0D38744789D4F5D0399F027@de01exm68.ds.mot.com>
	 <1180993233.14220.171.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D0399F04E@de01exm68.ds.mot.com>
	 <1181048822.25769.23.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D0399F30B@de01exm68.ds.mot.com>
	 <1181064978.25769.73.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 13:51:28 -0400
Message-Id: <1181065888.25769.82.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-05 at 13:36 -0400, Stephen Smalley wrote:
> On Tue, 2007-06-05 at 12:34 -0400, Hasan Rezaul-CHR010 wrote:
> > The version of libsemanage I have is:   libsemanage-1.6.17-1
> > 
> > 1. What specific version of libsemanage  removes the use of the
> > ..../previous/  directory, as well as the  .../active/base.linked  files
> > ?
> 
> 1.9.2 or higher.
> 
> > 2. Would I need a newer version of some other library(ies) as well (like
> > libselinux, etc), so that executing semodule commands doesn't create a
> > .../previous/  directory ?  Example commands: 
> > "semodule -i myPolicy.pp"    -or-    "semodule -r myPolicy" 
> 
> No, it is a shared library and the .so version has not changed, so you
> don't have to upgrade other components.  However, common practice is to
> upgrade all of the selinux core userland together (checkpolicy,
> libsepol, libselinux, libsemanage, policycoreutils).

BTW, you can checkout the latest versions of the stable branch via:
$ svn co  https://selinux.svn.sourceforge.net/svnroot/selinux/branches/stable/1_0 sel-stable

You can then build and install the entire core selinux userland via:
$ cd sel-stable
$ su
# make install install-pywrap relabel

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
