Subject: Re: load_policy has to be moved to /sbin from /usr/sbin to handle
 initrd executing load_policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4AC39BC4.8020804@redhat.com>
References: <4AC39BC4.8020804@redhat.com>
Content-Type: text/plain
Date: Wed, 30 Sep 2009 13:59:16 -0400
Message-Id: <1254333556.30591.81.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-30 at 13:56 -0400, Daniel J Walsh wrote:
> Ubunto and Fedora have moved to a model where the initrd executes load_policy -i.
> 
> This means load_policy has to be in /sbin since /usr might not be mounted.

We had a similar change happen for setfiles, and if you look a little
further down in semanage_conf_init(), you'll see that we call access()
to check whether setfiles lives in /sbin or /usr/sbin and then set it
accordingly.  You'll want to do the same thing here to avoid breakage on
systems that still have it in the old location.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
