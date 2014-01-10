Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0AL8R4u030198
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 16:08:28 -0500
Received: from [172.16.0.199] ([172.16.0.199]) (authenticated bits=0)
 by knetgate.kensnet.org (8.14.4/8.14.4) with ESMTP id s0AL8F1S022571
 (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 21:08:16 GMT
Message-ID: <52D0613F.3030805@kensnet.org>
Date: Fri, 10 Jan 2014 21:08:15 +0000
From: Ken Smith <kens@kensnet.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Web Application access to files in /mnt/
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


Hi All, I could do with some simple guidance. I have a web application, 
written in Perl, that is part of MythTV. It can stream video from files 
mounted in /mnt.

The report from SElinux is

Source Context                system_u:system_r:httpd_sys_script_t:s0
Target Context                system_u:object_r:file_t:s0
Target Objects                /mnt/store0 [ dir ]
Source                        mythweb.pl

What would be the best approach. Should I relabel the files in /mnt or 
create a module like this

# grep mythweb.pl /var/log/audit/audit.log | audit2allow -M mypol
# semodule -i mypol.pp

Thanks in advance

Ken



-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
