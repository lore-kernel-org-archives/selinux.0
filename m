MIME-Version: 1.0
In-Reply-To: <1347373683.17403.36.camel@moss-pluto.epoch.ncsc.mil>
References: <CALrft9-GWLKNZU=4yDBNx6hp=HJbh9qCUEntvYypz3F63Sd==w@mail.gmail.com>
	<1347288243.9456.53.camel@moss-pluto.epoch.ncsc.mil>
	<CALrft98Np4v5Lyhzy+_NEJkf9aqkC60PzMT4fFoYcPgohzyJqQ@mail.gmail.com>
	<1347373683.17403.36.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 12 Sep 2012 14:18:01 +0300
Message-ID: <CALrft98LUVZgOULx5a47UWDZyjegGNbOZqpTyUtwLZcnDP_K2A@mail.gmail.com>
Subject: Re: Security hooks for rpm
From: Elena Reshetova <elena.reshetova@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, Steve Lawrence <slawrence@tresys.com>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 11, 2012 at 5:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> I would tend to view the collection hooks as just part of the overall
> hook interface for plugins.  You are defining per-transaction,
> per-package, and per-file hooks, and per-collection hooks are just
> another case to consider (unless I misunderstand).

Yes, I think they are certainly making sense as hooks, but the problem is
that the plug-in interface currently defined as "collection plug-in".
It would be
strange to add some per-file hooks to smth that is defined as "collection
plug-in". Maybe we can rename the whole construction and reorganize it in
a more generic way? I will ask rpm maintainer about this.

> If not, I don't see why it cannot be made to support that functionality.
> It isn't truly unique to security; other kinds of functional plugins may
> need/want to be able to abort the installation.

Agree, I guess if we go the path of defining the general rpm plugin interface,
then this can be included there too.

Best Regards,
Elena.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
