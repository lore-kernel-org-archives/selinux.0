Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBANuw7e005085
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2007 18:56:58 -0500
Received: from web36611.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id lBANuvqO004228
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2007 23:56:57 GMT
Date: Mon, 10 Dec 2007 15:56:57 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
To: David Howells <dhowells@redhat.com>, casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <25991.1197330258@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <112273.38088.qm@web36611.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> > That happens to me when interfaces are described in SELinux terms. I
> > still don't care much for multiple contexts, and I don't have a good
> > grasp of how you'll deal with Smack, or any LSM other than SELinux.
> 
> Me neither.  I understand SELinux somewhat, though it's got a lot of wibbly
> bits, and WinNT's security system, but I have no experience of the other
> stuff.
> 
> > Just as Stephen mentions, I also don't see the generality that a change
> > of this magnitude really ought to provide.
> 
> Perhaps it should be a specific interface, solely for cachefiles's use then.

That would help focus things, to be sure. I don't know if that
focus will speed things up or slow them down, but I think that
attempting to accomodate SELinux/NFS, with the state that effort
is in, will only lead to tears.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
