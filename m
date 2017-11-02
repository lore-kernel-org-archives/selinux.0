Date: Thu, 2 Nov 2017 15:17:17 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Message-ID: <20171102141717.GA1469@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <20171102131930.11585-1-plautrba@redhat.com>
 <1509630745.4623.4.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1509630745.4623.4.camel@tycho.nsa.gov>
Subject: Re: [PATCH] python/semanage: Do not try to reload policy
 when SELinux is disabled
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Nov 02, 2017 at 09:52:25AM -0400, Stephen Smalley wrote:
> On Thu, 2017-11-02 at 14:19 +0100, Petr Lautrbach wrote:
> > When SELinux is disabled, semanage without -N fails with a quite
> > complicated
> > error message when it tries to reload a new policy. Since reload in
> > this case
> > doesn't make sense, we should probably try to avoid that.
> 
> I haven't looked closely at this yet, but I know libsemanage itself
> internally sets ->do_reload to false if is_selinux_enabled() is 0 (or
> -1), so why is it that seobject.py is manually deciding whether to
> reload policy?

semanageRecords.commit() method calls semanage_set_reload(self.sh, self.load)
and this overrides the default value set in semanage_handle_create()

the flow something like this:

seobject: __init__(self, store):
    self.sh = self.get_handle(store)

semanage: semanageRecords.get_handle()
    handle = semanage_handle_create()

libsemanage: semanage_handle_create()
    sh->do_reload = (is_selinux_enabled() > 0);

seobject: commit()
    semanage_set_reload(self.sh, self.load)

Looking into this, the check if SELinux is enabled could be moved to
libsemanage: semanage_set_reload() and maybe with WARN message in case
that it doesn't set a new value.


> > 
> > Fixes:
> > $ sudo umount /sys/fs/selinux
> > 
> > $ sudo semanage fcontext -a --type=postfix_local_tmp_t
> > /var/opt/01789667
> > SELinux:  Could not downgrade policy file
> > /etc/selinux/targeted/policy/policy.31, searching for an older
> > version.
> > SELinux:  Could not open policy file <=
> > /etc/selinux/targeted/policy/policy.31:  No such file or directory
> > /sbin/load_policy:  Can't load policy:  No such file or directory
> > libsemanage.semanage_reload_policy: load_policy returned error code
> > 2. (No such file or directory).
> > SELinux:  Could not downgrade policy file
> > /etc/selinux/targeted/policy/policy.31, searching for an older
> > version.
> > SELinux:  Could not open policy file <=
> > /etc/selinux/targeted/policy/policy.31:  No such file or directory
> > /sbin/load_policy:  Can't load policy:  No such file or directory
> > libsemanage.semanage_reload_policy: load_policy returned error code
> > 2. (No such file or directory).
> > FileNotFoundError: [Errno 2] No such file or directory
> > 
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > ---
> >  python/semanage/seobject.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/python/semanage/seobject.py
> > b/python/semanage/seobject.py
> > index 1385315f..37f2b8c6 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -241,7 +241,7 @@ class semanageRecords:
> >  
> >      def __init__(self, store):
> >          global handle
> > -        self.load = True
> > +        self.load = selinux.is_selinux_enabled()
> >          self.sh = self.get_handle(store)
> >  
> >          rc, localstore = selinux.selinux_getpolicytype()
> > @@ -251,7 +251,7 @@ class semanageRecords:
> >              self.mylog = nulllogger()
> >  
> >      def set_reload(self, load):
> > -        self.load = load
> > +        self.load = selinux.is_selinux_enabled() and load
> >  
> >      def get_handle(self, store):
> >          global is_mls_enabled
