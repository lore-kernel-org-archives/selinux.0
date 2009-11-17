Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAHF0al4020873
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 10:00:36 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id nAHF2dSO006733
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 15:02:39 GMT
Subject: RE: Windows-level enforcement in SELinux?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Dyson, Mark L (IS)" <Mark.Dyson@ngc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <834B41F71BFB1D4385FC5E62CF526DCE01C59D23@XMBIL123.northgrum.com>
References: 
	 <834B41F71BFB1D4385FC5E62CF526DCE01C59D17@XMBIL123.northgrum.com>
	 <834B41F71BFB1D4385FC5E62CF526DCE01C59D23@XMBIL123.northgrum.com>
Content-Type: text/plain; charset="iso-8859-7"
Date: Tue, 17 Nov 2009 10:00:53 -0500
Message-ID: <1258470053.27504.246.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-11-17 at 08:21 -0600, Dyson, Mark L (IS) wrote:
> I¢ll narrow the scope of my initial question a bit, here:  can SELinux
> support this sort of operation?  Some online literature seems to
> suggest otherwise but it¢s admittedly a few years old.

Yes.  It is available in Fedora.  Eamon Walsh recently presented at the
SELinux Developer Summit and Linux Plumbers Conference

http://www.selinuxproject.org/page/Developer_Summit_2009/Abstracts/E_Walsh_X
http://linuxplumbersconf.org/ocw/proposals/87

Here's the video from the Plumber's session:

http://video.linuxfoundation.org/video/1566

I'm not sure if there is a specific project page, but Eamon will
hopefully respond to this thread.


> From:owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> On Behalf Of Dyson, Mark L (IS)
> Sent: Monday, November 16, 2009 10:09 AM
> To: selinux@tycho.nsa.gov
> Subject: Windows-level enforcement in SELinux?
> 
> 
>  
> 
> Hello,
> 
> I¢ve been tasked to map out a path for migrating a MLS application
> from Trusted Solaris to SELinux.  I¢m sure I¢ll have many questions to
> come, but after some initial readings one of my first is:
> 
> How does SELinux label individual X-windows in a user session, so that
> (for example) data contained in a high-level security window cannot be
> copied and then pasted into a lower-level security window?
> 
> Thanks in advance!
> Mark
> 
> 


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
