Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h948fusJ015035
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 04:41:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h948ft7d017313
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 08:41:55 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h948frRn017310 for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 08:41:54 GMT
Date: Sat, 4 Oct 2003 09:40:15 +0100
From: Dale Amon <amon@vnl.com>
To: Michael Reilly <michaelr@cisco.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Question about policy files and users
Message-ID: <20031004084015.GI12335@vnl.com>
References: <20031003210014.7c76f52f.michaelr@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031003210014.7c76f52f.michaelr@cisco.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 03, 2003 at 09:00:14PM -0700, Michael Reilly wrote:
> /home/jadmin/(/.*)?                     system_u:object_r:staff_home_t
> 
> (I, of course, replaced jadmin with my login name).  My question is why is
> the entry not -
> 
> /home/jadmin/(/.*)?                     jadmin_u:object_r:staff_home_t
> 

Perhaps because an admin user will have sensitive files and 
sysadmin scripts in their directory. If not, you could 
change the file labeling.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
