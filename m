Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4TEnMfq014593
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2012 10:49:22 -0400
Message-ID: <14448379b0e76791f399e460a0c093c4.squirrel@webmail.harte-lyne.ca>
In-Reply-To: <4FC4DBE9.6050305@redhat.com>
References: <3cc2271ab50f5f35b273260eda59d356.squirrel@webmail.harte-lyne.ca>
    <4FC4DBE9.6050305@redhat.com>
Date: Tue, 29 May 2012 10:49:14 -0400
Subject: Re: Where to go for advice on local policy secuirity implications
From: "James B. Byrne" <byrnejb@harte-lyne.ca>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, May 29, 2012 10:23, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 05/28/2012 11:54 AM, James B. Byrne wrote:
>> We are in the process of examining whether it is possible to
>> create a local policy for Passenger which will allow it to
>> run in enforcing mode but not open the system to other
>> exploits. We would like to know if there is any on-line venue
>> where the security aspects of specific policy elements
>> might be discussed.
>>
>> Is there such a resource?  If so, can anyone here provide the
>> reference?
>>
>>
> Why not just email to refpolicy list the rules you want to allow
> along with the AVC's.  If there is security info you do not want
> to reveal, I would be willing to look at them.

Thank you.  The refpolicy list is the reference I was seeking. I will
inquire there.

We have no unusually sensitive security issues with revealing the avcs
and recommended policies.  At the present time the server is running
in permissive mode so any action which offers us the hope of setting
it to enforcing is a step in the right direction.


-- 
***          E-Mail is NOT a SECURE channel          ***
James B. Byrne                mailto:ByrneJB@Harte-Lyne.ca
Harte & Lyne Limited          http://www.harte-lyne.ca
9 Brockley Drive              vox: +1 905 561 1241
Hamilton, Ontario             fax: +1 905 561 0757
Canada  L8E 3C3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
