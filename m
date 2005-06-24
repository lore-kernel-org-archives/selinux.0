Date: Fri, 24 Jun 2005 15:50:28 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: "Brian T. Sniffen" <bsniffen@mitre.org>,
   Karl MacMillan <kmacmillan@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: Alternative user management approach
In-Reply-To: <1119637275.12865.116.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0506241549100.19660-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 24 Jun 2005, Stephen Smalley wrote:

> Yes, but SELinux doesn't isolate those shells even if they have
> different SELinux user identities if they have the same role and domain.
> In fact, you only get real isolation in SELinux between domains (or MLS
> levels, if using MLS).  

But how would this change impact MLS, given that levels are associated 
with SELinux users?


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
