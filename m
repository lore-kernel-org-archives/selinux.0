Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75KLUNP003422
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 16:21:30 -0400
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m75KLE9V007387
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 20:21:24 GMT
Received: by an-out-0708.google.com with SMTP id d30so484587and.75
        for <selinux@tycho.nsa.gov>; Tue, 05 Aug 2008 13:21:19 -0700 (PDT)
Message-ID: <dd18b0c30808051321h46d7942clf6a91f79370dc40d@mail.gmail.com>
Date: Tue, 5 Aug 2008 13:21:19 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Dennis Wronka" <linuxweb@gmx.net>
Subject: Re: Question about newrole
Cc: "SELinux Mailing List" <selinux@tycho.nsa.gov>
In-Reply-To: <200808052346.38916.linuxweb@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200808052155.18105.linuxweb@gmx.net>
	 <200808052323.48362.linuxweb@gmx.net>
	 <1217950600.2994.116.camel@moss-spartans.epoch.ncsc.mil>
	 <200808052346.38916.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 5, 2008 at 8:46 AM, Dennis Wronka <linuxweb@gmx.net> wrote:
> On Tuesday 05 August 2008 23:36:40 Stephen Smalley wrote:
>> On Tue, 2008-08-05 at 23:23 +0800, Dennis Wronka wrote:
>> > On Tuesday 05 August 2008 22:48:55 Stephen Smalley wrote:
>> > > On Tue, 2008-08-05 at 22:32 +0800, Dennis Wronka wrote:
>> > > > Thanks.
>> > > > That seems to help quite a bit.
>> > > > I now get some messages. For example it seems that newrole wants to
>> > > > read /etc/shadow directly.
>> > > > Will check those messages and play around with the policy.
>> > >
>> > > The way it works is that pam_unix attempts to open /etc/shadow directly
>> > > for reading, and if it fails, it falls back to running unix_chkpwd to
>> > > perform the password check.  SELinux policy prohibits most programs
>> > > from directly reading /etc/shadow, including even ones that run as
>> > > root, and forces them to go through unix_chkpwd instead, in order to
>> > > limit the set of processes that have full read access to the shadow
>> > > password file.
>> > >
>> > > The logic to try to open /etc/shadow and fall back to unix_chkpwd
>> > > already existed before SELinux in order to support non-root processes
>> > > re-authenticating the current user.  What changed with SELinux was that
>> > > it could also happen for root processes.
>> > >
>> > > The current policy dontaudit's the attempt to directly read /etc/shadow
>> > > to avoid noise.  When you did semodule -DB, you turned on that
>> > > auditing. But those denials are what is expected, and allowing them
>> > > will mean giving newrole direct read access to /etc/shadow (although
>> > > that will only work if running as root, of course, as otherwise it has
>> > > to use a suid helper like unix_chkpwd anyway).
>> > >
>> > > Does newrole work for you as a non-root user?
>> >
>> > Okay, it looks like that unix_chkpwd is not allowed to read /etc/shadow
>> > when running in newrole_t.
>> >
>> > Here's the message:
>> > type=1400 audit(1217920543.235:26): avc: denied { read } for pid=1210
>> > comm="unix_chkpwd" name="shadow" dev=dm-0 ino=29366926
>> > scontext=staff_u:staff_r:newrole_t tcontext=system_u:object_r:shadow_t
>> > tclass=file
>> >
>> > Is it safe to add the rule suggested by audit2allow "allow newrole_t
>> > shadow_t:file read;" to the policy or would there be a better way?
>> >
>> > Wouldn't it in general be better if unix_chkpwd would transition into a
>> > domain for itself which then in turn is allowed to access /etc/shadow?
>>
>> unix_chkpwd is supposed to transition into its own domain already.  Is
>> it properly labeled (ls -Z /sbin/unix_chkpwd)?  It should have the
>> chkpwd_exec_t type.  And newrole_t should transition to the
>> system_chkpwd_t domain upon executing it.
>
> Thanks Stephen, that was the magic hint I believe.
> My unix_chkpwd and unix_update were still in the position they got put by the
> PAM-installation (gotta check the install-script if there's a way to put them
> directly into /sbin). I moved them over, checked with restorecon and now it
> works.
> Just had to put symlinks back to the original place because otherwise login
> didn't work. Will have to check if I really need these symlinks or if I can
> do without (Fedora 9 seems to get along without, so there must be a way for
> me to do it too).
>

Cool, glad to see you're up and running.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
