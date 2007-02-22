Message-ID: <45DDBFB0.9040401@redhat.com>
Date: Thu, 22 Feb 2007 11:07:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC] Remove init_context_translations() from libselinux
References: <1172078429.14363.279.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1172078429.14363.279.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> I think we've talked about this before, but never followed through.
> Is there any reason to retain the init_context_translations() function
> in libselinux, which sends a SETRANS_INIT message to mcstransd, gets a
> response, and discards it?  Can we drop it and the call to it from the
> library constructor/initializer?
>
>   
Ok with me.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
