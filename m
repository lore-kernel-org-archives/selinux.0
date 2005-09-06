Message-Id: <200509061252.j86CqbUO002501@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: RE: quotaon
Date: Tue, 6 Sep 2005 08:52:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1125683312.21817.132.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, September 02, 2005 1:49 PM
> To: Karl MacMillan
> Cc: SELinux List
> Subject: Re: quotaon
> 
> On Fri, 2005-09-02 at 12:32 -0400, Karl MacMillan wrote:
> > Under what conditions is quotaon checked for files? After some looking I
> > found that you can mount a file on another file using bind mount - which
> I
> > was not previously aware of - which would trigger the mounton check. It
> is
> > not clear to me, though, when quotaon would be checked and whether it is
> > related to the bind mount of a file on another file.
> 
> mount -o remount,quota /boot
> /sbin/quotacheck /boot
> /sbin/quotaon /boot
> 
> type=AVC msg=audit(1125682618.727:11233081): avc:  denied  { quotaon } for
> pid=24938 comm="quotaon" name="aquota.user" dev=hda1 ino=18119
> scontext=root:system_r:quota_t tcontext=root:object_r:boot_t tclass=file
> 
> It has no connection to mounton, not sure what you are asking.
> It effectively controls what files can be used as quota files based on
> their type, e.g. so that a maliciously constructed quota file won't be
> used by the kernel.  Whether or not it matters in practice...
> 

Interesting - not at all what I was thinking. I can imagine scenarios where
this enforcement might be in important, but seems like a stretch. I was
thinking that this permission had something to do with the filesystem rather
than the quota file - which was why I was thinking about interaction with
mounton. Of course, this doesn't really make sense after thinking about it.

Thanks,

Karl


> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
