Date: Thu, 3 Jun 2004 19:57:38 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Fedora SELinux support list for users & developers.'" <fedora-selinux-list@redhat.com>
Subject: Re: Summary of Informal SELinux Meeting on May 6, 2004
Message-ID: <20040603195738.GE3856@lkcl.net>
References: <200406022032.i52KWuSf003348@gotham.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406022032.i52KWuSf003348@gotham.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 02, 2004 at 04:33:19PM -0400, Karl MacMillan wrote:

> circumstance because of some details of the SMB/CIFS protocol. It was argued
> that Samba is a trusted application and it would be appropriate, therefore,
> to allow it to enforce SELinux access decisions by becoming a user-space
> object manager. 

 samba is not a single "entity".

 samba consists of approximately twenty to twenty five
 separate services, six or seven different network protocols,
 approximately FIVE different authentication systems or
 authentication modes, the list goes on.

 that, in samba(3) they are implemented in only two daemons is
 both amazing and also, to be quite blunt, short-sighted.

 at least in samba tng an effort was made to split out the
 DCE/RPC services into separate programs (with intended and
 planned work - that was shelved - to split out the Network
 Neighbourhood arena from the WINS Server from the browsing
 services)

 
 think of all of the services that NT has - NETLOGON, spool / printer,
 registry, SAM database, Local Security Authority, CMDAT (capability
 to run remote jobs), EventLog, WINS server, Browser Server to
 handle the Network Neighbourhood, File server.

 samba (at least, samba tng) has _all_ of these services, in incomplete
 form, in the same way that Wine has some of the Win32 API.


 i just want you to be aware of this before making any recommendations
 that samba should be considered to be a "trusted application".

 think of it this way.

 if somebody decided to implement:

 - lpd or cupsys
 - an nfs user-space file server
 - cron
 - a dhcp server
 - a dns server
 - a syslog server
 - KDE's DCOP server or Gnome's CORBA services

 all in the same single monolithic daemon that bound itself
 to several different ports and several different unix domain
 sockets, you wouldn't seriously consider saying that "this
 hybrid is a trusted application" would you?
 
 l.

 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
