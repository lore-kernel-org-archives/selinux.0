Date: Fri, 12 Apr 2002 10:07:36 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Tom <tom@lemuria.org>, <SELinux@tycho.nsa.gov>
Subject: Re: db conflict ?
In-Reply-To: <20020412135859.3D809281EF@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204121003010.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Russell Coker wrote:

> Although I now think that the correct thing to do is to have a
> file_auto_trans() rule to do it.

The problem with using a file_type_auto_trans rule to label /ss_policy is
that you don't want all files created by sysadm_t in the root directory to
end up with policy_config_t.  However, we could relocate /ss_policy into
a subdirectory of the root directory, and label that subdirectory with
policy_config_t so that subsequent installs will always pick up that type
automatically without needing any type transition rules.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com








--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
