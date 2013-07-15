Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6FD7xAd018144
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2013 09:07:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 15 Jul 2013 09:07:54 -0400
From: David Quigley <selinux@davequigley.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: =?UTF-8?Q?matchportcon=3F?=
In-Reply-To: <51E3F30A.8010603@tycho.nsa.gov>
References: <51E23671.2060205@davequigley.com>
 <51E3F30A.8010603@tycho.nsa.gov>
Message-ID: <3fa9165e8c1cfe4a72ba570e3420de6a@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/15/2013 09:03, Stephen Smalley wrote:
> On 07/14/2013 01:26 AM, Dave Quigley wrote:
>> Do we have an equivalent of matchpathcon for ports? Where we can 
>> specify
>> a protocol and port and see what the policy thinks it labeled?
>
> Closest approximation I can think of would be to use
> checkpolicy -Mdb /path/to/policy
> and then choose 9, input the protocol and port number, choose 1, and
> input the SID that was displayed.
>
> It would be very nice to have a more user-friendly (and scriptable)
> interface to the checkpolicy -d (debug) functionality.


So over on fedora-selinux dominic grift suggested I use sepolicy 
network to check it out. The only issue with its usage is that it 
doesn't tell you what it actually is. Instead it gives you all rules 
that will match and you have to realize the most specific one wins. It 
is however sufficient for my talk so I'll probably use it.

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
