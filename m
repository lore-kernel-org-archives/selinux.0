Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM
	settings for task actions [try #2]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: David Howells <dhowells@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <66139.71689.qm@web36604.mail.mud.yahoo.com>
References: <66139.71689.qm@web36604.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 12 Dec 2007 14:35:08 -0500
Message-Id: <1197488108.1125.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-12 at 11:20 -0800, Casey Schaufler wrote:
> --- David Howells <dhowells@redhat.com> wrote:
> 
> > Casey Schaufler <casey@schaufler-ca.com> wrote:
> > 
> > > You may need to have an application, say cachefileselinuxcontext, that will
> > > read the current policy and spit out an appropriate value of "<whatever>",
> > > but that can be separate and LSM specific without mucking up your basic
> > > infrastructure applications.
> > 
> > What would I do with such a thing?  How would it get run?  Spat out to where?
> 
> Put it in /etc/init.d/cachefiles and run it at boot time. Put the
> result into /etc/cachefiles.conf. Have cachefilesd read it and pass
> it downward.

More likely, run it at build time in your .spec file to generate
cachefiles.conf, then run it again maybe upon a policy update or if the
user selects a different policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
