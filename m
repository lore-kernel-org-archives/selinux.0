MIME-Version: 1.0
In-Reply-To: <1274988457.7399.48.camel@moss-pluto.epoch.ncsc.mil>
References: <AANLkTilavQK5qmG2B3wuWzfd2kqEK6EP54r3R7A99LI0@mail.gmail.com>
	<1274988457.7399.48.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 28 May 2010 01:28:16 +0500
Message-ID: <AANLkTinNrewuTkyzLPalh-pUMZkvgGJfozB9Hl9YgOgi@mail.gmail.com>
Subject: Re: Default security module feature of 2.6.34
From: Shaz <shazalive@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>,
        securityengineeringresearchgroup <securityengineeringresearchgroup@googlegroups.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 28, 2010 at 12:27 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2010-05-27 at 22:12 +0500, Shaz wrote:
>> Dear all,
>>
>> I saw the default security feature in linux-2.6.34 and wanted to know
>> what difference does it make to have linux DAC or selinux as the
>> default security module?
>
> It doesn't appear to change anything.  Not sure if that was the intent.
>
> The purpose of the option was to allow specification of what security
> module to enable at boot by default when multiple security modules are
> built into the kernel and no security= parameter was specified on the
> kernel command line.  Mostly useful for distributions who want to ship a
> single kernel that can support any security module and default to a
> particular one.  So for example you could compile SELinux, Smack, and
> TOMOYO into your kernel while defaulting to enabling TOMOYO at boot
> time, letting the user optionally select SELinux or Smack via the
> security= kernel parameter.
>
> I think the DAC setting was just to reflect the fact that if you don't
> enable anything else, you'll get DAC by default.  But to make that
> option actually select DAC-only at boot (i.e. not enable any of security
> modules), it would have to set the DEFAULT_SECURITY string to some
> non-empty string that doesn't match any security module name rather than
> to the empty string.

If selinux is chosen at default then what would be the effect? Would
LSM be invoked before DAC checks? If not then this kernel
configuration scheme needs to be corrected.

-- 
Shaz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
