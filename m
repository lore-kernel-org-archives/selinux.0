From: David Howells <dhowells@redhat.com>
In-Reply-To: <1190643719.487.41.camel@moss-spartans.epoch.ncsc.mil>
References: <1190643719.487.41.camel@moss-spartans.epoch.ncsc.mil> <20070919161749.8334.26064.stgit@warthog.procyon.org.uk> <20070919161759.8334.11581.stgit@warthog.procyon.org.uk> <20070924140003.GA25689@vino.hallyn.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, "Serge E. Hallyn" <serge@hallyn.com>,
        viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/3] CRED: Split the task security data and move part of it into struct cred
Date: Wed, 26 Sep 2007 14:30:19 +0100
Message-ID: <22215.1190813419@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Precisely when to use one identity vs. the other though isn't always
> clear, and the potential for accidental divergence is also a concern.

What should auditing use in audit_filter_rules() when dealing with
AUDIT_SUBJ_* cases?  Should the SUBJ cases use the subjective SID and the
AUDIT_OBJ_* cases use the objective SID?  On the other hand AUDIT_OBJ_* cases
don't seem to have anything to do with tasks.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
