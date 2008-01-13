Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0D0rLRw025231
	for <selinux@tycho.nsa.gov>; Sat, 12 Jan 2008 19:53:21 -0500
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0D0rKLw012404
	for <selinux@tycho.nsa.gov>; Sun, 13 Jan 2008 00:53:20 GMT
Received: by wa-out-1112.google.com with SMTP id k22so3076059waf.0
        for <selinux@tycho.nsa.gov>; Sat, 12 Jan 2008 16:53:19 -0800 (PST)
Message-ID: <dd18b0c30801121653j398a258ei30660f2e2a871553@mail.gmail.com>
Date: Sat, 12 Jan 2008 16:53:19 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: sysadm_devpts_t
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6624_9737019.1200185599553"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_6624_9737019.1200185599553
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Im wanting to know if there is an answer to this problem; with later
mls policies you have the option of
/etc/selinux/mls/contexts/securetty_contexts, but with
selinux-policy-default (Debian)there is no option. Im running into the
problem of = newrole -l s3 Error: you are not allowed to change levels on a
non secure terminal.
Does anybody know where I might look for adding sysadm_devpts_t so I can use
newrole -l s3?
Is there a simple fix with /etc/pam.d/newrole for this problem? Is there a
way to add securetty_contexts to selinux-policy-default manually?
Ultimatlly I want to have my system running at a level of s3 then when
wanting to use firefox and xmms at a level of s0.
any info would be helpful
regards;
               --Justin P. Mattock

------=_Part_6624_9737019.1200185599553
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Im wanting to know if there is an answer to this problem; with later mls policies you have the option of /etc/selinux/mls/contexts/securetty_contexts, but with selinux-policy-default (Debian)there is no option. Im running into the problem of = newrole -l s3 Error: you are not allowed to change levels on a non secure terminal.
<br>Does anybody know where I might look for adding sysadm_devpts_t so I can use newrole -l s3? <br>Is there a simple fix with /etc/pam.d/newrole for this problem? Is there a way to add securetty_contexts to selinux-policy-default manually?
<br>Ultimatlly I want to have my system running at a level of s3 then when wanting to use firefox and xmms at a level of s0.<br>any info would be helpful<br>regards;<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; --Justin P. Mattock &nbsp; <br>

------=_Part_6624_9737019.1200185599553--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
