Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA11701
	for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 16:57:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA16171
	for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 20:57:08 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id UAA16167
	for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 20:57:07 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524398@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker '" <russell@coker.com.au>,
        "'SE Linux '"
	 <selinux@tycho.nsa.gov>
Subject: RE: auditing etc
Date: Sun, 9 Jun 2002 15:57:35 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
ON 6/9/02 3:59 AM, Russell Coker wrote:
> I was just speaking to a HP representative about their 
> Linux security solution (which has GPL kernel code and 
> expensive user-space tools). The access control sounds 
> less capable than SE Linux (EG it only controls read/write/append 
> for files instead of all the operations SE controls). But 
> the auditing seems much more capable.  Maybe if SE auditing 
> worked with the new IBM logging (which complies with the 
> appropriate specs from POSIX for logging) and logged more 
> data it would address this.

I have used the snare module for auditing extensively with SELinux
 and it works well . I have not look into the IBM module yet, but
will check is out. Sound promising.

Mark Westerman

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
