MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] Ability to allow unknown class and permissions
Date: Mon, 4 Dec 2006 13:13:51 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885C829F@exchange.columbia.tresys.com>
In-Reply-To: <1165245851.2923.52.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Eric Paris" <eparis@parisplace.org>, <selinux@tycho.nsa.gov>,
        "James Morris" <jmorris@redhat.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> Convenience should certainly be our primary design criteria.  
> On synchronization, the issue is applying a property (compat_net or
> handle_undefined) to a given policy and nothing else.  With 
> booleans, we can preload them into the policy image before 
> loading it.  With compat_net or handle_undefined, we have to 
> switch it before (possibly affecting the currently running 
> policy) or after (leaving open a window where the new policy 
> has the wrong setting), and we have to have a mechanism for 
> coordinating that switch and reload (vs. a single loading mechanism).
> 

Ok, ok.. It sounds like you are pretty bitter about compat_net :)

Are you suggesting we add to libsemanage the ability to manipulate the
config field? Do you dislike the idea of it being settable via some
other means at all? Should someone be able to build a kernel that does
not allow this option? Can it be switchable at runtime without a
rebuild/reload?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
