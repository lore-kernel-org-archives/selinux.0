Message-ID: <40E298E8.9030107@laufwerka.de>
Date: Wed, 30 Jun 2004 12:41:44 +0200
From: Pascal Hahn <p.hahn@laufwerka.de>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: apache rule to make it write in directory
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

> On Fri, 25 Jun 2004 16:35, Pascal Hahn <p.hahn@laufwerka.de> wrote:
>  
>
>> heres my output i get from avc messages:
>>
>> /Jun 16 13:39:36 lboxx avc:  denied  { write } for  pid=3161
>> exe=/usr/sbin/apache2 path=/var/www/localhost/lwa/infos/auth.tmp
>> dev=hdc6 ino=96389 scontext=system_u:system_r:httpd_t
>> tcontext=system_u:object_r:httpd_sys_content_t tclass=file
>>   
>
>
> Try the following:
> file_type_auto_trans(httpd_t, httpd_sys_content_t, 
> httpd_sys_script_rw_t, file)
>
>  
>
Hi there,

I inserted the rule but get the following error although:


Jun 30 12:45:30 lboxx avc:  denied  { write } for  pid=3190
exe=/usr/sbin/apache2 name=ip.tmp dev=hdc6 ino=96390
scontext=system_u:system_r:httpd_t
tcontext=system_u:object_r:httpd_sys_content_t tclass=file
Jun 30 12:45:30 lboxx avc:  denied  { setattr } for  pid=3190
exe=/usr/sbin/apache2 name=ip.tmp dev=hdc6 ino=96390
scontext=system_u:system_r:httpd_t
tcontext=system_u:object_r:httpd_sys_content_t tclass=file

I just need file creation, chmodding, reading and writing on this folder
and all its subolders.

Thanks,

Pascal Hahn


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
