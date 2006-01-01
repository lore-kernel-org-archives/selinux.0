Message-ID: <43B7FB1D.3010807@cornell.edu>
Date: Sun, 01 Jan 2006 10:54:05 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Erich Schubert <erich@debian.org>
CC: SELinux@tycho.nsa.gov
Subject: Re: Documentation, anyone?
References: <1136133436.27906.56.camel@wintermute.xmldesign.de>
In-Reply-To: <1136133436.27906.56.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Hi,
> Recent changes broke lots of stuff on my system.
> For example, genhomedircon no longer reads my local.users file...
> It seems that this is somehow related to semanage changes...
>   
More detail please..
> Which doesn't work for me, and I can't find *any* documentation on it.
> So the current SELinux shape is IMHO really bad... no current
> documentation, and even those who have working installations (like me)
> have no idea how to get the latest stuff working... :-(
>   
I didn't realize that there's been a stable release - if so, I will 
agree with you.
If not, please consider that this is software in development - code 
takes priority to documentation.
Also, I do see manpages for the utilities semanage, and semodule, which 
would be most relevant to you.
> I have a user role "netuser" who is allowed to use the network to a
> larger extend (e.g. bind to port_t). I'd like to make that the default
> role for certain unix accounts...
>
> $ semanage user --add -s netuser_u -R netuser_r erich
> ['netuser_r']
> libsemanage.assert_init: A direct or server connection is needed to use
> this function - please call the corresponding connect() method
> libsemanage.enter_ro: could not enter read-only section
> /usr/sbin/semanage: Seuser lerich already defined
>   
The semanage tool in particular was only created recently. I would 
qualify it as alpha at this point, since I can find tons of bugs without 
trying very hard. The situation above would occur if you ran it as 
non-root user. The semanage connection failed, but the python tool 
doesn't check the rc value for most of the libsemanage calls it makes, 
so it continues on, instead of reporting the error, and tries to call 
functions that require a connection. It should likely make sure you have 
proper access rights on startup.
> I couldn't find an example for /etc/selinux/seusers, I guessed it looks
> like
> "lerich:netuser_u" but that didn't work either...
>   
You should not edit /etc/selinux/seusers directly. On a "managed" 
system, which I assume yours is, the master copies of all such files are 
located in a sandbox at /etc/selinux/<type>/modules/active. If you want 
to edit them manually (which is probably recommended at this point, you 
need sufficient access, then you can edit, and run "semodule -B", which 
rebuilds and reinstalls the sandbox).

An example does not exist, because you're really *not* supposed to be 
editing the files manually - hopefully the semanage utility will get 
into shape soon, so you won't have to edit config files by hand. The 
format is:
linux user:selinux_user[:mls], where the mls part is optional. The 
selinux_user must be listed in your users.local file at 
/etc/selinux/<type>/modules/active/users.local. The format for that is 
backwards compatible with the previous one, except that MLS contexts 
must be on one line with no spaces. You do not have to put user_u, root, 
system_u and the like in that file, since they are build into policy, 
depending on which policy type you use. You can use semanage user -l to 
see the combination of local and in-policy users.

> I've also investigated "genhomedircon", and what strikes me as really
> bad code is that it keeps on calling an external "grep" on just about
> everything.
> Loading a file and applying a regexp is really easy in Python, you
> know...
>   
I can't comment on that. The genhomedircon utility (which is really an 
internal tool, not to be called manually anymore, that will hopefully go 
away in the future), should mostly work. It has one major bug - it can't 
expand ROLE macros for non user_r users at this point - this is relevant 
for users of mls and strict policy, not targeted. I am hoping to fix 
that by the time FC 5 is released.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
