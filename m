Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SELinux List <SELinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1099404989.23756.79.camel@pham.columbia.tresys.com>
References: <4182959B.4080503@trustedcs.com>
	 <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net>
	 <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil>
	 <20041101141025.GZ8897@lkcl.net>  <418662EE.5090001@trustedcs.com>
	 <1099344460.23756.49.camel@pham.columbia.tresys.com>
	 <1099402984.31739.17.camel@moss-spartans.epoch.ncsc.mil>
	 <1099404989.23756.79.camel@pham.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099405140.31739.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 09:19:00 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 09:16, Karl MacMillan wrote:
> It would certainly require some additional infrastructure and more
> invasive changes to init scripts, but it could be made to work. I think
> that others have raised the more important point - what real use case is
> there for this functionality?

A common problem in Fedora is that daemons expect to be able to display
output and possibly to get user input during startup (e.g. httpd ssl
requesting a passphrase), then close their descriptors and proceed to
normal operation.  Since we revoke access to the tty upon the exec of
the daemon, we run into this problem frequently.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
