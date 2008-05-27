Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4RJCtVO026576
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 15:12:56 -0400
Received: from mail.fluendo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4RJCrGb000725
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 19:12:54 GMT
Received: from mail.fluendo.com (localhost.localdomain [127.0.0.1])
	by mail.fluendo.com (Postfix) with ESMTP id 7B2CB2500F8
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 21:12:52 +0200 (CEST)
Received: from deathwing00.fluendo.lan (core.fluendo.com [195.10.6.237])
	by mail.fluendo.com (Postfix) with ESMTP id 2432F2500F5
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 21:12:52 +0200 (CEST)
Message-ID: <483C5D33.3000800@flumotion.com>
Date: Tue, 27 May 2008 21:12:51 +0200
From: Ioannis Aslanidis <iaslanidis@flumotion.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Quick question
References: <483C46FA.9030904@flumotion.com>	 <1211911009.19360.51.camel@moss-spartans.epoch.ncsc.mil>	 <483C4E13.2030903@flumotion.com> <1211912805.19360.65.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1211912805.19360.65.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Understood. That changes a little the policy, but I could still create
one mount point per user inside his own home. That still leaves me with
the possibility of listing /home, which could be achieved by removing
the read flag on the directory on normal permission mode and so on, so I
guess SELinux wouldn't be needed in that case.

Thanks for your help. If you have any comments or proposals I am open to
them.

Thanks once again,

Ioannis

Stephen Smalley wrote:
> On Tue, 2008-05-27 at 20:08 +0200, Ioannis Aslanidis wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Stephen Smalley wrote:
>>> If I understand correctly, you want to provide separation on a per-user
>>> basis (not just per-role) for NFS-mounted home directories.  I don't
>>> think that is realistically supportable by SELinux today, as 1) SELinux
>>> distinguishes based on security context/label, not uid, and 2) NFS
>>> doesn't support file labeling yet.  Sounds more like a job for 'normal
>>> permissions' i.e. discretionary access modes and/or ACLs.  There is
>>> ongoing work to support file labeling in NFSv4, but it is still in
>>> development, and even then, instantiating a separate role for every user
>>> is going to be problematic for any large number of users.
>>>
>>
>> And would there be a way to do something so that each user has a
>> different context? That is to say, I can assign a different context to
>> each user and have something easily maintained. Do you see that viable?
> 
> It can be done (e.g. you can define a SELinux user in policy for each of
> your users and then use a policy constraint on the user identity field
> to enforce the separation, or you can define per-user roles in policy
> and use the RBAC support), but I'm not sure how practical it is.  But
> even if it were done, without labeling support in NFS, you can't use it
> for NFS-mounted home directories (you are limited to a single context
> per filesystem there at present).
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFIPF0zFq+8w76sCAARAmICAJ9BzLJdQv1f9tWKt9SbCXAES89FvACgswzB
GV7yhgfJEZCmxUlgpq/0U4g=
=CwtZ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
