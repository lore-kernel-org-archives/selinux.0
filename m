Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l369YNp5009846
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2007 05:34:23 -0400
Received: from web86903.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l369YM0s027827
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2007 09:34:22 GMT
Date: Fri, 6 Apr 2007 09:34:07 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: conditional. policy does not take effect.
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Message-ID: <164692.56209.qm@web86903.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi every one,

  My cond. policies are not taking effect. Following are the contents of my lodable policy module.

policy_module(myapp,1.0)  
require {
        type unconfined_t;
        type fs_t;
}
type x_t;
bool test true;
auditallow x_t fs_t:filesystem associate;
if (test) {
    auditallow unconfined_t x_t:dir *;
    auditallow unconfined_t x_t:file *;
} else {
      auditallow unconfined_t x_t:dir { getattr read search };
      auditallow unconfined_t x_t:file {getattr };
}

and

/root/medicalpolicy  -- gen_context(root:object_r:x_t)

After compiling the module and adding it to the base policy using "semodule -i myapp.pp",
when i execute the command: "chcon -u root -r object_r -t x_t /root/medicalpolicy"

I get the following error message:
chcon: failed to change context of /root/medicalpolicy to root:object_r:x_t: Permission denied

when i unload the module, the same command says:
chcon: failed to change context of /root/medicalpolicy to root:object_r:x_t: Invalid argument

Previously, the module was working, I just changed the allow to audit, in order to see its effect in the /var/log/audit/audit.log.

The boolean variable test, is set or not, it has no effect on the file, possibly due to  labelling problem, i think so.  Further, i can see the messages in the audit, particularly, when chcon command gives denied message.


Thanks,
JG







		
___________________________________________________________ 
Copy addresses and emails from any email account to Yahoo! Mail - quick, easy and free. http://uk.docs.yahoo.com/trueswitch2.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
