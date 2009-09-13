Date: Mon, 14 Sep 2009 08:23:53 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        mingo@elte.hu, dhowells@redhat.com
Subject: Re: [PATCH 1/3] Creds: creds->security can be NULL is selinux is
 disabled
In-Reply-To: <20090913025409.6583.58777.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.0909140823320.27953@tundra.namei.org>
References: <20090913025409.6583.58777.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 12 Sep 2009, Eric Paris wrote:

> __validate_process_creds should check if selinux is actually enabled before
> running tests on the selinux portion of the credentials struct.

Have you verified that this fixes the problem?


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
