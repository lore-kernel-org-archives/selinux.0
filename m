Date: Mon, 1 Sep 2008 15:04:26 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Murray McAllister <mmcallis@redhat.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Introduction" review
In-Reply-To: <48BB3E78.90406@redhat.com>
Message-ID: <alpine.LRH.1.10.0809011503430.7040@tundra.namei.org>
References: <48B4EAE2.302@redhat.com> <1219842715.5708.63.camel@moss-spartans.epoch.ncsc.mil> <48BB3E78.90406@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 1 Sep 2008, Murray McAllister wrote:

> Stephen Smalley wrote:
> 
> [snip]
> 
> > > 
> > > -rwxrw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0      file1
> > > 
> > > In this example, SELinux provides a user (unconfined_u), a role
> > > (object_r), a type (user_home_t), and a category (s0). 
> 
> Should this be, "...and a level (s0)"?

It's a sensitivity.

Security level = sensitivity + 0 or more categories.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
