Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2T3uxDo002248
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 22:57:14 -0500 (EST)
Received: from wproxy.gmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2T3u51g021285
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 03:56:05 GMT
Received: by wproxy.gmail.com with SMTP id 68so491546wri
        for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 19:56:00 -0800 (PST)
Message-ID: <fa8ec5d8050328195571c9d4fc@mail.gmail.com>
Date: Mon, 28 Mar 2005 22:55:57 -0500
From: Kodungallur Varma <ramgwu@gmail.com>
Reply-To: Kodungallur Varma <ramgwu@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: problems using setcon()
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1110812772.21378.79.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa8ec5d80503082008161e5619@mail.gmail.com>
	 <20050309084655.GC5236@thorium.jmh.mhn.de>
	 <fa8ec5d805031118353197f745@mail.gmail.com>
	 <1110812772.21378.79.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen and all,

       the following setconexample.c(attachment) really did help me,
but I have one more issue. I dont have the context_str() function. I
installed the 2.6.11.5 kernel and tried to apply patches mentioned in
the NSA website. I updated to the checkpolicy-1.22, libselinux-1.22,
policycoreutils-1.22, ibsepol-1.4. I dont know if I am supposed to
upgrade to the above.  I wanted to update to apply the patch-2.6.11.6.
but I could not execute it and I dont know how to apply it. I wonder
why I dont have just the context_str().

also, when I make load from the directory
/etc/selinux/strict/src/policy/, I have the following errors:

Validating file_contexts ...
/usr/sbin/setfiles -q -c /etc/selinux/strict/policy/policy.19
/etc/selinux/strict/contexts/files/file_contexts
/usr/sbin/load_policy /etc/selinux/strict/policy/policy.19
sepol_genusers: Can't load system.users:  No such file or directory
/usr/sbin/load_policy:  Error while setting user configuration from
/etc/selinux/strict/users//{local.users,system.users}:  No such file
or directory
/usr/sbin/load_policy:  security_load_policy failed
make: *** [tmp/load] Error 3

why is the above occuring?? 

any help would do a great deal to completion of my thesis. thanx in advance..

Ram


On Mon, 14 Mar 2005 10:06:12 -0500, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2005-03-11 at 21:35 -0500, Kodungallur Varma wrote:
> >        I came to know that I cant simply cast a string into a security
> > identifier as shown below. insted I found out that I have to use
> > security_compute_create().
> 
> No, you can directly construct context strings; you just have to ensure
> that they are valid contexts or the kernel will reject them.  The
> easiest approach is to use getcon() to get the current context, then use
> the context_new(), context_type_set(), context_str() functions to create
> a context string with a modified type field, and then call setcon() on
> the resulting context string.  security_compute_create() is appropriate
> when you want to get a context based on a type_transition rule in the
> policy (for an exec-based process transition or a file creation), but
> that is not what you are doing.  Sample program below should work for
> you, assuming appropriate policy and a kernel that supports dynamic
> context transitions (>= 2.6.11 for the mainline kernel).  Policy would
> need can_setcon() for the domain and allow <olddomain>
> <newdomain>:process dyntransition; (the domain_auto_trans rules are for
> exec-based transitions only).
> 
> --
> Stephen Smalley <sds@tycho.nsa.gov>
> National Security Agency
> 
> 
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
