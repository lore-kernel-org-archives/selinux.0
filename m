Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i816bnrT018624
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 02:37:49 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i816awY2013336
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 06:36:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom London <selinux@comcast.net>
Subject: Re: Progress! .532 boots! -- but dbus/hotplug/udev problems remain?
Date: Wed, 1 Sep 2004 16:37:41 +1000
Cc: fedora-selinux-list@redhat.com, SE-Linux <selinux@tycho.nsa.gov>
References: <4130CF1B.3090909@comcast.net> <200408291737.17497.russell@coker.com.au> <41322F5E.90409@comcast.net>
In-Reply-To: <41322F5E.90409@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409011637.41952.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Aug 2004 05:32, Tom London <selinux@comcast.net> wrote:
> --- /root/src.package/policy/domains/program/dbusd.te   2004-08-29
> 11:38:27.000000000 -0700
> +++ dbusd.te    2004-08-29 12:19:25.000000000 -0700
> @@ -32,3 +32,7 @@
>
>  # SE-DBus specific permissions
>  allow { dbus_client_domain userdomain } { dbusd_t self }:dbus { send_msg
> }; +
> +allow user_t etc_dbusd_t:dir { search };
> +allow user_t etc_dbusd_t:file { getattr read };
> +allow user_t user_t:netlink_selinux_socket { bind create };

One thing to remember is that any time you see user_t in policy it's a local 
customisation or a bug.

In this case it seems to me that one correct way of writing policy for this is 
the following:
allow { dbus_client_domain userdomain } etc_dbusd_t:dir { search };
allow { dbus_client_domain userdomain } etc_dbusd_t:file { getattr read };
allow { dbus_client_domain userdomain } user_t:netlink_selinux_socket { bind 
create };

But then we are granting almost every domain that has any significance in the 
security of the system read access.  So why not just label the files as etc_t 
and remove the etc_dbusd_t type entirely?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
