Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4GG4Guh005793
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2011 12:04:16 -0400
Received: from moutng.kundenserver.de (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4GG4E6d019363
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2011 16:04:14 GMT
Message-ID: <4DD14AF5.1060609@2ndquadrant.com>
Date: Mon, 16 May 2011 12:04:05 -0400
From: Greg Smith <greg@2ndquadrant.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: Kohei Kaigai <Kohei.Kaigai@EMEA.NEC.COM>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patch Review Process
References: <4DC804D8.1080605@tresys.com> <1304968880.2521.43.camel@vortex> <4DC84776.8080708@tresys.com> <A9F5079BABDEE646AEBDB6831725762C55601124C2@EUEXCLU01.EU.NEC.COM> <4DD13501.1060406@tresys.com>
In-Reply-To: <4DD13501.1060406@tresys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve Lawrence wrote:
> Is commitfest custom built by the postgresql community or is it some open source
> project? I can't seem to find any information on what the backend is.
>   

Yes to both, sort of.  It was built for this purpose, but the result is 
an open-source project available for others.  Source code is 
http://git.postgresql.org/gitweb?p=pgcommitfest.git ; it's a Perl 
application aimed to run inside Apache, with a PostgreSQL back-end as 
you might expect. 

The application was developed after really not finding the workflow of 
existing applications like Reviewboard to mesh well with the 
requirements for PostgrSQL's development process.  The main thing that I 
think may not translate well into some other environments, but might 
actually work here, is its heavy reliance on mailing list integration.  
The main thing stored when you add a new entry to the CommitFest 
application is a pointer to a mailing list URL.  For the PostgreSQL 
lists, that is driven by the message-id of the e-mail sent.  The main 
data stored is essentially is a list of pointers into the mail archives, 
via message-id, with each tagged for what submission they all belong 
to.  Comments and such actually stored in the web application is 
minimal; the idea is that you're using it to track e-mails sent to the 
mailing list, where the primary review information is sent to.

Another caveat is that there was already a PostgreSQL single login 
service that this hooks into.  There's no internal support in the 
CommitFest app for account creation/maintenance, it just calls the API 
available on postgresql.org for that.

-- 
Greg Smith   2ndQuadrant US    greg@2ndQuadrant.com   Baltimore, MD
PostgreSQL Training, Services, and 24x7 Support  www.2ndQuadrant.us



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
