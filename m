Message-ID: <47C4CB9A.40807@tycho.nsa.gov>
Date: Tue, 26 Feb 2008 21:31:54 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Adam Jackson <ajax@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Permissive mode for xace is broken.
References: <47C2CC18.6080801@redhat.com>	 <1203948764.2804.183.camel@moss-spartans.epoch.ncsc.mil>	 <1203949499.2804.188.camel@moss-spartans.epoch.ncsc.mil>	 <47C2D552.8060509@redhat.com>	 <1203965363.2804.201.camel@moss-spartans.epoch.ncsc.mil>	 <47C316EF.5090206@redhat.com> <47C3261C.1070508@tycho.nsa.gov>	 <47C36767.7030503@tycho.nsa.gov> <1204030752.2804.282.camel@moss-spartans.epoch.ncsc.mil> <47C40F85.60407@redhat.com>
In-Reply-To: <47C40F85.60407@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Stephen Smalley wrote:
>   
>> On Mon, 2008-02-25 at 20:12 -0500, Eamon Walsh wrote:
>>     
>>> Eamon Walsh wrote:
>>>       
>>>> The X object manager logs all avc's and status messages (including the 
>>>> AVC netlink stuff) through the audit system using libaudit calls 
>>>> (audit_log_user_avc_message, etc.)   I disavow all responsibility for 
>>>> the messages once they enter libaudit
>>>>         
>>> It's being black-holed in rawhide.  To see for yourself, add the 
>>> attached patch to the spec file and rebuild the xserver from SRPM.  It 
>>> will tee the avc messages into /var/log/Xorg.0.log.
>>>       
>> Looking at the corresponding code in dbus, I see that dbus is calling
>> both audit_log_user_avc_message() (if HAVE_LIBAUDIT) and
>> vsyslog(LOG_INFO...) with the message.
>>
>> Can you verify that the X server was able to create the audit socket
>> successfully?
>>
>> Things that could go wrong:
>> - X server uses privilege bracketing (switching uids or capabilities)
>> and lacks the necessary audit capabilities.
>> - X server shuts down all descriptors _after_ you've opened the audit
>> socket, thereby closing it down too.
>> - Policy doesn't allow X server to write audit messages (requires
>> audit_write capability and netlink_audit_socket perms).
>>
>> Dan, what policy are you using?  trunk?  or xselinux branch?
>> I don't think Chris has merged xselinux branch to trunk yet, or that it
>> is necessarily safe to work from that branch (i.e. things could change
>> as part of the merge in an incompatible way).
>>
>>     
>>> Also, pull libselinux from upstream.  The BadWindow error may be fixed.
>>>
>>> You'll have to report to me what you see in the X server output.  I'm 
>>> seeing tons of avc's: it doesn't appear as though staff_t is even 
>>> getting X permissions allowed.
>>>
>>>
>>>
>>>
>>>
>>>       
> I have merged changes from the xselinux into the Fedora pool.  I am now
> seeing AVC messages in the /var/log/audit/audit.log with an unreleased
> policy.  My current policy does not generate AVC's with staff_t, but in
> permissive mode/without the xserver_object_manager boolean set, lots of
> XApps (toolbar apps) with BadWindow.  In enforcing mode with the
> xserver_object_manager boolean set they are also failing.  I have
> updated to the latest libselinux and am still seeing the problem.
>   

I found the source of the BadWindow errors.  I'm going to fix this 
upstream and throw an SRPM patch to Dan so he can test.

Also, I think I'm going to change XQueryPointer() from requring "read" 
to simply "getattr" permission on the device.  I really do think it 
should require "read," but too many things call it and we need to turn 
"read" off to prevent the xspy attack.

Finally, I'm going to try and get the polyinstantiation code for 
properties and selections in before the feature freeze.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
