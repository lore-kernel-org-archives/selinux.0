Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72FQkW0030919
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 11:26:46 -0400
Received: from web36608.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l72FQiWr026546
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:26:44 GMT
Date: Thu, 2 Aug 2007 08:26:31 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] SENFS: MAC labeling support for NFSv4
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
In-Reply-To: <1186060789.26901.72.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <912088.21089.qm@web36608.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:
 
> > In the spirit of LSM I suggest that blobs are more appropriate
> > units of data than u32s. I understand that the SELinux design
> > philosophy is well served by secids. My design philosophy, which
> > is pretty much the opposite, has no need for secids and is
> > negatively impacted by interfaces that require them.
> 
> Blobs require full lifecycle management.

Yup.

> secids are lighter weight,

They are lighter weight than big labels. They are heavier than
small labels. They require translation, while certain designs of
small labels don't even require translation to print.

> and
> it isn't that hard for you to implement a secid-to-label mapping in your
> own module even if you don't otherwise use them internally.

Is true. It just feels silly to translate a text string into a secid
so that I can pass it to someone who only cares about the secid because
they want to use it to get the string I had in the first place.

> secids are already entrenched in the LSM interface for labeled
> networking

The xfrm interfaces that require secids are seriously SELinux components.
Netlabel only uses secids for audit. 

> and are already entrenched in the audit-selinux interface
> (even if converted to using LSM hooks).

So I've found. It is annoying that the audit system passes around sids
when it never uses them except to get the associated strings, which
Smack uses natively and can provide trivially.

Well, I can generally identify a windmill when I'm tilting it, so
now that I've aired my heretical notions I'll get on with it.

Thank you.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
