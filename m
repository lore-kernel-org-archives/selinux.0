Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAQDgmRb019275
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 08:42:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAQDgCp7014409
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 13:42:13 GMT
Message-ID: <3FC4ADD3.9040505@redhat.com>
Date: Wed, 26 Nov 2003 08:42:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: russell@coker.com.au,
   =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?=
 <monteiro@ipen.br>,
   selinux <selinux@tycho.nsa.gov>
Subject: Re: genfs_contexts file
References: <3FC3CE10.8020307@ipen.br> <200311261135.09128.russell@coker.com.au>
In-Reply-To: <200311261135.09128.russell@coker.com.au>
Content-Type: multipart/alternative;
 boundary="------------000702040801050805040608"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000702040801050805040608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Russell Coker wrote:

>On Wed, 26 Nov 2003 08:48, Carlos Anísio Monteiro <monteiro@ipen.br> wrote:
>  
>
>>I have a doubt about *genfs_contexts* file. For example, the statement
>>below:
>>
>>*genfscon vfat /                system_u:object_r:dosfs_t*
>>
>>I mounted the windows filesystem with: *mount -t vfat /dev/hda1 /mnt/win*
>>I access with: *cd /mnt/win* and run *ls --context*
>>The print out of the *ls --context* is:
>>*-rwxr--r--  root     root     (null)                           130700.htm
>>    
>>
>
>Files/directories that are assigned contexts with genfscon do not have an 
>xattr, so "ls --context" can not show their context.
>
>This is a known issue.  I don't know if there are plans to change it.
>  
>
Steven,

Is there a way to change libselinux to return this data, ie if 
getfilecon is going to return NULL, then have it return the genfscon value?

Dan

--------------000702040801050805040608
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Russell Coker wrote:<br>
<blockquote type="cite"
 cite="mid200311261135.09128.russell@coker.com.au">
  <pre wrap="">On Wed, 26 Nov 2003 08:48, Carlos An&iacute;sio Monteiro <a class="moz-txt-link-rfc2396E" href="mailto:monteiro@ipen.br">&lt;monteiro@ipen.br&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have a doubt about *genfs_contexts* file. For example, the statement
below:

*genfscon vfat /                system_u:object_r:dosfs_t*

I mounted the windows filesystem with: *mount -t vfat /dev/hda1 /mnt/win*
I access with: *cd /mnt/win* and run *ls --context*
The print out of the *ls --context* is:
*-rwxr--r--  root     root     (null)                           130700.htm
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Files/directories that are assigned contexts with genfscon do not have an 
xattr, so "ls --context" can not show their context.

This is a known issue.  I don't know if there are plans to change it.
  </pre>
</blockquote>
Steven,<br>
<br>
Is there a way to change libselinux to return this data, ie if
getfilecon is going to return NULL, then have it return the genfscon
value?<br>
<br>
Dan<br>
</body>
</html>

--------------000702040801050805040608--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
