Message-ID: <438B5A15.4060604@redhat.com>
Date: Mon, 28 Nov 2005 14:27:17 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] wrap char*** for user_get_roles()
References: <1133205192.17541.1.camel@twoface.columbia.tresys.com>
In-Reply-To: <1133205192.17541.1.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> This adds wrappers for char*** so that semanage_user_get_roles will
> work. I added the test to the user test (-u), please let me know if
> there are any issues with this.
>
>   
No patch attached.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
