Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA01173
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 12:02:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA01390
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 17:01:37 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id RAA01378 for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 17:01:33 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015242F3@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Justin Smith'" <jsmith@mcs.drexel.edu>, selinux@tycho.nsa.gov
Subject: RE: suggested policy change
Date: Wed, 6 Mar 2002 11:02:39 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I would not get rid of the neverallow rule. 
If you must add insmod_t and kmod_t to assertion rule

file assert.te

neverallow ~{ initrc_t admin } sysctl_kernel_t:file { write append };

Modification

neverallow ~{ insmod_t kmod_t initrc_t admin } sysctl_kernel_t:file { write
append };


Mark

-----Original Message-----
From: Justin Smith [mailto:jsmith@mcs.drexel.edu]
Sent: Wednesday, March 06, 2002 10:49 AM
To: selinux@tycho.nsa.gov
Subject: suggested policy change


Adding the rules:
# policy/domains/system/kmod.te
allow kmod_t sysctl_kernel_t:file rw_file_perms;

# policy/domains/program/modutil.te
allow insmod_t sysctl_kernel_t:file rw_file_perms;

results in the error messages:

error in the statement ending on line 25688 (token ';'): assertion
failed:  allow kmod_t sysctl_kernel_t:file { write append } was granted.


error in the statement ending on line 25688 (token ';'): assertion
failed:  allow insmod_t sysctl_kernel_t:file { write append } was
granted.

i.e., they conflict with some of the neverallow rules. Should I simply
get rid of the appropriate neverallow rules?

--

--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
