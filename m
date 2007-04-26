Subject: Re: policycoreutils patch
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4630C59F.1070106@redhat.com>
References: <4630C59F.1070106@redhat.com>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 15:18:54 -0400
Message-Id: <1177615134.3405.43.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-26 at 11:30 -0400, Daniel J Walsh wrote:
> This patch moves audit2why to /usr/bin to match audit2allow, since both
> can be used from userspace.  Also moves sepolgen-ifget to /usr/sbin,
> since this is not to be run by normal users.
> 

sepolgen-ifgen can be run by a normal user and the output saved to an
arbitrary file. audit2allow also has flags for reading the interface
information from a non-default flag. So I think it should stay
in /usr/bin.

I merged the audit2why change to trunk, stable, and policyrep.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
