Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7IHTJHa012900
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 13:29:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7IHTDj6007448
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 17:29:13 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
        by jazzband.ncsc.mil  with ESMTP id h7IHTDNN007445 for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 17:29:13 GMT
Message-ID: <3F410CE8.9060807@diyab.net>
Date: Mon, 18 Aug 2003 13:29:12 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Kerry Thompson <kerry@crypt.gen.nz>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: SELinux on Slackware 9 with PAM
References: <3F3896BD.5000307@diyab.net> <3357.202.27.185.71.1061177252.squirrel@www.crypt.gen.nz> <200308181510.29857.russell@coker.com.au>
In-Reply-To: <200308181510.29857.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Mon, 18 Aug 2003 13:27, Kerry Thompson wrote:
> 
>>- you should mention that the Vixie crond in the SE release has been
>>modified for SELinux and really needs to be installed if you want cron.
>>Alternatively the user would need to modify Dillon's crond code to support
>>the SELinux extensions.
> 
> 
> http://archives.neohapsis.com/archives/linux/lsap/2001-q1/0142.html
> Solar Designer says some nice things about Dillon Cron at the above URL (the 
> Linux Security Auditing Project mailing list - which should be of interest to 
> people on this list).
> 
> It would be good to have some SE Linux patches to Dillon Cron if someone's got 
> the time for the coding.
> 
> Especially as Vixie cron seems as good as dead upstream.
> 

I noticed Vixie looks dead also, so I guess I'll try fixing Dillon's 
crond.  I can learn to code along the way and the rest of you can at 
least tell me if I did it right once I'm finished.  Of course if anyone 
else wants to do this or if anyone wants this soon you can go right 
ahead and do it.

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
