Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAMJS0Ii007190
	for <selinux@tycho.nsa.gov>; Mon, 22 Nov 2004 14:28:00 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAMJRtOZ022880
	for <selinux@tycho.nsa.gov>; Mon, 22 Nov 2004 19:28:03 GMT
Message-ID: <41A23DBB.5010704@redhat.com>
Date: Mon, 22 Nov 2004 14:27:55 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: Yuichi Nakamura <himainu-ynakam@miomio.jp>, sds@epoch.ncsc.mil,
   selinux@tycho.nsa.gov
Subject: Re: idea: setfiles to exclude specific type
References: <200411221554.iAMFsPDM027086@mms-r01.iijmio.jp> <1101151201.28164.28.camel@nexus.verbum.private>
In-Reply-To: <1101151201.28164.28.camel@nexus.verbum.private>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin Walters wrote:

>On Mon, 2004-11-22 at 10:54 -0500, Yuichi Nakamura wrote:
>  
>
>>Hello.
>>
>>I add setfiles "-x" option.
>>I attach my idea in "setfiles.diff".
>>
>>-x option is used to exclude specified type.
>>
>>For example,
>># setfiles file_contexts /home -x httpd_user_rw_t
>>setfiles skips relabeling files that have "httpd_user_rw_t".
>>    
>>
>
>I thought the conclusion from previous discussion on user-customizable
>file contexts was that we were going to add notation to file_contexts
>for groups of contexts, so that all of e.g.
>system_u:object_r:httpd_sys_content_t,
>system_u:object_r:httpd_sys_script_exec_t, 
>system_u:object_r:httpd_sys_script_rw_t,
>etc. would be acceptable.  
>
>For example:
>
>/var/www(/.*)?			system_u:object_r:httpd_sys_content_t system_u:object_r:httpd_sys_script_rw_t system_u:object_r:httpd_sys_script_exec_t ...
>
>
>  
>
I am not sure that works, and I kind of like the idea of adding a 
attribute to a context to maintain it.

Certain contexts we want to make the admin force a change on, usually 
these are contexts that the user used chcon to create, or mv to make a 
copy of it.    So if a user creates a /var/web account with 
httpd_sys_content_rw_t, we would hammer it, but if we put 
httpd_content_t in a don't change category fixfiles will leave it alone 
by default.  The other main example would be, the user makes a copy of 
his gpg_keys and restorecon/setfiles/fixfiles changes them to 
user_home_t which is readable by other domains.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
