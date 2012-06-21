Message-ID: <1340303052.4234.98.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: AOSP patches
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: seandroid@tycho.nsa.gov, AndroidSupport@tresys.com, selinux@tycho.nsa.gov
Date: Thu, 21 Jun 2012 14:24:12 -0400
In-Reply-To: <CAFftDdqJ3XJs8J-OY1Jsom4aS9WaA8QMafyPNni3yfbFWd1YjA@mail.gmail.com>
References: 
	<CAFftDdqJ3XJs8J-OY1Jsom4aS9WaA8QMafyPNni3yfbFWd1YjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-06-21 at 11:19 -0700, William Roberts wrote:
> I am reading the patches submitted in Garret:
> 
> 
> Change-Id: I166ffc267e8e0543732e7118eb0fd4b031efac3b
>    
>    What happens if this init script is executed when
> HAVE_SELINUX:=false in the device.mk
>    Will the restorecon's and other selinux commands fail and init just
> moves on?

If you look at the builtins.c code, you'll see that if built with
HAVE_SELINUX=false, the SELinux commands just always return 0
immediately.  Similarly, if built with HAVE_SELINUX=true but the kernel
doesn't have SELinux enabled or the policy was not loaded, then the
is_selinux_enabled() check at the beginning of each command will fail
and the command will return 0.  So they become no-ops on a non-SE
system.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
