Date: Sun, 12 Jun 2005 21:25:39 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: Park Lee <parklee_sel@yahoo.com>, Casey Schaufler <casey@schaufler-ca.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux?
Message-ID: <20050612202539.GE31033@lkcl.net>
References: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com> <20050612021611.94597.qmail@web51501.mail.yahoo.com> <20050612114421.GA31033@lkcl.net> <200506121239.j5CCdksZ009355@turing-police.cc.vt.edu> <20050612152038.GC31033@lkcl.net> <200506121918.j5CJIhlt021805@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200506121918.j5CJIhlt021805@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 12, 2005 at 03:18:42PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 12 Jun 2005 16:20:38 BST, Luke Kenneth Casson Leighton said:
> 
> >  the underlying SIDs of selinux are 32-bit.
> 
> Whoops. I forgot about that. ;)

 :)  but hey, like you point out, it's not the SIDs that are the
 critical bits, it's the context "name" - string.


> >  [i do not know about IPsec or IPv6.]
> 
> The 'spi' field in the ip_auth_hdr and ip_esp_hdr is a u32, which is what
> I was thinking of...
> 
> >  ... when you only have 32-bit SIDs, as you do in selinux,
> >  how do you merge two departments or two corporations together,
> >  _after_ their MLS security has been independently developed?
> 
> We just rely on the magic of sidtab_context_to_sid() -  it's basically
> handed something that looks like a 'foo_u:bar_r:baz_t' and cranks out a
> new SID, which is only used in the kernel.  As long as the merger of the
> two systems doesn't require more total SID's than a u32 can represent,
> there's no problem.
> 
> You however *do* need to adress collisions between two different foo_u ;)
 
 ah _ha_.  there y'go.


> >  ah - but how do you say "a local [to me] user when they log
> >  in to the remote domain must be allowed to run program X"
> >  when the number for the selinux SID on that remote domain
> >  utilises the same SID number - for a different purpose?
> 
> The SIDs are locally generated on the fly. It's the *CONTEXT* that might
> be in use elsewhere.  You'd basically want to make sure that on-the-wire you
> always pass around a context label rather than a SID.
 
 okay.  cool.

> You'll want *some* way of managing the allocation of contexts cluster-wide,
> just so you don't have two usages of jdoe_u that refer to two different users..
> 
> >  are you intending to add in a prefix of some kind, just like
> >  there is in NT / VAX-VMS security?
> 
> Might be worth looking into..

 well, if you're going to follow the convention of passing around the
 context [as a string] then you might as well continue with that
 tradition...

 i dunno... say, by adding @hostname or @dns.domain.name

 e.g. foo_u:bar_r:baz_t@toplevelmlsgroup.mycompany.co.uk or
 foo_u:bar_r:baz_t@myworkstation.mycompany.co.uk


> > > What information needs to be passed when opening an inter-domain trusted
> > > connection, that isn't already available in the IPSec headers?
> > 
> >  could you possibly help out here by clarifying that we are talking
> >  about the same thing?
> 
> You already clarified that we weren't.. ;)

oh. i did?  glad to be of help, then.  um :)  

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
