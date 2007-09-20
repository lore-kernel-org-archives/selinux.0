From: David Howells <dhowells@redhat.com>
In-Reply-To: <14969.1190308632@redhat.com>
References: <14969.1190308632@redhat.com> <956034.72880.qm@web36610.mail.mud.yahoo.com>
Cc: dhowells@redhat.com, casey@schaufler-ca.com, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/3] CRED: Split the task security data and move part of it into struct cred
Date: Thu, 20 Sep 2007 18:33:16 +0100
Message-ID: <15093.1190309596@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Howells <dhowells@redhat.com> wrote:

> > So it sounds like what you'd be happiest with would be a separate task
> > struct hand crafted to he the right "object" and "subject" attributes.

Actually, that whilst that is sort of feasible for CacheFiles[*], it is not
really feasible for NFSd.  NFSd possesses a set of daemons that have a
standard objective context and substitute a lot of different subjective
contexts as they perform VFS operations on behalf of remote clients.

  [*] But in practice quite icky from other points of view.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
