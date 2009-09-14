From: David Howells <dhowells@redhat.com>
In-Reply-To: <20090913025409.6583.58777.stgit@paris.rdu.redhat.com>
References: <20090913025409.6583.58777.stgit@paris.rdu.redhat.com>
To: Eric Paris <eparis@redhat.com>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov, jmorris@namei.org, mingo@elte.hu
Subject: Re: [PATCH 1/3] Creds: creds->security can be NULL is selinux is disabled
Date: Mon, 14 Sep 2009 12:53:33 +0100
Message-ID: <11977.1252929213@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris <eparis@redhat.com> wrote:

> __validate_process_creds should check if selinux is actually enabled before
> running tests on the selinux portion of the credentials struct.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by: David Howells <dhowells@redhat.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
