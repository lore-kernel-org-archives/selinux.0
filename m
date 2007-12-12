Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBCJLIvG013918
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 14:21:18 -0500
Received: from web36604.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id lBCJL4fM027747
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 19:21:05 GMT
Date: Wed, 12 Dec 2007 11:20:40 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
To: David Howells <dhowells@redhat.com>, casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <32137.1197483929@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <66139.71689.qm@web36604.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> > You may need to have an application, say cachefileselinuxcontext, that will
> > read the current policy and spit out an appropriate value of "<whatever>",
> > but that can be separate and LSM specific without mucking up your basic
> > infrastructure applications.
> 
> What would I do with such a thing?  How would it get run?  Spat out to where?

Put it in /etc/init.d/cachefiles and run it at boot time. Put the
result into /etc/cachefiles.conf. Have cachefilesd read it and pass
it downward.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
