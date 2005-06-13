Date: Mon, 13 Jun 2005 22:17:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Valdis.Kletnieks@vt.edu, Park Lee <parklee_sel@yahoo.com>,
   Casey Schaufler <casey@schaufler-ca.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux?
Message-ID: <20050613211755.GC17412@lkcl.net>
References: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com> <20050612021611.94597.qmail@web51501.mail.yahoo.com> <20050612114421.GA31033@lkcl.net> <200506121239.j5CCdksZ009355@turing-police.cc.vt.edu> <20050612152038.GC31033@lkcl.net> <1118666993.24565.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1118666993.24565.13.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 13, 2005 at 08:49:53AM -0400, Stephen Smalley wrote:
> On Sun, 2005-06-12 at 16:20 +0100, Luke Kenneth Casson Leighton wrote:
> >  the underlying SIDs of selinux are 32-bit.
> <snip>
> >  ... when you only have 32-bit SIDs, as you do in selinux,
> >  how do you merge two departments or two corporations together,
> >  _after_ their MLS security has been independently developed?
> 
> SIDs are node-local and non-persistent (and now kernel-private)
> identifiers.  Complete non-issue.
 
 *sigh* yes, it took valdis and i a couple of rounds of email
 on sunday to establish / remind ourselves of that.

 
> For a CIPSO-style implementation like the Selopt implementation by James
> Morris for the old SELinux, you can store the SID in the option and then
> perform translation on the receiving host based on a network SID cache
> that maps (source address, SID) pairs to local SIDs, using a userspace
> security context mapping daemon to get the actual security context if
> the network SID isn't already cached.
 
 ah HA!  so there exists something that does ... sort-of-NAT, already?
 GREAT!



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
