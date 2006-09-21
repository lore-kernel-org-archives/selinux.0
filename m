Date: Thu, 21 Sep 2006 11:04:26 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Erich Schubert <erich@debian.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Michael C Thompson <thompsmc@us.ibm.com>,
        "Serge E. Hallyn" <serue@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SSH pubkey authentication & MLS policy
Message-ID: <20060921160426.GA2487@sergelap.austin.ibm.com>
References: <4511AAF2.8090809@us.ibm.com> <45129698.5080503@redhat.com> <1158852528.14117.48.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1158852528.14117.48.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Erich Schubert (erich@debian.org):
> Hi,
> This is not MLS related.
> Here's the Debian diff used to allow public key logins.
> http://svn.debian.org/wsvn/selinux/refpolicy/branches/debian/policy/modules/services/ssh.te?op=diff&rev=0&sc=0

Looks like the statements we need, but why do you have this
under tunable_policy(`ssh_sysadm_login')?

> I believe that sshd verifies the home directory to be not
> world-writeable.
> The patch above adds "search", although "getattr" probably is
> sufficient. But I didn't want to add another interface... yeah, I'm a
> bit lazy sometimes.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
