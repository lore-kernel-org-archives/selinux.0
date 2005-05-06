Subject: Re: [Fwd: Latest Diff]
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <200505061134.27455.russell@coker.com.au>
References: <427A757F.9040009@redhat.com>
	 <1115329465.13097.23.camel@localhost.localdomain>
	 <200505061134.27455.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 05 May 2005 21:58:03 -0400
Message-Id: <1115344683.15149.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > Is it better to create orbit-$USER in a startup script, or
> > to include selinux support in libORBit2 in order to
> > properly set the context of /tmp/orbit-$USER to ROLE_orbit_tmp_t
> > when it's created?
> 
> What does orbit do exactly?  What needs to access it?

ORBit is an implementation of CORBA - it has to do with 
inter-process communication. All GNOME programs use
it to talk to each other. For example, mozilla (with gnome support)
uses it to talk to GConf and the gnome vfs daemon 
(and other things that I haven't figured out yet, which 
need to be constrained). 

Apps create sockets in /tmp/orbit-$USER, and read/write to other apps'
sockets to talk to them. 

The current orbit rules in mozilla/gift are a mess, because they allow
interaction w/ ROLE_tmp_t, which seems to me like a bad idea.

I have a better suggestion (I think), included as part of my patch here:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=155800

It's the patch you were looking at earlier, but I've added a lot more
stuff, and fixed bugs. It can't be merged at this point, but parts of
it probably can..

...but orbit-$USER needs to be labeled properly, and it can be created
by anything that interfaces w/ libORBit-2, I think...which means
that either it has to be created by a startup script, or
the library should be modified to use matchpathcon() 
when it creates the folder. I don't know which. 
I also thought perhaps there should be a skeleton for /tmp
(https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=156452)
but I'm now starting to think that's may be a bad idea, and I should
close the bug.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
