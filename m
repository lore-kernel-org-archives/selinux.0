Subject: Re: problems using setcon()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kodungallur Varma <ramgwu@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <fa8ec5d8050328195571c9d4fc@mail.gmail.com>
References: <fa8ec5d80503082008161e5619@mail.gmail.com>
	 <20050309084655.GC5236@thorium.jmh.mhn.de>
	 <fa8ec5d805031118353197f745@mail.gmail.com>
	 <1110812772.21378.79.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d8050328195571c9d4fc@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 09:37:08 -0500
Message-Id: <1112107028.4339.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 22:55 -0500, Kodungallur Varma wrote:
>        the following setconexample.c(attachment) really did help me,
> but I have one more issue. I dont have the context_str() function.

What do you mean?  It is defined in libselinux.  You do need to link
with -lselinux, obviously, e.g.
	gcc -lselinux -o setconexample setconexample.c
context_str() is defined in libselinux/src/context.c, along with the
other context functions.

>  I
> installed the 2.6.11.5 kernel and tried to apply patches mentioned in
> the NSA website.

Any kernel >= 2.6.11 should be fine for using setcon().

>  I updated to the checkpolicy-1.22, libselinux-1.22,
> policycoreutils-1.22, ibsepol-1.4. I dont know if I am supposed to
> upgrade to the above.

You only needed to have a libselinux that included setcon.  Not sure
whether the stock FC3 libselinux included it or not.  You didn't need to
update the rest.

>   I wanted to update to apply the patch-2.6.11.6.
> but I could not execute it and I dont know how to apply it.

They are relative to 2.6.11, right?

>  I wonder
> why I dont have just the context_str().

Yes, that doesn't make any sense to me either.

> also, when I make load from the directory
> /etc/selinux/strict/src/policy/, I have the following errors:
> 
> Validating file_contexts ...
> /usr/sbin/setfiles -q -c /etc/selinux/strict/policy/policy.19
> /etc/selinux/strict/contexts/files/file_contexts
> /usr/sbin/load_policy /etc/selinux/strict/policy/policy.19
> sepol_genusers: Can't load system.users:  No such file or directory
> /usr/sbin/load_policy:  Error while setting user configuration from
> /etc/selinux/strict/users//{local.users,system.users}:  No such file
> or directory
> /usr/sbin/load_policy:  security_load_policy failed
> make: *** [tmp/load] Error 3
> 
> why is the above occuring?? 

You updated checkpolicy, libsepol and policycoreutils but didn't update
your policy.  Bad idea.  Either update your policy or roll back the
others.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
