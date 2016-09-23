Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NHiK1l018387
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 13:44:20 -0400
Received: by mail-pa0-f41.google.com with SMTP id wk8so42200623pab.1
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 10:44:17 -0700 (PDT)
Date: Sat, 24 Sep 2016 01:44:13 +0800
From: Jason Zaman <jason@perfinion.com>
To: Petr Lautrbach <plautrba@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: setools4 support
Message-ID: <20160923174413.GA1499@meriadoc>
References: <1474557453-14379-1-git-send-email-jason@perfinion.com>
 <dab0152e-1976-5eab-b834-6c1b572ff4bc@tycho.nsa.gov>
 <22ff72d8-7d98-d35a-e193-52beb64e80e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22ff72d8-7d98-d35a-e193-52beb64e80e8@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 23, 2016 at 07:11:55PM +0200, Petr Lautrbach wrote:
> On 09/23/2016 07:07 PM, Stephen Smalley wrote:
> > On 09/22/2016 11:17 AM, Jason Zaman wrote:
> >> Hi all,
> >>
> >> I finally got everything updated to use setools4. The most complicated parts
> >> were sepolicy.search() and sepolicy.info() which were largely undocumented. I
> >> dumped and diff'd the output from the old and new code so am fairly confident
> >> that they are the same (barring some issues that setools3 appears to have with
> >> cil). I also changed several places to just use setools directly, having the
> >> indirection through search() mostly just complicates and slows things down.
> >>
> >> The first patch is just cleanup. Next imports and initializes setools.
> >> Patches 3-4 update a lot of the users of search() and info() to work with the next
> >> changes.
> >> Patches 5-6 update search() and info() themselves and the last drops the C
> >> module completely
> >>
> >> I dont know the status of setools4 on fedora (someone else will have to update
> >> the README if needed) or others but I've added it masked in gentoo a fair while
> >> ago. Once this patchset is merged we can finally get rid of setools3, its been
> >> half-broken for a while now.
> > 
> > AFAICT, setools4 is not packaged for Fedora yet.
> 
> I haven't updated it for some time but you can try
> 
> https://copr.fedorainfracloud.org/coprs/plautrba/setools4/
> 
> I would like setools4 to be packaged for Fedora 26. The conflict among
> setools 3 and setools 4 needs to be resolved first. The idea is to have
> legacy setools3-libs and setools4 with the tools.

Once sepolicy is updated there is no conflict anymore. The problem was
sepolicy needed old setools3 stuff, this makes it all use setools4 so
you would be able to kill setools3 completely and just update setools to
4.0

-- Jason

> 
> Petr
> 
> > $ git clone https://github.com/TresysTechnology/setools
> > $ cd setools
> > $ git checkout 4.0
> > $ sudo python setup.py install
> > $ sesearch
> > Traceback (most recent call last):
> >   File "/usr/bin/sesearch", line 4, in <module>
> >     __import__('pkg_resources').run_script('setools==4.0.1', 'sesearch')
> >   File "/usr/lib/python2.7/site-packages/pkg_resources/__init__.py",
> > line 724, in run_script
> >     self.require(requires)[0].run_script(script_name, ns)
> >   File "/usr/lib/python2.7/site-packages/pkg_resources/__init__.py",
> > line 1657, in run_script
> >     exec(script_code, namespace, namespace)
> >   File
> > "/usr/lib64/python2.7/site-packages/setools-4.0.1-py2.7-linux-x86_64.egg/EGG-INFO/scripts/sesearch",
> > line 21, in <module>
> > 
> >   File "build/bdist.linux-x86_64/egg/setools/__init__.py", line 30, in
> > <module>
> >   File "build/bdist.linux-x86_64/egg/setools/policyrep/__init__.py",
> > line 34, in <module>
> > ImportError: cannot import name qpol
> > 
> > What I am doing wrong?
> > 
> 
