Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2DF2Dje021788
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2007 11:02:13 -0400
Received: from web86902.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2DF2BSH026315
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2007 15:02:12 GMT
Date: Tue, 13 Mar 2007 15:01:55 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: Confirmation about task_has_security in selinuxfs.c
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1173786888.2738.173.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <537052.29906.qm@web86902.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,

Is the following lines in the selinuxfs.c that gets
the final decision from the security server:

length = security_compute_av(ssid, tsid, tclass, req,
&avd);
        if (length < 0)
               goto out2;
...


Actually, i am intrested in locating the last point at
which the selinuxfs.c communicates with the security
server for an access decision (no matter cached or
not) and then conveys back the decision to the LSM
hook. 

Alternatively, the point, at which the DAC checks are
again checked by the LSM hook, which query the SElinux
LSM. I have checked the "security.c", which contains
the SELinux LSM hook registration but did not succeed
to locate the point, where all these calls are taking
place.

Thank You,
MA








		
___________________________________________________________ 
What kind of emailer are you? Find out today - get a free analysis of your email personality. Take the quiz at the Yahoo! Mail Championship. 
http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
