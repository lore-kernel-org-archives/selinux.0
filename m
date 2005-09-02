Subject: Re: quotaon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <200509021632.j82GWrss022126@gotham.columbia.tresys.com>
References: <200509021632.j82GWrss022126@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 02 Sep 2005 13:48:32 -0400
Message-Id: <1125683312.21817.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-02 at 12:32 -0400, Karl MacMillan wrote:
> Under what conditions is quotaon checked for files? After some looking I
> found that you can mount a file on another file using bind mount - which I
> was not previously aware of - which would trigger the mounton check. It is
> not clear to me, though, when quotaon would be checked and whether it is
> related to the bind mount of a file on another file.

mount -o remount,quota /boot
/sbin/quotacheck /boot
/sbin/quotaon /boot

type=AVC msg=audit(1125682618.727:11233081): avc:  denied  { quotaon } for  pid=24938 comm="quotaon" name="aquota.user" dev=hda1 ino=18119 scontext=root:system_r:quota_t tcontext=root:object_r:boot_t tclass=file

It has no connection to mounton, not sure what you are asking.
It effectively controls what files can be used as quota files based on
their type, e.g. so that a maliciously constructed quota file won't be
used by the kernel.  Whether or not it matters in practice...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
