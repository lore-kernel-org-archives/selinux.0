To: SELinux@tycho.nsa.gov
From: Jan-Frode Myklebust <janfrode@tanso.net>
Subject: Centos5 setroubleshoot failure
Date: Wed, 12 Sep 2007 11:54:59 +0200
Message-ID: <slrnfefdrj.p00.janfrode@lc4eb8045376502.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I want the setroubleshooter to send me email on denials, 
so to test this I put a file of type "system_u:object_r:rpm_log_t"
into /var/www/html and tried to access it trough apache. This
gives me an AVC denial, and no mail. Setroubleshoot logs a traceback:

[Wed Sep 12 11:49:52 2007] [error] [client 148.122.207.136] (13)Permission denied: access to /z.html denied

[root@via log]# 2007-09-12 11:49:54,887 [avc.ERROR] Plugin Exception plugins.httpd_bad_labels 
Traceback (most recent call last):
  File "/usr/lib/python2.4/site-packages/setroubleshoot/analyze.py", line 260, in analyze_avc
    report_receiver.report_problem(report)
  File "/usr/lib/python2.4/site-packages/setroubleshoot/server.py", line 145, in report_problem
    self.database.set_filter(self, siginfo.sig, addr, FILTER_ALWAYS)
  File "/usr/lib/python2.4/site-packages/setroubleshoot/analyze.py", line 468, in set_filter
    siginfo = self.lookup_signature(sig)
  File "/usr/lib/python2.4/site-packages/setroubleshoot/analyze.py", line 388, in lookup_signature
    matches = self.sigs.match_signatures(sig)
  File "/usr/lib/python2.4/site-packages/setroubleshoot/signature.py", line 1265, in match_signatures
    if pat.__dict__[name] == sig.__dict__[name]:
KeyError: 'analysis_id'
2007-09-12 11:49:55,034 [avc.ERROR] Plugin Exception plugins.disable_trans 
Traceback (most recent call last):
  File "/usr/lib/python2.4/site-packages/setroubleshoot/analyze.py", line 260, in analyze_avc
    report_receiver.report_problem(report)
  File "/usr/lib/python2.4/site-packages/setroubleshoot/server.py", line 145, in report_problem
    self.database.set_filter(self, siginfo.sig, addr, FILTER_ALWAYS)
  File "/usr/lib/python2.4/site-packages/setroubleshoot/analyze.py", line 468, in set_filter
    siginfo = self.lookup_signature(sig)
  File "/usr/lib/python2.4/site-packages/setroubleshoot/analyze.py", line 388, in lookup_signature
    matches = self.sigs.match_signatures(sig)
  File "/usr/lib/python2.4/site-packages/setroubleshoot/signature.py", line 1265, in match_signatures
    if pat.__dict__[name] == sig.__dict__[name]:
KeyError: 'analysis_id'
2007-09-12 11:49:55,170 [avc.ERROR] Plugin Exception plugins.catchall_file 
Traceback (most recent call last):
  File "/usr/lib/python2.4/site-packages/setroubleshoot/analyze.py", line 260, in analyze_avc
    report_receiver.report_problem(report)
  File "/usr/lib/python2.4/site-packages/setroubleshoot/server.py", line 145, in report_problem
    self.database.set_filter(self, siginfo.sig, addr, FILTER_ALWAYS)
  File "/usr/lib/python2.4/site-packages/setroubleshoot/analyze.py", line 468, in set_filter
    siginfo = self.lookup_signature(sig)
  File "/usr/lib/python2.4/site-packages/setroubleshoot/analyze.py", line 388, in lookup_signature
    matches = self.sigs.match_signatures(sig)
  File "/usr/lib/python2.4/site-packages/setroubleshoot/signature.py", line 1265, in match_signatures
    if pat.__dict__[name] == sig.__dict__[name]:
KeyError: 'analysis_id'



  -jf


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
