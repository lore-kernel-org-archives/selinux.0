Subject: Re: [PATCH 1/3] Creds: creds->security can be NULL is selinux is
 disabled
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        mingo@elte.hu, dhowells@redhat.com
In-Reply-To: <alpine.LRH.2.00.0909140823320.27953@tundra.namei.org>
References: <20090913025409.6583.58777.stgit@paris.rdu.redhat.com>
	 <alpine.LRH.2.00.0909140823320.27953@tundra.namei.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 13 Sep 2009 18:55:41 -0400
Message-Id: <1252882541.16335.1.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-09-14 at 08:23 +1000, James Morris wrote:
> On Sat, 12 Sep 2009, Eric Paris wrote:
> 
> > __validate_process_creds should check if selinux is actually enabled before
> > running tests on the selinux portion of the credentials struct.
> 
> Have you verified that this fixes the problem?

Yes, I was able to reproduce the problem using selinux=0 at the command
line.  This patch fixes the problem.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
