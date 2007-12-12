Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM
	settings for task actions [try #2]
From: Karl MacMillan <kmacmill@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <31067.1197471197@redhat.com>
References: <1197470515.3019.2.camel@localhost.localdomain>
	 <1197322068.18120.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1197307397.18120.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil>
	 <20071205193818.24617.79771.stgit@warthog.procyon.org.uk>
	 <20071205193859.24617.36392.stgit@warthog.procyon.org.uk>
	 <25037.1197306473@redhat.com> <25572.1197320887@redhat.com>
	 <25965.1197329769@redhat.com>
	 <1197401823.28006.74.camel@moss-spartans.epoch.ncsc.mil>
	 <31067.1197471197@redhat.com>
Content-Type: text/plain
Date: Wed, 12 Dec 2007 09:59:30 -0500
Message-Id: <1197471570.3019.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2007-12-12 at 14:53 +0000, David Howells wrote:
> Karl MacMillan <kmacmill@redhat.com> wrote:
> 
> > That's what I remember as well - I suggested the transition idea and
> > then, after discussion, agreed that it wasn't the best approach.
> 
> Sigh.
> 
> Can you tell me then how to do it now?  I don't know very much about using
> SELinux userspace stuff libraries or configuring them.
> 

I don't have enough context anymore to help with design, but I can help
with the actual usage of the libraries if you have specific questions.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
