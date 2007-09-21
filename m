From: David Howells <dhowells@redhat.com>
In-Reply-To: <718847.32805.qm@web36601.mail.mud.yahoo.com>
References: <718847.32805.qm@web36601.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/22] Introduce credential record
Date: Fri, 21 Sep 2007 16:40:16 +0100
Message-ID: <9072.1190389216@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > One thing I'm not certain about is how this should interact with /proc,
> > which can display some of the stuff in the cred struct.  I think it may be
> > necessary to have a real cred pointer and an effective cred pointer, with
> > the contents of /proc coming from the real, but the effective governing
> > what actually goes on.
> 
> I think you want the effective values to show up in /proc.

Perhaps - but bear in mind that in the override case they weren't set by the
process itself.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
