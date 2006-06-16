From: David Howells <dhowells@redhat.com>
In-Reply-To: <1150303229.3408.10.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1150303229.3408.10.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, dhowells@redhat.com, sds@tycho.nsa.gov,
        jmorris@redhat.com
Subject: Re: [PATCH] selinux: add /proc/pid/attr/keycreate 
Date: Fri, 16 Jun 2006 11:33:41 +0100
Message-ID: <20114.1150454021@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> -	security_key_alloc(&root_user_keyring, current);
> -	security_key_alloc(&root_session_keyring, current);
> +	selinux_key_alloc(&root_user_keyring, current, 1);
> +	selinux_key_alloc(&root_session_keyring, current, 1);

Is that right?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
