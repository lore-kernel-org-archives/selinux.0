Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA28226
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 10:04:00 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1LF3xI29174
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 15:03:59 GMT
Received: from torexch1.mykotronx.com (host-65-119-11-194.mykotronx.com [65.119.11.194] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id h1LF3vf29170 for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 15:03:57 GMT
Message-ID: <FD2221F5E1A8184DB61AFCE064C395F1C91CFE@torexch1.mykotronx.com>
From: CNGUYEN <CNguyen@mykotronx.com>
To: "'lrp@xmission.com'" <lrp@xmission.com>,
        "'Russell Coker'"
	 <russell@coker.com.au>,
        "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>,
        "'tom@lemuria.org'"
	 <tom@lemuria.org>
Cc: "Chieu Nguyen (E-mail)" <ctnguyen@cox.net>,
        "David Gathright (E-mail)"
	 <davidgathright@attbi.com>
Subject: RE: Making OPIE/QTOPIA aware of SELinux
Date: Fri, 21 Feb 2003 07:05:31 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you for your advices, we will take these into consideration as we
investigate further into the QTOPIA/OPIE SDKs.

-----Original Message-----
From: Lamont R. Peterson [mailto:lrp@xmission.com]
Sent: Friday, February 21, 2003 6:58 AM
To: CNGUYEN; 'Russell Coker'; 'Stephen D. Smalley';
'selinux@tycho.nsa.gov'
Subject: Re: Making OPIE/QTOPIA aware of SELinux


On Thursday 20 February 2003 12:42 pm, CNGUYEN wrote:
> Applications <----
> ----              |
> OPIE/QTOPIA  <---------|
> ---                    |
> SELinux                |
> ---                    |
> Device Drivers <-------|

If I understand the architecture of the kernel (and particularly, how
SELinux 
affects the kernel) then I would have to say that your diagram is incorrect.

SELinux does not sit on top of the kernel; it "IS" the kernel.

Qtopia (I don't know OPIE) does not bypass the kernel in order to talk to 
devices directly.  There is nothing (other than compiling SELinux into your 
"embedded" kernel) that needs be done for Qtopia to run securely.

However, if I were to do this, I would write some Qtopia apps to wrap around

SELinux specific tools such as spasswd, and would explore the "login" 
facility that Qtopia Desktop uses to communicate with Qtopia devices.
-- 
Sincerely,
Lamont R. Peterson <lrp@xmission.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
