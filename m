Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SELinux List <SELinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1099344460.23756.49.camel@pham.columbia.tresys.com>
References: <4182959B.4080503@trustedcs.com>
	 <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net>
	 <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil>
	 <20041101141025.GZ8897@lkcl.net>  <418662EE.5090001@trustedcs.com>
	 <1099344460.23756.49.camel@pham.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099402984.31739.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 08:43:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 16:27, Karl MacMillan wrote:
> Dropping privileges after startup can already be accomplished with
> conditional policies, though it requires that only one process be
> running in a given domain.

Not sure that this works well in practice, e.g. daemon restart is an
issue here, and as you note, it cannot distinguish among multiple
instances of the domain.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
