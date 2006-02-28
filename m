Message-ID: <44048377.2010707@cornell.edu>
Date: Tue, 28 Feb 2006 12:08:07 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Chad Hanson <chanson@TrustedCS.com>, joe@nall.com,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        SELinux List <SELinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Context translation and MLS categories
References: <4403E1A0.8030704@cornell.edu>	 <1141132115.22297.158.camel@moss-spartans.epoch.ncsc.mil>	 <44047455.4010601@cornell.edu> <1141144322.22297.267.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1141144322.22297.267.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> What do I present to the user if they want their file accessible by 
>> s0:c0, and s0:c3, but not the other two.
>>     
>
> It doesn't work that way - it isn't an ACL.  s0:c0,c3 means that the
> file can only be accessed by processes with both c0 and c3 in its
> low/sensitivity level (or high/clearance level in the MCS case).  Adding
> a category to a file further restricts who can access it - it isn't
> additive.
>   
Okay... so I am completely misunderstanding this.
That's good to know, before I make critical design mistakes.

I blame James Morris' howto :)
It has no examples with more than one category marked on a file.
============

Okay, how about....

1) We translate the entire range when displaying
2) When modifying the range, we unroll the user's range as (s,c) pairs, 
then translate each of them, and present them as required clearances to 
be added or removed
3) When the range is displayed again, re-translate the whole thing.
============



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
