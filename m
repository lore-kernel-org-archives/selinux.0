Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3CJJ8Yg014596
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 15:19:08 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p3CJJ8eR025607
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 19:19:08 GMT
Message-ID: <4DA4A602.9090702@tresys.com>
Date: Tue, 12 Apr 2011 15:20:34 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Harry Ciao <qingtao.cao@windriver.com>
Subject: Re: Here is an updated Eric Paris patch for adding named file trans
 rules.
References: <4D9CD64B.7020207@redhat.com> <4DA454A8.7030005@tresys.com> <4DA47A02.400@redhat.com> <4DA49B88.3040300@redhat.com>
In-Reply-To: <4DA49B88.3040300@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/12/2011 02:35 PM, Daniel J Walsh wrote:
> It also has a fix for the ROLE_TRANS patch from Harry Ciao that was
> blowing up when used with policy less then 26.  IE Everywhere.
> 

Thanks for the patch. I'm looking into it right now.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
