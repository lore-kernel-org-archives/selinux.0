Message-ID: <437CB954.3000104@tresys.com>
Date: Thu, 17 Nov 2005 12:09:40 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Please tell semodule to shut up????
References: <437A7AD5.6040500@cornell.edu> <1132150739.3425.16.camel@moss-spartans.epoch.ncsc.mil> <437CAA27.30302@redhat.com>
In-Reply-To: <437CAA27.30302@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
<snip>
> -                {"quiet", 0, NULL, 'q'},
> +                {"verbose", 0, NULL, 'v'},

Why not just run -q in audit2allow, the rpm, etc? I don't understand why 
  a patch is necessary when the flag for the behavior you want already 
exists.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
