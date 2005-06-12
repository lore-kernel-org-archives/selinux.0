Date: Sun, 12 Jun 2005 21:52:29 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu, Park Lee <parklee_sel@yahoo.com>,
   Casey Schaufler <casey@schaufler-ca.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux?
Message-ID: <20050612205229.GH31033@lkcl.net>
References: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com> <20050612021611.94597.qmail@web51501.mail.yahoo.com> <20050612114421.GA31033@lkcl.net> <200506121239.j5CCdksZ009355@turing-police.cc.vt.edu> <20050612152038.GC31033@lkcl.net> <200506121918.j5CJIhlt021805@turing-police.cc.vt.edu> <20050612202539.GE31033@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050612202539.GE31033@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 12, 2005 at 09:25:39PM +0100, Luke Kenneth Casson Leighton wrote:
> > >  are you intending to add in a prefix of some kind, just like
> > >  there is in NT / VAX-VMS security?
> > 
> > Might be worth looking into..
> 
>  well, if you're going to follow the convention of passing around the
>  context [as a string] then you might as well continue with that
>  tradition...
> 
>  i dunno... say, by adding @hostname or @dns.domain.name
> 
>  e.g. foo_u:bar_r:baz_t@toplevelmlsgroup.mycompany.co.uk or
>  foo_u:bar_r:baz_t@myworkstation.mycompany.co.uk
 
 just an additional thought - i think people would _hate_ to
 have to add @thingy... in front of every single type.

 from a compilation perspective it might be best to be
 able to specify a default dns domain name as part of the
 /etc/selinux/src/policy/.... config and to accept "exceptions" to this
 in a grouping syntax:

 @mls-external-domain=someoneelsesworkstation.mycompany.com
 {
 	allow foo_t ...
 	allow bar_t ...
 }

 as an understandable simplification for:

 allow foo_t@mls-external-domain=someoneelsesworkstation.mycompany.com ...
 allow bar_t@mls-external-domain=someoneelsesworkstation.mycompany.com ...

 that way it minimises the impact on single-workstation systems.


 ... you have _no_ idea how delighted i would be to see this in
 operation.

 linux finally catching up with nt after nearly 20 years,
 sticking one in MS's eye, having a security model that
 surpasses NT domains.

 ... of course, i wouldn't expect its configuration and setup
 to be easy, of _course_ i'd expect configuration to involve
 flat text files.

 teehee.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
