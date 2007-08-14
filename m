Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7EHpTbm000663
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2007 13:51:29 -0400
Received: from web51508.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7EHpS2U014164
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2007 17:51:28 GMT
Date: Tue, 14 Aug 2007 10:51:23 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Illegal errno from kernel
To: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <126339.54611.qm@web51508.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

In security/selinux/ss/services.c at the selinux_audit_rule_init() function is
this code:

        if (!ss_initialized)
                return -ENOTSUPP;

The audit system sends that to user space, but its a special value that is
supposed to be internal to the kernel. Should the audit system look for this
value and change it when it calls the function, or should we change this value in
the selinux code? And if we change it, what should it be? EINVAL doesn't make
sense as the syntax of what's being asked to do is correct. Should we define
something like ENOMAC?

-Steve


      ____________________________________________________________________________________
Fussy? Opinionated? Impossible to please? Perfect.  Join Yahoo!'s user panel and lay it on us. http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
