Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7TBmNLa025390
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 07:48:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7TBkrpQ025813
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 11:46:53 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h7TBkrQX025810
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 11:46:53 GMT
Date: Fri, 29 Aug 2003 12:48:21 +0100
From: Dale Amon <amon@vnl.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: Package install probs
Message-ID: <20030829114820.GB17642@vnl.com>
Mime-Version: 1.0
Content-Type: message/rfc822
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> On Fri, 29 Aug 2003 02:30, Dale Amon wrote:
> OK, I've made changes to assert.te and syslogd.te that should do what you 
> want.  I've attached the new versions, let me know how they go.

Close but no cigar.

 ERROR 'unknown type klogd_t' at token ';' on line 40021:
    neverallow klogd_t ~klogd_exec_t:file entrypoint; neverallow klogd_t ~{ klogd_exec_t ld_so_t }:file execute_no_trans;
 #line 8101
 /usr/bin/checkpolicy:  error(s) encountered while parsing configuration
 /usr/bin/checkpolicy:  loading policy configuration from /etc/security/selinux/src/policy.conf

> Strange.  I tried to reproduce that and couldn't, it refers to *.te every 
> time.  Please show me the error messages.

 apt-get install --reinstall selinux-policy-default
                   :
                   :
 Using policy installation method "Semi-automatic"
 Upstream deletion or custome file: domains/program/dpkg.te~, Delete/Ignore [d/l]?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
