Subject: Re: policycoreutils patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB0AB8.3070803@redhat.com>
References: <45DB0AB8.3070803@redhat.com>
Content-Type: text/plain
Date: Wed, 21 Feb 2007 12:22:23 -0500
Message-Id: <1172078543.14363.284.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 09:50 -0500, Daniel J Walsh wrote:
> newrole hangs on a attached terminal device.  Nonblocking allows it to 
> proceed.

I dropped this, per the bugzilla report (fixable by passing -L to agetty
in inittab).

> chcat fixes:
>     * Broken stderr handling fix
>     * if serange ends in a ":" chop it off.
>     * Switch chcat to exec semanage rather than use builtin so that 
> proper transitions happen, otherwise I would have to run chcat under an 
> semanage context.
> 
> Man pages fixes to be more standard.
> 
> 
> More translations.

I merged the rest, except for the call to mcstrans reload from
seobject.py.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
