Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA28145
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 09:59:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1LExsI28915
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 14:59:54 GMT
Received: from mgr4.xmission.com (mgr4.xmission.com [198.60.22.204])
        by jazzband.ncsc.mil  with ESMTP id h1LExqf28911 for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 14:59:52 GMT
From: "Lamont R. Peterson" <lrp@xmission.com>
Reply-To: lrp@xmission.com
To: CNGUYEN <CNguyen@mykotronx.com>, "'Russell Coker'" <russell@coker.com.au>,
        "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Making OPIE/QTOPIA aware of SELinux
Date: Fri, 21 Feb 2003 07:57:56 -0700
References: <FD2221F5E1A8184DB61AFCE064C395F1C91CEF@torexch1.mykotronx.com>
In-Reply-To: <FD2221F5E1A8184DB61AFCE064C395F1C91CEF@torexch1.mykotronx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302210757.56785.lrp@xmission.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 20 February 2003 12:42 pm, CNGUYEN wrote:
> Applications <----
> ----              |
> OPIE/QTOPIA  <---------|
> ---                    |
> SELinux                |
> ---                    |
> Device Drivers <-------|

If I understand the architecture of the kernel (and particularly, how SELinux 
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
