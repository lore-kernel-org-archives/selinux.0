Date: Fri, 20 Sep 2002 22:58:51 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: some patches
In-Reply-To: <200209151556.PAA17617@jazzswing.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0209202254480.2978-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 15 Sep 2002, Carsten Grohmann wrote:

> I've attached follow patches:
> inetd.diff:
>   add a type var_log_inetd_t for daemons logs

Thanks, merged.

> ldconfig.diff:
>   dontaudit ldconfig_t device_t:dir { search };
>   change { read write } for sysadm_devpts_t and sysadm_tty_device_t
>   to rw_file_perms, because I need also getattr and ioctl for SuSE

The first change is obsoleted by a patch from Russell that was merged
earlier, granting that permission.
I've merged the second change.

> pppd.diff:
>   allow pppd_t device_t:dir { search };

This change is also obsoleted by a patch from Russell that was merged
earlier, adding this permission to daemon_base_domain().

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
