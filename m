Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EGlFWt019692
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 12:47:15 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9EGlCmR015931
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 16:47:12 GMT
Received: from ms-smtp-01-eri0.southeast.rr.com (ms-smtp-01.southeast.rr.com [24.93.67.82])
        by jazzband.ncsc.mil  with ESMTP id h9EGlBjp015924 for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 16:47:11 GMT
Received: from nc.rr.com (rdu26-59-021.nc.rr.com [66.26.59.21])
	by ms-smtp-01-eri0.southeast.rr.com (8.12.10/8.12.7) with ESMTP id h9EGlA2I005628
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 12:47:10 -0400 (EDT)
Message-ID: <3F8C288E.2090603@nc.rr.com>
Date: Tue, 14 Oct 2003 12:47:10 -0400
From: Jeff Johnson <n3npq@nc.rr.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: trusted vs untrusted packages
Content-Type: multipart/mixed;
 boundary="------------060604030808060806040504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060604030808060806040504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------060604030808060806040504
Content-Type: message/rfc822;
 name="Re: trusted vs untrusted packages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: trusted vs untrusted packages"

Message-ID: <3F8BEC00.9070909@nc.rr.com>
Date: Tue, 14 Oct 2003 08:28:48 -0400
From: Jeff Johnson <n3npq@nc.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: russell@coker.com.au
Subject: Re: trusted vs untrusted packages
References: <200310141107.53852.russell@coker.com.au>
In-Reply-To: <200310141107.53852.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Russell Coker wrote:

>We have been having some IRC discussions about trusted RPMs.  But please note 
>that I am not an expert on RPM, so I'll probably get terminology wrong (at 
>least).  Please correct any errors and CC the list for the benefit of all 
>readers.
>
>RPMs can be signed or unsigned.  If an RPM is signed by a trusted organization 
>then there should be some differences in an SE Linux install than if it is 
>not signed or if we don't trust the signer.
>
>One idea is to have signed packages be installed by rpm running as rpm_t and 
>unsigned packages be installed by rpm running as rpm_unsigned_t [1].  So for 
>example we could allow rpm_unsigned_t to install files in /sbin as 
>sbin_unsigned_t and in /bin as bin_unsigned_t [2].  Then a program installed 
>from an untrusted package can't be run from sysadm_t, and if it's run from 
>other trusted domains (EG part of the mail server) then it could trigger an 
>automatic domain transition to an appropriate domain.
>
>Now this raises some interesting issues.  If a signed package has a program 
>which relies on some other program (and has a dependency), what happens if 
>the dependency is satisfied by an unsigned package?  Installing the unsigned 
>package may not result in the system being fully functional (execution of the 
>file in question may be denied).
>  
>

The key phrase is "relies on some other program" and the type of 
relationship.

Clearly, a trusted executable cannot invoke an untrusted executable 
without losing its
trustedness.

The answer is far less clear when the relationship is a dependency 
between signed and
unsigned packages, and the files contained within.

Which indicates to me that decicisions on whether to permit file exec 
based on package
signatures needs to be reworked. An executable (or library or script) 
might  lose some
aspect of "trust" because the executable came from an unsigned package, 
but a stronger
definition of "trust" must be associated with the file itself, not the 
cellophane from which
it came.

73 de Jeff



--------------060604030808060806040504--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
