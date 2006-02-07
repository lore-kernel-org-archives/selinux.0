Message-ID: <43E8BB82.7000708@redhat.com>
Date: Tue, 07 Feb 2006 10:23:46 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Why cron doesn't work in strict policy
References: <43E7C52E.601@cornell.edu> <43E7C804.3040507@cornell.edu>	 <43E8B013.8000000@redhat.com>	 <1139323414.2872.46.camel@moss-spartans.epoch.ncsc.mil>	 <43E8B1F0.5030208@cornell.edu> <1139324141.2872.49.camel@moss-spartans.epoch.ncsc.mil> <43E8B699.50502@cornell.edu>
In-Reply-To: <43E8B699.50502@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>> What kind of problem? 
> The user doesn't exist, while genhomedircon() will do a passwd check 
> on it, and print out warnings.
>
You could change genhomedircon to ignore it as it does for default and 
user_u now.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
