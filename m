Message-Id: <200509211803.j8LI3XYs012693@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, <selinux@tycho.nsa.gov>,
   <jbrindle@tresys.com>
Subject: RE: [ SEPOL/SEMANAGE ] Boolean record
Date: Wed, 21 Sep 2005 14:03:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1127325213.2550.87.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Wednesday, September 21, 2005 1:54 PM
> To: Karl MacMillan
> Cc: 'Ivan Gyurdiev'; selinux@tycho.nsa.gov; jbrindle@tresys.com
> Subject: RE: [ SEPOL/SEMANAGE ] Boolean record
> 
> On Wed, 2005-09-21 at 13:48 -0400, Karl MacMillan wrote:
> > Just a note - there is a working policy server right now
> > (sepolicy-server.sf.net has the latest release). That is why these
> > functions, at the very least, need to be indirected through the
> > semanage_handle_t function pointers so different versions can be plugged
> in
> > for the remote implementation.
> 
> Last release there that I see was April.  And the CVS looks dead.
>

A new release is pending the completion of the libsemanage changes.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
