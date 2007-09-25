From: David Howells <dhowells@redhat.com>
In-Reply-To: <19445.1190748021@lwn.net>
References: <19445.1190748021@lwn.net>
To: corbet@lwn.net (Jonathan Corbet)
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 04/22] CRED: Request a credential record for a kernel service 
Date: Tue, 25 Sep 2007 20:27:10 +0100
Message-ID: <24448.1190748430@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jonathan Corbet <corbet@lwn.net> wrote:

> The comment describes a "dentry" argument, but the actual function does
> not have that argument.

oops.  Yeah, I decided I didn't want that there.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
