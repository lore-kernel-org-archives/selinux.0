Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3LNBOE0014561
	for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2009 19:11:24 -0400
Message-ID: <49EE529A.3030908@tycho.nsa.gov>
Date: Tue, 21 Apr 2009 19:11:22 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: libselinux behavior in permissive mode wrt invalid domains
References: <faa16b610904141142v1d1e92ddxd78d5e1a0fbb0be7@mail.gmail.com>	 <49E5CFD8.6060903@redhat.com>	 <1239800627.27560.34.camel@localhost.localdomain>	 <49E7D1BF.2010405@tycho.nsa.gov>	 <1239973084.15304.17.camel@localhost.localdomain>	 <49EE2D59.3080403@manicmethod.com> <1240346499.1678.33.camel@localhost.localdomain>
In-Reply-To: <1240346499.1678.33.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2009-04-21 at 16:32 -0400, Joshua Brindle wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> On Thu, 2009-04-16 at 20:47 -0400, Eamon Walsh wrote:
>>>       
>>>> Stephen Smalley wrote:
>>>>         
>> <snip>
>>
>>     
>>> No, I don't want to change the behavior upon context_to_sid calls in
>>> general, as we otherwise lose all context validity checking in
>>> permissive mode.
>>>
>>> I think I'd rather change compute_sid behavior to preclude the situation
>>> from arising in the first place, possibly altering the behavior in
>>> permissive mode upon an invalid context to fall back on the ssid
>>> (process) or the tsid (object).  But I'm not entirely convinced any
>>> change is required here.
>>>
>>>       
>> I just want to follow up to make sure we are all on the same page here. Was the 
>> suggestion to change avc_has_perm in libselinux or context_to_sid in the kernel 
>> or leave the code as is and fix the callers of avc_has_perm to correctly handle 
>> error codes?
>>
>> I prefer the last approach because of Eamon's explanation, EINVAL is already 
>> passed in errno to specify the context was invalid (and if object managers 
>> aren't handling that correctly now there is a good chance they aren't handling 
>> the ENOMEM case either).
>>     
>
> I'd be inclined to change compute_sid (not context_to_sid) in the kernel
> to prevent invalid contexts from being formed even in permissive mode
> (scenario is a type transition where role is not authorized for the new
> type).  That was originally to allow the system to boot in permissive
> mode.  But an alternative would be to just stay in the caller's context
> (ssid) in that situation.
>
> Changing the callers of avc_has_perm() to handle EINVAL and/or ENOMEM
> may make sense, but that logic should not depend on enforcing vs.
> permissive mode.
>  
>   


FWIW, the following patch to D-Bus should help:


bfo21072 - Log SELinux denials better by checking errno for the cause
    
    Note that this does not fully address the bug report since
    EINVAL can still be returned in permissive mode.  However the log
    messages will now reflect the proper cause of the denial.
    
Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

diff --git a/bus/selinux.c b/bus/selinux.c
index c0f6f4d..46a18a9 100644
--- a/bus/selinux.c
+++ b/bus/selinux.c
@@ -433,8 +433,18 @@ bus_selinux_check (BusSELinuxID        *sender_sid,
                     SELINUX_SID_FROM_BUS (bus_sid), 
                     target_class, requested, &aeref, auxdata) < 0)
     {
-      _dbus_verbose ("SELinux denying due to security policy.\n");
-      return FALSE;
+    switch (errno)
+      {
+      case EACCES:
+        _dbus_verbose ("SELinux denying due to security policy.\n");
+        return FALSE;
+      case EINVAL:
+        _dbus_verbose ("SELinux denying due to invalid security context.\n");
+        return FALSE;
+      default:
+        _dbus_verbose ("SELinux denying due to: %s\n", _dbus_strerror (errno));
+        return FALSE;
+      }
     }
   else
     return TRUE;


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
