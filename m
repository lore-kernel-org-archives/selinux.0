Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8JHUrSH018427
	for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2007 13:30:53 -0400
Received: from web36611.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8JHUnYs029154
	for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2007 17:30:53 GMT
Date: Wed, 19 Sep 2007 10:28:32 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 2/3] CRED: Split the task security data and move part of it into struct cred
To: David Howells <dhowells@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com, sds@tycho.nsa.gov,
        casey@schaufler-ca.com
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
In-Reply-To: <20070919161759.8334.11581.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <843863.97817.qm@web36611.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Move into the cred struct the part of the task security data that defines how
> a
> task acts upon an object.  The part that defines how something acts upon a
> task
> remains attached to the task.

This seems to me to be an unnatural and inappropriate separation.
Move the whole of the security blob into the cred if you must have
a cred (which I was soooo glad Linux didn't have after having dealt
with it in Solaris) rather than having two blobs to deal with. If an
LSM requires a different treatment between when a task is a subject
and when it is an object the LSM should handle that itself.

> For SELinux this requires some of task_security_struct to be split off into
> cred_security_struct which is then attached to struct cred.  Note that the
> contents of cred_security_struct may not be changed without the generation of
> a
> new struct cred.
> 
> The split is as follows:
> 
>  (*) create_sid, keycreate_sid and sockcreate_sid just move across.
> 
>  (*) sid is split into victim_sid - which remains - and action_sid - which
>      migrates.
> 
>  (*) osid, exec_sid and ptrace_sid remain.
> 
> victim_sid is the SID used to govern actions upon the task.  action_sid is
> used
> to govern actions made by the task.

So put all these fields into one blob and attach them to the cred.
Actually, if you put all these fields in the task blob maybe you
don't need to do your COW thing at all.
 



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
