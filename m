Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11I1K53017119
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 13:01:20 -0500 (EST)
Message-ID: <41FFC3E9.9020805@redhat.com>
Date: Tue, 01 Feb 2005 13:01:13 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: ivg2@cornell.edu, selinux@tycho.nsa.gov
Subject: Re: File Browsing apps and getattr
References: <1107210369.1928.5.camel@cobra.ivg2.net>	 <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>	 <1107263308.6722.5.camel@cobra.ivg2.net>	 <1107263499.26936.50.camel@moss-spartans.epoch.ncsc.mil>	 <1107264384.6956.2.camel@cobra.ivg2.net> <1107264676.26936.63.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1107264676.26936.63.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2005-02-01 at 08:26, Ivan Gyurdiev wrote:
>  
>
>>Why is the stat() information so important for security?
>>    
>>
>
>It depends on the particular file, obviously.  The point is that it
>represents an information flow that conveys possibly sensitive
>information about the object, and should be controlled in accordance
>with the security properties of the object.
>
>  
>
>>If you won't do this, how do you plan to address the denials I have
>>posted about? 
>>
>>Will you leave ls in this state:
>>
>>[phantom@cobra ~]$ ls -l /var
>>total 112
>>?---------   ? ?    ?       ?            ? account
>>drwxr-xr-x  10 root root 4096 Jan 16 05:33 cache
>>drwxr-xr-x   3 root root 4096 Oct 19 13:20 db
>>drwxr-xr-x   3 root root 4096 Aug 12 11:02 empty
>>?---------   ? ?    ?       ?            ? gdm
>>drwxr-xr-x  24 root root 4096 Jan 16 05:33 lib
>>drwxr-xr-x   2 root root 4096 Aug 12 11:02 local
>>?---------   ? ?    ?       ?            ? lock
>>drwxr-xr-x  13 root root 4096 Feb  1 04:02 log
>>?---------   ? ?    ?       ?            ? mail
>>?---------   ? ?    ?       ?            ? named
>>drwx------   2 root root 4096 Dec  1 13:49 net-snmp
>>drwxr-xr-x   2 root root 4096 Aug 12 11:02 nis
>>drwxr-xr-x   2 root root 4096 Aug 12 11:02 opt
>>drwxr-xr-x   2 root root 4096 Aug 12 11:02 preserve
>>drwxr-xr-x  18 root root 4096 Feb  1 06:16 run
>>drwxr-xr-x  14 root root 4096 Aug 12 11:02 spool
>>drwxrwxrwt   2 root root 4096 Feb  1 06:16 tmp
>>drwxr-xr-x  12 root root 4096 Jan 11 19:28 www
>>?---------   ? ?    ?       ?            ? yp
>>[phantom@cobra ~]$
>>    
>>
>
>You can certainly propose allowing access to additional file types on a
>case-by-case basis, possibly introducing new attributes to identify the
>desired set of types, but adding permissions always requires a
>justification, not just 'why not?'.  What is the functional requirement
>that ls display the attributes of those subdirectories/files?  What is
>the real benefit if you cannot search the subdirectories or read the
>files?
>
>dontaudit is appropriate if you just want to silence the warnings,
>although you obviously don't want to do that for a file to which you
>truly want to track attempted accesses.
>
>  
>
There is already a usrcanread attribute.

Should we create another attribute SECURITYFILE, so we could label 
file_types that have greater security concerns.

shadow_t, cert_t, kerberos_*, ...




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
