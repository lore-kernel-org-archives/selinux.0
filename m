Subject: Re: nfs_t mount label
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <0794F277152EF94AA637E3AECF5CB70F2F8527@blums0042.bluelnk.net>
References: <0794F277152EF94AA637E3AECF5CB70F2F8527@blums0042.bluelnk.net>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 13:02:39 -0500
Message-Id: <1204826559.1397.312.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-03-06 at 09:55 -0800, Clarkson, Mike R (US SSA) wrote:
> nfs_t is the default label for nfs mounted file systems. Where in the
> policy is this set? (RHEL5.1)

The genfs contexts have to be defined in the base module presently -
non-base modules don't support them.

In the sources, it would be policy/modules/kernel/filesystem.te.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
