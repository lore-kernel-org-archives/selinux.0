Message-ID: <444F639D.9080709@redhat.com>
Date: Wed, 26 Apr 2006 08:12:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: getfscreatecon(3)
References: <200604261337.50730.russell@coker.com.au> <1146051859.28745.16.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1146051859.28745.16.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------070100060006010306070900"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070100060006010306070900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Wed, 2006-04-26 at 13:37 +1000, Russell Coker wrote:
>   
>> RETURN VALUE
>>        On error -1 is returned.
>>
>>        On success getfscreatecon  returns  the  length  of  the  context  (not
>>        including  the  trailing zero byte).  On success setfscreatecon returns
>>        0.
>>
>>
>> Currently getfscreatecon() returns 0 on success.  Should we change the man 
>> page or change the library?
>>
>> I think that it would be best to change the library.
>>     
>
> The man page should be fixed.  Or you'd have to change all of the
> process-oriented get*con functions.  As the string is NUL-terminated,
> you don't need the length.
>
>   


--------------070100060006010306070900
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getfscreatecon.3 libselinux-1.30.3/man/man3/getfscreatecon.3
--- nsalibselinux/man/man3/getfscreatecon.3	2004-05-20 11:32:44.000000000 -0400
+++ libselinux-1.30.3/man/man3/getfscreatecon.3	2006-04-26 08:10:37.000000000 -0400
@@ -32,9 +32,7 @@
 save, reset, and restore the fscreate context to avoid unexpected behaviors.
 .SH "RETURN VALUE"
 On error -1 is returned.
-
-On success getfscreatecon returns the length of the context (not including
-the trailing zero byte).  On success setfscreatecon returns 0.
+On success 0 is returned.
 
 .SH "SEE ALSO"
 .BR freecon "(3), " getcon "(3), " getexeccon "(3)"

--------------070100060006010306070900--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
