Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM
	settings for task actions [try #2]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: casey@schaufler-ca.com, Karl MacMillan <kmacmill@redhat.com>,
        viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <715.1197500109@redhat.com>
References: <1197488108.1125.141.camel@moss-spartans.epoch.ncsc.mil>
	 <66139.71689.qm@web36604.mail.mud.yahoo.com>  <715.1197500109@redhat.com>
Content-Type: text/plain
Date: Thu, 13 Dec 2007 09:51:01 -0500
Message-Id: <1197557461.20226.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-12 at 22:55 +0000, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > More likely, run it at build time in your .spec file to generate
> > cachefiles.conf,
> 
> I don't think sticking it in cachefiles.conf is a good idea necessarily.
> That has to be an administrator modifiable file.  Is there a program I could
> make cachefiles run directly and capture the output of that could give me the
> info I want?

Yes, we could easily make a simple program that just invokes a
libselinux function that in turn grabs the proper context from some
context configuration file under /etc/selinux/$SELINUXTYPE/contexts/ and
outputs it.  Dan can help with that.

> > then run it again maybe upon a policy update or if the user selects a
> > different policy.
> 
> How do I do that?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
