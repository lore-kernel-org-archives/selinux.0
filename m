Message-ID: <434D3D33.90104@cornell.edu>
Date: Wed, 12 Oct 2005 12:43:31 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ RESEND ] [ SEMANAGE ] Debugging system
References: <434CC592.70001@cornell.edu>	 <1129132332.3308.288.camel@moss-spartans.epoch.ncsc.mil>	 <434D35B1.7060409@cornell.edu> <1129133080.3308.294.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129133080.3308.294.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Hmm...I was thinking that the callback could add it as desired.  Each
> invocation of the callback constitutes a separate message, and the
> callback is free to introduce message separators as desired
>   
I guess we are already chopping up the info stream into messages, so 
pushing the separator into the messaging system might make sense... 
argh... I guess I'll redo the patch again, and next time I'll package up 
sepol as well, and drop enable_debug/disable_debug.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
