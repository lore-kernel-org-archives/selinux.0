Subject: Re: MLS and dbus-daemon related avcs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40712201311x36f4625at123b9e9712b14c56@mail.gmail.com>
References: <cadfc0e40712201311x36f4625at123b9e9712b14c56@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 20 Dec 2007 16:36:07 -0500
Message-Id: <1198186567.32563.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-12-20 at 15:11 -0600, Xavier Toth wrote:
> dbus-daemon is running at UNCLASSIFIED-SystemHigh. A number of
> processes running at UNCLASSIFIED (my seuers default level) are trying
> to use dbus and getting mls constraint avcs. I'm not that familar with
> dbus but I was thinking of changing its init script to runcon it at
> level UNCLASSIFIED or will that just mess up other things?

What are the exact avc messages in question here?

There are two instances of the bus, one system-wide and one per-session,
so you need to think about both cases.

At least the system-wide bus will have to handle connections from
clients at different levels.  If you are supporting multi-level
sessions, then the per-session bus will also have to do that.

For connecting to the bus, you have to make the bus' socket a mlstrusted
object if you want to allow any level to connect.

For preventing two levels from communicating through the bus in
violation of MLS policy, you need to write mls constraints on the dbus
class.  I don't think that has been done since the LSPP work didn't
cover the desktop.

Running the bus at unclassified will only help with the unclassified
clients; any higher level client will then be unable to connect.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
