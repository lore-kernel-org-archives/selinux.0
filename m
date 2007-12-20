Message-ID: <476AEACB.4070902@tycho.nsa.gov>
Date: Thu, 20 Dec 2007 17:20:59 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
Subject: Re: avc:  granted null messages
References: <1198014552.11568.49.camel@moss-spartans.epoch.ncsc.mil>	 <47685BBB.7060308@tycho.nsa.gov>	 <Xine.LNX.4.64.0712191107170.22567@us.intercode.com.au>	 <1198080906.19081.64.camel@moss-spartans.epoch.ncsc.mil> <1198082209.19081.80.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1198082209.19081.80.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-12-19 at 11:15 -0500, Stephen Smalley wrote:
>   
>> On Wed, 2007-12-19 at 11:09 +1100, James Morris wrote:
>>     
>>> On Tue, 18 Dec 2007, Eamon Walsh wrote:
>>>
>>>       
>>>> Stephen Smalley wrote:
>>>>         
>>>>> If a (buggy) caller passes a requested permission value of zero to
>>>>> avc_has_perm, it correctly returns a permission denial (if enforcing),
>>>>>   
>>>>>           
>>>> Now I'm questioning why we don't just return success.  Doesn't everyone have
>>>> permission to do nothing?  It seems odd to think that a process could receive
>>>> "granted" for a set of permissions A, but "denied" for a subset of A.
>>>>         
>>> Given that the caller is buggy, we don't really know what it's trying to 
>>> do, so denying access seems prudent.
>>>
>>> Can we get the audit log to produce something unparseable by audit2allow, 
>>> as we don't _want_ policy being generated in response to a buggy caller ?
>>>       
>> At present, it generates no avc message in permissive (avc_audit entered
>> with requested == 0 and result == 0) and a misleading avc message in
>> enforcing (avc_audit entered with requested == 0 and result < 0),
>> neither of which will generate any policy.
>>
>> If we change it to consistently generate an:
>> 	avc:  denied null for scontext=...
>> then audit2allow would try to create an allow rule like:
>> 	allow a_t b_t:class null;
>> which would compile but fail when one tries to insert the module, since
>> null is not a defined permission in the base policy.
>>
>> I don't think we want to generate an unparseable avc message, whatever
>> that might mean, as that too could potentially break audit2allow and in
>> a less understandable way, and we want these failures to be noticeable,
>> just not immediately fatal to the system (ala BUG_ON or assert).
>>     
>
> Oh, the other reason to keep it in the existing format is to ensure that
> setroubleshoot picks up on it, since users are now trained to look for
> its alerts rather than inspecting the audit log for SELinux denials.
>   

How about the following:

Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c	(revision 2708)
+++ libselinux/src/avc.c	(working copy)
@@ -756,12 +756,19 @@
 
 	denied = requested & ~avd->allowed;
 	if (denied) {
+		/* Permissions were denied */
 		audited = denied;
 		if (!(audited & avd->auditdeny))
 			return;
+	} else if (!requested) {
+		/* Request was made with "null" permission vector */
+		audited = requested;
+		denied = 1;
 	} else if (result) {
+		/* Another error besides a denial occurred */
 		audited = denied = requested;
 	} else {
+		/* Permissions were granted */
 		audited = requested;
 		if (!(audited & avd->auditallow))
 			return;


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
