Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vA2ERAnV005498
 for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2017 10:27:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 3ySRrb4NZwz1pJCR
 for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2017 14:13:19 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 3ySRrZ6B5Tz1pJCH
 for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2017 14:13:18 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id z11so4701852pfk.4
 for <selinux@tycho.nsa.gov>; Thu, 02 Nov 2017 07:05:13 -0700 (PDT)
Date: Thu, 2 Nov 2017 22:05:04 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Message-ID: <20171102140504.GA1098@meriadoc.perfinion.com>
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

seobject.py is like a pile of hacks now, im not surprised its bad. We
really need to kill it completely (ie use setools directly instead of the
annoying wrappers in seobject). I keep meaning to go through and
port over the consumers of it slowly but -ENOTIME :(.

-- Jason

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
