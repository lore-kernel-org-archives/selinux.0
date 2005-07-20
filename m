Subject: Re: Latest diffs
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <42DE679D.2080909@redhat.com>
References: <42DD6CBE.7090506@redhat.com>
	 <1121811396.11941.19.camel@localhost.localdomain>
	 <42DE679D.2080909@redhat.com>
Content-Type: text/plain
Date: Wed, 20 Jul 2005 14:41:10 -0400
Message-Id: <1121884870.29587.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> >>+allow $1_cdrecord_t $1_devpts_t:chr_file rw_file_perms;
> >>+allow $1_cdrecord_t $1_home_t:dir search;
> >>+allow $1_cdrecord_t $1_home_dir_t:dir r_dir_perms;
> >>+allow $1_cdrecord_t $1_home_t:file r_file_perms;
> >> ')
> >>    
> >>
> >
> >Same here... why is cdrecord reading the user's private documents.
> >
> >  
> >
> Usually if you are creating a cd, it will be from your home dir.

Then cdrecord should be using the read_content macros.

> >>+allow $1_thunderbird_t fs_t:filesystem getattr;
> >>    
> >>
> >
> >Why does it need to do that?
> >  
> >
> Don't know.  Probably checking filesystems in mtab

Is this statfs() related? 
We need to implement a macro for statfs, since the same code can be
found in: gnome_vfs, samba, daemon_core_domain (or daemon_* something),
and now you're saying thunderbird does something similar. In most of
those cases the code is incomplete, and doesn't quite work. 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
