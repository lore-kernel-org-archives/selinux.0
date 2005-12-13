Subject: Re: SELinux: Unregistering netfilter hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Saivasan, Prakash (STSD)" <prakash.saivasan@hp.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <48A6EBBDA6EC5F4A9A65B843D5C821AB016F8897@bgeexc05.asiapacific.cpqcorp.net>
References: 
	 <48A6EBBDA6EC5F4A9A65B843D5C821AB016F8897@bgeexc05.asiapacific.cpqcorp.net>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 11:57:59 -0500
Message-Id: <1134493079.3421.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-12-13 at 22:13 +0530, Saivasan, Prakash (STSD) wrote:
>  Hi all,
>    I was trying to build a test kernel (2.6.14-3) from kernel
> (2.6.11-1), on fedora core 4. However on trying to boot the new kernel,
> I find that the kernel would not boot beyond a certain point. I seems to
> hang on SELinux: Unregistering netfilter hooks. This happens when I
> disable SELinux. When I try to enable SELinux it hangs at a different
> point trying to do something on usbfs. Is this a know problem or am I
> doing something wrong ? Can anyone help ??
>    There is no problem when I try to boot with the original kernel.

Latest FC4 kernel update seems to be 2.6.14-1.1644.

What kernel configuration are you using to build your test kernel?  The
same one used to build the FC4 kernel (you can obtain it from the srpm)?

If you boot with selinux enabled but in permissive mode (i.e.
enforcing=0), does that make any difference?  Do you have avc denied
messages in your /var/log/messages or /var/log/audit/audit.log files?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
