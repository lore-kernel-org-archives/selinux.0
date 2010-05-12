MIME-Version: 1.0
In-Reply-To: <1273668133.3738.14.camel@moss-pluto.epoch.ncsc.mil>
References: <AANLkTin7SkXe1jInacpozS64IR138O-qyOaF-DRG3k4L@mail.gmail.com>
	 <1273668133.3738.14.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 12 May 2010 18:15:55 +0500
Message-ID: <AANLkTinAdFMzG9194kLunvUKUI-IoOnP1P_lW6sUoBAG@mail.gmail.com>
Subject: Re: Dbus rules in LPM for a Dbus based service like Network Manager
From: Shaz <shazalive@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>, refpolicy@oss1.tresys.com,
        Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/alternative; boundary=000e0cd1a89a2ad3ae048665711c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd1a89a2ad3ae048665711c
Content-Type: text/plain; charset=ISO-8859-1

> It doesn't look like refpolicy presently defines any associate elements
> in the default dbus_contexts configuration files.  So that would mean
> that acquire_svc checks are always against the bus daemon context, as
> per man dbus-daemon.  The intent was to allow control over what
> processes can bind to specific names in dbus, just as we control what
> processes can bind to specific TCP/UDP ports in the kernel.  I'm not
> sure why people haven't configured it for well-known dbus services and
> used that to prevent arbitrary processes from binding those service
> names.
>
> The send_msg checks on the other hand are between the sender and
> recipient contexts and don't rely on dbus_contexts configuration.
>

Thank you Stephen for a nice starting pointer. Before asking any further
questions regarding this I will wait for some more replies from others to
make the thread useful.


-- 
Shaz

--000e0cd1a89a2ad3ae048665711c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;"><div><div class=3D"h5">
</div></div>It doesn&#39;t look like refpolicy presently defines any associ=
ate elements<br>
in the default dbus_contexts configuration files. =A0So that would mean<br>
that acquire_svc checks are always against the bus daemon context, as<br>
per man dbus-daemon. =A0The intent was to allow control over what<br>
processes can bind to specific names in dbus, just as we control what<br>
processes can bind to specific TCP/UDP ports in the kernel. =A0I&#39;m not<=
br>
sure why people haven&#39;t configured it for well-known dbus services and<=
br>
used that to prevent arbitrary processes from binding those service<br>
names.<br>
<br>
The send_msg checks on the other hand are between the sender and<br>
recipient contexts and don&#39;t rely on dbus_contexts configuration.<br>
</blockquote></div><br>Thank you Stephen for a nice starting pointer. Befor=
e asking any further questions regarding this I will wait for some more rep=
lies from others to make the thread useful.<br><br clear=3D"all"><br>-- <br=
>
Shaz<br><br>

--000e0cd1a89a2ad3ae048665711c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
