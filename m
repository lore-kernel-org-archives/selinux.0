Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA04572
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 10:09:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA20037
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 15:09:28 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA20033
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 15:09:27 GMT
Date: Thu, 29 Mar 2001 10:09:09 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Rajan Ravindran <rajancr@us.ibm.com>
cc: selinux@tycho.nsa.gov
Subject: Re: error while building initial policy
In-Reply-To: <OF063C958F.83A691A3-ON85256A1E.00515858@pok.ibm.com>
Message-ID: <Pine.SOL.3.95.1010329100204.17401I-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Try running 'make initpolicy' again, and see if it shows
the line number where the error occurs.  If so, look
at that line and its surrounding context in initpolicy.conf
to see if you can identify the problem.  Did you customize
the policy for your system other than changing policy/users
for your users?  

If you have difficulty in tracking down the problem, you
can send a gzipped tar file of your entire policy directory to 
me and I'll take a look at it.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Thu, 29 Mar 2001, Rajan Ravindran wrote:

> I had a problem while building initial policy (make initpolicy)
> on Redhat 7.0. The error it showed was
> ---------------------------------------------------------------------------------------------
> error: unknown class file system used in rule.
> ../kernel/security/checkpolicy: error(s) encountered
> while parsing configuration.
> make: *** [initpolicy] error 1
> --------------------------------------------------------------------------------------------
> Do I need to modify anything in my file system policy file?
> 
> Rajan


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
