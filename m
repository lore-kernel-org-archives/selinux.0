Date: Sun, 12 Jun 2005 16:20:38 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: Park Lee <parklee_sel@yahoo.com>, Casey Schaufler <casey@schaufler-ca.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux?
Message-ID: <20050612152038.GC31033@lkcl.net>
References: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com> <20050612021611.94597.qmail@web51501.mail.yahoo.com> <20050612114421.GA31033@lkcl.net> <200506121239.j5CCdksZ009355@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200506121239.j5CCdksZ009355@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 12, 2005 at 08:39:45AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 12 Jun 2005 12:44:21 BST, Luke Kenneth Casson Leighton said:
> 
> >  btw i should also raise - again - the wisdom of only utilising
> >  a 32-bit security descriptor in a networked environment.
> 
> Should be sufficient in an IPv4 environment, since it's only identifying
> the other end.  I'm not awake enough yet

 ha!  you too? :)

> - does IPsec on the IPv6 side only
> carry 32-bit identifiers too? I'd consider *that* a design whoops...
 
 the underlying SIDs of selinux are 32-bit.

 [i do not know about IPsec or IPv6.]

 NT security descriptors are variable-length in multiples of 32-bit -
 anything up to a maximum of... [*guess*] 6x32-bit.

 there are special well-known security descriptors e.g. iirc correctly:
 S-1-0 is "world".

 even a workstation has its own SID "prefix", such that local users and
 local services running on that workstation are uniquely - world-wide -
 identifiable.

 [side-note: the only thing stopping NT 4.0 security from being
 expandable world-wide was the use of a NetBIOS naming scheme
 for name resolution.  if microsoft had obeyed the rfc1001
 and rfc1002 specifications, developed back by IBM somewhere
 in the 1980s iirc, then it would have been possible to map
 MS's NetBIOS implementation properly onto DNS, and they would
 have been off on a winner.  anyway...]


 ... when you only have 32-bit SIDs, as you do in selinux,
 how do you merge two departments or two corporations together,
 _after_ their MLS security has been independently developed?



> >  only 32-bit means that if you want to merge or join two secure
> >  environments together, well.... you basically can't: you have a clash
> >  of 32-bit SIDs.
> 
> Oh - the old "merge 2 1918 spaces" problem.. ;)  I suppose suggesting
> creative use of a NAT and RFC3489 would get blunt objects heaved in my direction. ;)

 well... maybe and maybe not :)

 as long as you are happy to put up with the selinux-sid-NAT table
 expanding out to near-epic proportions...

 ... but it's not _as_ daft as it sounds [at least to me, who came up
 with the SID<->uid/gid-Resolution system for samba]

 just... whatever you do, don't for one second be as stupid
 as the present samba team leadership, and imagine that it's
 okay to do "one-to-many" or "many-to-one" mappings in the
 selinux-sid-NAT tables...

 but the _better_ solution is to have a prefix - on a per-workstation
 basis AND also on a per-... ummm....

 what's a top-level MLS policy called?

 with the word "domain" taken up, which from the "nt domain"
 perspective i _would_ recommend the use of if it wasn't
 already used by selinux "domains"...

 what name should be given to a per-group-of-machines-and-users MLS
 policy?



> >  with NT / VAX-VMS style security descriptors (comprising 4of 32-bit
> >  "SIDs" for a domain and a 32-bit "RID" - relative ID) you can at least
> >  start creating inter-domain trust relationships.
> 
> Once you've established a secure connection to an identified host, there's
> nothing stopping you from passing more info down the pipe if the IP 4-tuple
> isn't sufficient to provide all the info needed..
 
 ah - but how do you say "a local [to me] user when they log
 in to the remote domain must be allowed to run program X"
 when the number for the selinux SID on that remote domain
 utilises the same SID number - for a different purpose?

 are you intending to add in a prefix of some kind, just like
 there is in NT / VAX-VMS security?

> >  now's the opportunity to ensure that MLS will be future-proof.
> > 
> >  are there any other alternate solutions to merging two MLS secure
> >  environments together?
> 
> I think a useful rephrasing is:
> 
> What information needs to be passed when opening an inter-domain trusted
> connection, that isn't already available in the IPSec headers?

 could you possibly help out here by clarifying that we are talking
 about the same thing?

 i don't see what the relevance of the IPsec headers are.

 are you intending the IPsec headers to be the equivalent of the NT /
 VAX-VMS domain "prefix"?

 is there any documentation online that i can read/refer to that will
 help me out, here?

 ta,

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
