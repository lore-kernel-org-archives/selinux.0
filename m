Date: Mon, 3 Dec 2001 15:16:21 +0000
From: Dale Amon <amon@vnl.com>
To: Grant Bayley <gbayley@ausmac.net>
Cc: 0x@bk.ru, SELinux@tycho.nsa.gov
Subject: Re: have you seen spfx2.c?
Message-ID: <20011203151621.A7873@vnl.com>
References: <E16ALyE-000BX7-00@f6.mail.ru> <Pine.BSO.4.33.0112021406500.3173-100000@ausmac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.BSO.4.33.0112021406500.3173-100000@ausmac.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Dec 02, 2001 at 02:14:35PM +1100, Grant Bayley wrote:
> 
> What I don't understand with Linux users is the endless desire to
> prevent broken things by patching around them in the kernel.
> 
> Why not concentrate on cleaning up the userland apps in Linux in such a
> way that they're not overflowable in the first place?
> 
> No broken [suid | sgid | priviliged uid daemon ] userland apps means you
> have a substantially better chance of keeping a system secure without all
> the sleight of hand that lkms typically pull to prevent something bad from
> happening.
> 
> Think about this logic for a second, then check out:
> 
> 	http://www.openwall.com/Owl/
> 

The logic fails in real life. There is one kernel,
written by experts. There are tens if not hundreds of 
thousands of apps, written by novices, experts, people
who listen, people who don't listen, supported, 
unsupported...

An environment that defends against userland lameness
is the only solution.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
