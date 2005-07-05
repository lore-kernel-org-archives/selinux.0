Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j65KLKgA026069
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 16:21:20 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j65KJNEn004067
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 20:19:24 GMT
Message-ID: <42CAEB48.1030309@redhat.com>
Date: Tue, 05 Jul 2005 16:19:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: "'Colin Walters'" <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: Groups in the alternative user solution
References: <200507052001.j65K1W7f018433@gotham.columbia.tresys.com>
In-Reply-To: <200507052001.j65K1W7f018433@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:

>>-----Original Message-----
>>From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
>>Behalf Of Daniel J Walsh
>>Sent: Tuesday, July 05, 2005 3:40 PM
>>To: Colin Walters
>>Cc: selinux@tycho.nsa.gov
>>Subject: Re: Groups in the alternative user solution
>>
>>Colin Walters wrote:
>>
>>    
>>

But this does not scale.

If the patient app is allow to write a medical record to the users 
homedir it should be labeled medical_record and not be allowed
to be viewed by the user unless he is in running the app.  This should 
not be protected by the homedir file context, it will never scale.

In the case of the doctor being able to assume multiple roles, what 
context would the patient record app write to the home dir.

RBAC being tied to TE in the homedirs is broken. 

Currently if we switch a user from user_r to staff_r, he looses access 
to all his files until a magic relabel happens.  If we allow
an expansion of roles available to the user, the problem explodes.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
