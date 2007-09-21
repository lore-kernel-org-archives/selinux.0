From: David Howells <dhowells@redhat.com>
In-Reply-To: <533105.53764.qm@web36610.mail.mud.yahoo.com>
References: <533105.53764.qm@web36610.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/22] Introduce credential record
Date: Sat, 22 Sep 2007 00:18:01 +0100
Message-ID: <10185.1190416681@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> They are nonetheless in effect and (heaven forbid) should they be
> abused you don't want to hide the facts from concerned observers.

Because, I suspect, what the observer through /proc should see is what the
process thinks it is doing, not what is transparently going on behind the
scenes.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
