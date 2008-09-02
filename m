Subject: Re: user guide draft: "Introduction" review
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Murray McAllister <mmcallis@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <alpine.LRH.1.10.0809011503430.7040@tundra.namei.org>
References: <48B4EAE2.302@redhat.com>
	 <1219842715.5708.63.camel@moss-spartans.epoch.ncsc.mil>
	 <48BB3E78.90406@redhat.com>
	 <alpine.LRH.1.10.0809011503430.7040@tundra.namei.org>
Content-Type: text/plain
Date: Tue, 02 Sep 2008 08:28:27 -0400
Message-Id: <1220358507.26711.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-09-01 at 15:04 +1000, James Morris wrote:
> On Mon, 1 Sep 2008, Murray McAllister wrote:
> 
> > Stephen Smalley wrote:
> > 
> > [snip]
> > 
> > > > 
> > > > -rwxrw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0      file1
> > > > 
> > > > In this example, SELinux provides a user (unconfined_u), a role
> > > > (object_r), a type (user_home_t), and a category (s0). 
> > 
> > Should this be, "...and a level (s0)"?
> 
> It's a sensitivity.
> 
> Security level = sensitivity + 0 or more categories.

True, but it is also a level (i.e. the sensitivity s0 and no
categories).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
