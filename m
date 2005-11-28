Subject: Re: [ SEPOL ] Check if policy file is MLS enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <4384732F.90808@cornell.edu>
References: <438452BD.30101@cornell.edu> <43846B71.6000806@tresys.com>
	 <4384732F.90808@cornell.edu>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 14:28:55 -0500
Message-Id: <1133206135.348.222.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-23 at 08:48 -0500, Ivan Gyurdiev wrote:
> Joshua Brindle wrote:
> > A much better way to do this would be to extract the header reading 
> > from policydb_read and make a helper function that does it. You will 
> > still be able to do a partial parse of the binary but only 1 function 
> > will have to be changed when a format change happens.
> That's true.. will fix.

Other issue here (as noted off-list) is whether this should be acting on
a module/policy file directly or on a module package file.  The latter
seems more suitable for use by libsemanage, like the existing _info
interface.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
