Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA08389
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2001 03:26:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id HAA21615
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2001 07:25:55 GMT
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com [194.25.134.18])
	by jazzband.ncsc.mil  with ESMTP id HAA21611
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2001 07:25:54 GMT
From: Amon Ott <ao@rsbac.org>
To: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
Date: Thu, 5 Apr 2001 08:00:33 +0200
Content-Type: text/plain
References: <Pine.SOL.3.95.1010402145703.8569J-100000@clipper.gw.tislabs.com>
In-Reply-To: <Pine.SOL.3.95.1010402145703.8569J-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <01040509250501.00859@marvin>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 02 Apr 2001 Stephen Smalley wrote:
> 7) Most of the RSBAC policy modules are very hardwired in their
> policy logic, and can be easily expressed using the SELinux Type
> Enforcement (TE) configuration.

After rereading Section 'Overview' of your 'Security Policy Configuration'
paper, and remembering a similar claim at another place, which I had no way of
answering, I kindly ask for some explanation.

Without knowing your exact model details, I believe your claim 'can be easily
expressed using SELinux Type Enforcement' to be

- completely wrong for Privacy Model (PM), Malware Scan (MS), Role Compatibility
(RC) and Access Control Lists (ACL)

- doubtful for Mandatory Access Control (MAC), File Flags (FF) and
Authentication (AUTH)

- correct for the very simple models Functional Control (FC) and Security
Information Modification (SIM)


Since I regard all modules except FC and SIM as important models (or at least
modules), I hereby ask you to either

- prove your claim or

- officially take it back

for all these models.

Amon.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
