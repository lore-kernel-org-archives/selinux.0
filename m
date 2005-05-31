Subject: Re: file_type_auto_trans is not sufficient
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1117545526.28924.57.camel@moss-spartans.epoch.ncsc.mil>
References: <1117249760.19257.18.camel@localhost.localdomain>
	 <1117545526.28924.57.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 31 May 2005 09:35:55 -0400
Message-Id: <1117546555.13058.14.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I'd advise against creating a composite interface like this, as it runs
> into the same problems that we had with the original SELinux API (which
> had extended forms of mkdir/creat/mknod/exec), i.e. use of glibc
> functions that internally use these functions, as you note in a later
> message.

I agree, that was a bad idea.

>   Instead, keep the setting and resetting of the fscreate
> context as a separate operation, and then let the application continue
> to use ordinary mkdir/create/mknod or glibc functions for the actual
> creation.

Yes, but there's problems with that - in particular:

- is this thread-safe - see my later message

- is this a good idea - it pushes dynamic type changes into various
programs, while otherwise it's all in the policy, and easier to analyze 

- makes virtually everything depend on libselinux

- I'm replicating the same code pattern in lots of places...

- it puts linux-specific code into otherwise portable apps. I've
surrounded it all by WITH_SELINUX, but it's still rather ugly - 
don't think upstream will like it.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
