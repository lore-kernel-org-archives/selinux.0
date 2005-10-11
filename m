Message-ID: <434BF60A.5020204@cornell.edu>
Date: Tue, 11 Oct 2005 13:27:38 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Replace semanage debugging system
References: <434B62B8.4080309@cornell.edu>	 <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>	 <1129039592.3308.110.camel@moss-spartans.epoch.ncsc.mil>	 <434BCC58.7030509@cornell.edu> <1129041009.3308.125.camel@moss-spartans.epoch.ncsc.mil> <434BD2CB.8050007@cornell.edu>
In-Reply-To: <434BD2CB.8050007@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Okay, so it sounds like the optimal setup is:
> - pass variadic list to callback
> - remove msg field from message structure (rename?)
> - embed message structure into handle to avoid allocation
>
> Then handler takes four arguments instead of the current two:
>
> - void* arg
> - message structure (rename?)
> - fmt
> - variadic list
Wait.... how do I invoke a variadic function from a variadic function?
Should I pass the va_list as an argument?
I knew there was a reason I got rid of this in the first place...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
