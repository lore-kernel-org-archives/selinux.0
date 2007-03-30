Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UAHSPg007692
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 06:17:28 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UAHRpm006061
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 10:17:27 GMT
Message-ID: <460CE391.6090100@redhat.com>
Date: Fri, 30 Mar 2007 06:16:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ted X Toth <txtoth@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: api for getting setrans information
References: <460C3195.1020505@gmail.com>
In-Reply-To: <460C3195.1020505@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ted X Toth wrote:
> Are there apis to retrieve all of the categories and sensitivity 
> levels and to convert them into a human readable form?
No, Not really,  you either read the setrans.conf file directly, but 
this would break if you used a different translation library (mitre).

Or you could attempt to exhaustively search the namespace using:

        extern int selinux_raw_to_trans_context(security_context_t raw,,
                                                security_context_t * 
transp);

Which would have 16 * 1024! (Factorial) combinations.  IE It would take 
a long time.

If you call the functions and (raw == transp ) no translation.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
