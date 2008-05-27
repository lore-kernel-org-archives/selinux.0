Subject: Re: Quick question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ioannis Aslanidis <iaslanidis@flumotion.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <483C4E13.2030903@flumotion.com>
References: <483C46FA.9030904@flumotion.com>
	 <1211911009.19360.51.camel@moss-spartans.epoch.ncsc.mil>
	 <483C4E13.2030903@flumotion.com>
Content-Type: text/plain
Date: Tue, 27 May 2008 14:26:45 -0400
Message-Id: <1211912805.19360.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-05-27 at 20:08 +0200, Ioannis Aslanidis wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > 
> > If I understand correctly, you want to provide separation on a per-user
> > basis (not just per-role) for NFS-mounted home directories.  I don't
> > think that is realistically supportable by SELinux today, as 1) SELinux
> > distinguishes based on security context/label, not uid, and 2) NFS
> > doesn't support file labeling yet.  Sounds more like a job for 'normal
> > permissions' i.e. discretionary access modes and/or ACLs.  There is
> > ongoing work to support file labeling in NFSv4, but it is still in
> > development, and even then, instantiating a separate role for every user
> > is going to be problematic for any large number of users.
> > 
> 
> 
> And would there be a way to do something so that each user has a
> different context? That is to say, I can assign a different context to
> each user and have something easily maintained. Do you see that viable?

It can be done (e.g. you can define a SELinux user in policy for each of
your users and then use a policy constraint on the user identity field
to enforce the separation, or you can define per-user roles in policy
and use the RBAC support), but I'm not sure how practical it is.  But
even if it were done, without labeling support in NFS, you can't use it
for NFS-mounted home directories (you are limited to a single context
per filesystem there at present).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
