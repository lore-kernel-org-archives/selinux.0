Message-ID: <440489F9.40007@cornell.edu>
Date: Tue, 28 Feb 2006 12:35:53 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Chad Hanson <chanson@TrustedCS.com>, joe@nall.com,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        SELinux List <SELinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Context translation and MLS categories
References: <4403E1A0.8030704@cornell.edu>	 <1141132115.22297.158.camel@moss-spartans.epoch.ncsc.mil>	 <44047455.4010601@cornell.edu>	 <1141144322.22297.267.camel@moss-spartans.epoch.ncsc.mil>	 <44048377.2010707@cornell.edu> <1141148047.22297.272.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1141148047.22297.272.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> 1) We translate the entire range when displaying
>> 2) When modifying the range, we unroll the user's range as (s,c) pairs, 
>> then translate each of them, and present them as required clearances to 
>> be added or removed
>>     
>
> In general, you can't unroll it in this manner.  It may make sense to do
> so for a particular policy (e.g. MCS in particular), but not in the
> general case for MLS.
>   
Can you give an example?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
