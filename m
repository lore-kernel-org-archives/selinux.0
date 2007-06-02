Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l52Dil9F008452
	for <selinux@tycho.nsa.gov>; Sat, 2 Jun 2007 09:44:47 -0400
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l52DijVf023693
	for <selinux@tycho.nsa.gov>; Sat, 2 Jun 2007 13:44:46 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <40E6CEE4-6DFE-4458-8DB7-11D81DFC7E80@sf-net.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Apache and PHP
Date: Sat, 2 Jun 2007 15:44:37 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello everyone,

I try to create a policy for a Wiki system:

dokuwiki.te:

policy_module(dokuwiki, 1.0.0)

gen_require(`
         type httpd_t;
')

apache_content_template(dokuwiki)

I labeled the files correctly and enabled the apache_enable_cgi  
boolean, but I still get some AVC errors:

# dmesg -c | audit2allow
allow httpd_t httpd_dokuwiki_content_t:dir { getattr read search };
allow httpd_t httpd_dokuwiki_content_t:file { getattr read };
allow httpd_t httpd_dokuwiki_script_rw_t:dir { getattr search write };
allow httpd_t httpd_dokuwiki_script_rw_t:file { getattr read write };

It seems to me that the apache daemon does no type transition from  
httpd_t to httpd_dokuwiki_script_t. I thought that if I use the  
apache_content_template that a new type is created (along some others  
too) and that I can use this as an entrypoint. Do I have to enable  
something else so that a type transition will occure?

Best regards,
Stefan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
