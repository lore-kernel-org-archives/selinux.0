Subject: Re: [PATCH] Security/sysfs: v2 - Enable security xattrs to be set
 on sysfs files, directories, and symlinks.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>, jmorris@namei.org,
        gregkh@suse.de, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <m1skfni4uy.fsf@fess.ebiederm.org>
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <4A84EF1D.8060408@schaufler-ca.com> <m1my62xde6.fsf@fess.ebiederm.org>
	 <4A861291.1030404@schaufler-ca.com> <m1tz09j00q.fsf@fess.ebiederm.org>
	 <4A864008.50907@schaufler-ca.com> <m1my61sjie.fsf@fess.ebiederm.org>
	 <4A8A2616.8020809@schaufler-ca.com>
	 <1250597660.3629.204.camel@moss-pluto.epoch.ncsc.mil>
	 <4A8AB6B0.8010800@schaufler-ca.com>
	 <1250605386.3629.236.camel@moss-pluto.epoch.ncsc.mil>
	 <4A8B81A0.6070206@schaufler-ca.com>
	 <1250683089.3629.268.camel@moss-pluto.epoch.ncsc.mil>
	 <4A8C91D4.3070308@schaufler-ca.com>  <m1skfni4uy.fsf@fess.ebiederm.org>
Content-Type: text/plain
Date: Thu, 20 Aug 2009 07:53:07 -0400
Message-Id: <1250769187.3629.361.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-08-19 at 19:41 -0700, Eric W. Biederman wrote:
> Casey Schaufler <casey@schaufler-ca.com> writes:
> 
> > So I still don't like the way it exposes LSM internal data to the
> > file system code, but given how long it's taking for me to create
> > a better solution I don't think that I can in all fairness say NAK
> > to David Quigley's sysfs patch any longer. I withdraw my objection,
> > while maintaining my reservations.
> 
> Until I see it wired up against another filesystem I retain my
> objections.  When I asked he pretty much told me that it doesn't
> generalize to other filesystems well and it is a sysfs special case.

I think that's a misunderstanding (likely our fault).  As I said, we
already have what we need for getting and setting security xattrs on
in-memory filesystems that pin their inodes, so the only missing bit was
the ability to preserve userspace-set attributes in in-memory
filesystems that can evict their inodes.  And the hooks proposed by
David are generic for that purpose.   You still have to add them to each
such in-memory filesystem that doesn't pin its inodes as each has its
own distinct backing data structure, but you don't need more hooks or a
different approach.

> The way sysctl and proc are wired as special cases into the lsm
> has been a maintenance disaster so far, and I think it a very bad
> idea to add yet another lsm special case, that supports only one
> filesystem.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
