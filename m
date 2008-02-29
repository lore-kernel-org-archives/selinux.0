Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1T49YvW020340
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 23:09:34 -0500
Message-ID: <47C7857C.7070406@tycho.nsa.gov>
Date: Thu, 28 Feb 2008 23:09:32 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Tonights rawhide contains a fix to stop xspy.
References: <47C63353.9040008@redhat.com> <47C6650F.2060909@tycho.nsa.gov> <47C6C16D.1010002@redhat.com>
In-Reply-To: <47C6C16D.1010002@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Eamon Walsh wrote:
>> Daniel J Walsh wrote:
>> Basically if you turn on xserver_object_manager boolean, no applications
>> will be allowed to read the x_device.  This stops xspy as you said dead
>> in its tracks,  but some other applications start to get AVC's around
>> querypointer, and eventually I hung the server.  You mentioned in
>> another email, that you were going to change the querypointer to a
>> getattr rather then a read, I think this is necessary, to make this work.
>>   
>>
>>> I have attached a patch that will do this.  There is another request,
>>> XKEYBOARD:GetState, that also requires read and I've noticed that
>>> gnome-settings-daemon is calling it (see below).  If you want to drop
>>> that down to getattr too, let me know; it doesn't look like it returns
>>> the whole keyboard like XQueryKeymap does, however both it and
>>> XQueryPointer return the mouse buttons and the modifier keys (shift,
>>> alt, ctrl, etc.).  Long-term we really need to get applications to stop
>>> calling these.
 >
> Is there any way to differentiate the mouse from the keyboard, why are
> the the same type?

The idea behind the PAM work is to relabel the devices at login time. 
It's kind of a moot point though because XQueryPointer returns both 
mouse and keyboard state and should technically require read permission 
on both devices.

> Can you get this patch upstream, it is a lot easier
> to get it into rawhide that way.

The patch is upstream now, with a big /*XXX*/ on it.  Tom London's 
compiz issues are fixed as well.


> 
> Open bugzilla's on any you find, is the best way to get it fixed.
> 

Rest assured I will.

>>> "Manage" permission on devices is another can of worms you may care to
>>> open at some point.  Anyone with that can remap the keys or do other
>>> things that affect the device globally.
>>> The other AVC's I'm getting are from interactions between staff_mono and
>>> staff.  I believe that this the result of a small application such as
>>> the clock or load graph being staff_mono_t, running inside gnome-panel
>>> which is staff_t.  This is the type of thing I was trying to solve with
>>> the 4-argument templates that allowed some permissions among the entire
>>> "role's" windows (however manage was not one of them).
> Yes this is one of the reasons that I like the ability to extend
> contexts so all privs of staff_t are inherited by staff_mono_t plus the
> exec checks.
> 
> staff_mono_t == staff_t + execmem execstack;

This would be more than simple inheritance though.  This would be 
implicitly granting staff_mono_t and staff_t permissions on each other 
as well.

> 
> I think we are going to need an interface that says one domain can play
> communicate with another domain, sort of the dbus_chat type interfaces.

This or the inheritance thing will be necessary, yes, until a better 
handle is gotten on the interaction issues.

Have you considered starting out by supporting a simpler desktop 
environment, such as XFCE?



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
