Date: Fri, 26 May 2017 16:34:11 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix recently introduced TabError's
Message-ID: <20170526143410.GB7094@pl-workstation.usersys.redhat.com>
References: <20170526140951.5112-1-plautrba@redhat.com>
 <1495809419.12091.11.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1495809419.12091.11.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 26, 2017 at 10:36:59AM -0400, Stephen Smalley wrote:
> On Fri, 2017-05-26 at 16:09 +0200, Petr Lautrbach wrote:
> > Commits a3d2c7a 6a7a5aa introduced inconsistent use of tabs and
> > spaces
> > in indentation what makes python3.6 unhappy.
> 
> Thanks, applied, and also fixed up print statements -> functions.

Great thanks. In this case please ignore my previous email.

> 
> > 
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > ---
> >  libsemanage/utils/semanage_migrate_store | 4 ++--
> >  python/semanage/seobject.py              | 6 +++---
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/libsemanage/utils/semanage_migrate_store
> > b/libsemanage/utils/semanage_migrate_store
> > index 9a9fac22..2e6cb278 100755
> > --- a/libsemanage/utils/semanage_migrate_store
> > +++ b/libsemanage/utils/semanage_migrate_store
> > @@ -254,8 +254,8 @@ if __name__ == "__main__":
> >  		"policy.kern",
> >  		"file_contexts",
> >  		"homedir_template",
> > -                "pkeys.local",
> > -                "ibendports.local"]
> > +		"pkeys.local",
> > +		"ibendports.local"]
> >  
> >  
> >  	create_dir(newroot_path(), 0o755)
> > diff --git a/python/semanage/seobject.py
> > b/python/semanage/seobject.py
> > index 61be6198..c97a9f0c 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -1321,10 +1321,10 @@ class ibpkeyRecords(semanageRecords):
> >          semanageRecords.__init__(self, store)
> >  
> >      def __genkey(self, pkey, subnet_prefix):
> > -	if subnet_prefix == "":
> > +        if subnet_prefix == "":
> >              raise ValueError(_("Subnet Prefix is required"))
> >  
> > -	pkeys = pkey.split("-")
> > +        pkeys = pkey.split("-")
> >          if len(pkeys) == 1:
> >              high = low = int(pkeys[0], 0)
> >          else:
> > @@ -1576,7 +1576,7 @@ class ibendportRecords(semanageRecords):
> >          semanageRecords.__init__(self, store)
> >  
> >      def __genkey(self, ibendport, ibdev_name):
> > -	if ibdev_name == "":
> > +        if ibdev_name == "":
> >              raise ValueError(_("IB device name is required"))
> >  
> >          port = int(ibendport)
