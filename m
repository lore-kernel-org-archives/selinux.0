Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6UBahe6010133
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 07:36:43 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6UBaIbD012244
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 11:36:18 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id n6UBZjjG021742
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 07:35:45 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id n6UBZjkp021740
	for selinux@tycho.nsa.gov; Thu, 30 Jul 2009 07:35:45 -0400
Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6U3x9Ug013072
	for <selinux@tycho.nsa.gov>; Wed, 29 Jul 2009 23:59:09 -0400
Received: from outbound.icp-qv1-irony-out1.iinet.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6U402k5013220
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 04:00:04 GMT
Message-ID: <4A711890.2030101@ii.net>
Date: Thu, 30 Jul 2009 11:50:40 +0800
From: Cliffe <cliffe@ii.net>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Help with SELinux policy for Usability Study
References: <200907300352.n6U3qvAC012682@tarius.tycho.ncsc.mil>
In-Reply-To: <200907300352.n6U3qvAC012682@tarius.tycho.ncsc.mil>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dear SELinux Gurus,

I am a PhD candidate conducting research into the usability of security 
mechanisms. I would really appreciate some help regarding the use of 
SELinux. Let me know if this is not the right place to be asking these 
types of questions.

I generated a policy for opera using polgengui. I then ran the generated 
./opera.sh.

Although SELinux was still set to enforcing mode opera seemed to run 
unconfined. The executable and process was labelled as expected 
(unconfined_u:unconfined_r:opera_t). AVCs were generated, but not enforced.

I added to opera.te using
grep opera /var/log/audit/audit.log | audit2allow >> opera.te
and reran ./opera.sh
until no AVCs were generated.

Looking at opera.te I noticed the line “permissive opera_t”, and not 
knowing exactly what this line does, I thought it may be placing this 
domain into permissive mode (although the gui tools suggest otherwise). 
Removing the line causes “/bin/sh: /usr/bin/opera: Permission denied”. 
No AVCs are generated.

So I am not sure why opera seams to be unconfined, or if removing the 
permissive line was on the right track. Any advice?

Also I tried creating a policy for kwrite. This time the created policy 
seemed to be in effect as soon as I ran the kwrite.sh script. I set 
setenforce 0 and added to kwrite.te (as above for opera) until no error 
msgs were generated. Then I reran ./kwrite.sh. Now kwrite exists with 
“kwrite(2533): Couldn’t register name ‘”org.kate-editor.kwrite-2533’” 
with DBUS – another process owns it already!”. When setenforce 0 it runs 
without AVCs.

Again I am sure I am missing something simple and your advice will help 
a lot.

I need to resolve this asap and will really appreciate any advice.

Soon I will be running a comparative study comparing a number of 
security mechanisms and I need to sort this out.

Thank you,

Cliffe.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
