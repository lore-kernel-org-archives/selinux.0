Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9BG9Rc2010174
	for <selinux@tycho.nsa.gov>; Thu, 11 Oct 2007 12:09:27 -0400
Received: from mailmac.ads-oh.atg.titan.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9BG9IK4019975
	for <selinux@tycho.nsa.gov>; Thu, 11 Oct 2007 16:09:18 GMT
Received: from [192.168.50.32] (unknown [66.218.141.135])
	by mailmac.ads-oh.atg.titan.com (Postfix) with ESMTP id AA4E5EE66E
	for <selinux@tycho.nsa.gov>; Thu, 11 Oct 2007 12:08:17 -0400 (EDT)
Mime-Version: 1.0
Message-Id: <p0600201ec333f539728d@[192.168.50.32]>
Date: Thu, 11 Oct 2007 12:08:58 -0400
To: selinux@tycho.nsa.gov
From: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Subject: Question about domain transition and MLS
Content-Type: multipart/alternative; boundary="============_-1020003553==_ma============"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--============_-1020003553==_ma============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"

I am writing policy for an application which runs in a domain with a 
SystemHigh range and attempts to launch (via fork/exec) an 
application (/bin/df) having it run in a domain with SystemLow range. 
My application performs a setexeccon, passing it the domain 
root:sysadm_r:sysadm_t:SystemLow,  prior to the fork and exec.

My policy contains a rule to allow the application's domain type to 
do a process dyntransition to sysadm_t, but I continue to get an 
audit message indicating it cannot perform a dyntransition from its 
domain, system_u:system_r:my_app_t:SystemHigh to 
root:sysadm_r:sysadm_t:SystemLow.

I have added numerous mls macros to try to allow the process 
transition, such as mls_rangetrans_source, mls_rangetrans_target, and 
mls_process_set_level, but I still get the dyntransition audit 
message.  Any suggestions for what mls attributes my application 
needs?

Thanks,
Rosalie
--============_-1020003553==_ma============
Content-Type: text/html; charset="us-ascii"

<!doctype html public "-//W3C//DTD W3 HTML//EN">
<html><head><style type="text/css"><!--
blockquote, dl, ul, ol, li { padding-top: 0 ; padding-bottom: 0 }
 --></style><title>Question about domain transition and
MLS</title></head><body>
<div>I am writing policy for an application which runs in a domain
with a SystemHigh range and attempts to launch (via fork/exec) an
application (/bin/df) having it run in a domain with SystemLow range.&nbsp;
My application performs a setexeccon, passing it the domain
root:sysadm_r:sysadm_t:SystemLow<font face="Helvetica" size="+1"
color="#000000">,&nbsp;</font> prior to the fork and exec.</div>
<div><br></div>
<div>My policy contains a rule to allow the application's domain type
to do a process dyntransition to sysadm_t, but I continue to get an
audit message indicating it cannot perform a dyntransition from its
domain, system_u:system_r:my_app_t:SystemHigh to
root:sysadm_r:sysadm_t:SystemLow.</div>
<div><br></div>
<div>I have added numerous mls macros to try to allow the process
transition, such as mls_rangetrans_source, mls_rangetrans_target, and
mls_process_set_level, but I still get the dyntransition audit
message.&nbsp; Any suggestions for what mls attributes my application
needs?</div>
<div><br></div>
<div>Thanks,</div>
<div>Rosalie</div>
</body>
</html>
--============_-1020003553==_ma============--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
