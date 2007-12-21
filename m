Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBLFfhDE027838
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 10:41:43 -0500
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBLFfX9b002395
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 15:41:33 GMT
Received: by fg-out-1718.google.com with SMTP id 16so160932fgg.40
        for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 07:41:22 -0800 (PST)
Message-ID: <cadfc0e40712210741v42d7e118y2ce11c73e1bbfe33@mail.gmail.com>
Date: Fri, 21 Dec 2007 09:41:22 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: MLS and dbus-daemon related avcs
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <1198186567.32563.94.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40712201311x36f4625at123b9e9712b14c56@mail.gmail.com>
	 <1198186567.32563.94.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What's the difference between an AVC and a USER_AVC?

type=USER_AVC msg=audit(1198251251.059:579): user pid=2115 uid=81
auid=4294967295 subj=system_u:system_r:system_dbusd_t:s0-s15:c0.c1023
msg='avc:  denied  { send_msg } for msgtype=method_return dest=:1.10
spid=2551 tpid=2987 scontext=system_u:system_r:hald_t:s0-s15:c0.c1023
tcontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 tclass=dbus :
exe="/bin/dbus-daemon" (sauid=81, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1198251267.173:632): user pid=2115 uid=81
auid=4294967295 subj=system_u:system_r:system_dbusd_t:s0-s15:c0.c1023
msg='avc:  denied  { send_msg } for msgtype=method_return dest=:1.11
spid=2243 tpid=2982
scontext=system_u:system_r:initrc_t:s0-s15:c0.c1023
tcontext=system_u:system_r:xdm_t:s0-s15:c0.c1023 tclass=dbus :
exe="/bin/dbus-daemon" (sauid=81, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1198251271.497:674): user pid=2115 uid=81
auid=4294967295 subj=system_u:system_r:system_dbusd_t:s0-s15:c0.c1023
msg='avc:  denied  { send_msg } for msgtype=method_call
interface=org.freedesktop.DBus member=Hello dest=org.freedesktop.DBus
spid=3122 scontext=user_u:user_r:user_xpriv_t:s0
tcontext=system_u:system_r:system_dbusd_t:s0-s15:c0.c1023 tclass=dbus
: exe="/bin/dbus-daemon" (sauid=81, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1198251271.520:675): user pid=2115 uid=81
auid=4294967295 subj=system_u:system_r:system_dbusd_t:s0-s15:c0.c1023
msg='avc:  denied  { send_msg } for msgtype=method_return dest=:1.13
spid=2551 tpid=3122 scontext=system_u:system_r:hald_t:s0-s15:c0.c1023
tcontext=user_u:user_r:user_xpriv_t:s0 tclass=dbus :
exe="/bin/dbus-daemon" (sauid=81, hostname=?, addr=?, terminal=?)'


On Dec 20, 2007 3:36 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Thu, 2007-12-20 at 15:11 -0600, Xavier Toth wrote:
> > dbus-daemon is running at UNCLASSIFIED-SystemHigh. A number of
> > processes running at UNCLASSIFIED (my seuers default level) are trying
> > to use dbus and getting mls constraint avcs. I'm not that familar with
> > dbus but I was thinking of changing its init script to runcon it at
> > level UNCLASSIFIED or will that just mess up other things?
>
> What are the exact avc messages in question here?
>
> There are two instances of the bus, one system-wide and one per-session,
> so you need to think about both cases.
>
> At least the system-wide bus will have to handle connections from
> clients at different levels.  If you are supporting multi-level
> sessions, then the per-session bus will also have to do that.
>
> For connecting to the bus, you have to make the bus' socket a mlstrusted
> object if you want to allow any level to connect.
>
> For preventing two levels from communicating through the bus in
> violation of MLS policy, you need to write mls constraints on the dbus
> class.  I don't think that has been done since the LSPP work didn't
> cover the desktop.
>
> Running the bus at unclassified will only help with the unclassified
> clients; any higher level client will then be unable to connect.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
