Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA02616
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 13:51:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id SAA23147
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 18:50:14 GMT
Received: from mailgw3a.lmco.com (mailgw3a.lmco.com [192.35.35.24])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id SAA23142
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 18:50:13 GMT
Received: from emss04g01.ems.lmco.com ([166.17.13.122])
	by mailgw3a.lmco.com (8.8.8/8.8.8) with ESMTP id NAA15217
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 13:51:34 -0500 (EST)
Received: from CONVERSION-DAEMON by lmco.com (PMDF V5.2-32 #38890) id <0G6Y00401N109O@lmco.com> for selinux@tycho.nsa.gov;
 Wed, 10 Jan 2001 13:51:00 -0500 (EST)
Received: from emss04i00.ems.lmco.com ([166.17.13.135]) by lmco.com (PMDF V5.2-32 #38890)
 with ESMTP id <0G6Y001E2N0VT0@lmco.com> for selinux@tycho.nsa.gov; Wed, 10 Jan 2001 13:50:56 -0500 (EST)
Date: Wed, 10 Jan 2001 13:52:34 -0500
From: "Kutz, William R" <william.r.kutz@lmco.com>
Subject: RE: SELinux and covert channels
To: selinux@tycho.nsa.gov
Message-id: <079B626B05A0D3118B1000508B0EA5E90629F560@emss04m05.ems.lmco.com>
MIME-version: 1.0
Content-type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Chris,

While covert channel analysis is a good thing, I think it needs to take place in the future after the system is more complete, with additional security mechanisms included in the baseline. The additional shared security services and applications on the system provide many of the sources for covert channel exploits, and it is that interaction that will make the covert channel analysis interesting. Performing such an analysis now would simply need to be readdressed later when the system is mature.

I think a more practical initial analysis would be of the MAC mechanism itself. The kernel enforcement and security server should be reviewed to determine if they meet the requirements they was designed against; namely features like non-bypassability, and consistent kernel policy enforcement. If there are flaws here, then the covert channel analysis will not be needed because the policy can be violated directly, and the more sophisticated covert channel attacks will not be needed.

Another type of analysis that may be useful is to assess SELinux capability at limiting the impact of malicious activities within the system. We all know that flaws/bugs/vulnerabilities are going to exist in any OS environment, so the question becomes, "How good is SELinux at containing the impact of these flaws. One could start with the known Linux issues and determine the impact on a SELinux system running with any one of a number of security policies. This has the potential of providing a good metric for the value of SELinux over any of the vanilla Linux offerings.

Once the implementation has been analyzed, and any issues within the selinux kernel addressed, it makes sense to start looking at some of the other security services needed in the system, As these features become available, it will be time to address some of the covert channel questions.

Bill


Bill Kutz

M&DS Lockheed Martin
william.r.kutz@lmco.com
610-354-7149



> -----Original Message-----
> From:	Belmonte, Christopher [SMTP:cbelmonte@dit.state.va.us]
> Sent:	Wednesday, January 10, 2001 11:45 AM
> To:	'Johnathon Day'; selinux@tycho.nsa.gov
> Subject:	SELinux and covert channels
> 
> Has anyone considered analyzing SELinux for covert channels?
> 
> 
> - Chris Belmonte
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
