Date: Thu, 27 Sep 2001 09:35:49 -0400 (EDT)
From: Chris Vance <cvance@tislabs.com>
To: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
cc: SELinuxML <SELinux@tycho.nsa.gov>, Chris Vance <cvance@tislabs.com>
Subject: Re: I can ' t use named on LSM-based Prototype. Why?
In-Reply-To: <002401c14595$5d1a8fb0$68026c85@ilios104>
Message-ID: <Pine.LNX.4.33.0109270904260.12723-100000@zorg.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


With RedhHat 7.1, the default configuration for named uses the '-u' flag
to tell named to run as the specified user.  For Linux, named uses the
kernel's capability mechanism to drop all root privileges except the
ability to bind() to a privileged port.

As a result, the '-u' option requires Linux kernel capability checks.
While the prior SELinux prototype retained these checks, the current
LSM-based kernel removes the capabilities checks from the kernel and
places them in a separately configurable LSM module.

We are currently investigating ways to compose the SELinux module with the
capabilities module or reproduce the capabilities checks in SELinux, so
that we can retain all of the original Linux kernel checks. However, the
current LSM-based SELinux distribution does not perform kernel capability
checks.

In the mean time, if you start named without that option, it should run
normally.  Since the default SELinux policy does not contain support for
named, I would recommend adding a domain and appropriate permissions.

Has anyone on this list already created a policy for named?

chris.

On Tue, 25 Sep 2001, Yuichi Nakamura wrote:

> I found that named(bind 9.1.0) didn't work on SELinux(LSM-based Prototype)
> even if the kernel was flask development mode.
>
> Named doesn't response to nslookup.
>
> I can use other services(httpd,sendmail,ftpd).
> And,Named works on usual Linux(2.4.3,2.4.9) and on original SELinux
> prototype.
>
> I installed SELinux (LSM-based Prototype) as development mode in RH7.1.
> And the kernel configration option is following,
> CONFIG_NETFILTER="Y"
> CONFIG_CAPABILITIES ="N"
> CONFIG_SELINUX="Y"
> CONFIG_LSM_IP="Y".
>
> The  startup log of named is following.
> --------------------------------------------------------
> Sep 25 15:11:54 myhost named[797]: starting BIND 9.1.0 -u named
> Sep 25 15:11:54 myhost named[797]: using 1 CPU
> Sep 25 15:11:54 myhost named: named startup succeeded
> Sep 25 15:11:54 myhost named[801]: loading configuration from
> '/etc/named.conf'
> Sep 25 15:11:54 myhost named[801]: the default for the 'auth-nxdomain'
> option is now 'no'
> Sep 25 15:11:54 myhost named[801]: no IPv6 interfaces found
> Sep 25 15:11:54 myhost named[801]: listening on IPv4 interface lo,
> 127.0.0.1#53
>
> Sep 25 15:11:54 myhost named[801]: could not listen on UDP socket:
> permission denied
>
> Sep 25 15:11:54 myhost named[801]: creating IPv4 interface lo failed;
> interface ignored
> Sep 25 15:11:54 myhost named[801]: listening on IPv4 interface eth0,
> 133.xxx.x.75#53
>
> Sep 25 15:11:54 myhost named[801]: could not listen on UDP socket:
> permission denied
>
> Sep 25 15:11:54 myhost named[801]: creating IPv4 interface eth0 failed;
> interface ignored
> Sep 25 15:11:54 myhost named[801]: not listening on any interfaces
> -------------------------------------------------------------
>
> Why named doesn't work on LSM based prototype?
>
> Did I miss kernel configuration or else?
>
> Please tell me.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
