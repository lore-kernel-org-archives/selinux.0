To: Selinux@tycho.nsa.gov
From: "RM-IT R.Mielnik" <r.mielnik@rm-it.pl>
Subject: selinux transition rules
Message-ID: <81aa96e5-873c-2514-92b2-2d272b8fe619@rm-it.pl>
Date: Tue, 28 Feb 2017 16:06:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


	hi,

    i got a problem with transition rules. what i try to do is to make 
selinux change the context type of "rwdirectory" while it is created via 
ftp (proftpd in ftpd_t domain) in httpd_user_content_t directory

1st module:

module custom_transition_httpd_rw 1.0;

require {
	type httpd_user_content_t;
	type httpd_user_rw_content_t;
         type ftpd_t;
	class dir relabelto;
}

type_transition ftpd_t httpd_user_content_t : dir 
httpd_user_rw_content_t ".rw";

2nd module:

policy_module(custom_transition_httpd_rw2, 1.0)
gen_require(`
     type ftpd_t, httpd_user_content_t, httpd_user_rw_content_t;
')
filetrans_pattern(ftpd_t, httpd_user_content_t, httpd_user_rw_content_t, 
dir, "rwdirectory")


1. it works for unconfined_t domain: e.g. while in shell, mkdir (and 
selinux) happily creates rwdirectory with desired context type. it 
doesn't work for ftpd_t domain

it doesn't work for most of centos systems i have, e.g.:

Linux host1 3.10.0-327.18.2.el7.x86_64 #1 SMP Thu May 12 11:03:55 UTC 
2016 x86_64 x86_64 x86_64 GNU/Linux
CentOS Linux release 7.2.1511 (Core)

libselinux-2.2.2-6.el7.x86_64
selinux-policy-3.13.1-60.el7_2.3.noarch
libselinux-python-2.2.2-6.el7.x86_64
libselinux-devel-2.2.2-6.el7.x86_64
selinux-policy-targeted-3.13.1-60.el7_2.3.noarch
libselinux-utils-2.2.2-6.el7.x86_64


Linux host2 3.10.0-514.6.2.el7.x86_64 #1 SMP Thu Feb 23 03:04:39 UTC 
2017 x86_64 x86_64 x86_64 GNU/Linux
CentOS Linux release 7.3.1611 (Core)

libselinux-utils-2.5-6.el7.x86_64
selinux-policy-3.13.1-102.el7_3.13.noarch
selinux-policy-targeted-3.13.1-102.el7_3.13.noarch
libselinux-2.5-6.el7.x86_64
selinux-policy-devel-3.13.1-102.el7_3.13.noarch
libselinux-python-2.5-6.el7.x86_64

2. somehow it works for unconfined_t AND ftpd_t domains on a certain 
centos 7.2 (bug or feature?:)):

Linux host 3.10.0-327.36.3.el7.x86_64 #1 SMP Mon Oct 24 16:09:20 UTC 
2016 x86_64 x86_64 x86_64 GNU/Linux
CentOS Linux release 7.2.1511 (Core)

selinux-policy-3.13.1-60.el7_2.9.noarch
libselinux-python-2.2.2-6.el7.x86_64
libselinux-devel-2.2.2-6.el7.x86_64
selinux-policy-targeted-3.13.1-60.el7_2.9.noarch
libselinux-2.2.2-6.el7.x86_64
libselinux-utils-2.2.2-6.el7.x86_64
