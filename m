From: "Ed Street" <edstreet@street-tek.com>
To: <russell@coker.com.au>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: RE: courier mods for Debian
Date: Tue, 13 Apr 2004 17:25:43 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <200404132128.15421.russell@coker.com.au>
Message-Id: <20040413212543.F095B3A404F@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

For run_init /etc/init.d/courier-imap I had to add the following to get it
to start.

allow initrc_t initrc_t:process { setrlimit };

 
Also it looks like allow httpd_t var_run_t:sock_file { write }; is needed
for this.

avc:  denied  { write } for  pid=27683 exe=/usr/sbin/apache-ssl
name=gcache_port dev=hda3 ino=2539533 scontext=system_u:system_r:httpd_t
tcontext=system_u:object_r:var_run_t tclass=sock_file

Ed


---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.656 / Virus Database: 421 - Release Date: 4/9/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
