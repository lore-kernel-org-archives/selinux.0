Subject: Re: Default security module feature of 2.6.34
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shaz <shazalive@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <AANLkTilavQK5qmG2B3wuWzfd2kqEK6EP54r3R7A99LI0@mail.gmail.com>
References: <AANLkTilavQK5qmG2B3wuWzfd2kqEK6EP54r3R7A99LI0@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 27 May 2010 15:27:37 -0400
Message-ID: <1274988457.7399.48.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-05-27 at 22:12 +0500, Shaz wrote:
> Dear all,
> 
> I saw the default security feature in linux-2.6.34 and wanted to know
> what difference does it make to have linux DAC or selinux as the
> default security module?

It doesn't appear to change anything.  Not sure if that was the intent.

The purpose of the option was to allow specification of what security
module to enable at boot by default when multiple security modules are
built into the kernel and no security= parameter was specified on the
kernel command line.  Mostly useful for distributions who want to ship a
single kernel that can support any security module and default to a
particular one.  So for example you could compile SELinux, Smack, and
TOMOYO into your kernel while defaulting to enabling TOMOYO at boot
time, letting the user optionally select SELinux or Smack via the
security= kernel parameter.

I think the DAC setting was just to reflect the fact that if you don't
enable anything else, you'll get DAC by default.  But to make that
option actually select DAC-only at boot (i.e. not enable any of security
modules), it would have to set the DEFAULT_SECURITY string to some
non-empty string that doesn't match any security module name rather than
to the empty string.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
