Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PFXJNV029580
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 11:33:19 -0400
Received: from web86906.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3PFWpcu008503
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 15:32:52 GMT
Date: Wed, 25 Apr 2007 15:31:00 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: cannot login using strict policy
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Message-ID: <706356.14667.qm@web86906.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Karl,

Thanks for the response. I have to reboot with 'selinux=0' in order to diagnose the type of .bash_profile. It is 'root:object_r:user_home_t:s0'. This seems to me a problem, like every time, i will have to reboot with selinux=0, in order to get the attributes of the file. Plus one question regarding the unconfined_t. Is unconfined_t is changed to confined_t in strict policy mode?

Best,
JG

----- Original Message ----
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>; Stephen Smalley <sds@tycho.nsa.gov>
Sent: Wednesday, 25 April, 2007 5:20:28 PM
Subject: Re: cannot login using strict policy

On Wed, 2007-04-25 at 14:52 +0000, JanuGerman wrote:
> I have installed strict policy and then relabelled the files using 'fixfiles relablel' after rebooting with 'enforcing=0 single'. Every thing went well, but when i try to login, i get an error message that 
> localuser:root being added to access control list
> -/bin/bash: /root/.bash_profile: permission denied.
> Any idea?

What is the type on /root/.bash_profile? Any avcs?

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.





      ___________________________________________________________
Yahoo! Answers - Got a question? Someone out there knows the answer. Try it
now.
http://uk.answers.yahoo.com/ 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
