Subject: RE: [ SEPOL/SEMANAGE ] Boolean record
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   jbrindle@tresys.com
In-Reply-To: <200509211748.j8LHmnYs012526@gotham.columbia.tresys.com>
References: <200509211748.j8LHmnYs012526@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 13:53:33 -0400
Message-Id: <1127325213.2550.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-21 at 13:48 -0400, Karl MacMillan wrote:
> Just a note - there is a working policy server right now
> (sepolicy-server.sf.net has the latest release). That is why these
> functions, at the very least, need to be indirected through the
> semanage_handle_t function pointers so different versions can be plugged in
> for the remote implementation.

Last release there that I see was April.  And the CVS looks dead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
