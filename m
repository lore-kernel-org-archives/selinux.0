Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96FT9rT005497
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 11:29:10 -0400 (EDT)
Message-ID: <41640F34.6090705@redhat.com>
Date: Wed, 06 Oct 2004 11:28:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: policy patches
References: <200409292354.15227.russell@coker.com.au> <200410021042.15371.russell@coker.com.au> <415E8019.6000100@redhat.com> <200410030614.57157.russell@coker.com.au>
In-Reply-To: <200410030614.57157.russell@coker.com.au>
Content-Type: multipart/mixed;
 boundary="------------050602020004060500030406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050602020004060500030406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Russell Coker wrote:

>On Sat, 2 Oct 2004 20:16, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>Russell Coker wrote:
>>    
>>
>>>On Sat, 2 Oct 2004 06:45, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>>      
>>>
>>>>Cleaned up patch with some of russells changes.
>>>>
>>>>chage has been updated to do a checkPasswdAccess(PASSWD__ROOTOK) now.
>>>>        
>>>>
>>>+allow getty_t initrc_devpts_t:chr_file { read write };
>>>
>>>What is this for?
>>>      
>>>
>>I have been getting AVC messages for it.
>>    
>>
>
>Please show me the AVC messages.
>
>  
>


--------------050602020004060500030406
Content-Type: text/plain;
 name="getty"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="getty"

Oct  6 07:31:21 dhcppc0 kernel: audit(1097062281.872:0): avc:  denied  { read write } for  pid=3884 exe=/sbin/mingetty path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:initrc_devpts_t tclass=chr_file
Oct  6 07:31:22 dhcppc0 kernel: audit(1097062281.909:0): avc:  denied  { read write } for  pid=3885 exe=/sbin/mingetty path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:initrc_devpts_t tclass=chr_file
Oct  6 07:31:22 dhcppc0 kernel: audit(1097062281.910:0): avc:  denied  { read write } for  pid=3885 exe=/sbin/mingetty path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:initrc_devpts_t tclass=chr_file
Oct  6 07:31:22 dhcppc0 kernel: audit(1097062281.910:0): avc:  denied  { read write } for  pid=3885 exe=/sbin/mingetty path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:initrc_devpts_t tclass=chr_file
Oct  6 07:31:22 dhcppc0 kernel: audit(1097062282.034:0): avc:  denied  { read write } for  pid=3930 exe=/sbin/mingetty path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:initrc_devpts_t tclass=chr_file
Oct  6 07:31:22 dhcppc0 kernel: audit(1097062282.157:0): avc:  denied  { read write } for  pid=3975 exe=/sbin/mingetty path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:initrc_devpts_t tclass=chr_file
Oct  6 07:31:22 dhcppc0 kernel: audit(1097062282.157:0): avc:  denied  { read write } for  pid=3975 exe=/sbin/mingetty path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:initrc_devpts_t tclass=chr_file
Oct  6 07:31:22 dhcppc0 kernel: audit(1097062282.158:0): avc:  denied  { read write } for  pid=3975 exe=/sbin/mingetty path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:initrc_devpts_t tclass=chr_file
Oct  6 07:31:22 dhcppc0 kernel: audit(1097062282.279:0): avc:  denied  { read write } for  pid=4020 exe=/sbin/mingetty path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:initrc_devpts_t tclass=chr_file
Oct  6 07:31:22 dhcppc0 kernel: audit(1097062282.280:0): avc:  denied  { read write } for  pid=4020 exe=/sbin/mingetty path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:initrc_devpts_t tclass=chr_file
Oct  6 07:31:22 dhcppc0 kernel: audit(1097062282.280:0): avc:  denied  { read write } for  pid=4020 exe=/sbin/mingetty path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:initrc_devpts_t tclass=chr_file
Oct  6 07:31:22 dhcppc0 kernel: audit(1097062282.580:0): avc:  denied  { read write } for  pid=4065 exe=/sbin/mingetty path=/dev/pts/0 dev=devpts ino=2 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:initrc_devpts_t tclass=chr_file

--------------050602020004060500030406--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
