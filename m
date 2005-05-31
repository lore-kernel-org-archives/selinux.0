Subject: Re: file_type_auto_trans is not sufficient
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1117546555.13058.14.camel@dhcp83-8.boston.redhat.com>
References: <1117249760.19257.18.camel@localhost.localdomain>
	 <1117545526.28924.57.camel@moss-spartans.epoch.ncsc.mil>
	 <1117546555.13058.14.camel@dhcp83-8.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 31 May 2005 09:53:51 -0400
Message-Id: <1117547631.28924.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-05-31 at 09:35 -0400, Ivan Gyurdiev wrote:
> Yes, but there's problems with that - in particular:
> 
> - is this thread-safe - see my later message

Answer:  Thread-safe, yes.  Allowed by current libselinux, no.

> - is this a good idea - it pushes dynamic type changes into various
> programs, while otherwise it's all in the policy, and easier to analyze 

Everything still has to be allowed by the policy, so analysis is still
feasible.  setfscreatecon() just selects one of the types allowed by the
policy for that domain to create.  Further, as you are using
matchpathcon(3), you can still see the filesystem mapping via
file_contexts.  Possibly the real question is whether the fine-grained
typing is truly justified and/or whether it might be feasible to achieve
via relocation so that the parent directory can be the distinguisher.

> - makes virtually everything depend on libselinux

Already true, e.g. /sbin/init, coreutils, ...
If it is a real concern, then others have suggested dlopen() and
friends.  But given that distros have been willing to date to accept
fundamental dependency for init and coreutils, it seems unlikely to be
needed.

> - I'm replicating the same code pattern in lots of places...

True.

> - it puts linux-specific code into otherwise portable apps. I've
> surrounded it all by WITH_SELINUX, but it's still rather ugly - 
> don't think upstream will like it.

True.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
