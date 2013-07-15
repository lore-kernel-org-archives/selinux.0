Message-ID: <51E3F30A.8010603@tycho.nsa.gov>
Date: Mon, 15 Jul 2013 09:03:06 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dave Quigley <selinux@davequigley.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: matchportcon?
References: <51E23671.2060205@davequigley.com>
In-Reply-To: <51E23671.2060205@davequigley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/14/2013 01:26 AM, Dave Quigley wrote:
> Do we have an equivalent of matchpathcon for ports? Where we can specify
> a protocol and port and see what the policy thinks it labeled?

Closest approximation I can think of would be to use
checkpolicy -Mdb /path/to/policy
and then choose 9, input the protocol and port number, choose 1, and
input the SID that was displayed.

It would be very nice to have a more user-friendly (and scriptable) 
interface to the checkpolicy -d (debug) functionality.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
