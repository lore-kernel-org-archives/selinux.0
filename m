To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
Cc: Simon McVittie <smcv@debian.org>
References: <9dc38544-b297-741e-dd7e-e09778a0baf3@debian.org>
 <7ba2608b-f5e1-a3ce-583a-1cabcffdffb9@tycho.nsa.gov>
 <82c84995-c4ba-545a-9b69-81f9731a4cb5@bigonville.be>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <359e8425-480e-8a37-1fef-e7a39e746f7a@tycho.nsa.gov>
Date: Fri, 23 Mar 2018 08:26:32 -0400
MIME-Version: 1.0
In-Reply-To: <82c84995-c4ba-545a-9b69-81f9731a4cb5@bigonville.be>
Content-Type: text/plain; charset=utf-8
Subject: Re: dbus-daemon patches review
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/23/2018 06:31 AM, Laurent Bigonville wrote:
> Le 22/03/18 à 17:09, Stephen Smalley a écrit :
>> On 03/21/2018 07:58 AM, Laurent Bigonville wrote:
>>> Hello,
>>>
>>> Could somebody have a quick look at the two patches that I opened for two dbus bugs:
>>>
>>> https://bugs.freedesktop.org/show_bug.cgi?id=92831  (stop using avc_init())
>>>
>>> https://bugs.freedesktop.org/attachment.cgi?id=138021  (stop using selinux_set_mapping())
>>>
>>> I'm also wondering whether the call to avc_add_callback() shouldn't be replaced by selinux_set_callback(), an opinion on this?
>> Patches look sane to me although I'm not really familiar with dbus code.
> 
> Thanks for the review, Simon already had a look at the dbus part of the code
> 
>> Looks like the callback is only used to trigger a reload of the dbus configuration (for dbus_contexts updates), and thus selinux_set_callback(SELINUX_CB_POLICYLOAD) is more appropriate than avc_add_callback(AVC_CALLBACK_RESET), since the latter is called upon setenforce 1 as well.  However, if it were truly only for that purpose, one might argue that it ought to be a watch on the dbus_contexts file instead and not be tied to selinux at all.
> I really don't know the original rational of this. But I guess that if somebody is modifying dbus_contexts file, there are big chances that he will reload the policy as well(?).
> 
> I'll change avc_add_callback() by selinux_set_callback(), we could say that as the file is in the SELinux path it's its responsibility.
> 
>> NB This still won't fix the case where dbusd has already performed a string_to_security_class/av_perm lookup and the result has been cached by the libselinux class cache and then a subsequent policy update alters those values.  That is what was fixed for systemd's usage of selinux_check_access() by selinux commit b408d72ca9104cb0c1bc4e154d8732cc7c0a9190.  Offhand, I'm now wondering why I didn't just call flush_class_cache() from avc_reset() itself.  That would fix it for other users of the AVC.  You can't directly call flush_class_cache() from the dbus selinux policyload callback because it is hidden presently.  If we can fix it directly in libselinux, then that is better.  If not, we'd need to export it and probably give it a more unique name, ala selinux_flush_class_cache().
> Right, that's a really good point, that I apparently overlooked...
> 
> Is that cache really supposed to substantially speedup things? Would it be possible to create a version of selinux_check_access() that allows to pass a reference the cache or let selinux_check_access() create that cache itself? If it's the case I guess that dbus-broker would benefit of that as well as they are using selinux_check_access().
> 
> Otherwise we can indeed clean up the cache our self, but wasn't the goal of selinux_check_access() to be an "easy" interface to use, asking the applications to do this kind of housekeeping is defeating that purpose, isn't it?

If you use selinux_check_access(), then the class cache is already flushed for you upon an AVC reset; that is what the commit I referenced above did.  The problem in the case of dbusd is that it is not using selinux_check_access() but rather its own direct usage of string_to_security_class/av_perm() and avc_has_perm().  That's why we need to either take the call to flush_class_cache() in libselinux to avc_reset() so that it is done for all users of the AVC, or we need to export it and have dbusd call it from its policy reload callback.
