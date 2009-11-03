Subject: Re: selinux_check_passwd_access() behaviour when passwd class does
 not exist
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux@tycho.nsa.gov
In-Reply-To: <4AF02C79.30806@redhat.com>
References: <1257201838.24413.20.camel@tesla.lan>
	 <4AF02C79.30806@redhat.com>
Content-Type: text/plain
Date: Tue, 03 Nov 2009 20:04:22 +0100
Message-Id: <1257275062.3005.66.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 03/11/2009 08.13 -0500, Daniel J Walsh wrote:

> I am not sure,  I think it could be argued that this function should not be in libselinux at all, since it hard codes policy into the library.
> 
> I think you need to start setting the errno if you are going to change the function ENOSUPP for this error versus EPERM for the other error, and then all users (passwd?) of the function need to change to look at the errno.
> 

Yes, I agree with you. The code in selinux_check_passwd_access() should
be removed from libselinux (and moved to passwd.c in the passwd package
or other users).

At the moment there is no errno provision at all, the function only sets
its default return value to -1 at the beginning.

Other than passwd, another user of that code is cronie (see version 1.2
at line 502 of src/security.c). There is no other users that I am aware
of.

With a couple of trivial patches (one for passwd and the other for
cronie) libselinux could be cleaned up of this policy-dependent code. 

I'll send the two patches to your email address as it is probably not
strictly relevant to this mailing list...

Guido



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
