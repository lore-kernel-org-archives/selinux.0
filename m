Message-ID: <4AF02C79.30806@redhat.com>
Date: Tue, 03 Nov 2009 08:13:29 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: selinux_check_passwd_access() behaviour when passwd class does
 not exist
References: <1257201838.24413.20.camel@tesla.lan>
In-Reply-To: <1257201838.24413.20.camel@tesla.lan>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/02/2009 05:43 PM, Guido Trentalancia wrote:
> Hello !
> 
> The current behaviour of selinux_check_passwd_access() is to succeed
> even if the "passwd" class does not exist (see checkAccess.c:21). Is
> this really the intended behaviour ??
> 
> It would make more sense if it failed in such case (as in
> mapping.c:66)... Or am I wrong ?
> 
> Guido Trentalancia
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
I am not sure,  I think it could be argued that this function should not be in libselinux at all, since it hard codes policy into the library.

I think you need to start setting the errno if you are going to change the function ENOSUPP for this error versus EPERM for the other error, and then all users (passwd?) of the function need to change to look at the errno.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
