Date: Sun, 12 Jun 2005 12:44:21 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Park Lee <parklee_sel@yahoo.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Valdis.Kletnieks@vt.edu,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux?
Message-ID: <20050612114421.GA31033@lkcl.net>
References: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com> <20050612021611.94597.qmail@web51501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050612021611.94597.qmail@web51501.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jun 11, 2005 at 07:16:11PM -0700, Park Lee wrote:
> On Sat, 11 Jun 2005 at 12:49, Casey Schaufler wrote:
> 
> > --- Valdis.Kletnieks@vt.edu wrote:
> >
> >> (I'm guessing that OpenSSH was one of the "other
> >> protocols" Casey mentioned -
> >> it's *very* useful in it's problem space, but isn't
> >> the best choice for *this*
> >> problem (building an MLS cluster)...)
> >
> > The higher level the protocol the fewer system
> > services (e.g. NFS) that you can use it for.
> 
> If we use OpenSSH, Does it mean that we should send
> the data and its security attribute (e.g. sensitivity
> and clearance information of the data) together within
> a packet? 
> and Is there any other way to send security attribute
> first and then the date (just like in IPsec case)
> except using IPsec?
 
 yes, of course there is - you can invent something: make
 something up, yourself.

 ... however, if you look at the requirements carefully, i
 think you will find that IPsec fits most of the requirements
 better than anything else available.

 ... so why bother to go to all the effort of doing _another_ NIH
 syndrome we-can-do-better-than-what-already-exists style of thing.

 
 perhaps a simple way to think of this is that you need an isolated VPN,
 one where nothing but the kernel itself may access it, over which to
 communicate to a centralised security info controller.


 btw i should also raise - again - the wisdom of only utilising
 a 32-bit security descriptor in a networked environment.

 only 32-bit means that if you want to merge or join two secure
 environments together, well.... you basically can't: you have a clash
 of 32-bit SIDs.

 with NT / VAX-VMS style security descriptors (comprising 4of 32-bit
 "SIDs" for a domain and a 32-bit "RID" - relative ID) you can at least
 start creating inter-domain trust relationships.

 ... do you _want_ to create that kind of headache, in advance?

 now's the opportunity to ensure that MLS will be future-proof.

 are there any other alternate solutions to merging two MLS secure
 environments together?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
