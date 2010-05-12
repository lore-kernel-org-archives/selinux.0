Subject: Re: Dbus rules in LPM for a Dbus based service like Network Manager
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shaz <shazalive@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>, refpolicy@oss1.tresys.com,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <AANLkTin7SkXe1jInacpozS64IR138O-qyOaF-DRG3k4L@mail.gmail.com>
References: <AANLkTin7SkXe1jInacpozS64IR138O-qyOaF-DRG3k4L@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 May 2010 08:42:13 -0400
Message-ID: <1273668133.3738.14.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-05-12 at 11:29 +0500, Shaz wrote:
> Dear list,
> 
> I was reading [1] and found it very interesting but I can't figure out
> how the dbus rules will be added to the network manager LPM. Are there
> any examples available in the reference policy that can be followed to
> understand this clearly? If not in reference policy then where can I
> find a good and clear example?
> 
> [1]
> http://www.redhat.com/magazine/003jan05/features/dbus/#more-security

It doesn't look like refpolicy presently defines any associate elements
in the default dbus_contexts configuration files.  So that would mean
that acquire_svc checks are always against the bus daemon context, as
per man dbus-daemon.  The intent was to allow control over what
processes can bind to specific names in dbus, just as we control what
processes can bind to specific TCP/UDP ports in the kernel.  I'm not
sure why people haven't configured it for well-known dbus services and
used that to prevent arbitrary processes from binding those service
names.

The send_msg checks on the other hand are between the sender and
recipient contexts and don't rely on dbus_contexts configuration.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
