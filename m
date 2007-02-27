Subject: Re: [PATCH] Lazy config init in libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <678979.3102.qm@web51510.mail.yahoo.com>
References: <678979.3102.qm@web51510.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 16:10:46 -0500
Message-Id: <1172610646.19041.419.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-27 at 12:47 -0800, Steve G wrote:
> >init_selinux_config() also sets several flags based on /etc/selinux/config
> >that are used by other functions, and you don't appear to have explicitly
> >added guards for them, 
> 
> OK, I see 3 new variables...however, they are not used in any selinux config file
> I've ever seen. Are they brand new and never used? Is there a reason they are not
> in /etc/selinux/config by default?

They aren't new, and SETLOCALDEFS=0 is in widespread use; you should
have it in your /etc/selinux/config if you are running anything newer
than Fedora Core 4.  But I'm not worried about the first two, because
they aren't on critical paths and can be easily guarded (and happen to
already hit a guard due to a prior call to a path function).  Only
CACHETRANS appears to be an issue.  You only need to define them
in /etc/selinux/config if you want something other than the default
value.  

> But so far no config file defines it. Is it really used? Right now everyone is
> getting the default value.

It was added back when the libselinux client-side support for context
translation was merged, upon someone's specific request on list.  So
we'd have to go back to that discussion.

> What about /etc/security...is that still used? Should that go away?

Likely obsolete, although we'd need to post an rfc asking whether any
distro is still using that as the location for their policy files. 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
