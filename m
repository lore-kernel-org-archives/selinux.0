Date: Fri, 4 Jun 2004 11:15:23 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Fedora SELinux support list for users & developers.'" <fedora-selinux-list@redhat.com>
Subject: Re: Summary of Informal SELinux Meeting on May 6, 2004
Message-ID: <20040604111523.GM3856@lkcl.net>
References: <200406022032.i52KWuSf003348@gotham.columbia.tresys.com> <20040603195738.GE3856@lkcl.net> <200406041803.23026.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406041803.23026.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 04, 2004 at 06:03:23PM +1000, Russell Coker wrote:
> On Fri, 4 Jun 2004 05:57, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > ?all in the same single monolithic daemon that bound itself
> > ?to several different ports and several different unix domain
> > ?sockets, you wouldn't seriously consider saying that "this
> > ?hybrid is a trusted application" would you?
> 
> "trusted" in this context does not mean "the code is great and we can totally 
> trust it", but rather "due to the design of the system we have no choice but 
> to trust it as it can totally break the security if it has a problem".
 
 well, the thing is that if you use samba-tng, you _do_ have a choice.

 each service is separated into its own daemon.

 you might want to mention this to the samba team because they were
 totally (and technically unjustifiable) unreasonably adamant that
 no such thing would be implemented in samba(3).

 "it's too slow"

 "using unix domain sockets is insecure"

 were my favourites.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
