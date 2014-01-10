Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0ADlVm7000982
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 08:47:31 -0500
Message-ID: <52CFF9EA.30705@redhat.com>
Date: Fri, 10 Jan 2014 08:47:22 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ilya Frolov <ilya.a.frolov@gmail.com>, Bryan Harris <bryanlharris@me.com>
Subject: Re: new to selinux
References: <441837E5-55B1-463C-A8E2-7F48F2C847E0@me.com>
 <CABu+-8pi=O=FWO=t-rGo-_9rSjmYagdFvJcjXyWvFKyd6m_NLQ@mail.gmail.com>
In-Reply-To: <CABu+-8pi=O=FWO=t-rGo-_9rSjmYagdFvJcjXyWvFKyd6m_NLQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/10/2014 04:33 AM, Ilya Frolov wrote:
> On Fri, Jan 10, 2014 at 1:16 PM, Bryan Harris <bryanlharris@me.com 
> <mailto:bryanlharris@me.com>> wrote:
> 
> Hello,
> 
> I'm wondering if it is possible to use selinux network & process labeling, 
> iptables, and something like /usr/bin/script to create an environment
> where we can enforce session recording for ssh sessions.
> 
> We will soon have a requirement to record our actions on customer 
> environments, but at the same time we also need to block users who have
> not activated the recording.  Is selinux policy an appropriate way to
> accomplish these requirements?  I'd like to search for the details and
> learn more, but if I'm taking the wrong approach I'd like to know that
> before starting out.
> 
> Any guidance is greatly appreciated.  Thanks in advance.
> 
> V/r, Bryan _______________________________________________ Selinux mailing
> list Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov> To unsubscribe,
> send email to Selinux-leave@tycho.nsa.gov 
> <mailto:Selinux-leave@tycho.nsa.gov>. To get help, send an email containing
> "help" to Selinux-request@tycho.nsa.gov
> <mailto:Selinux-request@tycho.nsa.gov>.
> 
> 
> Hello Bryan,
> 
> have a look at ttyrec -- you can set it as shell to do ssh session
> recording per-user and without fiddling in kernel space, and you can
> enforce it that way even without selinux for non-root users.
> 
> If you are interested in restricting root user and maybe play with the
> live system -- feel free to contact me offlist, i've done the similar
> things for my selinux playbox, and (i'll check now) i think its still
> alive.
> 
> 
> regards, ilya
> 
> 
> 
> _______________________________________________ Selinux mailing list 
> Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing "help"
> to Selinux-request@tycho.nsa.gov.
> 
You might want to look at pam_tty_audit also.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLP+eoACgkQrlYvE4MpobMrGgCbBYR6SKD+9jMAi55fWDZ7t9gE
H/oAoJ+qhVbE4go/k59SBwyJCA/ViUoR
=GPVQ
-----END PGP SIGNATURE-----
