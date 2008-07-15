Subject: Re: python gui gconf policy problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <cadfc0e40807150929nf059a31q9b9435b08b8ac7f6@mail.gmail.com>
References: <cadfc0e40807150929nf059a31q9b9435b08b8ac7f6@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 12:51:52 -0400
Message-Id: <1216140712.17602.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-07-15 at 11:29 -0500, Xavier Toth wrote:
> I'm writing policy for a python gui and having a problem getting preferences:
> 
> gobject.GError: Failed to contact configuration server; some possible
> causes are that you need to enable TCP/IP networking for ORBit, or you
> have a stale NFS locks due to a system crash. See
> http://www.gnome.org/project/gconf/ for information. (Details - 1:
> Could not send message to gconf daemon: An SELinux policy prevents
> this sender from sending this message to this recipient (rejected
> message had interface "org.gnome.GConf member "GetIOR" error name
> "(unset)" destination "org.gnome.GConf"))
> 
> The error message states that policy is preventing this operation but
> there isn't a corresponding AVC in the audit log. I'm using the
> gnome_stream_connect_gconf_template but that doesn't help and I'm not
> sure it is the right thing to do anyway.

Sounds like a dbus denial, which would show up as a USER_AVC.
Or might be dontaudit'd - try semodule -DB.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
