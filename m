Subject: RE: I am concerned about putting genhomedircon
	changesinlibsemanage into Fedora 8.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd Miller <Tmiller@tresys.com>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588010FFA00@exchange.columbia.tresys.com>
References: <200709262001.l8QK1Skx029939@tex.courtesan.com>
	 <1190836803.15779.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1190838018.15779.170.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B01588010FFA00@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 27 Sep 2007 07:19:42 -0400
Message-Id: <1190891982.27038.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-26 at 17:41 -0400, Todd Miller wrote:
> Stephen Smalley wrote:
> > - A diff of file_contexts.homedirs generated via libsemanage vs. the
> > old /usr/sbin/genhomedircon script shows differences on rawhide.  Not
> > sure who is right.  Diff below.
> 
> It looks like the new genhomedircon is being overzealous in its
> replacemen
> of system_u.

The python script sets the default user from the __default_ entry in
seusers and the default prefix from the default user's prefix.  I don't
see corresponding support in the C implementation; it seems to use a
fixed value of user_u (which I think the python script did too at one
point, but later changed to check __default__).  In rawhide, __default__
is set to system_u rather than user_u for some reason.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
