Subject: Re: filesystem mount AVC denial
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <7b4dai$ejec6@dmzms99901.na.baesystems.com>
References: <7b4dai$ejec6@dmzms99901.na.baesystems.com>
Content-Type: text/plain
Date: Mon, 02 Feb 2009 09:04:13 -0500
Message-Id: <1233583453.3826.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-01-30 at 15:45 -0800, Clarkson, Mike R (US SSA) wrote:
> I got the following AVC denial in the audit logs and I'm wondering what
> would cause this:
> 
> type=AVC msg=audit(1232734163.528:997720):avc: denied { mount } for
> pid=28016 comm="find" name="/" dev=0:1c ino=0
> scontext=root:staff_r:libstart_t:s0-s4:c0.c255
> tcontext=system_u:object_r:nfs_t:s0 tclass=filesystem
> 
> The program running in the libstart_t domain is using the "find" cmd,
> and find is requiring the "mount" permission. Could this be caused by
> "find" traversing into an automounted (NFS) directory? But in that case
> I would expect the automount daemon, which is running in the automount_t
> domain, to do the mounting.

Could be a nfs submount, triggered upon traversing the boundary?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
