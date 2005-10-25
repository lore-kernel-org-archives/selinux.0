Message-Id: <200510251508.j9PF8oao015698@mms-r00.iijmio.jp>
Date: Tue, 25 Oct 2005 11:08:41 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, himainu-ynakam@miomio.jp
Subject: Re: capability audit_write, audit_control
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1130168024.17609.87.camel@moss-spartans.epoch.ncsc.mil>
References: <1130168024.17609.87.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen Smalley  wrote:
> The explanation for #3 is as follows.  When in permissive mode, the AVC
> adds any denied permissions to the allowed set in the cache entry on the
> first access so that only the first access triggers a log message (to
> avoid repeated denials of the same permission, as this can easily lead
> to flooding when in permissive mode and we only care about collecting
> distinct denials in that mode).  At netlink send time, the entire
> capability vector is computed since we do not know in advance what
> capabilities (if any) will be required by the receive side code; when in
> permissive mode, this causes the entire capability vector in the cache
> entry to be filled.  Normally, we would get a denied audit message at
> that point, but we specifically do not audit that computation because we
> aren't actually checking a particular permission, just precomputing the
> entire vector to be stored in the eff_cap field.  At netlink receive
> time, the eff_cap field is checked but this also does not generate an
> audit message as it is a direct check and we lack the context of the
> sender at that point.  Later, sshd attempts to set its loginuid
> via /proc/self/loginuid, thereby triggering another audit_control check,
> but by then, the permission is already cached in the AVC due to the
> earlier computation while in permissive mode.  Therefore, we end up
> seeing only a granted audit message.
I understood the behavior.
Thanks a lot!

I had experienced in FC3 that some denials for capability is 
outputted only in enforcing mode, it may be related to above.

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor:  http://seedit.sourceforge.net/



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
