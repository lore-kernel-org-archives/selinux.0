Date: Wed, 16 Jan 2008 12:52:22 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: sds@tycho.nsa.gov, casey@schaufler-ca.com, Trond.Myklebust@netapp.com,
        npiggin@suse.de, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/26] Permit filesystem local caching
In-Reply-To: <20080115234652.22183.24850.stgit@warthog.procyon.org.uk>
Message-ID: <Xine.LNX.4.64.0801161248590.24959@us.intercode.com.au>
References: <20080115234652.22183.24850.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 15 Jan 2008, David Howells wrote:

> 
>   (*) 04-keys-get-label.diff
> 
>       A patch to allow the security label of a key to be retrieved.
>       Included because of patches 05-08.
> 
>   (*) 05-security-current-fsugid.diff
>   (*) 06-security-separate-task-bits.diff
>   (*) 07-security-subjective.diff
>   (*) 08-security-secctx2secid.diff
>   (*) 09-security-additional-classes.diff
>   (*) 10-security-kernel_service-class.diff
>   (*) 11-security-kernel-service.diff

All of the security patches look ok to me.  From the SELinux pov, this 
will need to go in after Paul Moore's labeled networking update (hopefully 
very soon after the next merge window opens).


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
