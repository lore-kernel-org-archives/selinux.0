From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Pascal Hahn <p.hahn@laufwerka.de>
Subject: Re: apache rule to make it write in directory
Date: Thu, 1 Jul 2004 00:27:39 +1000
Cc: SELinux@tycho.nsa.gov
References: <40E298E8.9030107@laufwerka.de>
In-Reply-To: <40E298E8.9030107@laufwerka.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407010027.39259.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 Jun 2004 20:41, Pascal Hahn <p.hahn@laufwerka.de> wrote:
> Russell Coker wrote:
> > On Fri, 25 Jun 2004 16:35, Pascal Hahn <p.hahn@laufwerka.de> wrote:
> >> heres my output i get from avc messages:
> >>
> >> /Jun 16 13:39:36 lboxx avc:  denied  { write } for  pid=3161
> >> exe=/usr/sbin/apache2 path=/var/www/localhost/lwa/infos/auth.tmp
> >> dev=hdc6 ino=96389 scontext=system_u:system_r:httpd_t
> >> tcontext=system_u:object_r:httpd_sys_content_t tclass=file
> >
> > Try the following:
> > file_type_auto_trans(httpd_t, httpd_sys_content_t,
> > httpd_sys_script_rw_t, file)
>
> I inserted the rule but get the following error although:
>
>
> Jun 30 12:45:30 lboxx avc:  denied  { write } for  pid=3190
> exe=/usr/sbin/apache2 name=ip.tmp dev=hdc6 ino=96390
> scontext=system_u:system_r:httpd_t
> tcontext=system_u:object_r:httpd_sys_content_t tclass=file

The following should solve it:
chcon -t httpd_sys_script_rw_t ip.tmp

Same goes for all other files like it, and you want an entry in 
file_contexts/misc/custom.fc to avoid accidentally relabelling it back.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
