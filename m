From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Pascal Hahn <p.hahn@laufwerka.de>
Subject: Re: apache rule to make it write in directory
Date: Fri, 25 Jun 2004 17:51:53 +1000
Cc: SELinux@tycho.nsa.gov
References: <40DACAF8.6000308@laufwerka.de> <200406250032.49303.russell@coker.com.au> <40DBC7B2.3040001@laufwerka.de>
In-Reply-To: <40DBC7B2.3040001@laufwerka.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406251751.53629.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 25 Jun 2004 16:35, Pascal Hahn <p.hahn@laufwerka.de> wrote:
> heres my output i get from avc messages:
>
> /Jun 16 13:39:36 lboxx avc:  denied  { write } for  pid=3161
> exe=/usr/sbin/apache2 path=/var/www/localhost/lwa/infos/auth.tmp
> dev=hdc6 ino=96389 scontext=system_u:system_r:httpd_t
> tcontext=system_u:object_r:httpd_sys_content_t tclass=file

Try the following:
file_type_auto_trans(httpd_t, httpd_sys_content_t, httpd_sys_script_rw_t, 
file)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
