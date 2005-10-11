Message-ID: <434BD7DE.3080206@cornell.edu>
Date: Tue, 11 Oct 2005 11:18:54 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: [ SEMANAGE ] Replace semanage debugging system
References: <434B62B8.4080309@cornell.edu>	 <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>	 <1129039592.3308.110.camel@moss-spartans.epoch.ncsc.mil>	 <434BCC58.7030509@cornell.edu>	 <1129041009.3308.125.camel@moss-spartans.epoch.ncsc.mil>	 <434BD2CB.8050007@cornell.edu> <1129042012.3308.139.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129042012.3308.139.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Why not just use the handle directly, and drop the separate message
> structure entirely?
>   
It's disorganized... the handle contains all kinds of things - I don't 
like adding random fields to it. It'd be more orderly to add a 
structure, and functions to work with it, in a separate file. I would 
think that nested structs have no runtime overhead...





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
