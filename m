Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0LIm23h022258
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2009 13:48:02 -0500
Received: from rn-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0LIj790007880
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2009 18:45:07 GMT
Received: by rn-out-0910.google.com with SMTP id k40so395438rnd.17
        for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2009 10:48:01 -0800 (PST)
Message-ID: <49776DDD.6080306@gmail.com>
Date: Wed, 21 Jan 2009 10:47:57 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: run_init confusion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm having an issue with run_init.
each time I try to restart alsa-utils
I get this:

name@computer:~$ newrole -r sysadm_r -- -c /usr/sbin/run_init 
/etc/init.d/alsa-utils restart
Password:
USAGE: run_init <script> <args ...>
  where: <script> is the name of the init script to run,
         <args ...> are the arguments to that script.
name@computer:~$

I've set /etc/pam.d/newrole_pam.conf
as su, but commented out:
 auth       sufficient pam_rootok.so
like what the doc said.

I've also set in the policy
DIRECT_INITRC = y
but still the same response.

any info would be appreciated.

regards;

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
