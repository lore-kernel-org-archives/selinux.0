Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2RDZs3i025705
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 09:35:56 -0400
Received: from web86904.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2RDZo3M001033
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 13:35:51 GMT
Message-ID: <20070327133530.47573.qmail@web86904.mail.ukl.yahoo.com>
Date: Tue, 27 Mar 2007 14:35:30 +0100 (BST)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Error in installing RefPolicy possibly some conflict?
To: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Every one,

I am getting the following error message, while trying
to install Refpolicy. If some one can help me, prior
to this, i installed refpolicy, but at startup, the
system hanged. The output is trancated, and only the
final part, which creates the problem is copied here
for reference purposes.

Thanks
JG


install -m 644 tmp/system.users
/etc/selinux/refpolicy/users/system.users
Validating refpolicy file_contexts.
/sbin/setfiles -q -c
/etc/selinux/refpolicy/policy/policy.21 file_contexts
libsepol.context_from_record: type
unconfined_execmem_exec_t is not defined
libsepol.context_from_record: could not create context
structure
libsepol.context_from_string: could not create context
structure
libsepol.sepol_context_to_sid: could not convert
system_u:object_r:unconfined_execmem_exec_t to sid
file_contexts:  line 1170 has invalid context
system_u:object_r:unconfined_execmem_exec_t
make: ***
[/etc/selinux/refpolicy/contexts/files/file_contexts]
Error 1






	
	
		
___________________________________________________________ 
New Yahoo! Mail is the ultimate force in competitive emailing. Find out more at the Yahoo! Mail Championships. Plus: play games and win prizes. 
http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
