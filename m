Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5TDXjWA009574
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2011 09:33:48 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p5TDXgMY009818
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2011 13:33:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Sam Gandhi <samgandhi9@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: login process unable to execute /bin/sh
Date: Wed, 29 Jun 2011 23:33:39 +1000
References: <BANLkTiknN0tGP7xJmUO7Enxmqw2TjtgVKg@mail.gmail.com> <201106282329.06313.russell@coker.com.au> <BANLkTimq6daGvg5kCbDy32y7RQ0fb4hLPA@mail.gmail.com>
In-Reply-To: <BANLkTimq6daGvg5kCbDy32y7RQ0fb4hLPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106292333.39323.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 29 Jun 2011, Sam Gandhi <samgandhi9@gmail.com> wrote:
> In my situation I am using busybox that is compiled with option
> CONFIG_INSTALL_APPLET_SCRIPT_WRAPPERS=y.
> hence /bin/sh  is not a link, but really a script that contains  following
> line
> 
> #!/bin/busybox

That is a rather convoluted way of launching all the shell scripts that have 
#!/bin/sh at the start, but it probably doesn't make a noticable impact on 
performance with modern hardware.

> We decided to use option of CONFIG_INSTALL_APPLET_SCRIPT_WRAPPERS as
> it will allow us to label busybox executables and may not require
> approach you have suggested in your paper

The advantage of using a small C program as the wrapper or of having multiple 
busybox applications for different sets of utilities is to provide a reliable 
atomic domain transition.

If one of those shell scripts causes a transition into a more privileged 
domain (as could be the case for ping or traceroute if you use them) then a 
hostile party could create a symlink to the shell script in question and try a 
race condition of replacing the link while in the process of executing it.  If 
they time it right then the old version of the symlink (pointing to a system 
script) would be used for the domain transition and the new version would be 
executed.

Of course if you define the threat model for your embedded/mobile device to 
not include having user_t take over ping_t via a race condition then it could 
be OK.  It would be quite valid in some situations to define SE Linux as only 
protecting local resources and not have it restrict network access.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
