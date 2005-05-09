Subject: Re: [Fwd: Latest Diff]
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: russell@coker.com.au, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <427FAB86.4050905@redhat.com>
References: <427A757F.9040009@redhat.com>
	 <1115344683.15149.11.camel@localhost.localdomain>
	 <1115393991.17301.18.camel@localhost.localdomain>
	 <200505072351.04728.russell@coker.com.au>
	 <1115485468.21610.8.camel@localhost.localdomain>
	 <1115495425.20062.2.camel@localhost.localdomain>
	 <427F76BE.60506@redhat.com>
	 <1115662376.10218.16.camel@localhost.localdomain>
	 <427FA923.9010906@redhat.com>
	 <1115663075.10218.25.camel@localhost.localdomain>
	 <427FAB86.4050905@redhat.com>
Content-Type: text/plain
Date: Mon, 09 May 2005 14:37:30 -0400
Message-Id: <1115663850.10218.34.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-05-09 at 14:27 -0400, Daniel J Walsh wrote:
> Ivan Gyurdiev wrote:
> 
> >>Doesn't you patch mean that every app that links with orbit needs to 
> >>able to read context files
> >>and able to setfscreatecon?
> >>

...

> >
> >Here's the full list of selinux privileges needed:
> >
> >
> ># Set its type - libselinux integration
> >can_setfscreate($1_t)
> >can_getsecurity($1_t)
> >r_dir_file($1_t, selinux_config_t)
> >r_dir_file($1_t, file_context_t)
> >allow $1_t default_context_t:dir search;
> >
> >  
> >
> I think I can create a file with context of passwd_t via those privs?

Is this true? Doesn't selinux audit calls to create/write/getattr/read..
for passwd_t.. or does setfscreate(passwd_t) allow all of this.

If that's true, then it's definitely not what I intended to do.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
