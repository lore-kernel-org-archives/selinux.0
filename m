Message-ID: <4678344B.1080108@redhat.com>
Date: Tue, 19 Jun 2007 15:53:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Athey <jathey@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Ted X Toth <txtoth@gmail.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [RFC][PATCH] libselinux: refactored SWIG bindings
References: <1181744873.18728.10.camel@exodus.columbia.tresys.com>	 <1182253254.15064.4.camel@moss-spartans.epoch.ncsc.mil>	 <1182265710.14549.7.camel@exodus.columbia.tresys.com>	 <467824E8.5000409@redhat.com> <1182282671.14549.20.camel@exodus.columbia.tresys.com>
In-Reply-To: <1182282671.14549.20.camel@exodus.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Athey wrote:
> The previous patch did not include the changes to the Makefile or the
> typo fix to fsetfilecon.c.  Here's an updated patch.
>
>   
I have played with this patch and system-config-selinux and semanage 
seem to be working.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
