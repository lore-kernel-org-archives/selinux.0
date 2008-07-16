Subject: Re: /etc/selinux/mls/contexts files labeled default_context_t
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40807151402k565fbdf6iea18f911f1e0cc00@mail.gmail.com>
References: <cadfc0e40807151402k565fbdf6iea18f911f1e0cc00@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 16 Jul 2008 06:47:54 -0400
Message-Id: <1216205274.17602.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-07-15 at 16:02 -0500, Xavier Toth wrote:
> Most of these files are labeled default_context_t which I thought was
> a no-no, why is this?

No, that's the right type for those files.  You might be thinking of
default_t.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
