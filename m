Subject: Re: dynamic context transitions
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SELinux List <SELinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1099402984.31739.17.camel@moss-spartans.epoch.ncsc.mil>
References: <4182959B.4080503@trustedcs.com>
	 <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net>
	 <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil>
	 <20041101141025.GZ8897@lkcl.net>  <418662EE.5090001@trustedcs.com>
	 <1099344460.23756.49.camel@pham.columbia.tresys.com>
	 <1099402984.31739.17.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 09:16:28 -0500
Message-Id: <1099404989.23756.79.camel@pham.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 08:43 -0500, Stephen Smalley wrote:
> On Mon, 2004-11-01 at 16:27, Karl MacMillan wrote:
> > Dropping privileges after startup can already be accomplished with
> > conditional policies, though it requires that only one process be
> > running in a given domain.
> 
> Not sure that this works well in practice, e.g. daemon restart is an
> issue here, and as you note, it cannot distinguish among multiple
> instances of the domain.
> 

It would certainly require some additional infrastructure and more
invasive changes to init scripts, but it could be made to work. I think
that others have raised the more important point - what real use case is
there for this functionality?

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
