Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2U3hXDo011667
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 22:43:33 -0500 (EST)
Received: from wproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2U3dha7023988
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 03:39:46 GMT
Received: by wproxy.gmail.com with SMTP id 68so16539wri
        for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 19:42:18 -0800 (PST)
Message-ID: <fa8ec5d8050329194145add881@mail.gmail.com>
Date: Tue, 29 Mar 2005 22:41:44 -0500
From: Kodungallur Varma <ramgwu@gmail.com>
Reply-To: Kodungallur Varma <ramgwu@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: problems using setcon()
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1112107028.4339.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa8ec5d80503082008161e5619@mail.gmail.com>
	 <20050309084655.GC5236@thorium.jmh.mhn.de>
	 <fa8ec5d805031118353197f745@mail.gmail.com>
	 <1110812772.21378.79.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d8050328195571c9d4fc@mail.gmail.com>
	 <1112107028.4339.34.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

thanx a lot..the program worked. however I need to change the policy
file(.te) often and so I need to make load it. I am unable to do that
at the moment due to the problem that I updated the following without
updating my policy:

checkpolicy-1.22
libsepol-1.4
policycoreutils-1.22

how do I uninstall them?? also I tried the alternative to update my
policy by doing:
"yum install selinux-policy-strict-sources" and "yum install
selinux-policy-targeted-sources". the targeted version was updated,
but strict had "nothing to do". seems like it is up to date. I couldnt
"make load" after I updated as the same problem(same error) persisted.

could someone point out how to uninstall the above three packages. 

thanx..
Ram


On Tue, 29 Mar 2005 09:37:08 -0500, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2005-03-28 at 22:55 -0500, Kodungallur Varma wrote:
> >        the following setconexample.c(attachment) really did help me,
> > but I have one more issue. I dont have the context_str() function.
> 
> What do you mean?  It is defined in libselinux.  You do need to link
> with -lselinux, obviously, e.g.
>         gcc -lselinux -o setconexample setconexample.c
> context_str() is defined in libselinux/src/context.c, along with the
> other context functions.
> 
> >  I
> > installed the 2.6.11.5 kernel and tried to apply patches mentioned in
> > the NSA website.
> 
> Any kernel >= 2.6.11 should be fine for using setcon().
> 
> >  I updated to the checkpolicy-1.22, libselinux-1.22,
> > policycoreutils-1.22, ibsepol-1.4. I dont know if I am supposed to
> > upgrade to the above.
> 
> You only needed to have a libselinux that included setcon.  Not sure
> whether the stock FC3 libselinux included it or not.  You didn't need to
> update the rest.
> 
> >   I wanted to update to apply the patch-2.6.11.6.
> > but I could not execute it and I dont know how to apply it.
> 
> They are relative to 2.6.11, right?
> 
> >  I wonder
> > why I dont have just the context_str().
> 
> Yes, that doesn't make any sense to me either.
> 
> > also, when I make load from the directory
> > /etc/selinux/strict/src/policy/, I have the following errors:
> >
> > Validating file_contexts ...
> > /usr/sbin/setfiles -q -c /etc/selinux/strict/policy/policy.19
> > /etc/selinux/strict/contexts/files/file_contexts
> > /usr/sbin/load_policy /etc/selinux/strict/policy/policy.19
> > sepol_genusers: Can't load system.users:  No such file or directory
> > /usr/sbin/load_policy:  Error while setting user configuration from
> > /etc/selinux/strict/users//{local.users,system.users}:  No such file
> > or directory
> > /usr/sbin/load_policy:  security_load_policy failed
> > make: *** [tmp/load] Error 3
> >
> > why is the above occuring??
> 
> You updated checkpolicy, libsepol and policycoreutils but didn't update
> your policy.  Bad idea.  Either update your policy or roll back the
> others.
> 
> --
> Stephen Smalley <sds@tycho.nsa.gov>
> National Security Agency
> 
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
