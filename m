Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA11091
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2002 01:47:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id GAA04247
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2002 06:46:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id GAA04243
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2002 06:45:59 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 8B3B492672
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2002 17:46:46 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 0BBBE24A7F
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2002 17:48:10 +1100 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: execve_secure(2)
Date: Tue, 19 Feb 2002 17:18:15 +1100
MIME-Version: 1.0
Message-Id: <20020219064810.0BBBE24A7F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From the man page:
       int execve (const char *filename,  char  *const  argv  [],
       char *const envp[], security_id_t sid);

NB it should be "execve_secure" not "execve".

>From the header file:
extern int execve_secure(const char *filename,
                         char **argv,
                         char **envp,
                         security_id_t sid);

Should be "char * const *" not "char **" for argv and envp.

-- 
Signatures >4 lines are rude.  If you send email to me or to a mailing list
that I am subscribed to which has >4 lines of legalistic junk at the end
then you are specifically authorizing me to do whatever I wish with the
message (the sig won't be read).

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
