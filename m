Date: Tue, 9 Jul 2002 14:13:43 +0100
From: Dale Amon <amon@vnl.com>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: comparison between SELinux and chroot
Message-ID: <20020709131343.GG11373@vnl.com>
References: <200207091109.LAA21173@jazzband.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200207091109.LAA21173@jazzband.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 09, 2002 at 12:00:44PM +0200, Carsten Grohmann wrote:
> I am looking for a paper with an comparison between SELinux and chroot.
> Why should I install and use SELinux, if I could use a chroot call, who is 
> possible simplier.
> 

That's sort of like comparing apples and rabbits. A chroot
is a way of setting up an environment for testing or for
a chroot jail... which can probably be broken out of, although
you can improve this greatly with the grsec patches.

Selinux is security from the base up, built into the very
operation of the system. It is MAC in the soul of the machine.

There simply *isn't* any real comparison.

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
