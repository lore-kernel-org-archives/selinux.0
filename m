Message-ID: <40DBC7B2.3040001@laufwerka.de>
Date: Fri, 25 Jun 2004 08:35:30 +0200
From: Pascal Hahn <p.hahn@laufwerka.de>
MIME-Version: 1.0
Cc: SELinux@tycho.nsa.gov
Subject: Re: apache rule to make it write in directory
References: <40DACAF8.6000308@laufwerka.de> <200406250032.49303.russell@coker.com.au>
In-Reply-To: <200406250032.49303.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker schrieb:

>On Thu, 24 Jun 2004 22:37, Pascal Hahn <p.hahn@laufwerka.de> wrote:
>  
>
>>I got the problem that my apache2 under selinux running on gentoo linux is
>>not able to write to a certain directory under htdocs which i need to be
>>writable.
>>
>>I need a rule to make it write in that directory but didnt find a
>>possibility to do so by now.
>>
>>Perhaps someone can help me out here.
>>    
>>
>
>Please show us the AVC messages from the access that is denied and then it 
>should be easy to demonstrate how to customise the policy to do what you 
>require.
>
>  
>
heres my output i get from avc messages:

/Jun 16 13:39:36 lboxx avc:  denied  { write } for  pid=3161 
exe=/usr/sbin/apache2 path=/var/www/localhost/lwa/infos/auth.tmp 
dev=hdc6 ino=96389 scontext=system_u:system_r:httpd_t 
tcontext=system_u:object_r:httpd_sys_content_t tclass=file

Jun 16 16:22:16 lboxx avc:  denied  { write } for  pid=3215 
exe=/usr/sbin/apache2 name=infos dev=hdc6 ino=96403 
scontext=system_u:system_r:httpd_t 
tcontext=system_u:object_r:httpd_sys_content_t tclass=dir/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
