Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l53Euph5032740
	for <selinux@tycho.nsa.gov>; Sun, 3 Jun 2007 10:56:52 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l53Eundo004090
	for <selinux@tycho.nsa.gov>; Sun, 3 Jun 2007 14:56:50 GMT
In-Reply-To: <40E6CEE4-6DFE-4458-8DB7-11D81DFC7E80@sf-net.com>
References: <40E6CEE4-6DFE-4458-8DB7-11D81DFC7E80@sf-net.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B10330AA-511A-4F34-BED6-C129EF5868B6@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: Apache and PHP
Date: Sun, 3 Jun 2007 16:56:44 +0200
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 02.06.2007, at 15:44, Stefan Schulze Frielinghaus wrote:
> I labeled the files correctly and enabled the apache_enable_cgi  
> boolean, but I still get some AVC errors:
>
> # dmesg -c | audit2allow
> allow httpd_t httpd_dokuwiki_content_t:dir { getattr read search };
> allow httpd_t httpd_dokuwiki_content_t:file { getattr read };
> allow httpd_t httpd_dokuwiki_script_rw_t:dir { getattr search write };
> allow httpd_t httpd_dokuwiki_script_rw_t:file { getattr read write };

OK like from http://fedoraproject.org/wiki/SELinux/apache I haven't  
enabled httpd_builtin_scripting. After that no AVCs are generated.  
But if you look at the policy (refpolicy-20061212) there are still  
some questions left. For example at the section (line 128)  
"tunable_policy(`httpd_builtin_scripting',`" there are many entries  
which allow the httpd_t domain to do what ever it wants with the  
httpd_$1_script_rw_t types:

manage_files_pattern(httpd_t,httpd_$1_script_rw_t,httpd_$1_script_rw_t)

This means to me that if the apache webserver gets compromised all my  
files which are labeled httpd_$1_script_rw_t could be damaged. I  
thought I could secure my PHP applications so that the only access to  
the PHP files is via the httpd_$1_script_t domain.
Is this really the deserved behavior for PHP applications running  
under SELinux or did I miss something? I'm not really sure how to  
interpret the message from the wiki:

httpd can be configured to turn off internal scripting (PHP).  PHP   
and other
loadable modules run under the same context as httpd.  Therefore
several  policy  rules  allow httpd greater access to the system
then is needed if you only use external cgi scripts.
setsebool -P httpd_builtin_scripting 0

Does this mean that all PHP applications can't be distinct between  
httpd_t and the httpd_$1_script_t?

Best regards,
Stefan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
