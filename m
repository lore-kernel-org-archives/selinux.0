Subject: Re: Policy loading problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dennis Wronka <linuxweb@gmx.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200905202146.54559.linuxweb@gmx.net>
References: <1242641994.470.5.camel@notebook2.grift.internal>
	 <20090520072118.226550@gmx.net>
	 <1242820009.20082.374.camel@localhost.localdomain>
	 <200905202146.54559.linuxweb@gmx.net>
Content-Type: text/plain
Date: Wed, 20 May 2009 09:49:52 -0400
Message-Id: <1242827392.20082.392.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-20 at 21:46 +0800, Dennis Wronka wrote:
> I have actually tried both.
> The way it's usually done is through a patched init, which used to work some 
> time ago (I don't remember which version of the kernel, the policy and the 
> SELinux-tools/-libraries I used then, as everything always is being updated 
> and I worked on a lot of other stuff in between).
> I also tried the approach Fedora uses, pretty much taking apart their initrd 
> and reimplementing the load_policy-command from nash into a seperate program 
> as I had trouble compiling nash). I got it partially working later, but not in 
> the way I used to do it and not the way it's supposed to be.
> 
> So, as said, the it's supposed to be is a patched init, although I could live 
> with doing it in my initramfs (I use that instead of an initrd, but it's 
> basically the same anyway).
> 
> Still I find it quite confusing that the policy gets loaded when I set SELinux 
> to enforcing, but not when I set it to permissive.

You didn't post your initial policy loading logic like I asked.  I agree
that there is no reason why it shouldn't get loaded when permissive, and
I don't see that behavior in Fedora, so I have to assume there is a bug
in the way you've integrated initial policy load in your distribution.

So, once again:  if you want help, show us how you are performing your
initial policy load (the actual code).

Also, if you boot permissive and then manually run load_policy, does
that work?  If so, then that even more strongly indicates a bug in how
you've integrated initial policy load in your distro.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
