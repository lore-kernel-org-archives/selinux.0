Subject: Re: (new?) problems installing with checkinstall
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andreas Bernauer <andreas.bernauer@gmx.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20051113184615.GB3618@tierbergli.Informatik.Uni-Tuebingen.De>
References: <20051113184615.GB3618@tierbergli.Informatik.Uni-Tuebingen.De>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 09:50:09 -0500
Message-Id: <1131979809.5415.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-11-13 at 19:46 +0100, Andreas Bernauer wrote:
> Hi,
> 
> First, I must admit I am new to SELinux.  I hope, this is the right
> place to ask my question.  I could not find an answer in the mailing
> list archives, the web or the UnOfficial FAQ.  If this is the wrong
> place, please be so kind and point me to the right place.
> 
> I'm running Fedora Core 4 (2.6.13-1.1526_FC4smp) with SELinux in
> permissive mode (and coreutils-5.2.1-48.1,
> policycoreutils-1.27.2-1.2).  I want to install software using
> checkinstall, which monitors the installation process and builds an
> RPM out of it.  [ http://asic-linux.com.mx/~izto/checkinstall/ ]
> 
> When I do a `make install`, everything runs fine.  However, when I use
> checkinstall (which creates a temporary script which in turn calls
> `make install`), I get error messages like the following:
> 
> ----------------------
> /usr/bin/install: warning: failed to change context of /usr/doc/mutt/samples/gpg
> .rc to system_u:object_r:usr_t: No such file or directory
> /usr/bin/install: setting permissions for `/usr/doc/mutt/samples/pgp2.rc': No su
> ch file or directory
> [...]
>   /usr/bin/install -c 'pgpewrap' '/usr/bin/pgpewrap'
> /usr/bin/install: setting permissions for `/usr/bin/pgpewrap': No such file or d
> irectory
> /usr/bin/install: warning: failed to change context of /usr/bin/pgpewrap to syst
> em_u:object_r:bin_t: No such file or directory

Can you run checkinstall under strace or autrace and identify the
specific failing syscall and its arguments?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
