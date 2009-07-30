Subject: Re: [PATCH -v3 1/3] Capabilities: move cap_file_mmap to commoncap.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        jwcart2@tycho.nsa.gov, spender@grsecurity.net, dwalsh@redhat.com,
        cl@linux-foundation.org, arjan@infradead.org, alan@lxorguk.ukuu.org.uk,
        kees@outflux.net, csellers@tresys.com,
        penguin-kernel@i-love.sakura.ne.jp
In-Reply-To: <20090730155403.GA13939@us.ibm.com>
References: <20090729185620.21757.44366.stgit@paris.rdu.redhat.com>
	 <20090730051426.GA6082@us.ibm.com> <1248968428.2597.79.camel@localhost>
	 <20090730155403.GA13939@us.ibm.com>
Content-Type: text/plain
Date: Thu, 30 Jul 2009 11:58:12 -0400
Message-Id: <1248969492.11627.172.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-30 at 10:54 -0500, Serge E. Hallyn wrote:
> Quoting Eric Paris (eparis@redhat.com):
> > On Thu, 2009-07-30 at 00:14 -0500, Serge E. Hallyn wrote:
> > > Quoting Eric Paris (eparis@redhat.com):
> > > > Currently we duplicate the mmap_min_addr test in cap_file_mmap and in
> > > > security_file_mmap if !CONFIG_SECURITY.  This patch moves cap_file_mmap
> > > > into commoncap.c and then calls that function directly from
> > > > security_file_mmap ifndef CONFIG_SECURITY like all of the other capability
> > > > checks are done.
> > > 
> > > It also
> > > 
> > > 	1. changes the return value in error case from -EACCES to
> > > 	   -EPERM
> > > 	2. no onger sets PF_SUPERPRIV in t->flags if the capability
> > > 	   is used.
> > > 
> > > Do we care about these?
> > 
> > Personally, not really, but I'll gladly put them back if you care.   #2
> > seems more interesting to me than number 1.   I actually kinda like
> > getting EPERM from caps rather than EACCES since them I know if I was
> > denied by selinux or by caps.....
> > 
> > -Eric
> 
> Yup, I asked bc I didn't particularly care myself.
> 
> I think I agree with you about -EPERM being better anyway.  However I
> (now) think in this case PF_SUPERPRIV definately should be set, as this
> is a clear use of a capability to do something that couldn't have been
> done without it.

On a related but different note, we should consider all current uses of
cap_capable(), as they represent capability checks that will not be
subject to a further restrictive check by other security modules.  In
this case and in the vm_enough_memory case, that is intentional, but not
so clear for other uses in commoncap.c.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
