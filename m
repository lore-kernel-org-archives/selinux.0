Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8QEwYdX011163
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 10:58:34 -0400
Received: from web36606.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8QEwW8B003219
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 14:58:32 GMT
Date: Wed, 26 Sep 2007 07:58:32 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 2/3] CRED: Split the task security data and move part of it into struct cred
To: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, "Serge E. Hallyn" <serge@hallyn.com>,
        viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <22215.1190813419@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <402619.1696.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > Precisely when to use one identity vs. the other though isn't always
> > clear, and the potential for accidental divergence is also a concern.
> 
> What should auditing use in audit_filter_rules() when dealing with
> AUDIT_SUBJ_* cases?  Should the SUBJ cases use the subjective SID and the
> AUDIT_OBJ_* cases use the objective SID?  On the other hand AUDIT_OBJ_* cases
> don't seem to have anything to do with tasks.

I believe that you'll need to audit both sets of credentials.
I think that for audit filtering you will need to have the ability
to filter on either. It's no different from the euid/ruid split.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
