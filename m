To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <9dc38544-b297-741e-dd7e-e09778a0baf3@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7ba2608b-f5e1-a3ce-583a-1cabcffdffb9@tycho.nsa.gov>
Date: Thu, 22 Mar 2018 12:09:08 -0400
MIME-Version: 1.0
In-Reply-To: <9dc38544-b297-741e-dd7e-e09778a0baf3@debian.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: dbus-daemon patches review
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/21/2018 07:58 AM, Laurent Bigonville wrote:
> Hello,
> 
> Could somebody have a quick look at the two patches that I opened for two dbus bugs:
> 
> https://bugs.freedesktop.org/show_bug.cgi?id=92831 (stop using avc_init())
> 
> https://bugs.freedesktop.org/attachment.cgi?id=138021 (stop using selinux_set_mapping())
> 
> I'm also wondering whether the call to avc_add_callback() shouldn't be replaced by selinux_set_callback(), an opinion on this?

Patches look sane to me although I'm not really familiar with dbus code.

Looks like the callback is only used to trigger a reload of the dbus configuration (for dbus_contexts updates), and thus selinux_set_callback(SELINUX_CB_POLICYLOAD) is more appropriate than avc_add_callback(AVC_CALLBACK_RESET), since the latter is called upon setenforce 1 as well.  However, if it were truly only for that purpose, one might argue that it ought to be a watch on the dbus_contexts file instead and not be tied to selinux at all.

NB This still won't fix the case where dbusd has already performed a string_to_security_class/av_perm lookup and the result has been cached by the libselinux class cache and then a subsequent policy update alters those values.  That is what was fixed for systemd's usage of selinux_check_access() by selinux commit b408d72ca9104cb0c1bc4e154d8732cc7c0a9190.  Offhand, I'm now wondering why I didn't just call flush_class_cache() from avc_reset() itself.  That would fix it for other users of the AVC.  You can't directly call flush_class_cache() from the dbus selinux policyload callback because it is hidden presently.  If we can fix it directly in libselinux, then that is better.  If not, we'd need to export it and probably give it a more unique name, ala selinux_flush_class_cache().
