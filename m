Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7JHla7Z004000
	for <selinux@tycho.nsa.gov>; Wed, 19 Aug 2009 13:47:36 -0400
Received: from smtp102.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n7JHl3Zv011949
	for <selinux@tycho.nsa.gov>; Wed, 19 Aug 2009 17:47:03 GMT
Message-ID: <4A8C3AB2.6080503@schaufler-ca.com>
Date: Wed, 19 Aug 2009 10:47:30 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>, jmorris@namei.org,
        gregkh@suse.de, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        SE Linux <selinux@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] Security/sysfs: v2 - Enable security xattrs to be set
 on sysfs files, directories, and symlinks.
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>	 <4A84EF1D.8060408@schaufler-ca.com> <m1my62xde6.fsf@fess.ebiederm.org>	 <4A861291.1030404@schaufler-ca.com> <m1tz09j00q.fsf@fess.ebiederm.org>	 <4A864008.50907@schaufler-ca.com> <m1my61sjie.fsf@fess.ebiederm.org>	 <4A8A2616.8020809@schaufler-ca.com>	 <1250597660.3629.204.camel@moss-pluto.epoch.ncsc.mil>	 <4A8AB6B0.8010800@schaufler-ca.com>	 <1250605386.3629.236.camel@moss-pluto.epoch.ncsc.mil>	 <4A8B81A0.6070206@schaufler-ca.com> <1250683089.3629.268.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1250683089.3629.268.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> ...
>> So how often is the SELinux label going to get explicitly set in /sys ?
>> I'm grappling with the value of going hog-wild in optimizing this. If
>> it is something that's quite rare I can see the concern with expanding
>> the d_entry. If it is common, the storage associated with storing the
>> xattr could be an issue. If it is uncommon but not rare there's another
>> story again.
>>
>> I'm looking at addressing the issues. Thank you.
>>     
>
> I'd expect most sysfs nodes to be left in the default label, although we
> don't really know as this would be the first time that people have the
> option of finer-grained control to sysfs.

This would be consistent with the Unix MLS experience. Most system
files, including things like sysfs, either stick with their original
labels. On the occasion where they get changed the reason is both
important and focused. I had an update almost ready, but I need some
changes to accommodate the assumption that setting an attribute
is rare.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
