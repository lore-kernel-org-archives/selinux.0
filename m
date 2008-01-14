Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0EEqJeo023558
	for <selinux@tycho.nsa.gov>; Mon, 14 Jan 2008 09:52:19 -0500
Received: from web36606.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m0EEqITI017193
	for <selinux@tycho.nsa.gov>; Mon, 14 Jan 2008 14:52:18 GMT
Date: Mon, 14 Jan 2008 06:52:02 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
To: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
        casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <3466.1200319279@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <929556.69990.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> 
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > > 	avc_has_perm(daemon_tsec->sid, nominated_sid,
> > > 		     SECCLASS_CACHE, CACHE__USE_AS_OVERRIDE, NULL);
> > > 
> > > And I assume this doesn't care if one, the other or both of the two SIDs
> > > mentioned are of SECCLASS_PROCESS rather than of SECCLASS_CACHE.
> > 
> > Right, the latter is reasonable.
> 
> Okay...  It looks like I want four security operations/hooks for cachefiles:
> 
>  (1) Check that a daemon can nominate a secid for use by the kernel to
> override
>      the process subjective secid.
> 
>  (2) Set the secid mentioned in (1).
> 
>  (3) Check that the kernel may create files as a particular secid (this could
>      be specified indirectly by specifying an inode, which would hide the
> secid
>      inside the LSM).
> 
>  (4) Set the fscreate secid mentioned in (3).
> 
> Now, it's possible to condense (1) and (2) into a single op,

Yes, and I would recommend doing so to avoid permission races.
You're going to have to deal with the case where step (2) fails
even if you have step (1), so the "test and set" mindset seems
prudent to me.

> and condense (3) and (4) into a single op.  That, however, might make
> the ops unusable by nfsd,
> which may well want to bypass the checks or do them elsewhere.

Again, I don't think you're doing yourself any favors with a separate
test operation.

On (4) are you suggesting a third attribute value? There's the secid
of the task originally, the secid you're going to use to do the access
checks, and the secid you're going to set the file to on creation.

> Any thoughts?

Let me see if I understand your current scheme.

You want a (object) secid that is used to access the task.
You want a (subject) secid that the task uses to accesses objects.
You want a (newobject) secid that an object gets on creation.
And you want them all to be distinct and settable.
Did I get that right?

Thank you.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
