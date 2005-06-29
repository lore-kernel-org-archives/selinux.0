Date: Wed, 29 Jun 2005 14:03:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: serue@us.ibm.com, <linux-security-module@wirex.com>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: RFC: jail functionality
In-Reply-To: <1120062900.3553.151.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0506291402040.12494-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 29 Jun 2005, Stephen Smalley wrote:

> > The attached task-lookup patches?
> 
> Not sure it provides much value.

If yoy need this, why not look at proper isolation via Xen?

LSM is about access control, not virtualization.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
