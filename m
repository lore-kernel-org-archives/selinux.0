Message-ID: <40E3F655.8040000@laufwerka.de>
Date: Thu, 01 Jul 2004 13:32:37 +0200
From: Pascal Hahn <p.hahn@laufwerka.de>
MIME-Version: 1.0
To: russell@coker.com.au
Cc: SELinux@tycho.nsa.gov
Subject: Re: apache rule to make it write in directory
References: <40E298E8.9030107@laufwerka.de> <200407010027.39259.russell@coker.com.au>
In-Reply-To: <200407010027.39259.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker schrieb:

>On Wed, 30 Jun 2004 20:41, Pascal Hahn <p.hahn@laufwerka.de> wrote:
>  
>
>>Russell Coker wrote:
>>    
>>
>>>On Fri, 25 Jun 2004 16:35, Pascal Hahn <p.hahn@laufwerka.de> wrote:
>>>      
>>>
>>>>heres my output i get from avc messages:
>>>>
>>>>/Jun 16 13:39:36 lboxx avc:  denied  { write } for  pid=3161
>>>>exe=/usr/sbin/apache2 path=/var/www/localhost/lwa/infos/auth.tmp
>>>>dev=hdc6 ino=96389 scontext=system_u:system_r:httpd_t
>>>>tcontext=system_u:object_r:httpd_sys_content_t tclass=file
>>>>        
>>>>
>>>Try the following:
>>>file_type_auto_trans(httpd_t, httpd_sys_content_t,
>>>httpd_sys_script_rw_t, file)
>>>      
>>>
>>I inserted the rule but get the following error although:
>>
>>
>>Jun 30 12:45:30 lboxx avc:  denied  { write } for  pid=3190
>>exe=/usr/sbin/apache2 name=ip.tmp dev=hdc6 ino=96390
>>scontext=system_u:system_r:httpd_t
>>tcontext=system_u:object_r:httpd_sys_content_t tclass=file
>>    
>>
>
>The following should solve it:
>chcon -t httpd_sys_script_rw_t ip.tmp
>
>Same goes for all other files like it, and you want an entry in 
>file_contexts/misc/custom.fc to avoid accidentally relabelling it back.
>
>  
>
Hi there,

I fixed all my errors and inserted an own role called laufwerka_t. all 
runs fine. also sudo is doing its job nicely until it should execute the 
reboot command. I only get an error from apache called :


Could not set exec context to system_u:system_r:laufwerka_t.


The laufwerka_t also got a filetype called laufwerka_src_t

here is the most important parts of the definitions i made:
domains/program/laufwerka.te:

type laufwerka_t, admin, domain,  auth_chkpwd, privuser, privrole, 
privlog, privowner, mlstrustedreader, mlstrustedwriter, 
mlstrustedobject, privfd;
role sysadm_r types laufwerka_t;


file_contexts/program/laufwerka.fc:

/var/www/[^/]+/lwa(/.*)?        system_u:object_r:laufwerka_src_t

types/files.te:

type laufwerka_src_t, file_type, sysadmfile;

and finally the changes i made to the apache macro:

domain_auto_trans(httpd_t, laufwerka_src_t, laufwerka_t)


Can anyone now tell me how i can use sudo to execute my reboot?

Thanks a lot

Pascal Hahn



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
