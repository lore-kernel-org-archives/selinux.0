Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p51E4Ibx014288
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 10:04:18 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p51E4IVT027952
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 14:04:18 GMT
Message-ID: <4DE646E1.1000309@tresys.com>
Date: Wed, 1 Jun 2011 10:04:17 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Can we eliminate or optimize nodups_specs within libselinux
References: <4DE64180.50302@redhat.com> <4DE6430B.8080604@redhat.com>
In-Reply-To: <4DE6430B.8080604@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/01/11 09:47, Daniel J Walsh wrote:
> On 06/01/2011 09:41 AM, Daniel J Walsh wrote:
>> > We are costing boot 1.5s
>> > 
>> > https://bugzilla.redhat.com/show_bug.cgi?id=709014
> 
> This seems to be something libsemanage should do to verify the
> file_context file is good, but libselinux should just figure the
> file_context file is sane.  And be optimised to read access.

Makes sense.  It probably should have been doing this for a long time
anyway, since it needs to take into account for genhomedircon output and
local file contexts.  I think it should also cause a transaction fail if
there are file context errors.

> Might be a reason tools like install run slow also.

I'd bet on it, since all those tools do is, basically, matchpathcon()
then setfscreatecon().

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
