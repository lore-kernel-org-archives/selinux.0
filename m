Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA1HIXtw004102
	for <selinux@tycho.nsa.gov>; Thu, 1 Nov 2012 13:18:49 -0400
From: Bryan Hinton <bryan@bryanhinton.com>
To: "Moyer, Thomas - 0668 - MITLL" <thomas.moyer@ll.mit.edu>,
        Paul Moore
	<paul@paul-moore.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: Question about SELinux capability
Date: Thu, 1 Nov 2012 17:17:56 +0000
Message-ID: <F715099C1CA1494F845FAC75C5C298AB1EEEFCCC@CH1PRD0610MB355.namprd06.prod.outlook.com>
References: <3608707.WxASRDOVXr@sifl>,<CCB8247D.243B%thomas.moyer@ll.mit.edu>
In-Reply-To: <CCB8247D.243B%thomas.moyer@ll.mit.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thomas,
   You mentioned below that you are trying to ensure that only specific applications running on the system can communicate with the embedded hardware.
What type of bus and/or driver are being used to connect the system and the embedded hardware?

Bryan Hinton

________________________________________
From: owner-selinux@tycho.nsa.gov [owner-selinux@tycho.nsa.gov] on behalf of Moyer, Thomas - 0668 - MITLL [thomas.moyer@ll.mit.edu]
Sent: Thursday, November 01, 2012 10:09 AM
To: Paul Moore
Cc: selinux@tycho.nsa.gov
Subject: Re: Question about SELinux capability

On 11/1/12 11:58 AM, "Paul Moore" <paul@paul-moore.com> wrote:


>On Wednesday, October 31, 2012 08:24:21 AM Moyer, Thomas - 0668 - MITLL
>wrote:
>> Yes. That is correct. What I am looking at though is a piece of hardware
>> that does not use IP (or TCP and UDP for that matter). Instead, they
>> implement their own protocol at the IP layer. So any traffic coming from
>> the hardware (to the system that I am writing policy for) and any
>>traffic
>> being sent to that machine uses a raw socket to communicate (no IP at
>> all). I briefly looked at ebtables, but it doesn't appear to have the
>>same
>> type of SECMARK support that I would use with iptables.
>
>I think I misunderstood your original question; I thought you were
>interested
>in labeling the ethernet frames on the wire while it sounds like you are
>only
>interested in assigning labels to the network traffic once it has been
>received by the system - yes?

Correct.

>
>> I think the best solution that I have come up with is to label the
>>network
>> interface used to communicate with the hardware, and then only allow the
>> domain being confined to create sockets and bind to that interface.
>
>I assume you are talking about the ingress/egress controls?

Also correct.

>
>If so, a word of caution, they *may* not catch non-IP traffic due to they
>way
>they are hooked into the network stack.  I'd be interested in hearing
>what
>happens in your case.

We are trying to ensure that only specific applications running on the
system can communicate with the embedded hardware. One way to do this is
to filter network traffic. At least the "easiest" that I could identify.

>
>> >On Friday, October 26, 2012 04:08:15 PM Moyer, Thomas - 0668 - MITLL
>> >
>> >wrote:
>> >> I am working with a piece of embedded hardware that uses raw ethernet
>> >> frames to communicate with another (standard PC). Is it possible to
>>apply
>> >> SELinux labels to those ethernet frames like you can with IP packets
>> >> using iptables and SECMARK?
>> >
>> >The secmark/iptables labels never leave the local system, they are
>> >maintained only within the kernel and do not travel out over the wire.
>> If
>> >you are interested in communicating security label over the network
>>your
>> >only options at present require an IP header at the very least.
>
>--
>paul moore
>www.paul-moore.com
>
--
Thomas Moyer, Technical Staff   voice: (781) 981-1374
Cyber Systems Technology Group          mobile: (857) 268-0493
MIT Lincoln Laboratory                  email: thomas.moyer@ll.mit.edu
244 Wood Street
Lexington, MA 02420


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
