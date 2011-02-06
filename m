Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p169S6iT004267
	for <selinux@tycho.nsa.gov>; Sun, 6 Feb 2011 04:28:06 -0500
Received: from mail.eurojobs.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p169S5JO011695
	for <selinux@tycho.nsa.gov>; Sun, 6 Feb 2011 09:28:05 GMT
Message-ID: <4D4E69D0.50808@mintsource.org>
Date: Sun, 06 Feb 2011 10:28:48 +0100
From: Simon Peter Nicholls <simon@mintsource.org>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Trouble logging in through SSH
References: <4D4C8A4C.1070101@mintsource.org> <4D4D0B63.8070509@mintsource.org> <4D4D5038.2090403@gmail.com>
In-Reply-To: <4D4D5038.2090403@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/02/11 14:27, Dominick Grift wrote:
> By the way, these policy related questions should go to
> refpolicy@oss.tresys.com maillist.

Hi Dominick, thanks for your replies to my issues.

When I hit trouble, I thought I had hit something other than regular 
policy issues, but this was incorrect. I have missing access_vectors, 
and face some other issues (due to a combination of recent software and 
non-standard file locations), but all appear to be surmountable through 
a custom policy build.

I've learned a lot in a short time, thanks in large part to reading some 
key posts in this mailing list, and my system is firmly in the realm of 
policy tweaking now. Mostly I'm twiddling booleans and changing file 
contexts to match Arch Linux at this point, with cron and syslog-ng the 
only services with issues. My "semanage permissive -a" functionality is 
broken, as the "/var/lib/selinux" path I see hardcoded into semanage 
does not exist on my system, but it was no bother to hand code a 
permissive module to get my logging working for now. So I can run 
enforcing from boot whilst I finish up, no problem.

It looks like Fedora have already addressed some of the core refpolicy 
issues I've faced (problems unrelated to Arch file locations), but 
patches had not made it upstream the last time I checked. I'd also like 
to see a passenger module make it into refpolicy. So, I still have some 
outstanding refpolicy queries, which I'll take over to the mailing list 
you mention.

Thanks again.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
